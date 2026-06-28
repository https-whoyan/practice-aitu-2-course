import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/utils/timestamp_converter.dart';
import 'category_settings.dart';
import 'randomizer_settings.dart';
import 'show_result_mode.dart';

part 'quiz.freezed.dart';
part 'quiz.g.dart';

/// Квиз ← коллекция `quizzes` (ТЗ §5.7, шаги 22–24).
///
/// `quizId` — id документа, инжектится при чтении (в документе не дублируется).
/// Выборка вопросов задаётся [randomizerSettings] и [categorySettings];
/// `questionIds` хранит ручной список (для MVP — пуст, шаг 20).
@freezed
abstract class Quiz with _$Quiz {
  const factory Quiz({
    required String quizId,
    @Default('') String courseId,
    String? weekId,
    @Default('') String ownerTeacherId,
    @Default('') String title,
    @Default('') String description,
    @Default(<String>[]) List<String> questionIds,
    @Default(RandomizerSettings()) RandomizerSettings randomizerSettings,
    @Default(CategorySettings()) CategorySettings categorySettings,
    @NullableTimestampConverter() DateTime? startDate,
    @NullableTimestampConverter() DateTime? deadline,
    int? timeLimitMinutes,
    @Default(1) int attemptsAllowed,
    @Default(ShowResultMode.scoreOnly) ShowResultMode showResultMode,
    @Default(0) int maxScore,
    @Default(false) bool isPublished,
    @TimestampConverter() required DateTime createdAt,
    @TimestampConverter() required DateTime updatedAt,
  }) = _Quiz;

  factory Quiz.fromJson(Map<String, dynamic> json) => _$QuizFromJson(json);
}
