import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../core/error/error_mapper.dart';
import '../../../core/error/failure.dart';
import '../domain/question.dart';
import '../domain/question_status.dart';
import '../domain/question_repository.dart';

/// Реализация [QuestionRepository] поверх коллекции `questionBank`.
/// Ошибки → `Failure` (как в остальных репозиториях).
class FirestoreQuestionRepository implements QuestionRepository {
  FirestoreQuestionRepository(this._db);

  final FirebaseFirestore _db;

  CollectionReference<Question> get _questions =>
      _db.collection('questionBank').withConverter<Question>(
            fromFirestore: (snap, _) =>
                Question.fromJson({...?snap.data(), 'questionId': snap.id}),
            toFirestore: (q, _) => q.toJson()..remove('questionId'),
          );

  @override
  Stream<List<Question>> watchQuestions(String ownerTeacherId) => _questions
      .where('ownerTeacherId', isEqualTo: ownerTeacherId)
      .orderBy('createdAt', descending: true)
      .snapshots()
      .map((s) => s.docs.map((d) => d.data()).toList())
      .mapFailures();

  @override
  Future<Question?> getQuestion(String id) async {
    try {
      final snap = await _questions.doc(id).get();
      return snap.data();
    } catch (error, stackTrace) {
      throw mapErrorToFailure(error, stackTrace);
    }
  }

  @override
  Future<String> createQuestion(Question q) async {
    try {
      final ref = await _questions.add(q);
      return ref.id;
    } catch (error, stackTrace) {
      throw mapErrorToFailure(error, stackTrace);
    }
  }

  @override
  Future<void> updateQuestion(Question q) async {
    try {
      await _questions.doc(q.questionId).set(
            q.copyWith(updatedAt: DateTime.now()),
            SetOptions(merge: true),
          );
    } catch (error, stackTrace) {
      throw mapErrorToFailure(error, stackTrace);
    }
  }

  @override
  Future<void> archiveQuestion(String id) async {
    try {
      await _db.collection('questionBank').doc(id).update({
        'status': QuestionStatus.archived.code,
        'updatedAt': FieldValue.serverTimestamp(),
      });
    } catch (error, stackTrace) {
      throw mapErrorToFailure(error, stackTrace);
    }
  }

  @override
  Future<void> deleteQuestion(String id) async {
    try {
      await _db.collection('questionBank').doc(id).delete();
    } catch (error, stackTrace) {
      throw mapErrorToFailure(error, stackTrace);
    }
  }

  @override
  Future<String> duplicateQuestion(String id) async {
    try {
      final snap = await _questions.doc(id).get();
      final original = snap.data();
      if (original == null) {
        throw const Failure.notFound(message: 'Вопрос не найден');
      }
      final now = DateTime.now();
      final copy = original.copyWith(
        questionId: '',
        status: QuestionStatus.active,
        createdAt: now,
        updatedAt: now,
      );
      final ref = await _questions.add(copy);
      return ref.id;
    } catch (error, stackTrace) {
      throw mapErrorToFailure(error, stackTrace);
    }
  }

  @override
  Future<void> attachToCourses(String id, List<String> courseIds) async {
    try {
      await _db.collection('questionBank').doc(id).update({
        'courseIds': FieldValue.arrayUnion(courseIds),
        'updatedAt': FieldValue.serverTimestamp(),
      });
    } catch (error, stackTrace) {
      throw mapErrorToFailure(error, stackTrace);
    }
  }
}
