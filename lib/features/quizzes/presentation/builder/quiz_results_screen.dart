import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/error/failure.dart';
import '../../../../shared/widgets/widgets.dart';
import '../../../../theme/app_spacing.dart';
import '../../../auth/data/user_providers.dart';
import '../../data/attempt_providers.dart';
import '../../domain/quiz_attempt.dart';

/// Результаты квиза для преподавателя: попытки всех студентов (ТЗ 14.3 п.22,
/// P2-18). Показывает балл, процент и статус каждой попытки.
class QuizResultsScreen extends ConsumerWidget {
  const QuizResultsScreen({super.key, required this.quizId});

  final String quizId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final attemptsAsync = ref.watch(quizAllAttemptsProvider(quizId));

    return AppScaffold(
      title: 'Результаты квиза',
      body: attemptsAsync.when(
        data: (attempts) {
          if (attempts.isEmpty) {
            return const AppEmptyView(message: 'Попыток пока нет');
          }
          final graded = attempts.where((a) => a.score != null).toList();
          final avg = graded.isEmpty
              ? null
              : graded.fold<num>(0, (s, a) => s + (a.percentage ?? 0)) /
                  graded.length;
          return ListView(
            children: [
              AppCard(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Попыток: ${attempts.length}',
                        style: Theme.of(context).textTheme.titleMedium),
                    if (avg != null)
                      Text('Средний балл: ${(avg * 100).round()}%',
                          style: Theme.of(context).textTheme.titleMedium),
                  ],
                ),
              ),
              AppSpacing.gapMd,
              for (final a in attempts) _AttemptRow(attempt: a),
            ],
          );
        },
        loading: () => const AppLoader(),
        error: (e, _) => AppErrorView(
          failure: e as Failure,
          onRetry: () => ref.invalidate(quizAllAttemptsProvider(quizId)),
        ),
      ),
    );
  }
}

class _AttemptRow extends ConsumerWidget {
  const _AttemptRow({required this.attempt});

  final QuizAttempt attempt;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile =
        ref.watch(profileStreamProvider(attempt.studentId)).valueOrNull;
    final name = (profile?.fullName.trim().isNotEmpty ?? false)
        ? profile!.fullName
        : attempt.studentId;
    return AppCard(
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: Theme.of(context).textTheme.titleMedium),
                AppSpacing.gapXs,
                Text('Попытка №${attempt.attemptNumber} · ${attempt.status.label}',
                    style: Theme.of(context).textTheme.bodySmall),
              ],
            ),
          ),
          if (attempt.score != null)
            Text(
              '${attempt.score}/${attempt.maxScore}',
              style: Theme.of(context).textTheme.titleMedium,
            ),
        ],
      ),
    );
  }
}
