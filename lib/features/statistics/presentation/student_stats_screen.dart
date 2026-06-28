import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/error/failure.dart';
import '../../../shared/widgets/widgets.dart';
import '../../../theme/app_spacing.dart';
import '../data/statistics_repository.dart';
import 'risk_indicator.dart';

/// Экран «Моя статистика» для студента (read-only, шаг 25).
///
/// Читает агрегат [mySummaryProvider] (`studentSummaries`), который
/// обновляется на сервере после выставления оценок.
class StudentStatsScreen extends ConsumerWidget {
  const StudentStatsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final summaryAsync = ref.watch(mySummaryProvider);

    return AppScaffold(
      title: 'Моя статистика',
      body: summaryAsync.when(
        loading: () => const AppLoader(),
        error: (e, _) => AppErrorView(
          failure: e as Failure,
          onRetry: () => ref.invalidate(mySummaryProvider),
        ),
        data: (summary) {
          if (summary == null) {
            return const AppEmptyView(
              message: 'Статистика появится после первых оценок',
            );
          }
          final theme = Theme.of(context);
          return ListView(
            children: [
              const SectionHeader(title: 'Сводка'),
              AppCard(
                child: Text(
                  'Средний результат: ${summary.averagePercent}%',
                  style: theme.textTheme.titleMedium,
                ),
              ),
              AppSpacing.gapMd,
              AppCard(child: Text('Всего оценок: ${summary.totalGrades}')),
              AppSpacing.gapMd,
              AppCard(
                child: Text('Квизов пройдено: ${summary.gradedQuizzes}'),
              ),
              AppSpacing.gapMd,
              AppCard(
                child: Text('Заданий оценено: ${summary.gradedAssignments}'),
              ),
              if (summary.gradedQuizzes > 0) ...[
                AppSpacing.gapMd,
                AppCard(
                  child: Text(
                      'Средний балл по квизам: ${(summary.averageQuizPercentage * 100).round()}%'),
                ),
              ],
              AppSpacing.gapMd,
              AppCard(
                child: Text('Просрочено заданий: ${summary.overdueCount}'),
              ),
              AppSpacing.gapMd,
              AppCard(
                child: Text('Ближайших дедлайнов: ${summary.upcomingCount}'),
              ),
              AppSpacing.gapMd,
              AppCard(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: RiskIndicator(level: summary.riskLevel),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
