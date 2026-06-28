import 'dart:typed_data';

import 'submission.dart';
import 'submission_status.dart';

/// Контракт доступа к ответам студентов (ТЗ §7.8).
///
/// Студент работает только со своим ответом ([watchMySubmission]),
/// преподаватель видит все ответы задания ([watchSubmissionsForAssignment]).
/// Разграничение прав — в правилах (шаг 27).
abstract class SubmissionRepository {
  /// Ответ текущего студента на задание (поток, для экрана отправки).
  Stream<Submission?> watchMySubmission(String assignmentId, String studentId);

  /// Все ответы на задание (поток, для преподавателя).
  Stream<List<Submission>> watchSubmissionsForAssignment(String assignmentId);

  /// Разовое чтение своего ответа (без подписки).
  Future<Submission?> getMySubmission(String assignmentId, String studentId);

  /// Сохраняет черновик (`status` = draft), не отправляя его.
  Future<void> saveDraft(Submission s);

  /// Отправляет ответ: `status` = submitted, `submittedAt` — серверное время.
  Future<void> submit(Submission s);

  /// Загружает файл ответа в Storage и возвращает download URL.
  /// Путь: `submissions/<assignmentId>/<studentId>/<fileName>`.
  Future<String> uploadFile({
    required String assignmentId,
    required String studentId,
    required String fileName,
    required Uint8List bytes,
    String? contentType,
  });

  /// Меняет статус ответа (вызывается фичей проверки/оценивания, шаг 19).
  Future<void> setStatus(
    String submissionId,
    SubmissionStatus status, {
    String? teacherComment,
    String? gradeId,
  });
}
