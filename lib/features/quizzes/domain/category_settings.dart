import 'package:freezed_annotation/freezed_annotation.dart';

part 'category_settings.freezed.dart';
part 'category_settings.g.dart';

/// Категория выборки вопросов квиза (ТЗ §5.7, шаг 22).
///
/// `basis` — основание группировки (topic/type/difficulty), `questionCount`
/// — сколько вопросов взять, `pointsPerQuestion` — баллов за вопрос,
/// `required` — обязательна ли категория, `order` — порядок отображения.
@freezed
abstract class QuizCategory with _$QuizCategory {
  const factory QuizCategory({
    @Default('topic') String basis,
    @Default(0) int questionCount,
    @Default(1) int pointsPerQuestion,
    @Default(true) bool required,
    @Default(0) int order,
  }) = _QuizCategory;

  factory QuizCategory.fromJson(Map<String, dynamic> json) =>
      _$QuizCategoryFromJson(json);
}

/// Набор категорий выборки квиза (вложенная карта `categorySettings`).
///
/// Все поля имеют значения по умолчанию — `const CategorySettings()`
/// используется как default в [Quiz].
@freezed
abstract class CategorySettings with _$CategorySettings {
  const factory CategorySettings({
    @Default(<QuizCategory>[]) List<QuizCategory> categories,
  }) = _CategorySettings;

  factory CategorySettings.fromJson(Map<String, dynamic> json) =>
      _$CategorySettingsFromJson(json);
}
