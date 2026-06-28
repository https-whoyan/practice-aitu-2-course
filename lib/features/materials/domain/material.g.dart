// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'material.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CourseMaterial _$CourseMaterialFromJson(Map<String, dynamic> json) =>
    _CourseMaterial(
      materialId: json['materialId'] as String,
      courseId: json['courseId'] as String,
      weekId: json['weekId'] as String,
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      type:
          $enumDecodeNullable(_$CourseMaterialTypeEnumMap, json['type']) ??
          CourseMaterialType.text,
      url: json['url'] as String?,
      fileUrl: json['fileUrl'] as String?,
      orderIndex: (json['orderIndex'] as num?)?.toInt() ?? 0,
      isPublished: json['isPublished'] as bool? ?? false,
      createdAt: const TimestampConverter().fromJson(
        json['createdAt'] as Timestamp,
      ),
      updatedAt: const TimestampConverter().fromJson(
        json['updatedAt'] as Timestamp,
      ),
    );

Map<String, dynamic> _$CourseMaterialToJson(_CourseMaterial instance) =>
    <String, dynamic>{
      'materialId': instance.materialId,
      'courseId': instance.courseId,
      'weekId': instance.weekId,
      'title': instance.title,
      'description': instance.description,
      'type': _$CourseMaterialTypeEnumMap[instance.type]!,
      'url': instance.url,
      'fileUrl': instance.fileUrl,
      'orderIndex': instance.orderIndex,
      'isPublished': instance.isPublished,
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
      'updatedAt': const TimestampConverter().toJson(instance.updatedAt),
    };

const _$CourseMaterialTypeEnumMap = {
  CourseMaterialType.text: 'text',
  CourseMaterialType.link: 'link',
  CourseMaterialType.youtube: 'youtube',
  CourseMaterialType.file: 'file',
  CourseMaterialType.presentation: 'presentation',
  CourseMaterialType.pdf: 'pdf',
  CourseMaterialType.image: 'image',
};
