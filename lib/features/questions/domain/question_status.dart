import 'package:json_annotation/json_annotation.dart';

/// Статус вопроса банка (ТЗ §5.5): активный / черновик / архив.
enum QuestionStatus {
  @JsonValue('active')
  active('active', 'Активный'),
  @JsonValue('draft')
  draft('draft', 'Черновик'),
  @JsonValue('archived')
  archived('archived', 'В архиве');

  const QuestionStatus(this.code, this.label);

  final String code;
  final String label;

  static QuestionStatus fromCode(String? code) =>
      QuestionStatus.values.firstWhere(
        (s) => s.code == code,
        orElse: () => QuestionStatus.active,
      );

  bool get isActive => this == QuestionStatus.active;
  bool get isArchived => this == QuestionStatus.archived;
}
