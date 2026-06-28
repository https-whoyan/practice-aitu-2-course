import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../core/error/error_mapper.dart';
import '../domain/course_week.dart';
import '../domain/course_week_repository.dart';

/// Реализация [CourseWeekRepository] поверх Firestore. Ошибки → `Failure`.
class FirestoreCourseWeekRepository implements CourseWeekRepository {
  FirestoreCourseWeekRepository(this._db);

  final FirebaseFirestore _db;

  CollectionReference<CourseWeek> get _weeks =>
      _db.collection('courseWeeks').withConverter<CourseWeek>(
            fromFirestore: (snap, _) =>
                CourseWeek.fromJson({...?snap.data(), 'weekId': snap.id}),
            toFirestore: (week, _) => week.toJson()..remove('weekId'),
          );

  @override
  Stream<List<CourseWeek>> watchWeeks(String courseId) => _weeks
      .where('courseId', isEqualTo: courseId)
      .orderBy('orderIndex')
      .snapshots()
      .map((s) => s.docs.map((d) => d.data()).toList())
      .mapFailures();

  @override
  Stream<List<CourseWeek>> watchPublishedWeeks(String courseId) => _weeks
      .where('courseId', isEqualTo: courseId)
      .where('isPublished', isEqualTo: true)
      .orderBy('orderIndex')
      .snapshots()
      .map((s) => s.docs.map((d) => d.data()).toList())
      .mapFailures();

  @override
  Future<CourseWeek?> getWeek(String weekId) async {
    try {
      final snap = await _weeks.doc(weekId).get();
      return snap.data();
    } catch (error, stackTrace) {
      throw mapErrorToFailure(error, stackTrace);
    }
  }

  @override
  Future<String> addWeek(CourseWeek week) async {
    try {
      final ref = await _weeks.add(week);
      return ref.id;
    } catch (error, stackTrace) {
      throw mapErrorToFailure(error, stackTrace);
    }
  }

  @override
  Future<void> updateWeek(CourseWeek week) async {
    try {
      await _weeks.doc(week.weekId).set(
            week.copyWith(updatedAt: DateTime.now()),
            SetOptions(merge: true),
          );
    } catch (error, stackTrace) {
      throw mapErrorToFailure(error, stackTrace);
    }
  }

  @override
  Future<void> deleteWeek(String weekId) async {
    try {
      await _db.collection('courseWeeks').doc(weekId).delete();
    } catch (error, stackTrace) {
      throw mapErrorToFailure(error, stackTrace);
    }
  }

  @override
  Future<void> reorderWeeks(String courseId, List<String> orderedWeekIds) async {
    try {
      final batch = _db.batch();
      for (var i = 0; i < orderedWeekIds.length; i++) {
        batch.update(_db.collection('courseWeeks').doc(orderedWeekIds[i]), {
          'orderIndex': i,
          'updatedAt': FieldValue.serverTimestamp(),
        });
      }
      await batch.commit();
    } catch (error, stackTrace) {
      throw mapErrorToFailure(error, stackTrace);
    }
  }

  @override
  Future<void> setPublished(String weekId, bool value) async {
    try {
      await _db.collection('courseWeeks').doc(weekId).update({
        'isPublished': value,
        'updatedAt': FieldValue.serverTimestamp(),
      });
    } catch (error, stackTrace) {
      throw mapErrorToFailure(error, stackTrace);
    }
  }
}
