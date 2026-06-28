import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/error/failure.dart';
import '../../../../shared/widgets/widgets.dart';
import '../../../../theme/app_spacing.dart';
import '../../../auth/data/user_providers.dart';
import '../../../grading/data/grade_providers.dart';
import '../../data/course_providers.dart';
import '../../data/course_week_providers.dart';
import '../../domain/course.dart';

/// Страница курса для студента: заголовок, описание и список опубликованных
/// недель (ТЗ §5.4, шаг 16).
class StudentCoursePageScreen extends ConsumerWidget {
  const StudentCoursePageScreen({super.key, required this.courseId});

  final String courseId;

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
    final teacherName = course.ownerTeacherId == null
        ? null
        : ref.watch(profileStreamProvider(course.ownerTeacherId!)).valueOrNull
            ?.fullName;

    // Сводка успеваемости по курсу (P2-14): средний % по оценкам студента.
    final grades = ref.watch(myGradesProvider).valueOrNull ?? const [];
    final courseGrades =
        grades.where((g) => g.courseId == courseId).toList();
    final avg = courseGrades.isEmpty
        ? null
        : courseGrades.fold<num>(0, (s, g) => s + g.percentage) /
            courseGrades.length;

    return ListView(
      children: [
        AppCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(course.title, style: textTheme.headlineSmall),
              if (course.description.isNotEmpty) ...[
                AppSpacing.gapMd,
                Text(course.description, style: textTheme.bodyMedium),
              ],
              if (teacherName != null && teacherName.isNotEmpty) ...[
                AppSpacing.gapMd,
                Row(children: [
                  const Icon(Icons.school_outlined, size: 18),
                  const SizedBox(width: 6),
                  Text('Преподаватель: $teacherName',
                      style: textTheme.bodyMedium),
                ]),
              ],
              if (course.startDate != null || course.endDate != null) ...[
                AppSpacing.gapXs,
                Text(
                  'Период: ${_fmtDate(course.startDate)} — ${_fmtDate(course.endDate)}',
                  style: textTheme.bodySmall,
                ),
              ],
            ],
          ),
        ),
        AppSpacing.gapMd,
        AppCard(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Оценок: ${courseGrades.length}',
                  style: textTheme.titleSmall),
              Text(
                avg == null ? 'Прогресс: —' : 'Средний балл: ${(avg * 100).round()}%',
                style: textTheme.titleSmall,
              ),
            ],
          ),
        ),
        AppSpacing.gapXl,
        const SectionHeader(title: 'Недели'),
        _weeksSection(context, ref),
      ],
    );
  }

  static String _fmtDate(DateTime? d) => d == null
      ? '—'
      : '${d.day.toString().padLeft(2, '0')}.'
          '${d.month.toString().padLeft(2, '0')}.${d.year}';

  Widget _weeksSection(BuildContext context, WidgetRef ref) {
    final weeksAsync = ref.watch(publishedCourseWeeksProvider(courseId));
    return weeksAsync.when(
      data: (weeks) {
        if (weeks.isEmpty) {
          return const AppEmptyView(message: 'Опубликованных недель нет');
        }
        return Column(
          children: [
            for (final week in weeks) ...[
              AppCard(
                onTap: () => context.push(
                  '/student/courses/$courseId/weeks/${week.weekId}',
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      week.title,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    if (week.description.isNotEmpty) ...[
                      AppSpacing.gapXs,
                      Text(
                        week.description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
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
        onRetry: () => ref.invalidate(publishedCourseWeeksProvider(courseId)),
      ),
    );
  }
}
