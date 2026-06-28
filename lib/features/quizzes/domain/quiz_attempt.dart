import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/utils/timestamp_converter.dart';
import 'attempt_status.dart';
import 'question_snapshot_item.dart';

part 'quiz_attempt.freezed.dart';
part 'quiz_attempt.g.dart';

/// Попытка прохождения квиза ← коллекция `quizAttempts` (ТЗ §5.7, шаги 23–24).
///
/// `attemptId` — id документа, инжектится при чтении (в документе не
/// дублируется). Создаётся серверной функцией `startQuizAttempt`; клиент только
/// читает снимок и обновляет `answers`/`status`. `revealed` появляется только
/// после оценивания (если квиз настроен показывать правильные ответы).
@freezed
abstract class QuizAttempt with _$QuizAttempt {
  const factory QuizAttempt({
    required String attemptId,
    @Default('') String quizId,
    @Default('') String studentId,
    String? courseId,
    @Default(<QuestionSnapshotItem>[])
    List<QuestionSnapshotItem> questionSnapshot,
    @Default(<String, dynamic>{}) Map<String, dynamic> answers,
    @NullableTimestampConverter() DateTime? startedAt,
    @NullableTimestampConverter() DateTime? finishedAt,
    num? score,
    @Default(0) num maxScore,
    num? percentage,
    @Default(AttemptStatus.inProgress) AttemptStatus status,
    @Default(1) int attemptNumber,
    Map<String, dynamic>? revealed,
  }) = _QuizAttempt;

  factory QuizAttempt.fromJson(Map<String, dynamic> json) =>
      _$QuizAttemptFromJson(json);
}
