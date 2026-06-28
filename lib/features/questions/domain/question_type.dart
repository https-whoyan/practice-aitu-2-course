import 'package:json_annotation/json_annotation.dart';

/// Тип вопроса банка (ТЗ §5.5). Хранится строковым кодом в `questionBank.type`.
///
/// MVP покрывает 4 типа ([isMvp]); остальные зарезервированы для следующих
/// итераций и при импорте помечаются предупреждением «тип вне MVP».
enum QuestionType {
  @JsonValue('single')
  single('single', 'Один ответ'),
  @JsonValue('multiple')
  multiple('multiple', 'Несколько ответов'),
  @JsonValue('trueFalse')
  trueFalse('trueFalse', 'Верно-неверно'),
  @JsonValue('shortText')
  shortText('shortText', 'Краткий текст'),
  @JsonValue('matching')
  matching('matching', 'Соответствие'),
  @JsonValue('dragDrop')
  dragDrop('dragDrop', 'Перетаскивание'),
  @JsonValue('ordering')
  ordering('ordering', 'Порядок'),
  @JsonValue('fillBlank')
  fillBlank('fillBlank', 'Пропуск'),
  @JsonValue('numeric')
  numeric('numeric', 'Число'),
  @JsonValue('image')
  image('image', 'Изображение'),
  @JsonValue('code')
  codeType('code', 'Код'),
  @JsonValue('multiCategory')
  multiCategory('multiCategory', 'Категории');

  const QuestionType(this.code, this.label);

  final String code;
  final String label;

  static QuestionType fromCode(String? code) => QuestionType.values.firstWhere(
        (t) => t.code == code,
        orElse: () => QuestionType.single,
      );

  /// Типы, поддержанные в MVP (форма + автопроверка).
  bool get isMvp => <QuestionType>{
        QuestionType.single,
        QuestionType.multiple,
        QuestionType.trueFalse,
        QuestionType.shortText,
      }.contains(this);
}
