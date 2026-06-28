// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'student_summary.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_StudentSummary _$StudentSummaryFromJson(Map<String, dynamic> json) =>
    _StudentSummary(
      studentId: json['studentId'] as String,
      totalGrades: (json['totalGrades'] as num?)?.toInt() ?? 0,
      gradedQuizzes: (json['gradedQuizzes'] as num?)?.toInt() ?? 0,
      gradedAssignments: (json['gradedAssignments'] as num?)?.toInt() ?? 0,
      averagePercentage: json['averagePercentage'] as num? ?? 0,
      averageQuizPercentage: json['averageQuizPercentage'] as num? ?? 0,
      overdueCount: (json['overdueCount'] as num?)?.toInt() ?? 0,
      upcomingCount: (json['upcomingCount'] as num?)?.toInt() ?? 0,
      riskLevel:
          $enumDecodeNullable(_$RiskLevelEnumMap, json['riskLevel']) ??
          RiskLevel.low,
      updatedAt: const NullableTimestampConverter().fromJson(
        json['updatedAt'] as Timestamp?,
      ),
    );

Map<String, dynamic> _$StudentSummaryToJson(
  _StudentSummary instance,
) => <String, dynamic>{
  'studentId': instance.studentId,
  'totalGrades': instance.totalGrades,
  'gradedQuizzes': instance.gradedQuizzes,
  'gradedAssignments': instance.gradedAssignments,
  'averagePercentage': instance.averagePercentage,
  'averageQuizPercentage': instance.averageQuizPercentage,
  'overdueCount': instance.overdueCount,
  'upcomingCount': instance.upcomingCount,
  'riskLevel': _$RiskLevelEnumMap[instance.riskLevel]!,
  'updatedAt': const NullableTimestampConverter().toJson(instance.updatedAt),
};

const _$RiskLevelEnumMap = {
  RiskLevel.low: 'low',
  RiskLevel.medium: 'medium',
  RiskLevel.high: 'high',
};
