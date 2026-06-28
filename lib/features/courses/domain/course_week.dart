import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/utils/timestamp_converter.dart';

part 'course_week.freezed.dart';
part 'course_week.g.dart';

/// Учебная неделя курса ← коллекция `courseWeeks` (ТЗ §7.5).
///
/// Отдельная коллекция (не массив в `Course`): даёт правила видимости и
/// сортировку по `orderIndex` без перезаписи курса. Публикация — флаг
/// `isPublished` (скрытые недели студент не видит, шаг 16 + правила шага 27).
@freezed
abstract class CourseWeek with _$CourseWeek {
  const factory CourseWeek({
    required String weekId,
    required String courseId,
    @Default('') String title,
    @Default('') String description,
    @Default(0) int orderIndex,
    @NullableTimestampConverter() DateTime? startDate,
    @NullableTimestampConverter() DateTime? endDate,
    @Default(false) bool isPublished,
    @TimestampConverter() required DateTime createdAt,
    @TimestampConverter() required DateTime updatedAt,
  }) = _CourseWeek;

  factory CourseWeek.fromJson(Map<String, dynamic> json) =>
      _$CourseWeekFromJson(json);
}
