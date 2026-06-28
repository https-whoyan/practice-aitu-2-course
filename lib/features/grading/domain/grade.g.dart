// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'grade.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Grade _$GradeFromJson(Map<String, dynamic> json) => _Grade(
  gradeId: json['gradeId'] as String,
  studentId: json['studentId'] as String? ?? '',
  teacherId: json['teacherId'] as String? ?? '',
  courseId: json['courseId'] as String? ?? '',
  groupId: json['groupId'] as String?,
  sourceType:
      $enumDecodeNullable(_$GradeSourceTypeEnumMap, json['sourceType']) ??
      GradeSourceType.manual,
  sourceId: json['sourceId'] as String?,
  score: json['score'] as num? ?? 0,
  maxScore: json['maxScore'] as num? ?? 100,
  percentage: json['percentage'] as num? ?? 0,
  comment: json['comment'] as String?,
  createdAt: const TimestampConverter().fromJson(
    json['createdAt'] as Timestamp,
  ),
  updatedAt: const TimestampConverter().fromJson(
    json['updatedAt'] as Timestamp,
  ),
  history:
      (json['history'] as List<dynamic>?)
          ?.map((e) => GradeHistoryEntry.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <GradeHistoryEntry>[],
);

Map<String, dynamic> _$GradeToJson(_Grade instance) => <String, dynamic>{
  'gradeId': instance.gradeId,
  'studentId': instance.studentId,
  'teacherId': instance.teacherId,
  'courseId': instance.courseId,
  'groupId': instance.groupId,
  'sourceType': _$GradeSourceTypeEnumMap[instance.sourceType]!,
  'sourceId': instance.sourceId,
  'score': instance.score,
  'maxScore': instance.maxScore,
  'percentage': instance.percentage,
  'comment': instance.comment,
  'createdAt': const TimestampConverter().toJson(instance.createdAt),
  'updatedAt': const TimestampConverter().toJson(instance.updatedAt),
  'history': instance.history,
};

const _$GradeSourceTypeEnumMap = {
  GradeSourceType.assignment: 'assignment',
  GradeSourceType.quiz: 'quiz',
  GradeSourceType.manual: 'manual',
};
