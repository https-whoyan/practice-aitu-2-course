// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_week.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CourseWeek _$CourseWeekFromJson(Map<String, dynamic> json) => _CourseWeek(
  weekId: json['weekId'] as String,
  courseId: json['courseId'] as String,
  title: json['title'] as String? ?? '',
  description: json['description'] as String? ?? '',
  orderIndex: (json['orderIndex'] as num?)?.toInt() ?? 0,
  startDate: const NullableTimestampConverter().fromJson(
    json['startDate'] as Timestamp?,
  ),
  endDate: const NullableTimestampConverter().fromJson(
    json['endDate'] as Timestamp?,
  ),
  isPublished: json['isPublished'] as bool? ?? false,
  createdAt: const TimestampConverter().fromJson(
    json['createdAt'] as Timestamp,
  ),
  updatedAt: const TimestampConverter().fromJson(
    json['updatedAt'] as Timestamp,
  ),
);

Map<String, dynamic> _$CourseWeekToJson(
  _CourseWeek instance,
) => <String, dynamic>{
  'weekId': instance.weekId,
  'courseId': instance.courseId,
  'title': instance.title,
  'description': instance.description,
  'orderIndex': instance.orderIndex,
  'startDate': const NullableTimestampConverter().toJson(instance.startDate),
  'endDate': const NullableTimestampConverter().toJson(instance.endDate),
  'isPublished': instance.isPublished,
  'createdAt': const TimestampConverter().toJson(instance.createdAt),
  'updatedAt': const TimestampConverter().toJson(instance.updatedAt),
};
