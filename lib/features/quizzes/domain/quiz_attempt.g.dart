// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quiz_attempt.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_QuizAttempt _$QuizAttemptFromJson(Map<String, dynamic> json) => _QuizAttempt(
  attemptId: json['attemptId'] as String,
  quizId: json['quizId'] as String? ?? '',
  studentId: json['studentId'] as String? ?? '',
  courseId: json['courseId'] as String?,
  questionSnapshot:
      (json['questionSnapshot'] as List<dynamic>?)
          ?.map((e) => QuestionSnapshotItem.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <QuestionSnapshotItem>[],
  answers:
      json['answers'] as Map<String, dynamic>? ?? const <String, dynamic>{},
  startedAt: const NullableTimestampConverter().fromJson(
    json['startedAt'] as Timestamp?,
  ),
  finishedAt: const NullableTimestampConverter().fromJson(
    json['finishedAt'] as Timestamp?,
  ),
  score: json['score'] as num?,
  maxScore: json['maxScore'] as num? ?? 0,
  percentage: json['percentage'] as num?,
  status:
      $enumDecodeNullable(_$AttemptStatusEnumMap, json['status']) ??
      AttemptStatus.inProgress,
  attemptNumber: (json['attemptNumber'] as num?)?.toInt() ?? 1,
  revealed: json['revealed'] as Map<String, dynamic>?,
);

Map<String, dynamic> _$QuizAttemptToJson(
  _QuizAttempt instance,
) => <String, dynamic>{
  'attemptId': instance.attemptId,
  'quizId': instance.quizId,
  'studentId': instance.studentId,
  'courseId': instance.courseId,
  'questionSnapshot': instance.questionSnapshot,
  'answers': instance.answers,
  'startedAt': const NullableTimestampConverter().toJson(instance.startedAt),
  'finishedAt': const NullableTimestampConverter().toJson(instance.finishedAt),
  'score': instance.score,
  'maxScore': instance.maxScore,
  'percentage': instance.percentage,
  'status': _$AttemptStatusEnumMap[instance.status]!,
  'attemptNumber': instance.attemptNumber,
  'revealed': instance.revealed,
};

const _$AttemptStatusEnumMap = {
  AttemptStatus.inProgress: 'inProgress',
  AttemptStatus.submitted: 'submitted',
  AttemptStatus.graded: 'graded',
  AttemptStatus.expired: 'expired',
};
