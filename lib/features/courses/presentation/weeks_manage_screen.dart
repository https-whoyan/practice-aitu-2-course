import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/error/failure.dart';
import '../../../shared/widgets/widgets.dart';
import '../../../theme/app_spacing.dart';
import '../data/course_week_providers.dart';
import '../domain/course_week.dart';

/// Управление неделями курса: добавление, переупорядочивание (drag&drop),
/// публикация, удаление (ТЗ §5.4.4, шаг 14).
class WeeksManageScreen extends ConsumerWidget {
  const WeeksManageScreen({super.key, required this.courseId});

  final String courseId;

  Future<void> _setPublished(
    BuildContext context,
    WidgetRef ref,
    String weekId,
    bool value,
  ) async {
    try {
      await ref.read(courseWeekRepositoryProvider).setPublished(weekId, value);
      ref.invalidate(courseWeeksProvider(courseId));
    } catch (e) {
      if (!context.mounted) return;
      AppSnackbar.showFailure(context, e as Failure);
    }
  }

  Future<void> _delete(
    BuildContext context,
    WidgetRef ref,
    String weekId,
  ) async {
    final confirmed = await AppDialog.confirm(
      context,
      title: 'Удалить неделю',
      message: 'Неделя будет удалена безвозвратно. Продолжить?',
      confirmLabel: 'Удалить',
    );
    if (!confirmed) return;
    try {
      await ref.read(courseWeekRepositoryProvider).deleteWeek(weekId);
      ref.invalidate(courseWeeksProvider(courseId));
      if (!context.mounted) return;
      AppSnackbar.show(context, 'Неделя удалена');
    } catch (e) {
      if (!context.mounted) return;
      AppSnackbar.showFailure(context, e as Failure);
    }
  }

  Future<void> _reorder(
    BuildContext context,
    WidgetRef ref,
    List<CourseWeek> weeks,
    int oldIndex,
    int newIndex,
  ) async {
    final reordered = [...weeks];
    // ReorderableListView: при перемещении вниз индекс назначения смещается.
    final target = newIndex > oldIndex ? newIndex - 1 : newIndex;
    final moved = reordered.removeAt(oldIndex);
    reordered.insert(target, moved);
    final orderedIds = [for (final w in reordered) w.weekId];
    try {
      await ref
          .read(courseWeekRepositoryProvider)
          .reorderWeeks(courseId, orderedIds);
      ref.invalidate(courseWeeksProvider(courseId));
    } catch (e) {
      if (!context.mounted) return;
      AppSnackbar.showFailure(context, e as Failure);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weeksAsync = ref.watch(courseWeeksProvider(courseId));

    return AppScaffold(
      title: 'Недели курса',
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () =>
            context.push('/teacher/courses/$courseId/weeks/new'),
        icon: const Icon(Icons.add),
        label: const Text('Добавить неделю'),
      ),
      body: weeksAsync.when(
        data: (weeks) {
          if (weeks.isEmpty) {
            return const AppEmptyView(message: 'Недель пока нет');
          }
          return ReorderableListView(
            // _reorder применяет стандартную коррекцию newIndex для onReorder;
            // миграция на onReorderItem — позже.
            // ignore: deprecated_member_use
            onReorder: (oldIndex, newIndex) =>
                _reorder(context, ref, weeks, oldIndex, newIndex),
            children: [
              for (final week in weeks)
                Padding(
                  key: ValueKey(week.weekId),
                  padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                  child: AppCard(
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                week.title,
                                style:
                                    Theme.of(context).textTheme.titleMedium,
                              ),
                              AppSpacing.gapXs,
                              Text(
                                'Порядок: ${week.orderIndex}',
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ),
                        Switch(
                          value: week.isPublished,
                          onChanged: (value) => _setPublished(
                            context,
                            ref,
                            week.weekId,
                            value,
                          ),
                        ),
                        PopupMenuButton<String>(
                          onSelected: (value) {
                            if (value == 'edit') {
                              context.push(
                                '/teacher/courses/$courseId/weeks/${week.weekId}/edit',
                              );
                            } else if (value == 'delete') {
                              _delete(context, ref, week.weekId);
                            }
                          },
                          itemBuilder: (context) => const [
                            PopupMenuItem(
                              value: 'edit',
                              child: Text('Редактировать'),
                            ),
                            PopupMenuItem(
                              value: 'delete',
                              child: Text('Удалить'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          );
        },
        loading: () => const AppLoader(),
        error: (e, _) => AppErrorView(
          failure: e as Failure,
          onRetry: () => ref.invalidate(courseWeeksProvider(courseId)),
        ),
      ),
    );
  }
}
