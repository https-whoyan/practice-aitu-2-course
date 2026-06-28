import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/utils/timestamp_converter.dart';
import 'submission_status.dart';

part 'submission.freezed.dart';
part 'submission.g.dart';

/// Ответ студента на задание ← коллекция `submissions` (ТЗ §7.8).
///
/// Один документ на пару студент×задание: id детерминирован ([idFor]), поэтому
/// `set(merge)` обновляет тот же черновик без дублей. `submittedAt` ставится
/// серверным временем при отправке (шаг 18), `gradeId`/`teacherComment`
/// заполняет преподаватель при проверке (шаг 19).
@freezed
abstract class Submission with _$Submission {
  const Submission._();

  const factory Submission({
    required String submissionId,
    required String assignmentId,
    required String courseId,
    required String studentId,
    String? textAnswer,
    @Default(<String>[]) List<String> fileUrls,
    String? linkAnswer,
    @Default(SubmissionStatus.draft) SubmissionStatus status,
    @NullableTimestampConverter() DateTime? submittedAt,
    @TimestampConverter() required DateTime updatedAt,
    String? teacherComment,
    String? gradeId,
  }) = _Submission;

  factory Submission.fromJson(Map<String, dynamic> json) =>
      _$SubmissionFromJson(json);

  /// Детерминированный id документа: одна попытка на студента×задание.
  static String idFor(String assignmentId, String studentId) =>
      '${assignmentId}_$studentId';
}
