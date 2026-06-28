import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../core/error/error_mapper.dart';
import '../domain/course.dart';
import '../domain/course_repository.dart';
import '../domain/course_status.dart';

/// Реализация [CourseRepository] поверх Firestore. Ошибки → `Failure` (шаг 4).
class FirestoreCourseRepository implements CourseRepository {
  FirestoreCourseRepository(this._db);

  final FirebaseFirestore _db;

  CollectionReference<Course> get _courses =>
      _db.collection('courses').withConverter<Course>(
            fromFirestore: (snap, _) =>
                Course.fromJson({...?snap.data(), 'courseId': snap.id}),
            toFirestore: (course, _) => course.toJson()..remove('courseId'),
          );

  @override
  Stream<Course?> watchCourse(String courseId) =>
      _courses.doc(courseId).snapshots().map((snap) => snap.data()).mapFailures();

  @override
  Future<Course?> getCourse(String courseId) async {
    try {
      final snap = await _courses.doc(courseId).get();
      return snap.data();
    } catch (error, stackTrace) {
      throw mapErrorToFailure(error, stackTrace);
    }
  }

  @override
  Future<List<Course>> fetchCourses({
    int limit = 20,
    String? startAfterId,
    bool includeArchived = false,
  }) async {
    try {
      // Архивные исключаем на клиенте: «активные списки» = черновики + активные
      // (Firestore != неудобен с orderBy; страница невелика).
      Query<Course> query = _courses.orderBy('title');
      if (startAfterId != null) {
        final cursor = await _courses.doc(startAfterId).get();
        if (cursor.exists) query = query.startAfterDocument(cursor);
      }
      final snap = await query.limit(limit).get();
      final courses = snap.docs.map((d) => d.data());
      return (includeArchived
              ? courses
              : courses.where((c) => !c.status.isArchived))
          .toList();
    } catch (error, stackTrace) {
      throw mapErrorToFailure(error, stackTrace);
    }
  }

  @override
  Stream<List<Course>> watchCourses({bool includeArchived = false}) {
    return _courses.orderBy('title').snapshots().map((s) {
      final courses = s.docs.map((d) => d.data());
      return (includeArchived
              ? courses
              : courses.where((c) => !c.status.isArchived))
          .toList();
    }).mapFailures();
  }

  @override
  Stream<List<Course>> watchCoursesByOwner(String teacherId) => _courses
      .where('ownerTeacherId', isEqualTo: teacherId)
      .snapshots()
      .map((s) => s.docs.map((d) => d.data()).toList())
      .mapFailures();

  @override
  Stream<List<Course>> watchCoursesByGroups(List<String> groupIds) {
    if (groupIds.isEmpty) return Stream.value(const []);
    final ids = groupIds.take(30).toList(); // arrayContainsAny: лимит 30.
    return _courses
        .where('groupIds', arrayContainsAny: ids)
        .snapshots()
        .map((s) => s.docs
            .map((d) => d.data())
            // Студент видит только активные курсы (не черновики/архив).
            .where((c) => c.status.isActive)
            .toList())
        .mapFailures();
  }

  @override
  Stream<List<Course>> watchCoursesForTeacher(String teacherId) => _courses
      .where('teacherIds', arrayContains: teacherId)
      .snapshots()
      .map((s) => s.docs.map((d) => d.data()).toList())
      .mapFailures();

  @override
  Stream<List<Course>> watchCoursesByIds(List<String> courseIds) {
    if (courseIds.isEmpty) return Stream.value(const []);
    // Firestore whereIn ограничен 30 значениями; для MVP берём первые 30.
    final ids = courseIds.take(30).toList();
    return _courses
        .where(FieldPath.documentId, whereIn: ids)
        .snapshots()
        .map((s) => s.docs.map((d) => d.data()).toList())
        .mapFailures();
  }

  @override
  Future<String> createCourse(Course course) async {
    try {
      final ref = await _courses.add(course);
      return ref.id;
    } catch (error, stackTrace) {
      throw mapErrorToFailure(error, stackTrace);
    }
  }

  @override
  Future<void> updateCourse(Course course) async {
    try {
      await _courses.doc(course.courseId).set(
            course.copyWith(updatedAt: DateTime.now()),
            SetOptions(merge: true),
          );
    } catch (error, stackTrace) {
      throw mapErrorToFailure(error, stackTrace);
    }
  }

  @override
  Future<void> setStatus(String courseId, CourseStatus status) async {
    try {
      await _db.collection('courses').doc(courseId).update({
        'status': status.code,
        'updatedAt': FieldValue.serverTimestamp(),
      });
    } catch (error, stackTrace) {
      throw mapErrorToFailure(error, stackTrace);
    }
  }

  @override
  Future<void> archiveCourse(String courseId) =>
      setStatus(courseId, CourseStatus.archived);

  @override
  Future<void> deleteCourse(String courseId) async {
    try {
      // Защита (§5.4.3): курс с оценками/отправками только архивируют.
      final grades = await _db
          .collection('grades')
          .where('courseId', isEqualTo: courseId)
          .limit(1)
          .get();
      final subs = await _db
          .collection('submissions')
          .where('courseId', isEqualTo: courseId)
          .limit(1)
          .get();
      if (grades.docs.isNotEmpty || subs.docs.isNotEmpty) {
        throw mapErrorToFailure(
          FirebaseException(
            plugin: 'cloud_firestore',
            code: 'failed-precondition',
            message:
                'Курс содержит оценки или отправки — его можно только архивировать.',
          ),
        );
      }

      final course = await _db.collection('courses').doc(courseId).get();
      final groupIds =
          (course.data()?['groupIds'] as List?)?.cast<String>() ?? const [];
      final weeks = await _db
          .collection('courseWeeks')
          .where('courseId', isEqualTo: courseId)
          .get();
      final materials = await _db
          .collection('materials')
          .where('courseId', isEqualTo: courseId)
          .get();

      final batch = _db.batch();
      // Снимаем зеркальные связи групп.
      for (final g in groupIds) {
        batch.update(_db.collection('groups').doc(g), {
          'courseIds': FieldValue.arrayRemove([courseId]),
        });
      }
      for (final w in weeks.docs) {
        batch.delete(w.reference);
      }
      for (final m in materials.docs) {
        batch.delete(m.reference);
      }
      batch.delete(_db.collection('courses').doc(courseId));
      await batch.commit();
    } catch (error, stackTrace) {
      throw mapErrorToFailure(error, stackTrace);
    }
  }

  @override
  Future<String> duplicateCourse(
    String courseId, {
    bool resetWeekDates = false,
  }) async {
    try {
      final src = await _db.collection('courses').doc(courseId).get();
      if (!src.exists) {
        throw mapErrorToFailure(
          FirebaseException(plugin: 'cloud_firestore', code: 'not-found'),
        );
      }
      final data = Map<String, dynamic>.from(src.data()!);
      final now = FieldValue.serverTimestamp();

      // Новый курс — всегда черновик; связи с группами не копируем.
      final newCourseRef = _db.collection('courses').doc();
      final newCourse = {
        ...data,
        'title': '${data['title'] ?? 'Курс'} (копия)',
        'status': CourseStatus.draft.code,
        'groupIds': <String>[],
        'createdAt': now,
        'updatedAt': now,
      };

      final batch = _db.batch();
      batch.set(newCourseRef, newCourse);

      // Копируем недели с ремаппингом id (для переноса материалов).
      final weeks = await _db
          .collection('courseWeeks')
          .where('courseId', isEqualTo: courseId)
          .get();
      final weekIdMap = <String, String>{};
      for (final w in weeks.docs) {
        final newWeekRef = _db.collection('courseWeeks').doc();
        weekIdMap[w.id] = newWeekRef.id;
        final wd = Map<String, dynamic>.from(w.data());
        batch.set(newWeekRef, {
          ...wd,
          'courseId': newCourseRef.id,
          if (resetWeekDates) 'startDate': null,
          if (resetWeekDates) 'endDate': null,
          'createdAt': now,
          'updatedAt': now,
        });
      }

      // Копируем материалы, ремаппя courseId/weekId.
      final materials = await _db
          .collection('materials')
          .where('courseId', isEqualTo: courseId)
          .get();
      for (final m in materials.docs) {
        final md = Map<String, dynamic>.from(m.data());
        final oldWeekId = md['weekId'] as String?;
        batch.set(_db.collection('materials').doc(), {
          ...md,
          'courseId': newCourseRef.id,
          'weekId': oldWeekId == null ? null : weekIdMap[oldWeekId] ?? oldWeekId,
          'createdAt': now,
          'updatedAt': now,
        });
      }

      await batch.commit();
      return newCourseRef.id;
    } catch (error, stackTrace) {
      throw mapErrorToFailure(error, stackTrace);
    }
  }
}
