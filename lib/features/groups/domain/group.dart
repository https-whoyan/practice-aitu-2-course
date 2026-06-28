import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/domain/entity_status.dart';
import '../../../core/utils/timestamp_converter.dart';

part 'group.freezed.dart';
part 'group.g.dart';

/// Учебная группа ← коллекция `groups` (ТЗ §7.3).
///
/// `groupId` — id документа, инжектится при чтении (в документе не дублируется).
/// Связь с курсами хранится с двух сторон (`courseIds` ↔ `courses.groupIds`) и
/// пишется атомарно (шаг 12). Состав студентов зеркалится в `profiles.groupIds`.
@freezed
abstract class Group with _$Group {
  const factory Group({
    required String groupId,
    @Default('') String title,
    @Default('') String description,
    @Default(<String>[]) List<String> teacherIds,
    @Default(<String>[]) List<String> studentIds,
    @Default(<String>[]) List<String> courseIds,
    @Default(EntityStatus.active) EntityStatus status,
    @TimestampConverter() required DateTime createdAt,
    @TimestampConverter() required DateTime updatedAt,
  }) = _Group;

  factory Group.fromJson(Map<String, dynamic> json) => _$GroupFromJson(json);
}
