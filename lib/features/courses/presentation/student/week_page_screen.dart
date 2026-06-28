import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/error/failure.dart';
import '../../../../shared/widgets/widgets.dart';
import '../../../../theme/app_spacing.dart';
import '../../../materials/data/material_providers.dart';
import '../../../materials/presentation/widgets/material_tile.dart';

/// Материалы опубликованной недели для студента (ТЗ §5.4, шаг 16).
class StudentWeekPageScreen extends ConsumerWidget {
  const StudentWeekPageScreen({
    super.key,
    required this.courseId,
    required this.weekId,
  });

  final String courseId;
  final String weekId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final materialsAsync = ref.watch(publishedMaterialsProvider(weekId));

    return AppScaffold(
      title: 'Материалы недели',
      body: materialsAsync.when(
        data: (materials) {
          if (materials.isEmpty) {
            return const AppEmptyView(message: 'Материалов нет');
          }
          return ListView.separated(
            itemCount: materials.length,
            separatorBuilder: (_, _) => AppSpacing.gapSm,
            itemBuilder: (context, index) {
              final material = materials[index];
              return MaterialTile(
                material: material,
                onTap: () => context.push(
                  '/student/courses/$courseId/materials/${material.materialId}',
                ),
              );
            },
          );
        },
        loading: () => const AppLoader(),
        error: (e, _) => AppErrorView(
          failure: e as Failure,
          onRetry: () => ref.invalidate(publishedMaterialsProvider(weekId)),
        ),
      ),
    );
  }
}
