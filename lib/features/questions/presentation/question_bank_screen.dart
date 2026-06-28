import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/error/failure.dart';
import '../../../shared/widgets/widgets.dart';
import '../../../theme/app_spacing.dart';
import '../../auth/data/auth_providers.dart';
import '../../courses/data/course_providers.dart';
import '../data/question_providers.dart';
import '../domain/question.dart';
import '../domain/question_difficulty.dart';
import '../domain/question_filter.dart';
import '../domain/question_type.dart';

/// Банк вопросов преподавателя (ТЗ §5.5): список, поиск, создание, импорт.
class QuestionBankScreen extends ConsumerStatefulWidget {
  const QuestionBankScreen({super.key});

  @override
  ConsumerState<QuestionBankScreen> createState() => _QuestionBankScreenState();
}

class _QuestionBankScreenState extends ConsumerState<QuestionBankScreen> {
  QuestionFilter _filter = const QuestionFilter();

  /// Применяет фильтры банка к списку (тип/сложность/тема/текст, P1-5).
  List<Question> _apply(List<Question> all) {
    final search = _filter.search.trim().toLowerCase();
    final topic = _filter.topic.trim().toLowerCase();
    return all.where((q) {
      if (_filter.type != null && q.type != _filter.type) return false;
      if (_filter.difficulty != null && q.difficulty != _filter.difficulty) {
        return false;
      }
      if (topic.isNotEmpty && !q.topic.toLowerCase().contains(topic)) {
        return false;
      }
      if (search.isNotEmpty && !q.text.toLowerCase().contains(search)) {
        return false;
      }
      return true;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final uid = ref.watch(appUserProvider).valueOrNull?.uid;
    if (uid == null) {
      return const AppScaffold(
        title: 'Банк вопросов',
        body: AppLoader(),
      );
    }

    final questionsAsync = ref.watch(questionListProvider(uid));

    return AppScaffold(
      title: 'Банк вопросов',
      actions: [
        IconButton(
          tooltip: 'Импорт из TXT',
          icon: const Icon(Icons.upload_file),
          onPressed: () => context.push('/teacher/questions/import'),
        ),
      ],
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/teacher/questions/new'),
        icon: const Icon(Icons.add),
        label: const Text('Создать вопрос'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppTextField(
            label: 'Поиск',
            hint: 'Текст вопроса',
            prefixIcon: Icons.search,
            onChanged: (v) =>
                setState(() => _filter = _filter.copyWith(search: v)),
          ),
          AppSpacing.gapSm,
          Row(
            children: [
              Expanded(
                child: DropdownButtonFormField<QuestionType?>(
                  initialValue: _filter.type,
                  isExpanded: true,
                  decoration: const InputDecoration(labelText: 'Тип'),
                  items: [
                    const DropdownMenuItem(value: null, child: Text('Все типы')),
                    for (final t in QuestionType.values)
                      DropdownMenuItem(value: t, child: Text(t.label)),
                  ],
                  onChanged: (v) => setState(
                      () => _filter = _filter.copyWith(type: v, resetType: v == null)),
                ),
              ),
              AppSpacing.gapSm,
              Expanded(
                child: DropdownButtonFormField<QuestionDifficulty?>(
                  initialValue: _filter.difficulty,
                  isExpanded: true,
                  decoration: const InputDecoration(labelText: 'Сложность'),
                  items: [
                    const DropdownMenuItem(value: null, child: Text('Любая')),
                    for (final d in QuestionDifficulty.values)
                      DropdownMenuItem(value: d, child: Text(d.label)),
                  ],
                  onChanged: (v) => setState(() => _filter = _filter.copyWith(
                      difficulty: v, resetDifficulty: v == null)),
                ),
              ),
            ],
          ),
          AppSpacing.gapMd,
          Expanded(
            child: questionsAsync.when(
              loading: () => const AppLoader(),
              error: (e, _) => AppErrorView(
                failure: e as Failure,
                onRetry: () => ref.invalidate(questionListProvider(uid)),
              ),
              data: (questions) {
                final filtered = _apply(questions);
                if (filtered.isEmpty) {
                  return const AppEmptyView(message: 'Вопросов пока нет');
                }
                return ListView.builder(
                  itemCount: filtered.length,
                  itemBuilder: (context, index) =>
                      _QuestionTile(question: filtered[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

/// Действия над вопросом (P1-4): открывают готовые методы репозитория
/// duplicate/archive/delete/attachToCourses, не вызывавшиеся из UI.
enum _QuestionAction { duplicate, attach, archive, delete }

class _QuestionTile extends ConsumerWidget {
  const _QuestionTile({required this.question});

  final Question question;

  Future<void> _run(
    BuildContext context,
    Future<void> Function() action,
    String successMessage,
  ) async {
    try {
      await action();
      if (context.mounted) AppSnackbar.show(context, successMessage);
    } catch (e) {
      if (context.mounted) AppSnackbar.showFailure(context, e as Failure);
    }
  }

  Future<void> _onSelected(
      BuildContext context, WidgetRef ref, _QuestionAction action) async {
    final repo = ref.read(questionRepositoryProvider);
    final id = question.questionId;
    switch (action) {
      case _QuestionAction.duplicate:
        await _run(context, () => repo.duplicateQuestion(id), 'Вопрос продублирован');
      case _QuestionAction.archive:
        await _run(context, () => repo.archiveQuestion(id), 'Вопрос архивирован');
      case _QuestionAction.delete:
        final ok = await AppDialog.confirm(
          context,
          title: 'Удалить вопрос?',
          message: 'Действие необратимо.',
          confirmLabel: 'Удалить',
        );
        if (ok && context.mounted) {
          await _run(context, () => repo.deleteQuestion(id), 'Вопрос удалён');
        }
      case _QuestionAction.attach:
        final selected = await showDialog<List<String>>(
          context: context,
          builder: (_) => _AttachCoursesDialog(question: question),
        );
        if (selected != null && context.mounted) {
          await _run(context, () => repo.attachToCourses(id, selected),
              'Привязка к курсам обновлена');
        }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    return AppCard(
      onTap: () =>
          context.push('/teacher/questions/${question.questionId}'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  question.text.isEmpty ? '(без текста)' : question.text,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.titleMedium,
                ),
              ),
              PopupMenuButton<_QuestionAction>(
                tooltip: 'Действия',
                onSelected: (a) => _onSelected(context, ref, a),
                itemBuilder: (_) => [
                  const PopupMenuItem(
                    value: _QuestionAction.duplicate,
                    child: Text('Дублировать'),
                  ),
                  const PopupMenuItem(
                    value: _QuestionAction.attach,
                    child: Text('Привязать к курсам'),
                  ),
                  if (!question.status.isArchived)
                    const PopupMenuItem(
                      value: _QuestionAction.archive,
                      child: Text('Архивировать'),
                    ),
                  const PopupMenuItem(
                    value: _QuestionAction.delete,
                    child: Text('Удалить'),
                  ),
                ],
              ),
            ],
          ),
          AppSpacing.gapSm,
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.xs,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Chip(
                label: Text(question.type.label),
                visualDensity: VisualDensity.compact,
              ),
              Chip(
                label: Text(question.difficulty.label),
                visualDensity: VisualDensity.compact,
              ),
              Text(
                'Балл: ${question.points}',
                style: theme.textTheme.bodySmall,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Диалог выбора курсов для привязки вопроса (P1-4). Возвращает список id
/// выбранных курсов (или null при отмене).
class _AttachCoursesDialog extends ConsumerStatefulWidget {
  const _AttachCoursesDialog({required this.question});

  final Question question;

  @override
  ConsumerState<_AttachCoursesDialog> createState() =>
      _AttachCoursesDialogState();
}

class _AttachCoursesDialogState extends ConsumerState<_AttachCoursesDialog> {
  late final Set<String> _selected = {...widget.question.courseIds};

  @override
  Widget build(BuildContext context) {
    final coursesAsync =
        ref.watch(ownerCoursesProvider(widget.question.ownerTeacherId));
    return AlertDialog(
      title: const Text('Привязать к курсам'),
      content: SizedBox(
        width: double.maxFinite,
        child: coursesAsync.when(
          data: (courses) {
            if (courses.isEmpty) {
              return const Text('У вас пока нет курсов');
            }
            return ListView(
              shrinkWrap: true,
              children: [
                for (final c in courses)
                  CheckboxListTile(
                    contentPadding: EdgeInsets.zero,
                    value: _selected.contains(c.courseId),
                    title: Text(c.title.isEmpty ? c.courseId : c.title),
                    onChanged: (v) => setState(() {
                      if (v ?? false) {
                        _selected.add(c.courseId);
                      } else {
                        _selected.remove(c.courseId);
                      }
                    }),
                  ),
              ],
            );
          },
          loading: () => const Padding(
            padding: EdgeInsets.all(AppSpacing.lg),
            child: Center(child: CircularProgressIndicator()),
          ),
          error: (_, _) => const Text('Не удалось загрузить курсы'),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Отмена'),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(_selected.toList()),
          child: const Text('Сохранить'),
        ),
      ],
    );
  }
}
