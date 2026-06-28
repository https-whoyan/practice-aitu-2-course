import 'question.dart';

/// Контракт доступа к банку вопросов (ТЗ §5.5).
///
/// Вопросы принадлежат преподавателю (`ownerTeacherId`) и могут прикрепляться
/// к нескольким курсам (`courseIds`). Удаление мягкое через [archiveQuestion];
/// [deleteQuestion] — физическое (только для черновиков/импорта).
abstract class QuestionRepository {
  /// Все вопросы преподавателя (новые сверху).
  Stream<List<Question>> watchQuestions(String ownerTeacherId);

  Future<Question?> getQuestion(String id);

  /// Создаёт вопрос, возвращает новый id.
  Future<String> createQuestion(Question q);

  Future<void> updateQuestion(Question q);

  /// Мягкое удаление — перевод в архив.
  Future<void> archiveQuestion(String id);

  /// Физическое удаление документа.
  Future<void> deleteQuestion(String id);

  /// Создаёт независимую копию вопроса (новый id), возвращает её id.
  Future<String> duplicateQuestion(String id);

  /// Прикрепляет вопрос к курсам (arrayUnion по `courseIds`).
  Future<void> attachToCourses(String id, List<String> courseIds);
}
