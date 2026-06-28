// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'submission.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Submission _$SubmissionFromJson(Map<String, dynamic> json) => _Submission(
  submissionId: json['submissionId'] as String,
  assignmentId: json['assignmentId'] as String,
  courseId: json['courseId'] as String,
  studentId: json['studentId'] as String,
  textAnswer: json['textAnswer'] as String?,
  fileUrls:
      (json['fileUrls'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const <String>[],
  linkAnswer: json['linkAnswer'] as String?,
  status:
      $enumDecodeNullable(_$SubmissionStatusEnumMap, json['status']) ??
      SubmissionStatus.draft,
  submittedAt: const NullableTimestampConverter().fromJson(
    json['submittedAt'] as Timestamp?,
  ),
  updatedAt: const TimestampConverter().fromJson(
    json['updatedAt'] as Timestamp,
  ),
  teacherComment: json['teacherComment'] as String?,
  gradeId: json['gradeId'] as String?,
);

Map<String, dynamic> _$SubmissionToJson(_Submission instance) =>
    <String, dynamic>{
      'submissionId': instance.submissionId,
      'assignmentId': instance.assignmentId,
      'courseId': instance.courseId,
      'studentId': instance.studentId,
      'textAnswer': instance.textAnswer,
      'fileUrls': instance.fileUrls,
      'linkAnswer': instance.linkAnswer,
      'status': _$SubmissionStatusEnumMap[instance.status]!,
      'submittedAt': const NullableTimestampConverter().toJson(
        instance.submittedAt,
      ),
      'updatedAt': const TimestampConverter().toJson(instance.updatedAt),
      'teacherComment': instance.teacherComment,
      'gradeId': instance.gradeId,
    };

const _$SubmissionStatusEnumMap = {
  SubmissionStatus.draft: 'draft',
  SubmissionStatus.submitted: 'submitted',
  SubmissionStatus.inReview: 'inReview',
  SubmissionStatus.returned: 'returned',
  SubmissionStatus.rejected: 'rejected',
  SubmissionStatus.accepted: 'accepted',
  SubmissionStatus.graded: 'graded',
};
