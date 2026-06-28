import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/utils/timestamp_converter.dart';
import 'grade_history_entry.dart';
import 'grade_source_type.dart';

part 'grade.freezed.dart';
part 'grade.g.dart';

/// Оценка студента ← коллекция `grades` (ТЗ §7.9).
///
/// Единое хранилище оценок за задания, квизы и проставленных вручную.
/// `gradeId` — id документа, инжектится при чтении (в документе не дублируется).
/// `percentage` — нормированная доля `score/maxScore` для журнала/статистики.
/// `history` — журнал переоценок (вложенный массив [GradeHistoryEntry]).
@freezed
abstract class Grade with _$Grade {
  const factory Grade({
    required String gradeId,
    @Default('') String studentId,
    @Default('') String teacherId,
    @Default('') String courseId,
    String? groupId,
    @Default(GradeSourceType.manual) GradeSourceType sourceType,
    String? sourceId,
    @Default(0) num score,
    @Default(100) num maxScore,
    @Default(0) num percentage,
    String? comment,
    @TimestampConverter() required DateTime createdAt,
    @TimestampConverter() required DateTime updatedAt,
    @Default(<GradeHistoryEntry>[]) List<GradeHistoryEntry> history,
  }) = _Grade;

  factory Grade.fromJson(Map<String, dynamic> json) => _$GradeFromJson(json);
}
