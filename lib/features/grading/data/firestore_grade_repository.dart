import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../core/error/error_mapper.dart';
import '../domain/grade.dart';
import '../domain/grade_history_entry.dart';
import '../domain/grade_repository.dart';
import '../domain/grade_source_type.dart';

/// Реализация [GradeRepository] поверх Firestore. Ошибки → `Failure`.
class FirestoreGradeRepository implements GradeRepository {
  FirestoreGradeRepository(this._db);

  final FirebaseFirestore _db;

  CollectionReference<Grade> get _grades =>
      _db.collection('grades').withConverter<Grade>(
            fromFirestore: (snap, _) =>
                Grade.fromJson({...?snap.data(), 'gradeId': snap.id}),
            toFirestore: (grade, _) => grade.toJson()..remove('gradeId'),
          );

  CollectionReference<Map<String, dynamic>> get _submissions =>
      _db.collection('submissions');

  @override
  Stream<List<Grade>> watchGradesForStudent(String studentId) => _grades
      .where('studentId', isEqualTo: studentId)
      .snapshots()
      .map((s) => s.docs.map((d) => d.data()).toList())
      .mapFailures();

  @override
  Stream<List<Grade>> watchGradesForCourse(String courseId) => _grades
      .where('courseId', isEqualTo: courseId)
      .snapshots()
      .map((s) => s.docs.map((d) => d.data()).toList())
      .mapFailures();

  @override
  Stream<Grade?> watchGrade(String id) =>
      _grades.doc(id).snapshots().map((snap) => snap.data()).mapFailures();

  @override
  Future<Map<String, dynamic>?> getSubmissionRaw(String submissionId) async {
    try {
      final snap = await _submissions.doc(submissionId).get();
      final data = snap.data();
      if (data == null) return null;
      return {...data, 'submissionId': snap.id};
    } catch (error, stackTrace) {
      throw mapErrorToFailure(error, stackTrace);
    }
  }

  @override
  Future<void> gradeSubmission({
    required String submissionId,
    required String assignmentId,
    required String studentId,
    required String courseId,
    required String teacherId,
    required num score,
    required num maxScore,
    String? comment,
    String? groupId,
  }) async {
    try {
      final gradeId = '${assignmentId}_$studentId';
      final percentage = maxScore == 0 ? 0 : score / maxScore;
      final now = DateTime.now();

      final gradeRef = _grades.doc(gradeId);
      final existing = (await gradeRef.get()).data();
      final history = [
        ...existing?.history ?? const <GradeHistoryEntry>[],
        GradeHistoryEntry(
          score: score,
          comment: comment,
          changedBy: teacherId,
          changedAt: now,
        ),
      ];

      final grade = Grade(
        gradeId: gradeId,
        studentId: studentId,
        teacherId: teacherId,
        courseId: courseId,
        groupId: groupId,
        sourceType: GradeSourceType.assignment,
        // sourceId — идентификатор источника оценки = задание (а не отправка, P5).
        sourceId: assignmentId,
        score: score,
        maxScore: maxScore,
        percentage: percentage,
        comment: comment,
        createdAt: existing?.createdAt ?? now,
        updatedAt: now,
        history: history,
      );

      final batch = _db.batch();
      batch.set(gradeRef, grade);
      batch.update(_submissions.doc(submissionId), {
        'status': 'graded',
        'gradeId': gradeId,
        'teacherComment': comment,
      });
      await batch.commit();
    } catch (error, stackTrace) {
      throw mapErrorToFailure(error, stackTrace);
    }
  }

  @override
  Future<void> setSubmissionStatus(
    String submissionId,
    String status, {
    String? teacherComment,
  }) async {
    try {
      await _submissions.doc(submissionId).update({
        'status': status,
        'teacherComment': ?teacherComment,
      });
    } catch (error, stackTrace) {
      throw mapErrorToFailure(error, stackTrace);
    }
  }

  @override
  Future<void> addManualGrade({
    required String studentId,
    required String courseId,
    required String teacherId,
    required num score,
    required num maxScore,
    String? comment,
    String? groupId,
  }) async {
    try {
      final percentage = maxScore == 0 ? 0 : score / maxScore;
      final now = DateTime.now();

      final gradeRef = _grades.doc();
      final grade = Grade(
        gradeId: gradeRef.id,
        studentId: studentId,
        teacherId: teacherId,
        courseId: courseId,
        groupId: groupId,
        sourceType: GradeSourceType.manual,
        score: score,
        maxScore: maxScore,
        percentage: percentage,
        comment: comment,
        createdAt: now,
        updatedAt: now,
        history: [
          GradeHistoryEntry(
            score: score,
            comment: comment,
            changedBy: teacherId,
            changedAt: now,
          ),
        ],
      );
      await gradeRef.set(grade);
    } catch (error, stackTrace) {
      throw mapErrorToFailure(error, stackTrace);
    }
  }

  @override
  Future<List<Grade>> queryGradebook({
    String? courseId,
    String? studentId,
  }) async {
    try {
      Query<Grade> query = _grades;
      if (courseId != null) {
        query = query.where('courseId', isEqualTo: courseId);
      }
      if (studentId != null) {
        query = query.where('studentId', isEqualTo: studentId);
      }
      final snap = await query.get();
      return snap.docs.map((d) => d.data()).toList();
    } catch (error, stackTrace) {
      throw mapErrorToFailure(error, stackTrace);
    }
  }
}
