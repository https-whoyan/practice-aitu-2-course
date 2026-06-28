import 'package:json_annotation/json_annotation.dart';

/// Сложность вопроса (ТЗ §5.5). Хранится кодом в `questionBank.difficulty`.
enum QuestionDifficulty {
  @JsonValue('basic')
  basic('basic', 'Базовый'),
  @JsonValue('medium')
  medium('medium', 'Средний'),
  @JsonValue('hard')
  hard('hard', 'Сложный');

  const QuestionDifficulty(this.code, this.label);

  final String code;
  final String label;

  static QuestionDifficulty fromCode(String? code) =>
      QuestionDifficulty.values.firstWhere(
        (d) => d.code == code,
        orElse: () => QuestionDifficulty.basic,
      );
}
