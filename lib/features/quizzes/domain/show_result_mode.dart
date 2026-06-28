import 'package:json_annotation/json_annotation.dart';

/// Режим показа результатов квиза студенту (ТЗ §5.7, шаг 22/24).
///
/// Код хранится строкой (имя варианта), `fromCode` по умолчанию —
/// [ShowResultMode.scoreOnly] (показываем хотя бы балл).
enum ShowResultMode {
  @JsonValue('none')
  none('none', 'Ничего'),
  @JsonValue('scoreOnly')
  scoreOnly('scoreOnly', 'Только балл'),
  @JsonValue('scoreAndAnswers')
  scoreAndAnswers('scoreAndAnswers', 'Балл и ответы'),
  @JsonValue('scoreAnswersExplanations')
  scoreAnswersExplanations(
    'scoreAnswersExplanations',
    'Балл, ответы и пояснения',
  );

  const ShowResultMode(this.code, this.label);

  final String code;
  final String label;

  static ShowResultMode fromCode(String? code) =>
      ShowResultMode.values.firstWhere(
        (m) => m.code == code,
        orElse: () => ShowResultMode.scoreOnly,
      );
}
