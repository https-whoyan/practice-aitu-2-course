import 'package:json_annotation/json_annotation.dart';

/// Статус ответа студента (ТЗ §7.8).
///
/// Жизненный цикл: `draft` (черновик студента) → `submitted` (отправлено) →
/// `inReview`/`returned`/`accepted` (решение преподавателя) → `graded`
/// (выставлена оценка). [code] совпадает с `name` — единое значение для
/// хранения в Firestore и сравнения в правилах (шаг 27).
enum SubmissionStatus {
  @JsonValue('draft')
  draft('draft', 'Черновик'),
  @JsonValue('submitted')
  submitted('submitted', 'Отправлено'),
  @JsonValue('inReview')
  inReview('inReview', 'Проверяется'),
  @JsonValue('returned')
  returned('returned', 'Возвращено'),
  @JsonValue('rejected')
  rejected('rejected', 'Не принято'),
  @JsonValue('accepted')
  accepted('accepted', 'Принято'),
  @JsonValue('graded')
  graded('graded', 'Оценено');

  const SubmissionStatus(this.code, this.label);

  final String code;
  final String label;

  static SubmissionStatus fromCode(String? code) => SubmissionStatus.values.firstWhere(
        (s) => s.code == code,
        orElse: () => SubmissionStatus.draft,
      );
}
