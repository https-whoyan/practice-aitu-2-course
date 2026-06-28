import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/utils/timestamp_converter.dart';
import 'course_status.dart';

part 'course.freezed.dart';
part 'course.g.dart';

/// Курс ← коллекция `courses` (ТЗ §7.4).
///
/// `ownerTeacherId` хранится отдельно от `teacherIds` — владелец нужен для
/// проверки прав в Security Rules (ТЗ §8.3, шаг 27). Группы привязываются
/// двусторонне (`groupIds` ↔ `groups.courseIds`).
@freezed
abstract class Course with _$Course {
  const factory Course({
    required String courseId,
    @Default('') String title,
    @Default('') String description,
    String? ownerTeacherId,
    @Default(<String>[]) List<String> teacherIds,
    @Default(<String>[]) List<String> groupIds,
    String? coverUrl,
    @Default(CourseStatus.draft) CourseStatus status,
    @NullableTimestampConverter() DateTime? startDate,
    @NullableTimestampConverter() DateTime? endDate,
    @TimestampConverter() required DateTime createdAt,
    @TimestampConverter() required DateTime updatedAt,
  }) = _Course;

  factory Course.fromJson(Map<String, dynamic> json) => _$CourseFromJson(json);
}
