import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/error/failure.dart';
import '../../../shared/widgets/widgets.dart';
import '../../../theme/app_spacing.dart';
import '../../auth/data/auth_providers.dart';
import '../data/course_providers.dart';
import '../data/course_week_providers.dart';
import '../domain/course.dart';
import '../domain/course_status.dart';

/// Страница курса для преподавателя: сводка, действия со статусом, недели
/// и заглушки заданий/статистики (ТЗ §5.4, шаг 14).
class CoursePageScreen extends ConsumerWidget {
  const CoursePageScreen({super.key, required this.courseId});

  final String courseId;

  Future<void> _setStatus(
    BuildContext context,
    WidgetRef ref,
    CourseStatus status,
  ) async {
    try {
      await ref.read(courseRepositoryProvider).setStatus(courseId, status);
      ref.invalidate(courseByIdProvider(courseId));
      if (!context.mounted) return;
      AppSnackbar.show(context, 'Статус обновлён');
    } catch (e) {
      if (!context.mounted) return;
      AppSnackbar.showFailure(context, e as Failure);
    }
  }

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
      ref.invalidate(courseByIdProvider(courseId));
      if (!context.mounted) return;
      AppSnackbar.show(context, 'Курс архивирован');
    } catch (e) {
      if (!context.mounted) return;
      AppSnackbar.showFailure(context, e as Failure);
    }
  }

  Future<void> _duplicate(BuildContext context, WidgetRef ref) async {
    try {
      final newId =
          await ref.read(courseRepositoryProvider).duplicateCourse(courseId);
      final uid = ref.read(appUserProvider).valueOrNull?.uid;
      if (uid != null) ref.invalidate(ownerCoursesProvider(uid));
      if (!context.mounted) return;
      AppSnackbar.show(context, 'Курс продублирован (id: $newId)');
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
                    child: Text(course.title, style: textTheme.headlineSmall),
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
            ],
          ),
        ),
        AppSpacing.gapLg,
        PrimaryButton(
          label: 'Редактировать',
          onPressed: () => context.push('/teacher/courses/$courseId/edit'),
        ),
        AppSpacing.gapMd,
        SecondaryButton(
          label: 'Управление неделями',
          onPressed: () => context.push('/teacher/courses/$courseId/weeks'),
        ),
        AppSpacing.gapMd,
        SecondaryButton(
          label: 'Квизы курса',
          onPressed: () => context.push('/teacher/courses/$courseId/quizzes'),
        ),
        if (course.status.isDraft) ...[
          AppSpacing.gapMd,
          PrimaryButton(
            label: 'Опубликовать курс',
            onPressed: () => _setStatus(context, ref, CourseStatus.active),
          ),
        ],
        if (course.status.isActive) ...[
          AppSpacing.gapMd,
          SecondaryButton(
            label: 'В черновик',
            onPressed: () => _setStatus(context, ref, CourseStatus.draft),
          ),
        ],
        AppSpacing.gapMd,
        SecondaryButton(
          label: 'Дублировать курс',
          onPressed: () => _duplicate(context, ref),
        ),
        if (!course.status.isArchived) ...[
          AppSpacing.gapMd,
          SecondaryButton(
            label: 'Архивировать',
            onPressed: () => _archive(context, ref),
          ),
        ],
        AppSpacing.gapXl,
        const SectionHeader(title: 'Недели'),
        _weeksSection(context, ref),
        AppSpacing.gapXl,
        const SectionHeader(title: 'Задания'),
        const AppCard(child: Text('Появится позже')),
        AppSpacing.gapXl,
        const SectionHeader(title: 'Статистика'),
        const AppCard(child: Text('Появится позже')),
      ],
    );
  }

  Widget _weeksSection(BuildContext context, WidgetRef ref) {
    final weeksAsync = ref.watch(courseWeeksProvider(courseId));
    return weeksAsync.when(
      data: (weeks) {
        if (weeks.isEmpty) {
          return const AppCard(child: Text('Недель пока нет'));
        }
        return Column(
          children: [
            for (final week in weeks) ...[
              AppCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            week.title,
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                        ),
                        AppSpacing.gapMd,
                        Text(
                          week.isPublished ? 'опубликована' : 'скрыта',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        TextButton.icon(
                          icon: const Icon(Icons.folder_outlined, size: 18),
                          label: const Text('Материалы'),
                          onPressed: () => context.push(
                            '/teacher/courses/$courseId/weeks/${week.weekId}/materials',
                          ),
                        ),
                        TextButton.icon(
                          icon: const Icon(Icons.assignment_outlined, size: 18),
                          label: const Text('Задания'),
                          onPressed: () => context.push(
                            '/teacher/courses/$courseId/weeks/${week.weekId}/assignments',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              AppSpacing.gapSm,
            ],
          ],
        );
      },
      loading: () => const AppLoader(),
      error: (e, _) => AppErrorView(
        failure: e as Failure,
        onRetry: () => ref.invalidate(courseWeeksProvider(courseId)),
      ),
    );
  }
}
