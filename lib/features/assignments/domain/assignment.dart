import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/utils/timestamp_converter.dart';
import 'submission_type.dart';

part 'assignment.freezed.dart';
part 'assignment.g.dart';

/// Задание курса ← коллекция `assignments` (ТЗ §7.7).
///
/// Привязано к курсу ([courseId]) и неделе ([weekId]). Публикация — флаг
/// [isPublished] (неопубликованные задания студент не видит, правила шага 27).
@freezed
abstract class Assignment with _$Assignment {
  const factory Assignment({
    required String assignmentId,
    required String courseId,
    required String weekId,
    @Default('') String title,
    @Default('') String description,
    @Default('') String instruction,
    @NullableTimestampConverter() DateTime? deadline,
    @Default(100) int maxScore,
    @Default(SubmissionType.text) SubmissionType submissionType,
    @Default(false) bool allowLateSubmission,
    /// Штраф за просрочку в процентах от балла (§5.4.6, P2-9). 0 — без штрафа.
    @Default(0) int latePenalty,
    @Default(false) bool isPublished,
    @TimestampConverter() required DateTime createdAt,
    @TimestampConverter() required DateTime updatedAt,
  }) = _Assignment;

  factory Assignment.fromJson(Map<String, dynamic> json) =>
      _$AssignmentFromJson(json);
}
