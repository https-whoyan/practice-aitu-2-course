// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'grade_history_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_GradeHistoryEntry _$GradeHistoryEntryFromJson(Map<String, dynamic> json) =>
    _GradeHistoryEntry(
      score: json['score'] as num? ?? 0,
      comment: json['comment'] as String?,
      changedBy: json['changedBy'] as String? ?? '',
      changedAt: const TimestampConverter().fromJson(
        json['changedAt'] as Timestamp,
      ),
    );

Map<String, dynamic> _$GradeHistoryEntryToJson(_GradeHistoryEntry instance) =>
    <String, dynamic>{
      'score': instance.score,
      'comment': instance.comment,
      'changedBy': instance.changedBy,
      'changedAt': const TimestampConverter().toJson(instance.changedAt),
    };
