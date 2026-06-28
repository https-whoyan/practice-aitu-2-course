// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question_snapshot_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_QuestionSnapshotItem _$QuestionSnapshotItemFromJson(
  Map<String, dynamic> json,
) => _QuestionSnapshotItem(
  questionId: json['questionId'] as String,
  text: json['text'] as String? ?? '',
  type: json['type'] as String? ?? '',
  options:
      (json['options'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const <String>[],
  optionOrder:
      (json['optionOrder'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList() ??
      const <int>[],
  points: (json['points'] as num?)?.toInt() ?? 1,
);

Map<String, dynamic> _$QuestionSnapshotItemToJson(
  _QuestionSnapshotItem instance,
) => <String, dynamic>{
  'questionId': instance.questionId,
  'text': instance.text,
  'type': instance.type,
  'options': instance.options,
  'optionOrder': instance.optionOrder,
  'points': instance.points,
};
