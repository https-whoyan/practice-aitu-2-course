import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/utils/timestamp_converter.dart';
import 'material_type.dart';

part 'material.freezed.dart';
part 'material.g.dart';

/// Учебный материал недели курса ← коллекция `materials` (ТЗ §7.6).
///
/// Назван [CourseMaterial] (не `Material`), чтобы не конфликтовать с виджетом
/// Flutter `Material`. Привязан к неделе (`weekId`) и курсу (`courseId`),
/// сортируется по `orderIndex`. Скрытые материалы (`isPublished == false`)
/// студент не видит (правила шага 27).
@freezed
abstract class CourseMaterial with _$CourseMaterial {
  const factory CourseMaterial({
    required String materialId,
    required String courseId,
    required String weekId,
    @Default('') String title,
    @Default('') String description,
    @Default(CourseMaterialType.text) CourseMaterialType type,
    String? url,
    String? fileUrl,
    @Default(0) int orderIndex,
    @Default(false) bool isPublished,
    @TimestampConverter() required DateTime createdAt,
    @TimestampConverter() required DateTime updatedAt,
  }) = _CourseMaterial;

  factory CourseMaterial.fromJson(Map<String, dynamic> json) =>
      _$CourseMaterialFromJson(json);
}
