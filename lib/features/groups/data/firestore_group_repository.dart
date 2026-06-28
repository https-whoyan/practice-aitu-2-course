import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../core/domain/entity_status.dart';
import '../../../core/error/error_mapper.dart';
import '../domain/group.dart';
import '../domain/group_repository.dart';

/// Реализация [GroupRepository] поверх Firestore.
///
/// Типобезопасный доступ через `withConverter`; `groupId` = id документа.
/// Связь группа↔курс и состав студентов пишутся транзакцией/батчем, чтобы
/// зеркальные поля не расходились (шаг 12). Ошибки → `Failure` (шаг 4).
class FirestoreGroupRepository implements GroupRepository {
  FirestoreGroupRepository(this._db);

  final FirebaseFirestore _db;

  CollectionReference<Group> get _groups =>
      _db.collection('groups').withConverter<Group>(
            fromFirestore: (snap, _) =>
                Group.fromJson({...?snap.data(), 'groupId': snap.id}),
            toFirestore: (group, _) => group.toJson()..remove('groupId'),
          );

  @override
  Stream<Group?> watchGroup(String groupId) =>
      _groups.doc(groupId).snapshots().map((snap) => snap.data()).mapFailures();

  @override
  Future<Group?> getGroup(String groupId) async {
    try {
      final snap = await _groups.doc(groupId).get();
      return snap.data();
    } catch (error, stackTrace) {
      throw mapErrorToFailure(error, stackTrace);
    }
  }

  @override
  Future<List<Group>> fetchGroups({
    int limit = 20,
    String? startAfterId,
    bool includeArchived = false,
  }) async {
    try {
      Query<Group> query = _groups.orderBy('title');
      if (!includeArchived) {
        query = query.where('status', isEqualTo: EntityStatus.active.code);
      }
      if (startAfterId != null) {
        final cursor = await _groups.doc(startAfterId).get();
        if (cursor.exists) query = query.startAfterDocument(cursor);
      }
      final snap = await query.limit(limit).get();
      return snap.docs.map((d) => d.data()).toList();
    } catch (error, stackTrace) {
      throw mapErrorToFailure(error, stackTrace);
    }
  }

  @override
  Stream<List<Group>> watchGroups({bool includeArchived = false}) {
    Query<Group> query = _groups.orderBy('title');
    if (!includeArchived) {
      query = query.where('status', isEqualTo: EntityStatus.active.code);
    }
    return query
        .snapshots()
        .map((s) => s.docs.map((d) => d.data()).toList())
        .mapFailures();
  }

  @override
  Stream<List<Group>> watchGroupsForTeacher(String teacherId) => _groups
      .where('teacherIds', arrayContains: teacherId)
      .snapshots()
      .map((s) => s.docs.map((d) => d.data()).toList())
      .mapFailures();

  @override
  Stream<List<Group>> watchGroupsForStudent(String studentId) => _groups
      .where('studentIds', arrayContains: studentId)
      .snapshots()
      .map((s) => s.docs.map((d) => d.data()).toList())
      .mapFailures();

  @override
  Stream<List<Group>> watchGroupsForCourses(List<String> courseIds) {
    if (courseIds.isEmpty) return Stream.value(const <Group>[]);
    // arrayContainsAny ограничен 30 значениями — для MVP курсов преподавателя
    // достаточно; при превышении берём первые 30.
    return _groups
        .where('courseIds', arrayContainsAny: courseIds.take(30).toList())
        .snapshots()
        .map((s) => s.docs.map((d) => d.data()).toList())
        .mapFailures();
  }

  @override
  Future<String> createGroup(Group group) async {
    try {
      final ref = await _groups.add(group);
      return ref.id;
    } catch (error, stackTrace) {
      throw mapErrorToFailure(error, stackTrace);
    }
  }

  @override
  Future<void> updateGroup(Group group) async {
    try {
      await _groups.doc(group.groupId).set(
            group.copyWith(updatedAt: DateTime.now()),
            SetOptions(merge: true),
          );
    } catch (error, stackTrace) {
      throw mapErrorToFailure(error, stackTrace);
    }
  }

  @override
  Future<void> archiveGroup(String groupId) async {
    try {
      await _db.collection('groups').doc(groupId).update({
        'status': EntityStatus.archived.code,
        'updatedAt': FieldValue.serverTimestamp(),
      });
    } catch (error, stackTrace) {
      throw mapErrorToFailure(error, stackTrace);
    }
  }

  @override
  Future<void> addStudent(String groupId, String studentId) async {
    try {
      final batch = _db.batch();
      batch.update(_db.collection('groups').doc(groupId), {
        'studentIds': FieldValue.arrayUnion([studentId]),
        'updatedAt': FieldValue.serverTimestamp(),
      });
      // Зеркало для быстрых выборок «мои группы» у студента (шаг 16).
      batch.set(
        _db.collection('profiles').doc(studentId),
        {
          'groupIds': FieldValue.arrayUnion([groupId]),
          'updatedAt': FieldValue.serverTimestamp(),
        },
        SetOptions(merge: true),
      );
      await batch.commit();
    } catch (error, stackTrace) {
      throw mapErrorToFailure(error, stackTrace);
    }
  }

  @override
  Future<void> removeStudent(String groupId, String studentId) async {
    try {
      final batch = _db.batch();
      batch.update(_db.collection('groups').doc(groupId), {
        'studentIds': FieldValue.arrayRemove([studentId]),
        'updatedAt': FieldValue.serverTimestamp(),
      });
      batch.set(
        _db.collection('profiles').doc(studentId),
        {
          'groupIds': FieldValue.arrayRemove([groupId]),
          'updatedAt': FieldValue.serverTimestamp(),
        },
        SetOptions(merge: true),
      );
      await batch.commit();
    } catch (error, stackTrace) {
      throw mapErrorToFailure(error, stackTrace);
    }
  }

  @override
  Future<void> linkCourse(String groupId, String courseId) async {
    try {
      final batch = _db.batch();
      batch.update(_db.collection('groups').doc(groupId), {
        'courseIds': FieldValue.arrayUnion([courseId]),
        'updatedAt': FieldValue.serverTimestamp(),
      });
      batch.update(_db.collection('courses').doc(courseId), {
        'groupIds': FieldValue.arrayUnion([groupId]),
        'updatedAt': FieldValue.serverTimestamp(),
      });
      await batch.commit();
    } catch (error, stackTrace) {
      throw mapErrorToFailure(error, stackTrace);
    }
  }

  @override
  Future<void> unlinkCourse(String groupId, String courseId) async {
    try {
      final batch = _db.batch();
      batch.update(_db.collection('groups').doc(groupId), {
        'courseIds': FieldValue.arrayRemove([courseId]),
        'updatedAt': FieldValue.serverTimestamp(),
      });
      batch.update(_db.collection('courses').doc(courseId), {
        'groupIds': FieldValue.arrayRemove([groupId]),
        'updatedAt': FieldValue.serverTimestamp(),
      });
      await batch.commit();
    } catch (error, stackTrace) {
      throw mapErrorToFailure(error, stackTrace);
    }
  }
}
