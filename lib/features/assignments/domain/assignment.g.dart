// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assignment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Assignment _$AssignmentFromJson(Map<String, dynamic> json) => _Assignment(
  assignmentId: json['assignmentId'] as String,
  courseId: json['courseId'] as String,
  weekId: json['weekId'] as String,
  title: json['title'] as String? ?? '',
  description: json['description'] as String? ?? '',
  instruction: json['instruction'] as String? ?? '',
  deadline: const NullableTimestampConverter().fromJson(
    json['deadline'] as Timestamp?,
  ),
  maxScore: (json['maxScore'] as num?)?.toInt() ?? 100,
  submissionType:
      $enumDecodeNullable(_$SubmissionTypeEnumMap, json['submissionType']) ??
      SubmissionType.text,
  allowLateSubmission: json['allowLateSubmission'] as bool? ?? false,
  latePenalty: (json['latePenalty'] as num?)?.toInt() ?? 0,
  isPublished: json['isPublished'] as bool? ?? false,
  createdAt: const TimestampConverter().fromJson(
    json['createdAt'] as Timestamp,
  ),
  updatedAt: const TimestampConverter().fromJson(
    json['updatedAt'] as Timestamp,
  ),
);

Map<String, dynamic> _$AssignmentToJson(_Assignment instance) =>
    <String, dynamic>{
      'assignmentId': instance.assignmentId,
      'courseId': instance.courseId,
      'weekId': instance.weekId,
      'title': instance.title,
      'description': instance.description,
      'instruction': instance.instruction,
      'deadline': const NullableTimestampConverter().toJson(instance.deadline),
      'maxScore': instance.maxScore,
      'submissionType': _$SubmissionTypeEnumMap[instance.submissionType]!,
      'allowLateSubmission': instance.allowLateSubmission,
      'latePenalty': instance.latePenalty,
      'isPublished': instance.isPublished,
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
      'updatedAt': const TimestampConverter().toJson(instance.updatedAt),
    };

const _$SubmissionTypeEnumMap = {
  SubmissionType.text: 'text',
  SubmissionType.link: 'link',
  SubmissionType.file: 'file',
  SubmissionType.combined: 'combined',
  SubmissionType.none: 'none',
};
