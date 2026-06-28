import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/notification_providers.dart';

/// Обёртка с бейджем непрочитанных поверх иконки навигации.
///
/// Считает [unreadCountProvider]; при count > 0 показывает Material [Badge]
/// поверх [child], иначе отдаёт [child] без бейджа.
class NotificationBadge extends ConsumerWidget {
  const NotificationBadge({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final count = ref.watch(unreadCountProvider).valueOrNull ?? 0;
    if (count <= 0) return child;
    return Badge(
      label: Text('$count'),
      child: child,
    );
  }
}
