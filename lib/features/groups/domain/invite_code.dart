import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/utils/timestamp_converter.dart';

part 'invite_code.freezed.dart';
part 'invite_code.g.dart';

/// Код приглашения в группу ← коллекция `inviteCodes` (ТЗ §5.6.2, §7).
///
/// Создаётся преподавателем/админом; проверяется и «гасится» серверной
/// функцией `joinGroupByCode` (срок действия, лимит — на сервере, шаг 16).
@freezed
abstract class InviteCode with _$InviteCode {
  const factory InviteCode({
    required String inviteId,
    required String code,
    required String groupId,
    String? createdBy,
    @NullableTimestampConverter() DateTime? expiresAt,
    int? maxUses,
    @Default(0) int usedCount,
    @Default(true) bool active,
    @TimestampConverter() required DateTime createdAt,
  }) = _InviteCode;

  factory InviteCode.fromJson(Map<String, dynamic> json) =>
      _$InviteCodeFromJson(json);
}
