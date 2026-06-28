import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/error/failure.dart';
import '../../../shared/widgets/widgets.dart';
import '../../../theme/app_spacing.dart';
import '../../auth/data/auth_providers.dart';
import '../data/notification_providers.dart';
import '../domain/app_notification.dart';

/// Экран in-app уведомлений: список своих уведомлений + «прочитать все».
class NotificationsScreen extends ConsumerWidget {
  const NotificationsScreen({super.key});

  Future<void> _markAllRead(
    BuildContext context,
    WidgetRef ref,
    String uid,
  ) async {
    try {
      await ref.read(notificationsRepositoryProvider).markAllRead(uid);
    } on Failure catch (failure) {
      if (context.mounted) AppSnackbar.showFailure(context, failure);
    }
  }

  Future<void> _markRead(WidgetRef ref, String id) async {
    await ref.read(notificationsRepositoryProvider).markRead(id);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final uid = ref.watch(appUserProvider).valueOrNull?.uid;
    if (uid == null) {
      return const AppScaffold(title: 'Уведомления', body: AppLoader());
    }

    final notificationsAsync = ref.watch(myNotificationsProvider);

    return AppScaffold(
      title: 'Уведомления',
      actions: [
        IconButton(
          icon: const Icon(Icons.done_all),
          tooltip: 'Прочитать все',
          onPressed: () => _markAllRead(context, ref, uid),
        ),
      ],
      body: notificationsAsync.when(
        loading: () => const AppLoader(),
        error: (e, _) => AppErrorView(
          failure: e as Failure,
          onRetry: () => ref.invalidate(myNotificationsProvider),
        ),
        data: (items) {
          if (items.isEmpty) {
            return const AppEmptyView(
              message: 'Уведомлений нет',
              icon: Icons.notifications_none,
            );
          }
          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) => NotificationTile(
              notification: items[index],
              onTap: () => _markRead(ref, items[index].notificationId),
            ),
          );
        },
      ),
    );
  }
}

/// Карточка одного уведомления. Непрочитанные выделены фоном и жирным заголовком.
class NotificationTile extends StatelessWidget {
  const NotificationTile({
    super.key,
    required this.notification,
    this.onTap,
  });

  final AppNotification notification;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final unread = !notification.isRead;
    final createdAt = notification.createdAt;

    return AppCard(
      onTap: onTap,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            notification.type.icon,
            color: unread ? colors.primary : colors.onSurfaceVariant,
          ),
          AppSpacing.gapMd,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  notification.title,
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: unread ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
                if (notification.body.isNotEmpty) ...[
                  AppSpacing.gapXs,
                  Text(notification.body, style: theme.textTheme.bodySmall),
                ],
                if (createdAt != null) ...[
                  AppSpacing.gapXs,
                  Text(
                    _formatDateTime(createdAt.toLocal()),
                    style: theme.textTheme.bodySmall
                        ?.copyWith(color: colors.onSurfaceVariant),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

String _formatDateTime(DateTime d) {
  String two(int v) => v.toString().padLeft(2, '0');
  return '${d.day}.${d.month}.${d.year} ${two(d.hour)}:${two(d.minute)}';
}
