import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/utils/timestamp_converter.dart';

part 'audit_log.freezed.dart';
part 'audit_log.g.dart';

/// Запись журнала действий ← коллекция `auditLogs` (ТЗ §7.13, §8.6).
///
/// Пишется только доверенным серверным кодом (Cloud Functions,
/// `functions/src/lib/audit.ts`). `auditId` — id документа, инжектится при
/// чтении (в документе не дублируется). `oldValue`/`newValue` — произвольные
/// снимки значений до/после действия (могут отсутствовать).
@freezed
abstract class AuditLog with _$AuditLog {
  const factory AuditLog({
    required String auditId,
    @Default('') String userId,
    @Default('') String role,
    @Default('') String actionType,
    @Default('') String entityType,
    @Default('') String entityId,
    Map<String, dynamic>? oldValue,
    Map<String, dynamic>? newValue,
    @TimestampConverter() required DateTime createdAt,
  }) = _AuditLog;

  factory AuditLog.fromJson(Map<String, dynamic> json) =>
      _$AuditLogFromJson(json);
}
