import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../../core/error/error_mapper.dart';
import '../domain/submission.dart';
import '../domain/submission_repository.dart';
import '../domain/submission_status.dart';

/// Реализация [SubmissionRepository] поверх Firestore + Storage.
///
/// Документ адресуется детерминированным id ([Submission.idFor]) — `set(merge)`
/// обновляет единственный ответ студента без создания дублей. Ошибки → `Failure`.
class FirestoreSubmissionRepository implements SubmissionRepository {
  FirestoreSubmissionRepository(this._db, this._storage);

  final FirebaseFirestore _db;
  final FirebaseStorage _storage;

  CollectionReference<Submission> get _submissions =>
      _db.collection('submissions').withConverter<Submission>(
            fromFirestore: (snap, _) =>
                Submission.fromJson({...?snap.data(), 'submissionId': snap.id}),
            toFirestore: (s, _) => s.toJson()..remove('submissionId'),
          );

  @override
  Stream<Submission?> watchMySubmission(String assignmentId, String studentId) =>
      _submissions
          .doc(Submission.idFor(assignmentId, studentId))
          .snapshots()
          .map((snap) => snap.data())
          .mapFailures();

  @override
  Stream<List<Submission>> watchSubmissionsForAssignment(String assignmentId) =>
      _submissions
          .where('assignmentId', isEqualTo: assignmentId)
          .snapshots()
          .map((s) => s.docs.map((d) => d.data()).toList())
          .mapFailures();

  @override
  Future<Submission?> getMySubmission(
    String assignmentId,
    String studentId,
  ) async {
    try {
      final snap =
          await _submissions.doc(Submission.idFor(assignmentId, studentId)).get();
      return snap.data();
    } catch (error, stackTrace) {
      throw mapErrorToFailure(error, stackTrace);
    }
  }

  @override
  Future<void> saveDraft(Submission s) async {
    try {
      await _submissions.doc(Submission.idFor(s.assignmentId, s.studentId)).set(
            s.copyWith(
              status: SubmissionStatus.draft,
              updatedAt: DateTime.now(),
            ),
            SetOptions(merge: true),
          );
    } catch (error, stackTrace) {
      throw mapErrorToFailure(error, stackTrace);
    }
  }

  @override
  Future<void> submit(Submission s) async {
    try {
      final id = Submission.idFor(s.assignmentId, s.studentId);
      // Сначала пишем сам ответ (через конвертер), затем фиксируем статус и
      // время отправки серверным временем — надёжнее клиентских часов.
      await _submissions.doc(id).set(
            s.copyWith(
              status: SubmissionStatus.submitted,
              updatedAt: DateTime.now(),
            ),
            SetOptions(merge: true),
          );
      await _db.collection('submissions').doc(id).update({
        'status': SubmissionStatus.submitted.code,
        'submittedAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      });
    } catch (error, stackTrace) {
      throw mapErrorToFailure(error, stackTrace);
    }
  }

  @override
  Future<String> uploadFile({
    required String assignmentId,
    required String studentId,
    required String fileName,
    required Uint8List bytes,
    String? contentType,
  }) async {
    try {
      final path = 'submissions/$assignmentId/$studentId/$fileName';
      final ref = _storage.ref(path);
      await ref.putData(bytes, SettableMetadata(contentType: contentType));
      return await ref.getDownloadURL();
    } catch (error, stackTrace) {
      throw mapErrorToFailure(error, stackTrace);
    }
  }

  @override
  Future<void> setStatus(
    String submissionId,
    SubmissionStatus status, {
    String? teacherComment,
    String? gradeId,
  }) async {
    try {
      await _db.collection('submissions').doc(submissionId).update({
        'status': status.code,
        'updatedAt': FieldValue.serverTimestamp(),
        'teacherComment': ?teacherComment,
        'gradeId': ?gradeId,
      });
    } catch (error, stackTrace) {
      throw mapErrorToFailure(error, stackTrace);
    }
  }
}
