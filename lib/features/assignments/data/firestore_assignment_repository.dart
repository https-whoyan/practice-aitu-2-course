import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../core/error/error_mapper.dart';
import '../domain/assignment.dart';
import '../domain/assignment_repository.dart';

/// Реализация [AssignmentRepository] поверх Firestore. Ошибки → `Failure`.
class FirestoreAssignmentRepository implements AssignmentRepository {
  FirestoreAssignmentRepository(this._db);

  final FirebaseFirestore _db;

  CollectionReference<Assignment> get _assignments =>
      _db.collection('assignments').withConverter<Assignment>(
            fromFirestore: (snap, _) =>
                Assignment.fromJson({...?snap.data(), 'assignmentId': snap.id}),
            toFirestore: (a, _) => a.toJson()..remove('assignmentId'),
          );

  @override
  Stream<List<Assignment>> watchAssignmentsForCourse(String courseId) =>
      _assignments
          .where('courseId', isEqualTo: courseId)
          .orderBy('createdAt')
          .snapshots()
          .map((s) => s.docs.map((d) => d.data()).toList())
          .mapFailures();

  @override
  Stream<List<Assignment>> watchPublishedAssignmentsForCourse(
    String courseId,
  ) =>
      _assignments
          .where('courseId', isEqualTo: courseId)
          .where('isPublished', isEqualTo: true)
          .orderBy('createdAt')
          .snapshots()
          .map((s) => s.docs.map((d) => d.data()).toList())
          .mapFailures();

  @override
  Stream<List<Assignment>> watchAssignmentsForWeek(String weekId) =>
      _assignments
          .where('weekId', isEqualTo: weekId)
          .orderBy('createdAt')
          .snapshots()
          .map((s) => s.docs.map((d) => d.data()).toList())
          .mapFailures();

  @override
  Stream<Assignment?> watchAssignment(String id) => _assignments
      .doc(id)
      .snapshots()
      .map((snap) => snap.data())
      .mapFailures();

  @override
  Future<Assignment?> getAssignment(String id) async {
    try {
      final snap = await _assignments.doc(id).get();
      return snap.data();
    } catch (error, stackTrace) {
      throw mapErrorToFailure(error, stackTrace);
    }
  }

  @override
  Future<String> createAssignment(Assignment a) async {
    try {
      final ref = await _assignments.add(a);
      return ref.id;
    } catch (error, stackTrace) {
      throw mapErrorToFailure(error, stackTrace);
    }
  }

  @override
  Future<void> updateAssignment(Assignment a) async {
    try {
      await _assignments.doc(a.assignmentId).set(
            a.copyWith(updatedAt: DateTime.now()),
            SetOptions(merge: true),
          );
    } catch (error, stackTrace) {
      throw mapErrorToFailure(error, stackTrace);
    }
  }

  @override
  Future<void> setPublished(String id, bool value) async {
    try {
      await _db.collection('assignments').doc(id).update({
        'isPublished': value,
        'updatedAt': FieldValue.serverTimestamp(),
      });
    } catch (error, stackTrace) {
      throw mapErrorToFailure(error, stackTrace);
    }
  }

  @override
  Future<void> deleteAssignment(String id) async {
    try {
      await _db.collection('assignments').doc(id).delete();
    } catch (error, stackTrace) {
      throw mapErrorToFailure(error, stackTrace);
    }
  }
}
