// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quiz.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Quiz _$QuizFromJson(Map<String, dynamic> json) => _Quiz(
  quizId: json['quizId'] as String,
  courseId: json['courseId'] as String? ?? '',
  weekId: json['weekId'] as String?,
  ownerTeacherId: json['ownerTeacherId'] as String? ?? '',
  title: json['title'] as String? ?? '',
  description: json['description'] as String? ?? '',
  questionIds:
      (json['questionIds'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const <String>[],
  randomizerSettings: json['randomizerSettings'] == null
      ? const RandomizerSettings()
      : RandomizerSettings.fromJson(
          json['randomizerSettings'] as Map<String, dynamic>,
        ),
  categorySettings: json['categorySettings'] == null
      ? const CategorySettings()
      : CategorySettings.fromJson(
          json['categorySettings'] as Map<String, dynamic>,
        ),
  startDate: const NullableTimestampConverter().fromJson(
    json['startDate'] as Timestamp?,
  ),
  deadline: const NullableTimestampConverter().fromJson(
    json['deadline'] as Timestamp?,
  ),
  timeLimitMinutes: (json['timeLimitMinutes'] as num?)?.toInt(),
  attemptsAllowed: (json['attemptsAllowed'] as num?)?.toInt() ?? 1,
  showResultMode:
      $enumDecodeNullable(_$ShowResultModeEnumMap, json['showResultMode']) ??
      ShowResultMode.scoreOnly,
  maxScore: (json['maxScore'] as num?)?.toInt() ?? 0,
  isPublished: json['isPublished'] as bool? ?? false,
  createdAt: const TimestampConverter().fromJson(
    json['createdAt'] as Timestamp,
  ),
  updatedAt: const TimestampConverter().fromJson(
    json['updatedAt'] as Timestamp,
  ),
);

Map<String, dynamic> _$QuizToJson(_Quiz instance) => <String, dynamic>{
  'quizId': instance.quizId,
  'courseId': instance.courseId,
  'weekId': instance.weekId,
  'ownerTeacherId': instance.ownerTeacherId,
  'title': instance.title,
  'description': instance.description,
  'questionIds': instance.questionIds,
  'randomizerSettings': instance.randomizerSettings,
  'categorySettings': instance.categorySettings,
  'startDate': const NullableTimestampConverter().toJson(instance.startDate),
  'deadline': const NullableTimestampConverter().toJson(instance.deadline),
  'timeLimitMinutes': instance.timeLimitMinutes,
  'attemptsAllowed': instance.attemptsAllowed,
  'showResultMode': _$ShowResultModeEnumMap[instance.showResultMode]!,
  'maxScore': instance.maxScore,
  'isPublished': instance.isPublished,
  'createdAt': const TimestampConverter().toJson(instance.createdAt),
  'updatedAt': const TimestampConverter().toJson(instance.updatedAt),
};

const _$ShowResultModeEnumMap = {
  ShowResultMode.none: 'none',
  ShowResultMode.scoreOnly: 'scoreOnly',
  ShowResultMode.scoreAndAnswers: 'scoreAndAnswers',
  ShowResultMode.scoreAnswersExplanations: 'scoreAnswersExplanations',
};
