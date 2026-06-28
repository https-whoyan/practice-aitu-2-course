import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/error/failure.dart';
import '../../../shared/widgets/widgets.dart';
import '../../../theme/app_spacing.dart';
import '../data/assignment_providers.dart';

/// Опубликованные задания одного курса глазами студента (ТЗ §5.6.4, шаг 17).
class StudentCourseAssignmentsScreen extends ConsumerWidget {
  const StudentCourseAssignmentsScreen({super.key, required this.courseId});

  final String courseId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final assignmentsAsync =
        ref.watch(publishedAssignmentsForCourseProvider(courseId));

    return AppScaffold(
      title: 'Задания курса',
      body: assignmentsAsync.when(
        data: (assignments) {
          if (assignments.isEmpty) {
            return const AppEmptyView(message: 'Заданий нет');
          }
          return ListView.separated(
            itemCount: assignments.length,
            separatorBuilder: (_, _) => AppSpacing.gapSm,
            itemBuilder: (context, index) {
              final a = assignments[index];
              return AppCard(
                onTap: () =>
                    context.push('/student/assignments/${a.assignmentId}'),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      a.title,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    AppSpacing.gapXs,
                    Text(
                      'Дедлайн: ${_formatDeadline(a.deadline)}',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    Text(
                      'Балл: ${a.maxScore}',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              );
            },
          );
        },
        loading: () => const AppLoader(),
        error: (e, _) => AppErrorView(
          failure: e as Failure,
          onRetry: () =>
              ref.invalidate(publishedAssignmentsForCourseProvider(courseId)),
        ),
      ),
    );
  }
}

/// Дедлайн в формате d.m.y, либо «—», если он не задан.
String _formatDeadline(DateTime? deadline) {
  if (deadline == null) return '—';
  return '${deadline.day}.${deadline.month}.${deadline.year}';
}
