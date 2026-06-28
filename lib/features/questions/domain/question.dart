import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/utils/timestamp_converter.dart';
import 'question_difficulty.dart';
import 'question_status.dart';
import 'question_type.dart';

part 'question.freezed.dart';
part 'question.g.dart';

/// Вопрос банка ← коллекция `questionBank` (ТЗ §5.5).
///
/// Плоская модель (без union): один документ хранит поля всех типов, лишние
/// остаются пустыми/null. Это совпадает со схемой серверной функции
/// `importQuestions` и упрощает запросы/правила. `questionId` инжектится из
/// `doc.id` при чтении и удаляется при записи (см. репозиторий).
@freezed
abstract class Question with _$Question {
  const factory Question({
    required String questionId,
    @Default('') String ownerTeacherId,
    @Default(<String>[]) List<String> courseIds,
    @Default('') String text,
    @Default(QuestionType.single) QuestionType type,
    @Default('') String topic,
    @Default(<String>[]) List<String> tags,
    @Default(QuestionDifficulty.basic) QuestionDifficulty difficulty,
    @Default(1) int points,
    @Default('') String explanation,
    @Default(QuestionStatus.active) QuestionStatus status,
    @Default(<String>[]) List<String> options,
    int? correctIndex,
    @Default(<int>[]) List<int> correctIndexes,
    bool? correctBool,
    @Default(<String>[]) List<String> acceptedAnswers,
    @Default(false) bool caseSensitive,
    @Default(false) bool partialScoring,
    @TimestampConverter() required DateTime createdAt,
    @TimestampConverter() required DateTime updatedAt,
  }) = _Question;

  factory Question.fromJson(Map<String, dynamic> json) =>
      _$QuestionFromJson(json);
}
