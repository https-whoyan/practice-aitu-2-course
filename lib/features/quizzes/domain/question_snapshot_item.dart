import 'package:freezed_annotation/freezed_annotation.dart';

part 'question_snapshot_item.freezed.dart';
part 'question_snapshot_item.g.dart';

/// Снимок вопроса в попытке ← элемент массива `questionSnapshot` документа
/// `quizAttempts` (ТЗ §5.7, шаг 23).
///
/// Снимок фиксируется сервером при старте попытки и НЕ содержит правильных
/// ответов. `optionOrder` задаёт перемешанный порядок вариантов; клиент
/// сохраняет ответы как отображаемые позиции (а не исходные индексы).
@freezed
abstract class QuestionSnapshotItem with _$QuestionSnapshotItem {
  const factory QuestionSnapshotItem({
    required String questionId,
    @Default('') String text,
    @Default('') String type,
    @Default(<String>[]) List<String> options,
    @Default(<int>[]) List<int> optionOrder,
    @Default(1) int points,
  }) = _QuestionSnapshotItem;

  factory QuestionSnapshotItem.fromJson(Map<String, dynamic> json) =>
      _$QuestionSnapshotItemFromJson(json);
}
