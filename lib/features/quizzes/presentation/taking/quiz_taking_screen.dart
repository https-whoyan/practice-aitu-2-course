import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/error/failure.dart';
import '../../../../shared/widgets/widgets.dart';
import '../../../../theme/app_spacing.dart';
import '../../data/attempt_providers.dart';
import '../../data/quiz_providers.dart';
import '../../domain/attempt_status.dart';
import '../../domain/question_snapshot_item.dart';
import '../../domain/quiz.dart';
import '../../domain/quiz_attempt.dart';

/// Экран прохождения квиза (ТЗ §5.7, шаг 23).
///
/// Рендерит вопросы из снимка `questionSnapshot` и хранит ответы локально
/// (отображаемые позиции, а не исходные индексы). Сохранение прогресса и
/// завершение идут через репозиторий; оценивание выполняет сервер. Если
/// попытка уже завершена — показываем итог.
class QuizTakingScreen extends ConsumerStatefulWidget {
  const QuizTakingScreen({
    super.key,
    required this.quizId,
    required this.attemptId,
  });

  final String quizId;
  final String attemptId;

  @override
  ConsumerState<QuizTakingScreen> createState() => _QuizTakingScreenState();
}

class _QuizTakingScreenState extends ConsumerState<QuizTakingScreen> {
  /// Локальные ответы: questionId → значение по типу вопроса.
  final Map<String, dynamic> _answers = {};
  bool _seeded = false;
  bool _saving = false;
  bool _submitting = false;

  /// Таймер обратного отсчёта (лимит времени/дедлайн квиза, P0-2).
  Timer? _ticker;
  DateTime? _endsAt;
  Duration _remaining = Duration.zero;

  @override
  void dispose() {
    _ticker?.cancel();
    super.dispose();
  }

  /// Момент окончания попытки = ближайший из (старт + лимит) и дедлайна квиза.
  DateTime? _deadlineFor(QuizAttempt attempt, Quiz quiz) {
    final candidates = <DateTime>[];
    final startedAt = attempt.startedAt;
    if (quiz.timeLimitMinutes != null && startedAt != null) {
      candidates.add(startedAt.add(Duration(minutes: quiz.timeLimitMinutes!)));
    }
    if (quiz.deadline != null) candidates.add(quiz.deadline!);
    if (candidates.isEmpty) return null;
    candidates.sort();
    return candidates.first;
  }

  /// Запускает отсчёт один раз, когда известны попытка и квиз.
  void _ensureTimer(QuizAttempt attempt, Quiz quiz) {
    if (_ticker != null) return;
    final endsAt = _deadlineFor(attempt, quiz);
    if (endsAt == null) return;
    _endsAt = endsAt;
    void tick() {
      final left = _endsAt!.difference(DateTime.now());
      if (left <= Duration.zero) {
        _ticker?.cancel();
        if (mounted && !_submitting) _autoSubmit();
        return;
      }
      if (mounted) setState(() => _remaining = left);
    }

    tick();
    _ticker = Timer.periodic(const Duration(seconds: 1), (_) => tick());
  }

  /// Авто-отправка по истечении времени (без подтверждения).
  Future<void> _autoSubmit() async {
    if (_submitting) return;
    setState(() => _submitting = true);
    try {
      final repo = ref.read(quizAttemptRepositoryProvider);
      await repo.saveAnswers(widget.attemptId, _answers);
      await repo.submitAttempt(widget.attemptId);
      if (!mounted) return;
      AppSnackbar.show(context, 'Время вышло — попытка отправлена');
      context.pop();
    } catch (e) {
      if (!mounted) return;
      AppSnackbar.showFailure(context, e as Failure);
      setState(() => _submitting = false);
    }
  }

  /// Заполняет локальные ответы из попытки один раз при первой загрузке.
  void _seed(QuizAttempt attempt) {
    if (_seeded) return;
    _seeded = true;
    attempt.answers.forEach((key, value) {
      if (value is List) {
        _answers[key] = value.map((e) => e as int).toList();
      } else {
        _answers[key] = value;
      }
    });
  }

  Future<void> _save() async {
    setState(() => _saving = true);
    try {
      await ref
          .read(quizAttemptRepositoryProvider)
          .saveAnswers(widget.attemptId, _answers);
      if (!mounted) return;
      AppSnackbar.show(context, 'Прогресс сохранён');
    } catch (e) {
      if (!mounted) return;
      AppSnackbar.showFailure(context, e as Failure);
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  Future<void> _submit() async {
    final confirmed = await AppDialog.confirm(
      context,
      title: 'Завершить попытку?',
      message: 'После завершения изменить ответы будет нельзя.',
      confirmLabel: 'Завершить',
    );
    if (!confirmed || !mounted) return;
    setState(() => _submitting = true);
    try {
      final repo = ref.read(quizAttemptRepositoryProvider);
      await repo.saveAnswers(widget.attemptId, _answers);
      await repo.submitAttempt(widget.attemptId);
      if (!mounted) return;
      AppSnackbar.show(context, 'Попытка отправлена на проверку');
      context.pop();
    } catch (e) {
      if (!mounted) return;
      AppSnackbar.showFailure(context, e as Failure);
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final attemptAsync = ref.watch(attemptByIdProvider(widget.attemptId));
    final quiz = ref.watch(quizByIdProvider(widget.quizId)).valueOrNull;

    return AppScaffold(
      title: 'Прохождение квиза',
      body: attemptAsync.when(
        data: (attempt) {
          if (attempt == null) {
            return const AppEmptyView(message: 'Попытка не найдена');
          }
          if (attempt.status != AttemptStatus.inProgress) {
            return _FinishedView(attempt: attempt);
          }
          _seed(attempt);
          if (quiz != null) _ensureTimer(attempt, quiz);
          return _buildForm(attempt);
        },
        loading: () => const AppLoader(),
        error: (e, _) => AppErrorView(
          failure: e as Failure,
          onRetry: () =>
              ref.invalidate(attemptByIdProvider(widget.attemptId)),
        ),
      ),
    );
  }

  Widget _buildForm(QuizAttempt attempt) {
    final items = attempt.questionSnapshot;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Вопросов: ${items.length}',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              if (_endsAt != null) _TimerChip(remaining: _remaining),
            ],
          ),
          AppSpacing.gapMd,
          for (var i = 0; i < items.length; i++) ...[
            _QuestionCard(
              index: i,
              item: items[i],
              answer: _answers[items[i].questionId],
              onChanged: (value) =>
                  setState(() => _answers[items[i].questionId] = value),
            ),
            AppSpacing.gapMd,
          ],
          AppSpacing.gapSm,
          SecondaryButton(
            label: 'Сохранить прогресс',
            isLoading: _saving,
            onPressed: _saving || _submitting ? null : _save,
          ),
          AppSpacing.gapSm,
          PrimaryButton(
            label: 'Завершить',
            isLoading: _submitting,
            onPressed: _saving || _submitting ? null : _submit,
          ),
          AppSpacing.gapLg,
        ],
      ),
    );
  }
}

/// Чип обратного отсчёта; краснеет на последней минуте (P0-2).
class _TimerChip extends StatelessWidget {
  const _TimerChip({required this.remaining});

  final Duration remaining;

  @override
  Widget build(BuildContext context) {
    final isUrgent = remaining.inSeconds <= 60;
    final m = remaining.inMinutes.toString().padLeft(2, '0');
    final s = (remaining.inSeconds % 60).toString().padLeft(2, '0');
    final color = isUrgent
        ? Theme.of(context).colorScheme.error
        : Theme.of(context).colorScheme.primary;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.timer_outlined, size: 18, color: color),
        const SizedBox(width: 4),
        Text(
          '$m:$s',
          style: Theme.of(context)
              .textTheme
              .titleSmall
              ?.copyWith(color: color, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

/// Карточка одного вопроса; рендер зависит от `item.type`.
class _QuestionCard extends StatelessWidget {
  const _QuestionCard({
    required this.index,
    required this.item,
    required this.answer,
    required this.onChanged,
  });

  final int index;
  final QuestionSnapshotItem item;
  final dynamic answer;
  final ValueChanged<dynamic> onChanged;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Вопрос ${index + 1} · ${item.points} б.',
            style: Theme.of(context).textTheme.labelMedium,
          ),
          AppSpacing.gapXs,
          Text(
            item.text,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          AppSpacing.gapSm,
          ..._buildInput(context),
        ],
      ),
    );
  }

  List<Widget> _buildInput(BuildContext context) {
    switch (item.type) {
      case 'single':
        return _buildSingle();
      case 'multiple':
        return _buildMultiple();
      case 'trueFalse':
        return _buildTrueFalse();
      case 'shortText':
        return _buildShortText();
      default:
        return [
          Text(
            'Неподдерживаемый тип вопроса: ${item.type}',
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ];
    }
  }

  List<Widget> _buildSingle() {
    final selected = answer is int ? answer as int : null;
    return [
      RadioGroup<int>(
        groupValue: selected,
        onChanged: (value) => onChanged(value),
        child: Column(
          children: [
            for (var i = 0; i < item.options.length; i++)
              RadioListTile<int>(
                contentPadding: EdgeInsets.zero,
                value: i,
                title: Text(item.options[i]),
              ),
          ],
        ),
      ),
    ];
  }

  List<Widget> _buildMultiple() {
    final selected = answer is List ? List<int>.from(answer as List) : <int>[];
    return [
      for (var i = 0; i < item.options.length; i++)
        CheckboxListTile(
          contentPadding: EdgeInsets.zero,
          value: selected.contains(i),
          title: Text(item.options[i]),
          controlAffinity: ListTileControlAffinity.leading,
          onChanged: (checked) {
            final next = List<int>.from(selected);
            if (checked ?? false) {
              if (!next.contains(i)) next.add(i);
            } else {
              next.remove(i);
            }
            next.sort();
            onChanged(next);
          },
        ),
    ];
  }

  List<Widget> _buildTrueFalse() {
    final selected = answer is bool ? answer as bool : null;
    return [
      RadioGroup<bool>(
        groupValue: selected,
        onChanged: (value) => onChanged(value),
        child: const Column(
          children: [
            RadioListTile<bool>(
              contentPadding: EdgeInsets.zero,
              value: true,
              title: Text('Верно'),
            ),
            RadioListTile<bool>(
              contentPadding: EdgeInsets.zero,
              value: false,
              title: Text('Неверно'),
            ),
          ],
        ),
      ),
    ];
  }

  List<Widget> _buildShortText() {
    return [
      TextFormField(
        initialValue: answer is String ? answer as String : '',
        decoration: const InputDecoration(hintText: 'Ваш ответ'),
        onChanged: (value) => onChanged(value),
      ),
    ];
  }
}

/// Итог завершённой попытки (со счётом и, если квиз раскрывает ответы, разбором).
class _FinishedView extends StatelessWidget {
  const _FinishedView({required this.attempt});

  final QuizAttempt attempt;

  @override
  Widget build(BuildContext context) {
    final isGraded = attempt.status == AttemptStatus.graded;
    final reveal = attempt.revealed;
    return ListView(
      children: [
        AppCard(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Icon(
                isGraded ? Icons.task_alt : Icons.hourglass_top,
                size: 48,
                color: Theme.of(context).colorScheme.primary,
              ),
              AppSpacing.gapMd,
              Text(
                'Попытка завершена',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              AppSpacing.gapSm,
              Text(
                'Статус: ${attempt.status.label}',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              if (isGraded && attempt.score != null) ...[
                AppSpacing.gapMd,
                Text(
                  'Баллы: ${attempt.score} / ${attempt.maxScore}',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                if (attempt.percentage != null) ...[
                  AppSpacing.gapXs,
                  Text(
                    '${attempt.percentage!.toStringAsFixed(0)}%',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ],
              ],
            ],
          ),
        ),
        if (reveal != null && reveal.isNotEmpty) ...[
          AppSpacing.gapLg,
          Text('Разбор ответов',
              style: Theme.of(context).textTheme.titleMedium),
          AppSpacing.gapSm,
          for (var i = 0; i < attempt.questionSnapshot.length; i++)
            _RevealCard(
              index: i,
              item: attempt.questionSnapshot[i],
              reveal: reveal[attempt.questionSnapshot[i].questionId]
                  as Map<String, dynamic>?,
            ),
        ],
      ],
    );
  }
}

/// Карточка разбора одного вопроса: правильный ответ + объяснение (P1-8).
class _RevealCard extends StatelessWidget {
  const _RevealCard({
    required this.index,
    required this.item,
    required this.reveal,
  });

  final int index;
  final QuestionSnapshotItem item;
  final Map<String, dynamic>? reveal;

  /// Текст варианта по исходному индексу с учётом перемешивания.
  String _optionText(int originalIndex) {
    final order = item.optionOrder;
    final pos = order.indexOf(originalIndex);
    final p = pos >= 0 ? pos : originalIndex;
    return (p >= 0 && p < item.options.length) ? item.options[p] : '#$originalIndex';
  }

  String _correctAnswer() {
    final r = reveal;
    if (r == null) return '—';
    switch (item.type) {
      case 'single':
        final ci = r['correctIndex'] as int?;
        return ci == null ? '—' : _optionText(ci);
      case 'multiple':
        final list = (r['correctIndexes'] as List?)?.cast<int>() ?? const [];
        return list.map(_optionText).join(', ');
      case 'trueFalse':
        final b = r['correctBool'] as bool?;
        return b == null ? '—' : (b ? 'Верно' : 'Неверно');
      case 'shortText':
        final acc = (r['acceptedAnswers'] as List?)?.cast<String>() ?? const [];
        return acc.join(', ');
      default:
        return '—';
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final explanation = reveal?['explanation'] as String?;
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Вопрос ${index + 1}', style: theme.textTheme.labelMedium),
          AppSpacing.gapXs,
          Text(item.text, style: theme.textTheme.titleSmall),
          AppSpacing.gapSm,
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.check_circle_outline,
                  size: 18, color: theme.colorScheme.primary),
              const SizedBox(width: 4),
              Expanded(
                child: Text('Правильный ответ: ${_correctAnswer()}',
                    style: theme.textTheme.bodyMedium),
              ),
            ],
          ),
          if (explanation != null && explanation.isNotEmpty) ...[
            AppSpacing.gapXs,
            Text(explanation,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                )),
          ],
        ],
      ),
    );
  }
}
