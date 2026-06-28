import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/error/failure.dart';
import '../../../../shared/widgets/widgets.dart';
import '../../../../theme/app_spacing.dart';
import '../../data/attempt_providers.dart';
import '../../data/quiz_providers.dart';

/// Экран старта квиза (ТЗ §5.7, шаг 23).
///
/// Если у студента уже есть незавершённая попытка — предлагаем её продолжить.
/// Иначе старт идёт через серверную функцию `startQuizAttempt` (проверка
/// лимита попыток/дедлайна), и мы переходим на экран прохождения.
class QuizStartScreen extends ConsumerStatefulWidget {
  const QuizStartScreen({
    super.key,
    required this.quizId,
    required this.courseId,
  });

  final String quizId;
  final String courseId;

  @override
  ConsumerState<QuizStartScreen> createState() => _QuizStartScreenState();
}

class _QuizStartScreenState extends ConsumerState<QuizStartScreen> {
  bool _starting = false;

  Future<void> _start() async {
    setState(() => _starting = true);
    try {
      final attemptId =
          await ref.read(quizAttemptRepositoryProvider).startAttempt(
                widget.quizId,
              );
      if (!mounted) return;
      context.replace(
        '/student/quizzes/${widget.quizId}/attempt/$attemptId',
      );
    } catch (e) {
      if (!mounted) return;
      AppSnackbar.showFailure(context, e as Failure);
    } finally {
      if (mounted) setState(() => _starting = false);
    }
  }

  static String _fmtDate(DateTime d) =>
      '${d.day.toString().padLeft(2, '0')}.${d.month.toString().padLeft(2, '0')}.${d.year} '
      '${d.hour.toString().padLeft(2, '0')}:${d.minute.toString().padLeft(2, '0')}';

  Widget _infoRow(BuildContext context, String label, String value) => Padding(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: Theme.of(context).textTheme.bodyMedium),
            Text(value,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(fontWeight: FontWeight.w600)),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    final activeAsync = ref.watch(activeAttemptProvider(widget.quizId));
    final quiz = ref.watch(quizByIdProvider(widget.quizId)).valueOrNull;
    final attempts =
        ref.watch(myAttemptsProvider(widget.quizId)).valueOrNull ?? const [];
    final history = attempts.where((a) => !a.status.isInProgress).toList()
      ..sort((a, b) => b.attemptNumber.compareTo(a.attemptNumber));

    return AppScaffold(
      title: 'Квиз',
      body: activeAsync.when(
        data: (active) {
          return ListView(
            children: [
              AppCard(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      quiz?.title.isNotEmpty == true
                          ? quiz!.title
                          : 'Готовы начать?',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    if (quiz != null && quiz.description.isNotEmpty) ...[
                      AppSpacing.gapSm,
                      Text(quiz.description,
                          style: Theme.of(context).textTheme.bodyMedium),
                    ],
                    AppSpacing.gapMd,
                    if (quiz != null) ...[
                      _infoRow(context, 'Вопросов',
                          quiz.questionIds.isNotEmpty
                              ? '${quiz.questionIds.length}'
                              : (quiz.randomizerSettings.totalQuestions > 0
                                  ? '${quiz.randomizerSettings.totalQuestions} (из банка)'
                                  : 'по банку')),
                      _infoRow(
                          context,
                          'Лимит времени',
                          quiz.timeLimitMinutes != null
                              ? '${quiz.timeLimitMinutes} мин'
                              : 'без лимита'),
                      _infoRow(context, 'Попыток', '${quiz.attemptsAllowed}'),
                      if (quiz.deadline != null)
                        _infoRow(context, 'Дедлайн', _fmtDate(quiz.deadline!)),
                    ],
                    AppSpacing.gapXl,
                    if (active != null)
                      PrimaryButton(
                        label: 'Продолжить попытку',
                        icon: Icons.play_arrow,
                        onPressed: () => context.push(
                          '/student/quizzes/${widget.quizId}'
                          '/attempt/${active.attemptId}',
                        ),
                      )
                    else
                      PrimaryButton(
                        label: 'Начать попытку',
                        icon: Icons.play_arrow,
                        isLoading: _starting,
                        onPressed: _start,
                      ),
                  ],
                ),
              ),
              if (history.isNotEmpty) ...[
                AppSpacing.gapLg,
                Text('История попыток',
                    style: Theme.of(context).textTheme.titleMedium),
                AppSpacing.gapSm,
                for (final a in history)
                  AppCard(
                    onTap: () => context.push(
                      '/student/quizzes/${widget.quizId}'
                      '/attempt/${a.attemptId}',
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Попытка №${a.attemptNumber} · ${a.status.label}'),
                        if (a.score != null)
                          Text('${a.score}/${a.maxScore}',
                              style: Theme.of(context).textTheme.titleSmall),
                      ],
                    ),
                  ),
              ],
            ],
          );
        },
        loading: () => const AppLoader(),
        error: (e, _) => AppErrorView(
          failure: e as Failure,
          onRetry: () =>
              ref.invalidate(activeAttemptProvider(widget.quizId)),
        ),
      ),
    );
  }
}
