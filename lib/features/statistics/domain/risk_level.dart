import 'package:json_annotation/json_annotation.dart';

/// Уровень риска студента (агрегат `studentSummaries`, шаг 25).
///
/// Считается на сервере (Cloud Function); клиент только читает.
/// Коды (`@JsonValue`) совпадают с именами значений: low/medium/high.
enum RiskLevel {
  @JsonValue('low')
  low('low', 'Низкий'),
  @JsonValue('medium')
  medium('medium', 'Средний'),
  @JsonValue('high')
  high('high', 'Высокий');

  const RiskLevel(this.code, this.label);

  final String code;
  final String label;

  static RiskLevel fromCode(String? code) => RiskLevel.values.firstWhere(
        (r) => r.code == code,
        orElse: () => RiskLevel.low,
      );
}
