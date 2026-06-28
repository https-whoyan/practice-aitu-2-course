import 'grade.dart';

/// Контракт доступа к оценкам (ТЗ §7.9, §5.5).
///
/// Объединяет проверку работ (преподаватель), журнал оценок и просмотр оценок
/// студентом. Чтобы не тянуть зависимость на фичи `submissions`/`assignments`,
/// работа с документом отправки читается/обновляется «сырым» Firestore
/// ([getSubmissionRaw]/[setSubmissionStatus]).
abstract class GradeRepository {
  /// Все оценки одного студента (по всем курсам).
  Stream<List<Grade>> watchGradesForStudent(String studentId);

  /// Все оценки одного курса (журнал преподавателя).
  Stream<List<Grade>> watchGradesForCourse(String courseId);

  /// Одна оценка по id.
  Stream<Grade?> watchGrade(String id);

  /// «Сырой» документ отправки `submissions/{id}` (без модели Submission).
  Future<Map<String, dynamic>?> getSubmissionRaw(String submissionId);

  /// Выставляет оценку за задание и переводит отправку в статус `graded`.
  ///
  /// Пишет (батчем) документ `grades` с детерминированным id и обновляет
  /// `submissions/{submissionId}` (`status`, `gradeId`, `teacherComment`).
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
  });

  /// «Сырое» обновление статуса отправки (вернуть на доработку/принять).
  Future<void> setSubmissionStatus(
    String submissionId,
    String status, {
    String? teacherComment,
  });

  /// Проставляет оценку вручную (не привязана к отправке).
  Future<void> addManualGrade({
    required String studentId,
    required String courseId,
    required String teacherId,
    required num score,
    required num maxScore,
    String? comment,
    String? groupId,
  });

  /// Разовый запрос журнала оценок с фильтрами по курсу/студенту.
  Future<List<Grade>> queryGradebook({String? courseId, String? studentId});
}
