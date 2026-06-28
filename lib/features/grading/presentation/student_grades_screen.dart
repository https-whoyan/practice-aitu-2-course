import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/error/failure.dart';
import '../../../shared/widgets/widgets.dart';
import '../../../theme/app_spacing.dart';
import '../data/grade_providers.dart';
import '../domain/grade.dart';

/// Экран «Мои оценки» для студента (ТЗ §5.6.5).
///
/// Показывает все оценки текущего пользователя (через [myGradesProvider]):
/// балл, процент, источник и комментарий преподавателя.
class StudentGradesScreen extends ConsumerWidget {
  const StudentGradesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gradesAsync = ref.watch(myGradesProvider);

    return AppScaffold(
      title: 'Мои оценки',
      body: gradesAsync.when(
        loading: () => const AppLoader(),
        error: (e, _) => AppErrorView(
          failure: e as Failure,
          onRetry: () => ref.invalidate(myGradesProvider),
        ),
        data: (grades) {
          if (grades.isEmpty) {
            return const AppEmptyView(message: 'Оценок пока нет');
          }
          return ListView.separated(
            itemCount: grades.length,
            separatorBuilder: (_, _) => AppSpacing.gapMd,
            itemBuilder: (context, i) => _GradeCard(grade: grades[i]),
          );
        },
      ),
    );
  }
}

class _GradeCard extends StatelessWidget {
  const _GradeCard({required this.grade});

  final Grade grade;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final comment = grade.comment?.trim() ?? '';
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  '${grade.score}/${grade.maxScore}',
                  style: theme.textTheme.titleMedium,
                ),
              ),
              Text(
                '${(grade.percentage * 100).round()}%',
                style: theme.textTheme.titleMedium,
              ),
            ],
          ),
          AppSpacing.gapXs,
          Text(
            grade.sourceType.label,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          if (comment.isNotEmpty) ...[
            AppSpacing.gapMd,
            Text(comment, style: theme.textTheme.bodyMedium),
          ],
        ],
      ),
    );
  }
}
