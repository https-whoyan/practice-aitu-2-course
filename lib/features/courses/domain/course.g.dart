// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Course _$CourseFromJson(Map<String, dynamic> json) => _Course(
  courseId: json['courseId'] as String,
  title: json['title'] as String? ?? '',
  description: json['description'] as String? ?? '',
  ownerTeacherId: json['ownerTeacherId'] as String?,
  teacherIds:
      (json['teacherIds'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const <String>[],
  groupIds:
      (json['groupIds'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const <String>[],
  coverUrl: json['coverUrl'] as String?,
  status:
      $enumDecodeNullable(_$CourseStatusEnumMap, json['status']) ??
      CourseStatus.draft,
  startDate: const NullableTimestampConverter().fromJson(
    json['startDate'] as Timestamp?,
  ),
  endDate: const NullableTimestampConverter().fromJson(
    json['endDate'] as Timestamp?,
  ),
  createdAt: const TimestampConverter().fromJson(
    json['createdAt'] as Timestamp,
  ),
  updatedAt: const TimestampConverter().fromJson(
    json['updatedAt'] as Timestamp,
  ),
);

Map<String, dynamic> _$CourseToJson(_Course instance) => <String, dynamic>{
  'courseId': instance.courseId,
  'title': instance.title,
  'description': instance.description,
  'ownerTeacherId': instance.ownerTeacherId,
  'teacherIds': instance.teacherIds,
  'groupIds': instance.groupIds,
  'coverUrl': instance.coverUrl,
  'status': _$CourseStatusEnumMap[instance.status]!,
  'startDate': const NullableTimestampConverter().toJson(instance.startDate),
  'endDate': const NullableTimestampConverter().toJson(instance.endDate),
  'createdAt': const TimestampConverter().toJson(instance.createdAt),
  'updatedAt': const TimestampConverter().toJson(instance.updatedAt),
};

const _$CourseStatusEnumMap = {
  CourseStatus.draft: 'draft',
  CourseStatus.active: 'active',
  CourseStatus.archived: 'archived',
};
