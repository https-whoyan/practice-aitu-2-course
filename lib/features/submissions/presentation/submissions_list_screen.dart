import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/error/failure.dart';
import '../../../shared/widgets/widgets.dart';
import '../../../theme/app_spacing.dart';
import '../../auth/data/user_providers.dart';
import '../data/submission_providers.dart';
import '../domain/submission.dart';
import '../domain/submission_status.dart';

enum _SubmissionSort { dateDesc, dateAsc, status, student }

/// Список ответов студентов на задание (преподаватель, ТЗ §5.5, §5.4.6, P2-11).
///
/// Фильтр по статусу + сортировка; имя студента — из профиля, не uid.
class SubmissionsListScreen extends ConsumerStatefulWidget {
  const SubmissionsListScreen({
    super.key,
    required this.assignmentId,
    required this.courseId,
    required this.maxScore,
  });

  final String assignmentId;
  final String courseId;
  final int maxScore;

  @override
  ConsumerState<SubmissionsListScreen> createState() =>
      _SubmissionsListScreenState();
}

class _SubmissionsListScreenState extends ConsumerState<SubmissionsListScreen> {
  SubmissionStatus? _statusFilter;
  _SubmissionSort _sort = _SubmissionSort.dateDesc;

  List<Submission> _apply(List<Submission> items) {
    final list = _statusFilter == null
        ? [...items]
        : items.where((s) => s.status == _statusFilter).toList();
    switch (_sort) {
      case _SubmissionSort.dateDesc:
        list.sort((a, b) => (b.submittedAt ?? b.updatedAt)
            .compareTo(a.submittedAt ?? a.updatedAt));
      case _SubmissionSort.dateAsc:
        list.sort((a, b) => (a.submittedAt ?? a.updatedAt)
            .compareTo(b.submittedAt ?? b.updatedAt));
      case _SubmissionSort.status:
        list.sort((a, b) => a.status.code.compareTo(b.status.code));
      case _SubmissionSort.student:
        list.sort((a, b) => a.studentId.compareTo(b.studentId));
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    final submissionsAsync =
        ref.watch(submissionsForAssignmentProvider(widget.assignmentId));

    return AppScaffold(
      title: 'Отправки',
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: DropdownButtonFormField<SubmissionStatus?>(
                  initialValue: _statusFilter,
                  isExpanded: true,
                  decoration: const InputDecoration(labelText: 'Статус'),
                  items: [
                    const DropdownMenuItem(value: null, child: Text('Все')),
                    for (final s in SubmissionStatus.values)
                      DropdownMenuItem(value: s, child: Text(s.label)),
                  ],
                  onChanged: (v) => setState(() => _statusFilter = v),
                ),
              ),
              AppSpacing.gapSm,
              Expanded(
                child: DropdownButtonFormField<_SubmissionSort>(
                  initialValue: _sort,
                  isExpanded: true,
                  decoration: const InputDecoration(labelText: 'Сортировка'),
                  items: const [
                    DropdownMenuItem(
                        value: _SubmissionSort.dateDesc, child: Text('Дата ↓')),
                    DropdownMenuItem(
                        value: _SubmissionSort.dateAsc, child: Text('Дата ↑')),
                    DropdownMenuItem(
                        value: _SubmissionSort.status, child: Text('Статус')),
                    DropdownMenuItem(
                        value: _SubmissionSort.student, child: Text('Студент')),
                  ],
                  onChanged: (v) =>
                      setState(() => _sort = v ?? _SubmissionSort.dateDesc),
                ),
              ),
            ],
          ),
          AppSpacing.gapMd,
          Expanded(
            child: submissionsAsync.when(
              data: (submissions) {
                final list = _apply(submissions);
                if (list.isEmpty) {
                  return const AppEmptyView(message: 'Отправок нет');
                }
                return ListView.separated(
                  itemCount: list.length,
                  separatorBuilder: (_, _) => AppSpacing.gapSm,
                  itemBuilder: (context, index) => _SubmissionTile(
                    submission: list[index],
                    onTap: () => context.push(
                      '/teacher/courses/${widget.courseId}/weeks/_/assignments/'
                      '${widget.assignmentId}/submissions/${list[index].submissionId}'
                      '?studentId=${list[index].studentId}&maxScore=${widget.maxScore}',
                    ),
                  ),
                );
              },
              loading: () => const AppLoader(),
              error: (e, _) => AppErrorView(
                failure: e as Failure,
                onRetry: () => ref.invalidate(
                    submissionsForAssignmentProvider(widget.assignmentId)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Карточка отправки с именем студента из профиля (P2-11).
class _SubmissionTile extends ConsumerWidget {
  const _SubmissionTile({required this.submission, required this.onTap});

  final Submission submission;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile =
        ref.watch(profileStreamProvider(submission.studentId)).valueOrNull;
    final name = (profile?.fullName.trim().isNotEmpty ?? false)
        ? profile!.fullName
        : submission.studentId;
    return AppCard(
      onTap: onTap,
      child: Row(
        children: [
          Expanded(
            child: Text(name, style: Theme.of(context).textTheme.titleMedium),
          ),
          AppSpacing.gapSm,
          Chip(
            label: Text(submission.status.label),
            visualDensity: VisualDensity.compact,
          ),
        ],
      ),
    );
  }
}
