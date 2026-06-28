import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/error/failure.dart';
import '../../../shared/widgets/widgets.dart';
import '../../../theme/app_spacing.dart';
import '../data/assignment_providers.dart';
import '../domain/assignment.dart';

/// Список заданий недели для преподавателя (ТЗ §5.4.5, шаг 17).
class CourseAssignmentsScreen extends ConsumerWidget {
  const CourseAssignmentsScreen({
    super.key,
    required this.courseId,
    required this.weekId,
  });

  final String courseId;
  final String weekId;

  String _fmtDate(DateTime d) => '${d.day}.${d.month}.${d.year}';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final assignmentsAsync = ref.watch(assignmentsForWeekProvider(weekId));

    return AppScaffold(
      title: 'Задания',
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push(
          '/teacher/courses/$courseId/weeks/$weekId/assignments/new',
        ),
        icon: const Icon(Icons.add),
        label: const Text('Создать задание'),
      ),
      body: assignmentsAsync.when(
        data: (assignments) {
          if (assignments.isEmpty) {
            return const AppEmptyView(message: 'Заданий пока нет');
          }
          return ListView(
            children: [
              for (final assignment in assignments)
                Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                  child: _AssignmentCard(
                    assignment: assignment,
                    deadlineLabel: assignment.deadline == null
                        ? '—'
                        : _fmtDate(assignment.deadline!),
                    onTap: () => context.push(
                      '/teacher/courses/$courseId/weeks/$weekId/assignments/${assignment.assignmentId}/edit',
                    ),
                    onSubmissions: () => context.push(
                      '/teacher/courses/$courseId/weeks/$weekId/assignments/${assignment.assignmentId}/submissions?maxScore=${assignment.maxScore}',
                    ),
                  ),
                ),
            ],
          );
        },
        loading: () => const AppLoader(),
        error: (e, _) => AppErrorView(
          failure: e as Failure,
          onRetry: () => ref.invalidate(assignmentsForWeekProvider(weekId)),
        ),
      ),
    );
  }
}

class _AssignmentCard extends StatelessWidget {
  const _AssignmentCard({
    required this.assignment,
    required this.deadlineLabel,
    required this.onTap,
    required this.onSubmissions,
  });

  final Assignment assignment;
  final String deadlineLabel;
  final VoidCallback onTap;
  final VoidCallback onSubmissions;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return AppCard(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  assignment.title,
                  style: textTheme.titleMedium,
                ),
              ),
              _StatusChip(isPublished: assignment.isPublished),
            ],
          ),
          AppSpacing.gapXs,
          Text('Дедлайн: $deadlineLabel', style: textTheme.bodySmall),
          Text('Балл: ${assignment.maxScore}', style: textTheme.bodySmall),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton.icon(
              icon: const Icon(Icons.fact_check_outlined, size: 18),
              label: const Text('Отправки'),
              onPressed: onSubmissions,
            ),
          ),
        ],
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  const _StatusChip({required this.isPublished});

  final bool isPublished;

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(isPublished ? 'Опубликовано' : 'Черновик'),
      visualDensity: VisualDensity.compact,
    );
  }
}
