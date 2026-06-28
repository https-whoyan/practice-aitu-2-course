// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Group _$GroupFromJson(Map<String, dynamic> json) => _Group(
  groupId: json['groupId'] as String,
  title: json['title'] as String? ?? '',
  description: json['description'] as String? ?? '',
  teacherIds:
      (json['teacherIds'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const <String>[],
  studentIds:
      (json['studentIds'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const <String>[],
  courseIds:
      (json['courseIds'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const <String>[],
  status:
      $enumDecodeNullable(_$EntityStatusEnumMap, json['status']) ??
      EntityStatus.active,
  createdAt: const TimestampConverter().fromJson(
    json['createdAt'] as Timestamp,
  ),
  updatedAt: const TimestampConverter().fromJson(
    json['updatedAt'] as Timestamp,
  ),
);

Map<String, dynamic> _$GroupToJson(_Group instance) => <String, dynamic>{
  'groupId': instance.groupId,
  'title': instance.title,
  'description': instance.description,
  'teacherIds': instance.teacherIds,
  'studentIds': instance.studentIds,
  'courseIds': instance.courseIds,
  'status': _$EntityStatusEnumMap[instance.status]!,
  'createdAt': const TimestampConverter().toJson(instance.createdAt),
  'updatedAt': const TimestampConverter().toJson(instance.updatedAt),
};

const _$EntityStatusEnumMap = {
  EntityStatus.active: 'active',
  EntityStatus.archived: 'archived',
};
