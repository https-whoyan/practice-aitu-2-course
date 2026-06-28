import 'package:freezed_annotation/freezed_annotation.dart';

part 'randomizer_settings.freezed.dart';
part 'randomizer_settings.g.dart';

/// Настройки рандомайзера выборки вопросов для квиза (ТЗ §5.7, шаг 22).
///
/// Все поля имеют значения по умолчанию — `const RandomizerSettings()`
/// используется как default в [Quiz]. Карты `byTopic`/`byType`/`byDifficulty`
/// задают сколько вопросов брать по теме/типу/сложности (для MVP пустые).
@freezed
abstract class RandomizerSettings with _$RandomizerSettings {
  const factory RandomizerSettings({
    @Default(0) int totalQuestions,
    @Default(<String, int>{}) Map<String, int> byTopic,
    @Default(<String, int>{}) Map<String, int> byType,
    @Default(<String, int>{}) Map<String, int> byDifficulty,
    int? minHard,
    int? maxBasic,
    @Default(false) bool shuffleQuestions,
    @Default(false) bool shuffleOptions,
    @Default(true) bool excludeDuplicates,
  }) = _RandomizerSettings;

  factory RandomizerSettings.fromJson(Map<String, dynamic> json) =>
      _$RandomizerSettingsFromJson(json);
}
