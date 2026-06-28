// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'audit_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$recentAuditLogsHash() => r'ad2fbed25ac56de13cb98fd39621cadb5e866446';

/// Последние записи журнала действий (ТЗ §7.13). Только чтение; запись делает
/// серверный код (Cloud Functions).
///
/// Copied from [recentAuditLogs].
@ProviderFor(recentAuditLogs)
final recentAuditLogsProvider =
    AutoDisposeStreamProvider<List<AuditLog>>.internal(
      recentAuditLogs,
      name: r'recentAuditLogsProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$recentAuditLogsHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef RecentAuditLogsRef = AutoDisposeStreamProviderRef<List<AuditLog>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
