import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/error/error_mapper.dart';
import '../../../firebase/firebase_providers.dart';
import '../domain/audit_log.dart';

part 'audit_providers.g.dart';

/// Последние записи журнала действий (ТЗ §7.13). Только чтение; запись делает
/// серверный код (Cloud Functions).
@riverpod
Stream<List<AuditLog>> recentAuditLogs(Ref ref) {
  return ref
      .watch(firestoreProvider)
      .collection('auditLogs')
      .orderBy('createdAt', descending: true)
      .limit(50)
      .snapshots()
      .map(
        (snapshot) => snapshot.docs
            .map((d) => AuditLog.fromJson({...d.data(), 'auditId': d.id}))
            .toList(),
      )
      .mapFailures();
}
