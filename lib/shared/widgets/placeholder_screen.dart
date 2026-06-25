import 'package:flutter/material.dart';

import '../../theme/app_spacing.dart';

/// Единая заглушка раздела «в разработке» (ТЗ §6.3–6.5, §14). Каркас навигации
/// полный уже в Сессии 1; реальное наполнение — Сессия 2.
class PlaceholderScreen extends StatelessWidget {
  const PlaceholderScreen({super.key, required this.title, this.icon});

  final String title;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon ?? Icons.construction_outlined,
              size: 48, color: colors.onSurfaceVariant),
          AppSpacing.gapMd,
          Text(title, style: Theme.of(context).textTheme.titleLarge),
          AppSpacing.gapXs,
          Text(
            'Раздел в разработке',
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: colors.onSurfaceVariant),
          ),
        ],
      ),
    );
  }
}
