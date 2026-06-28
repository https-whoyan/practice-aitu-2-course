import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/error/failure.dart';
import '../../../shared/widgets/widgets.dart';
import '../../../theme/app_spacing.dart';
import '../data/material_providers.dart';
import '../domain/material.dart';
import 'widgets/material_tile.dart';

/// Список материалов недели для преподавателя (ТЗ §7.6, §12).
///
/// Поиск по названию (P2-22). Каждая плитка — переключатель публикации и меню.
class WeekMaterialsScreen extends ConsumerStatefulWidget {
  const WeekMaterialsScreen({
    super.key,
    required this.courseId,
    required this.weekId,
  });

  final String courseId;
  final String weekId;

  @override
  ConsumerState<WeekMaterialsScreen> createState() =>
      _WeekMaterialsScreenState();
}

class _WeekMaterialsScreenState extends ConsumerState<WeekMaterialsScreen> {
  String _search = '';

  @override
  Widget build(BuildContext context) {
    final materialsAsync = ref.watch(materialsProvider(widget.weekId));
    final q = _search.trim().toLowerCase();
    return AppScaffold(
      title: 'Материалы недели',
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push(
          '/teacher/courses/${widget.courseId}/weeks/${widget.weekId}/materials/new',
        ),
        icon: const Icon(Icons.add),
        label: const Text('Добавить материал'),
      ),
      body: materialsAsync.when(
        data: (materials) {
          if (materials.isEmpty) {
            return const AppEmptyView(message: 'Материалов пока нет');
          }
          final filtered = q.isEmpty
              ? materials
              : materials
                  .where((m) => m.title.toLowerCase().contains(q))
                  .toList();
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AppTextField(
                label: 'Поиск',
                hint: 'Название материала',
                prefixIcon: Icons.search,
                onChanged: (v) => setState(() => _search = v),
              ),
              AppSpacing.gapMd,
              Expanded(
                child: filtered.isEmpty
                    ? const AppEmptyView(message: 'Ничего не найдено')
                    : ListView.separated(
                        itemCount: filtered.length,
                        separatorBuilder: (_, _) => AppSpacing.gapSm,
                        itemBuilder: (context, index) {
                          final material = filtered[index];
                          return MaterialTile(
                            material: material,
                            onTap: () => _edit(context, material),
                            trailing: _trailing(context, material),
                          );
                        },
                      ),
              ),
            ],
          );
        },
        loading: () => const AppLoader(),
        error: (e, _) => AppErrorView(
          failure: e as Failure,
          onRetry: () => ref.invalidate(materialsProvider(widget.weekId)),
        ),
      ),
    );
  }

  Widget _trailing(BuildContext context, CourseMaterial material) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Switch(
          value: material.isPublished,
          onChanged: (value) => _setPublished(context, material, value),
        ),
        PopupMenuButton<String>(
          onSelected: (action) {
            switch (action) {
              case 'edit':
                _edit(context, material);
              case 'delete':
                _delete(context, material);
            }
          },
          itemBuilder: (context) => const [
            PopupMenuItem(value: 'edit', child: Text('Редактировать')),
            PopupMenuItem(value: 'delete', child: Text('Удалить')),
          ],
        ),
      ],
    );
  }

  void _edit(BuildContext context, CourseMaterial material) {
    context.push(
      '/teacher/courses/${widget.courseId}/weeks/${widget.weekId}/materials/${material.materialId}/edit',
    );
  }

  Future<void> _setPublished(
    BuildContext context,
    CourseMaterial material,
    bool value,
  ) async {
    try {
      await ref
          .read(materialRepositoryProvider)
          .setPublished(material.materialId, value);
    } catch (e) {
      if (!context.mounted) return;
      AppSnackbar.showFailure(context, e as Failure);
    }
  }

  Future<void> _delete(BuildContext context, CourseMaterial material) async {
    final confirmed = await AppDialog.confirm(
      context,
      title: 'Удалить материал',
      message:
          'Материал будет удалён без возможности восстановления. Продолжить?',
      confirmLabel: 'Удалить',
    );
    if (!confirmed) return;
    try {
      await ref
          .read(materialRepositoryProvider)
          .deleteMaterial(material.materialId);
      ref.invalidate(materialsProvider(widget.weekId));
    } catch (e) {
      if (!context.mounted) return;
      AppSnackbar.showFailure(context, e as Failure);
    }
  }
}
