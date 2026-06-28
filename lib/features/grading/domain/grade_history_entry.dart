import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/utils/timestamp_converter.dart';

part 'grade_history_entry.freezed.dart';
part 'grade_history_entry.g.dart';

/// Запись истории изменений оценки (ТЗ §7.9).
///
/// Вложена в массив `history` документа `grades`. Хранит снимок выставленного
/// балла, комментарий и автора изменения для аудита переоценок.
@freezed
abstract class GradeHistoryEntry with _$GradeHistoryEntry {
  const factory GradeHistoryEntry({
    @Default(0) num score,
    String? comment,
    @Default('') String changedBy,
    @TimestampConverter() required DateTime changedAt,
  }) = _GradeHistoryEntry;

  factory GradeHistoryEntry.fromJson(Map<String, dynamic> json) =>
      _$GradeHistoryEntryFromJson(json);
}
