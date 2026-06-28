import 'package:json_annotation/json_annotation.dart';

/// Статус попытки прохождения квиза ← поле `status` документа `quizAttempts`
/// (ТЗ §5.7, шаги 23–24).
///
/// Жизненный цикл: создаётся сервером в [AttemptStatus.inProgress] →
/// студент отправляет → [AttemptStatus.submitted] → сервер оценивает →
/// [AttemptStatus.graded]. [AttemptStatus.expired] — просроченная попытка.
enum AttemptStatus {
  @JsonValue('inProgress')
  inProgress('inProgress', 'В процессе'),
  @JsonValue('submitted')
  submitted('submitted', 'Отправлено'),
  @JsonValue('graded')
  graded('graded', 'Оценено'),
  @JsonValue('expired')
  expired('expired', 'Истекло');

  const AttemptStatus(this.code, this.label);

  final String code;
  final String label;

  static AttemptStatus fromCode(String? code) => AttemptStatus.values.firstWhere(
        (s) => s.code == code,
        orElse: () => AttemptStatus.inProgress,
      );

  bool get isInProgress => this == AttemptStatus.inProgress;
  bool get isSubmitted => this == AttemptStatus.submitted;
  bool get isGraded => this == AttemptStatus.graded;
  bool get isExpired => this == AttemptStatus.expired;
}
