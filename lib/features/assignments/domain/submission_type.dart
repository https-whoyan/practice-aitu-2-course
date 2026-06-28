import 'package:json_annotation/json_annotation.dart';

/// Тип отправки задания (ТЗ §7.7): чем студент отвечает на задание.
///
/// `none` — задание без отправки (например, оффлайн-активность), оценивается
/// преподавателем вручную.
enum SubmissionType {
  @JsonValue('text')
  text('text', 'Текст'),
  @JsonValue('link')
  link('link', 'Ссылка'),
  @JsonValue('file')
  file('file', 'Файл'),
  @JsonValue('combined')
  combined('combined', 'Комбинированный'),
  @JsonValue('none')
  none('none', 'Без отправки');

  const SubmissionType(this.code, this.label);

  final String code;
  final String label;

  static SubmissionType fromCode(String? code) =>
      SubmissionType.values.firstWhere(
        (t) => t.code == code,
        orElse: () => SubmissionType.text,
      );
}
