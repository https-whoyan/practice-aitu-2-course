// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Question _$QuestionFromJson(Map<String, dynamic> json) => _Question(
  questionId: json['questionId'] as String,
  ownerTeacherId: json['ownerTeacherId'] as String? ?? '',
  courseIds:
      (json['courseIds'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const <String>[],
  text: json['text'] as String? ?? '',
  type:
      $enumDecodeNullable(_$QuestionTypeEnumMap, json['type']) ??
      QuestionType.single,
  topic: json['topic'] as String? ?? '',
  tags:
      (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const <String>[],
  difficulty:
      $enumDecodeNullable(_$QuestionDifficultyEnumMap, json['difficulty']) ??
      QuestionDifficulty.basic,
  points: (json['points'] as num?)?.toInt() ?? 1,
  explanation: json['explanation'] as String? ?? '',
  status:
      $enumDecodeNullable(_$QuestionStatusEnumMap, json['status']) ??
      QuestionStatus.active,
  options:
      (json['options'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const <String>[],
  correctIndex: (json['correctIndex'] as num?)?.toInt(),
  correctIndexes:
      (json['correctIndexes'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList() ??
      const <int>[],
  correctBool: json['correctBool'] as bool?,
  acceptedAnswers:
      (json['acceptedAnswers'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const <String>[],
  caseSensitive: json['caseSensitive'] as bool? ?? false,
  partialScoring: json['partialScoring'] as bool? ?? false,
  createdAt: const TimestampConverter().fromJson(
    json['createdAt'] as Timestamp,
  ),
  updatedAt: const TimestampConverter().fromJson(
    json['updatedAt'] as Timestamp,
  ),
);

Map<String, dynamic> _$QuestionToJson(_Question instance) => <String, dynamic>{
  'questionId': instance.questionId,
  'ownerTeacherId': instance.ownerTeacherId,
  'courseIds': instance.courseIds,
  'text': instance.text,
  'type': _$QuestionTypeEnumMap[instance.type]!,
  'topic': instance.topic,
  'tags': instance.tags,
  'difficulty': _$QuestionDifficultyEnumMap[instance.difficulty]!,
  'points': instance.points,
  'explanation': instance.explanation,
  'status': _$QuestionStatusEnumMap[instance.status]!,
  'options': instance.options,
  'correctIndex': instance.correctIndex,
  'correctIndexes': instance.correctIndexes,
  'correctBool': instance.correctBool,
  'acceptedAnswers': instance.acceptedAnswers,
  'caseSensitive': instance.caseSensitive,
  'partialScoring': instance.partialScoring,
  'createdAt': const TimestampConverter().toJson(instance.createdAt),
  'updatedAt': const TimestampConverter().toJson(instance.updatedAt),
};

const _$QuestionTypeEnumMap = {
  QuestionType.single: 'single',
  QuestionType.multiple: 'multiple',
  QuestionType.trueFalse: 'trueFalse',
  QuestionType.shortText: 'shortText',
  QuestionType.matching: 'matching',
  QuestionType.dragDrop: 'dragDrop',
  QuestionType.ordering: 'ordering',
  QuestionType.fillBlank: 'fillBlank',
  QuestionType.numeric: 'numeric',
  QuestionType.image: 'image',
  QuestionType.codeType: 'code',
  QuestionType.multiCategory: 'multiCategory',
};

const _$QuestionDifficultyEnumMap = {
  QuestionDifficulty.basic: 'basic',
  QuestionDifficulty.medium: 'medium',
  QuestionDifficulty.hard: 'hard',
};

const _$QuestionStatusEnumMap = {
  QuestionStatus.active: 'active',
  QuestionStatus.draft: 'draft',
  QuestionStatus.archived: 'archived',
};
