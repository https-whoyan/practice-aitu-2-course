import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/error/failure.dart';
import '../../../shared/widgets/widgets.dart';
import '../../../theme/app_spacing.dart';
import '../../courses/data/course_providers.dart';
import '../../courses/domain/course.dart';

/// Карточка курса для админки: сводка + действия (редактирование/архивация).
class CourseCardScreen extends ConsumerWidget {
  const CourseCardScreen({super.key, required this.courseId});

  final String courseId;

  Future<void> _archive(BuildContext context, WidgetRef ref) async {
    final confirmed = await AppDialog.confirm(
      context,
      title: 'Архивировать курс',
      message: 'Курс будет перемещён в архив. Продолжить?',
      confirmLabel: 'Архивировать',
    );
    if (!confirmed) return;
    try {
      await ref.read(courseRepositoryProvider).archiveCourse(courseId);
      ref.invalidate(adminCoursesProvider);
      if (!context.mounted) return;
      AppSnackbar.show(context, 'Курс архивирован');
      context.pop();
    } catch (e) {
      if (!context.mounted) return;
      AppSnackbar.showFailure(context, e as Failure);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final courseAsync = ref.watch(courseByIdProvider(courseId));

    return AppScaffold(
      title: 'Курс',
      body: courseAsync.when(
        data: (course) {
          if (course == null) {
            return const AppEmptyView(message: 'Курс не найден');
          }
          return _content(context, ref, course);
        },
        loading: () => const AppLoader(),
        error: (e, _) => AppErrorView(
          failure: e as Failure,
          onRetry: () => ref.invalidate(courseByIdProvider(courseId)),
        ),
      ),
    );
  }

  Widget _content(BuildContext context, WidgetRef ref, Course course) {
    final textTheme = Theme.of(context).textTheme;
    return ListView(
      children: [
        AppCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(course.title, style: textTheme.titleLarge),
                  ),
                  Chip(
                    label: Text(course.status.label),
                    visualDensity: VisualDensity.compact,
                  ),
                ],
              ),
              if (course.description.isNotEmpty) ...[
                AppSpacing.gapMd,
                Text(course.description, style: textTheme.bodyMedium),
              ],
              AppSpacing.gapLg,
              Text(
                'Преподавателей: ${course.teacherIds.length}',
                style: textTheme.bodyMedium,
              ),
              AppSpacing.gapXs,
              Text(
                'Групп: ${course.groupIds.length}',
                style: textTheme.bodyMedium,
              ),
            ],
          ),
        ),
        AppSpacing.gapLg,
        PrimaryButton(
          label: 'Редактировать',
          onPressed: () => context.push('/admin/courses/$courseId/edit'),
        ),
        if (!course.status.isArchived) ...[
          AppSpacing.gapMd,
          SecondaryButton(
            label: 'Архивировать',
            onPressed: () => _archive(context, ref),
          ),
        ],
      ],
    );
  }
}
