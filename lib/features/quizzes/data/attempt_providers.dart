import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../firebase/firebase_providers.dart';
import '../../auth/data/auth_providers.dart';
import '../domain/quiz_attempt.dart';
import '../domain/quiz_attempt_repository.dart';
import 'firestore_quiz_attempt_repository.dart';

part 'attempt_providers.g.dart';

/// Репозиторий попыток прохождения квиза (шаги 23–24).
@Riverpod(keepAlive: true)
QuizAttemptRepository quizAttemptRepository(Ref ref) =>
    FirestoreQuizAttemptRepository(
      ref.watch(firestoreProvider),
      ref.watch(firebaseFunctionsProvider),
    );

/// Одна попытка по id (экран прохождения/результата).
@riverpod
Stream<QuizAttempt?> attemptById(Ref ref, String attemptId) =>
    ref.watch(quizAttemptRepositoryProvider).watchAttempt(attemptId);

/// Активная (незавершённая) попытка текущего студента по квизу.
@riverpod
Stream<QuizAttempt?> activeAttempt(Ref ref, String quizId) {
  final uid = ref.watch(appUserProvider).valueOrNull?.uid;
  if (uid == null) return Stream.value(null);
  return ref.watch(quizAttemptRepositoryProvider).watchActiveAttempt(
        quizId,
        uid,
      );
}

/// История попыток текущего студента по квизу.
@riverpod
Stream<List<QuizAttempt>> myAttempts(Ref ref, String quizId) {
  final uid = ref.watch(appUserProvider).valueOrNull?.uid;
  if (uid == null) return Stream.value(const <QuizAttempt>[]);
  return ref.watch(quizAttemptRepositoryProvider).watchAttempts(quizId, uid);
}

/// Все попытки по квизу — экран результатов преподавателя (P2-18).
@riverpod
Stream<List<QuizAttempt>> quizAllAttempts(Ref ref, String quizId) =>
    ref.watch(quizAttemptRepositoryProvider).watchAllAttempts(quizId);
