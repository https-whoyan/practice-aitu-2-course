import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../core/error/error_mapper.dart';
import '../domain/quiz.dart';
import '../domain/quiz_repository.dart';

/// Реализация [QuizRepository] поверх Firestore. Ошибки → `Failure`.
class FirestoreQuizRepository implements QuizRepository {
  FirestoreQuizRepository(this._db);

  final FirebaseFirestore _db;

  CollectionReference<Quiz> get _quizzes =>
      _db.collection('quizzes').withConverter<Quiz>(
            fromFirestore: (snap, _) =>
                Quiz.fromJson({...?snap.data(), 'quizId': snap.id}),
            toFirestore: (quiz, _) => quiz.toJson()..remove('quizId'),
          );

  @override
  Stream<List<Quiz>> watchQuizzes(String courseId) => _quizzes
      .where('courseId', isEqualTo: courseId)
      .orderBy('createdAt')
      .snapshots()
      .map((s) => s.docs.map((d) => d.data()).toList())
      .mapFailures();

  @override
  Stream<List<Quiz>> watchPublishedQuizzes(String courseId) => _quizzes
      .where('courseId', isEqualTo: courseId)
      .where('isPublished', isEqualTo: true)
      .orderBy('createdAt')
      .snapshots()
      .map((s) => s.docs.map((d) => d.data()).toList())
      .mapFailures();

  @override
  Stream<Quiz?> watchQuiz(String id) => _quizzes
      .doc(id)
      .snapshots()
      .map((snap) => snap.data())
      .mapFailures();

  @override
  Future<Quiz?> getQuiz(String id) async {
    try {
      final snap = await _quizzes.doc(id).get();
      return snap.data();
    } catch (error, stackTrace) {
      throw mapErrorToFailure(error, stackTrace);
    }
  }

  @override
  Future<String> createQuiz(Quiz q) async {
    try {
      final ref = await _quizzes.add(q);
      return ref.id;
    } catch (error, stackTrace) {
      throw mapErrorToFailure(error, stackTrace);
    }
  }

  @override
  Future<void> updateQuiz(Quiz q) async {
    try {
      await _quizzes.doc(q.quizId).set(
            q.copyWith(updatedAt: DateTime.now()),
            SetOptions(merge: true),
          );
    } catch (error, stackTrace) {
      throw mapErrorToFailure(error, stackTrace);
    }
  }

  @override
  Future<void> setPublished(String id, bool value) async {
    try {
      await _db.collection('quizzes').doc(id).update({
        'isPublished': value,
        'updatedAt': FieldValue.serverTimestamp(),
      });
    } catch (error, stackTrace) {
      throw mapErrorToFailure(error, stackTrace);
    }
  }

  @override
  Future<void> deleteQuiz(String id) async {
    try {
      await _db.collection('quizzes').doc(id).delete();
    } catch (error, stackTrace) {
      throw mapErrorToFailure(error, stackTrace);
    }
  }
}
