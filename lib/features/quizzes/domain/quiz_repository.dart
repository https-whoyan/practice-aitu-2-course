import 'quiz.dart';

/// Контракт доступа к квизам (ТЗ §7.7, §5.7).
///
/// Общий контракт для преподавателя (конструктор квизов, шаг 22) и студента
/// (прохождение, шаг 23) — различие только в правах (правила шага 27).
abstract class QuizRepository {
  /// Все квизы курса (для преподавателя).
  Stream<List<Quiz>> watchQuizzes(String courseId);

  /// Только опубликованные квизы (для студента).
  Stream<List<Quiz>> watchPublishedQuizzes(String courseId);

  /// Поток одного квиза по id.
  Stream<Quiz?> watchQuiz(String id);

  Future<Quiz?> getQuiz(String id);

  /// Создаёт квиз, возвращает id.
  Future<String> createQuiz(Quiz q);

  Future<void> updateQuiz(Quiz q);

  Future<void> setPublished(String id, bool value);

  Future<void> deleteQuiz(String id);
}
