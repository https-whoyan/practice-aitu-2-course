import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';

import '../../../core/error/error_mapper.dart';
import '../domain/quiz_attempt.dart';
import '../domain/quiz_attempt_repository.dart';

/// Реализация [QuizAttemptRepository] поверх Firestore + Cloud Functions.
///
/// Старт попытки идёт через callable `startQuizAttempt` (серверная проверка
/// лимита/дедлайна и формирование снимка вопросов). Чтения — через
/// `withConverter` с инжектом `attemptId`; ошибки потоков → `Failure`.
class FirestoreQuizAttemptRepository implements QuizAttemptRepository {
  FirestoreQuizAttemptRepository(this._db, this._functions);

  final FirebaseFirestore _db;
  final FirebaseFunctions _functions;

  CollectionReference<QuizAttempt> get _attempts =>
      _db.collection('quizAttempts').withConverter<QuizAttempt>(
            fromFirestore: (snap, _) =>
                QuizAttempt.fromJson({...?snap.data(), 'attemptId': snap.id}),
            toFirestore: (attempt, _) => attempt.toJson()..remove('attemptId'),
          );

  @override
  Future<String> startAttempt(String quizId) async {
    try {
      final res = await _functions
          .httpsCallable('startQuizAttempt')
          .call<Map<Object?, Object?>>({'quizId': quizId});
      return Map<String, dynamic>.from(res.data)['attemptId'] as String;
    } catch (error, stackTrace) {
      throw mapErrorToFailure(error, stackTrace);
    }
  }

  @override
  Stream<QuizAttempt?> watchAttempt(String attemptId) => _attempts
      .doc(attemptId)
      .snapshots()
      .map((snap) => snap.data())
      .mapFailures();

  @override
  Stream<QuizAttempt?> watchActiveAttempt(String quizId, String studentId) =>
      _attempts
          .where('quizId', isEqualTo: quizId)
          .where('studentId', isEqualTo: studentId)
          .where('status', isEqualTo: 'inProgress')
          .limit(1)
          .snapshots()
          .map((s) => s.docs.isEmpty ? null : s.docs.first.data())
          .mapFailures();

  @override
  Stream<List<QuizAttempt>> watchAttempts(String quizId, String studentId) =>
      _attempts
          .where('quizId', isEqualTo: quizId)
          .where('studentId', isEqualTo: studentId)
          .snapshots()
          .map((s) => s.docs.map((d) => d.data()).toList())
          .mapFailures();

  @override
  Stream<List<QuizAttempt>> watchAllAttempts(String quizId) => _attempts
      .where('quizId', isEqualTo: quizId)
      .snapshots()
      .map((s) => s.docs.map((d) => d.data()).toList())
      .mapFailures();

  @override
  Future<void> saveAnswers(
    String attemptId,
    Map<String, dynamic> answers,
  ) async {
    try {
      await _db.collection('quizAttempts').doc(attemptId).update({
        'answers': answers,
      });
    } catch (error, stackTrace) {
      throw mapErrorToFailure(error, stackTrace);
    }
  }

  @override
  Future<void> submitAttempt(String attemptId) async {
    try {
      await _db.collection('quizAttempts').doc(attemptId).update({
        'status': 'submitted',
        'finishedAt': FieldValue.serverTimestamp(),
      });
    } catch (error, stackTrace) {
      throw mapErrorToFailure(error, stackTrace);
    }
  }
}
