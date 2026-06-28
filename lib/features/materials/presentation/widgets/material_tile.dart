import 'package:flutter/material.dart';

import '../../../../shared/widgets/widgets.dart';
import '../../../../theme/app_spacing.dart';
import '../../domain/material.dart';

/// Плитка материала в списке (преподаватель/студент).
///
/// Показывает иконку типа, название и тип; для скрытых материалов выводит
/// чип «скрыт». [trailing] — место под переключатель публикации/меню.
class MaterialTile extends StatelessWidget {
  const MaterialTile({
    super.key,
    required this.material,
    this.onTap,
    this.trailing,
  });

  final CourseMaterial material;
  final VoidCallback? onTap;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AppCard(
      onTap: onTap,
      child: Row(
        children: [
          Icon(material.type.icon, color: theme.colorScheme.primary),
          AppSpacing.gapMd,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        material.title.isEmpty ? '(без названия)' : material.title,
                        style: theme.textTheme.titleSmall,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (!material.isPublished) ...[
                      AppSpacing.gapSm,
                      const _HiddenChip(),
                    ],
                  ],
                ),
                AppSpacing.gapXs,
                Text(
                  material.type.label,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          ?trailing,
        ],
      ),
    );
  }
}

class _HiddenChip extends StatelessWidget {
  const _HiddenChip();

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm, vertical: 2),
      decoration: BoxDecoration(
        color: colors.surfaceContainerHighest,
        borderRadius: AppRadius.brSm,
      ),
      child: Text(
        'скрыт',
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: colors.onSurfaceVariant,
            ),
      ),
    );
  }
}
