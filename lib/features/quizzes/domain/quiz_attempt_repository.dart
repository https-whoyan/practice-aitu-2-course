import 'quiz_attempt.dart';

/// Контракт доступа к попыткам прохождения квиза (ТЗ §5.7, шаги 23–24).
///
/// Старт попытки — только через серверную функцию `startQuizAttempt`
/// (проверка лимита попыток/дедлайна/выборки вопросов). Клиент далее читает
/// снимок и обновляет ответы/статус; оценивание выполняет сервер.
abstract class QuizAttemptRepository {
  /// Запускает попытку через Cloud Function `startQuizAttempt`.
  /// Возвращает `attemptId` созданного документа.
  Future<String> startAttempt(String quizId);

  /// Одна попытка по id.
  Stream<QuizAttempt?> watchAttempt(String attemptId);

  /// Активная (незавершённая) попытка студента по квизу, если есть.
  Stream<QuizAttempt?> watchActiveAttempt(String quizId, String studentId);

  /// История попыток студента по квизу.
  Stream<List<QuizAttempt>> watchAttempts(String quizId, String studentId);

  /// Все попытки по квизу — для экрана результатов преподавателя (P2-18).
  Stream<List<QuizAttempt>> watchAllAttempts(String quizId);

  /// Сохраняет ответы (черновик), не завершая попытку.
  Future<void> saveAnswers(String attemptId, Map<String, dynamic> answers);

  /// Завершает попытку: `status='submitted'`, `finishedAt` — серверное время.
  Future<void> submitAttempt(String attemptId);
}
