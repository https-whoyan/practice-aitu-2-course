import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/error/failure.dart';
import '../../../shared/widgets/widgets.dart';
import '../../../theme/app_spacing.dart';
import '../data/audit_providers.dart';
import '../domain/audit_log.dart';

/// Журнал действий администратора/преподавателей (ТЗ §7.13). Только чтение.
class AuditLogScreen extends ConsumerWidget {
  const AuditLogScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final logsAsync = ref.watch(recentAuditLogsProvider);

    return AppScaffold(
      title: 'Журнал действий',
      body: logsAsync.when(
        data: (logs) {
          if (logs.isEmpty) {
            return const AppEmptyView(message: 'Журнал пуст');
          }
          return ListView.separated(
            itemCount: logs.length,
            separatorBuilder: (_, _) => AppSpacing.gapSm,
            itemBuilder: (context, index) => _AuditTile(log: logs[index]),
          );
        },
        loading: () => const AppLoader(),
        error: (e, _) => AppErrorView(
          failure: e as Failure,
          onRetry: () => ref.invalidate(recentAuditLogsProvider),
        ),
      ),
    );
  }
}

class _AuditTile extends StatelessWidget {
  const _AuditTile({required this.log});

  final AuditLog log;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${log.actionType} • ${log.entityType}',
            style: textTheme.titleSmall,
          ),
          AppSpacing.gapXs,
          Text(log.entityId, style: textTheme.bodySmall),
          AppSpacing.gapXs,
          Text(
            _formatDate(log.createdAt.toLocal()),
            style: textTheme.bodySmall,
          ),
        ],
      ),
    );
  }

  /// Простое форматирование `YYYY-MM-DD HH:MM` (без внешних зависимостей).
  String _formatDate(DateTime date) {
    String two(int n) => n.toString().padLeft(2, '0');
    return '${date.year}-${two(date.month)}-${two(date.day)} '
        '${two(date.hour)}:${two(date.minute)}';
  }
}
