import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/error/failure.dart';
import '../../../shared/widgets/widgets.dart';
import '../../../theme/app_spacing.dart';
import '../../grading/data/grade_providers.dart';
import '../../submissions/data/submission_providers.dart';
import '../data/assignment_providers.dart';
import '../domain/assignment.dart';
import '../domain/student_assignment_status.dart';
import '../domain/submission_type.dart';

/// Страница задания глазами студента: условия, статус и переход к отправке
/// (ТЗ §5.6.4, шаг 17).
class StudentAssignmentPageScreen extends ConsumerWidget {
  const StudentAssignmentPageScreen({super.key, required this.assignmentId});

  final String assignmentId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final assignmentAsync = ref.watch(assignmentByIdProvider(assignmentId));

    return AppScaffold(
      title: 'Задание',
      body: assignmentAsync.when(
        data: (assignment) {
          if (assignment == null) {
            return const AppEmptyView(message: 'Задание не найдено');
          }
          return _content(context, ref, assignment);
        },
        loading: () => const AppLoader(),
        error: (e, _) => AppErrorView(
          failure: e as Failure,
          onRetry: () => ref.invalidate(assignmentByIdProvider(assignmentId)),
        ),
      ),
    );
  }

  Widget _content(BuildContext context, WidgetRef ref, Assignment a) {
    final textTheme = Theme.of(context).textTheme;
    final submission = ref.watch(mySubmissionProvider(assignmentId)).valueOrNull;

    final status = computeStudentAssignmentStatus(
      isPublished: a.isPublished,
      deadline: a.deadline,
      submissionStatus: submission?.status.code,
      hasGrade: submission?.gradeId != null,
    );

    final body = a.instruction.isNotEmpty ? a.instruction : a.description;
    final hasSubmission = submission != null;

    // Оценка за задание (P2-13): ищем среди оценок студента по gradeId.
    final grades = ref.watch(myGradesProvider).valueOrNull ?? const [];
    final grade = submission?.gradeId == null
        ? null
        : grades.where((g) => g.gradeId == submission!.gradeId).firstOrNull;

    return ListView(
      children: [
        Text(a.title, style: textTheme.headlineSmall),
        AppSpacing.gapSm,
        Chip(
          label: Text(status.label),
          visualDensity: VisualDensity.compact,
        ),
        if (body.isNotEmpty) ...[
          AppSpacing.gapMd,
          Text(body, style: textTheme.bodyMedium),
        ],
        AppSpacing.gapLg,
        Text(
          'Дедлайн: ${_formatDeadline(a.deadline)}',
          style: textTheme.bodyMedium,
        ),
        AppSpacing.gapXs,
        Text('Макс. балл: ${a.maxScore}', style: textTheme.bodyMedium),
        if (grade != null) ...[
          AppSpacing.gapLg,
          AppCard(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Ваш балл', style: textTheme.titleSmall),
                Text(
                  '${grade.score} / ${grade.maxScore} · '
                  '${(grade.percentage * 100).round()}%',
                  style: textTheme.titleMedium,
                ),
              ],
            ),
          ),
        ],
        if (hasSubmission &&
            (submission.teacherComment?.isNotEmpty ?? false)) ...[
          AppSpacing.gapLg,
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Комментарий преподавателя', style: textTheme.titleSmall),
                AppSpacing.gapXs,
                Text(submission.teacherComment!, style: textTheme.bodyMedium),
              ],
            ),
          ),
        ],
        if (a.submissionType != SubmissionType.none) ...[
          AppSpacing.gapXl,
          PrimaryButton(
            label: hasSubmission ? 'Редактировать ответ' : 'Отправить ответ',
            onPressed: () => context.push(
              '/student/assignments/${a.assignmentId}/submit'
              '?type=${a.submissionType.code}&courseId=${a.courseId}',
            ),
          ),
        ],
      ],
    );
  }
}

/// Дедлайн в формате d.m.y, либо «—», если он не задан.
String _formatDeadline(DateTime? deadline) {
  if (deadline == null) return '—';
  return '${deadline.day}.${deadline.month}.${deadline.year}';
}
