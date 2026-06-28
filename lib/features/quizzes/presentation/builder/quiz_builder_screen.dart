import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/error/failure.dart';
import '../../../../shared/widgets/widgets.dart';
import '../../../../theme/app_spacing.dart';
import '../../../auth/data/auth_providers.dart';
import '../../../questions/data/question_providers.dart';
import '../../data/quiz_providers.dart';
import '../../domain/category_settings.dart';
import '../../domain/quiz.dart';
import '../../domain/randomizer_settings.dart';
import '../../domain/show_result_mode.dart';

/// Конструктор квиза: создание/редактирование метаданных и настроек
/// рандомайзера (ТЗ §5.7, шаг 22).
///
/// [quizId] == null — создание, иначе редактирование (форма переиспользуется).
class QuizBuilderScreen extends ConsumerStatefulWidget {
  const QuizBuilderScreen({super.key, required this.courseId, this.quizId});

  final String courseId;
  final String? quizId;

  @override
  ConsumerState<QuizBuilderScreen> createState() => _QuizBuilderScreenState();
}

class _QuizBuilderScreenState extends ConsumerState<QuizBuilderScreen> {
  final _formKey = GlobalKey<FormState>();
  final _title = TextEditingController();
  final _description = TextEditingController();
  final _weekId = TextEditingController();
  final _timeLimit = TextEditingController();
  final _attempts = TextEditingController(text: '1');
  final _totalQuestions = TextEditingController(text: '0');

  DateTime? _startDate;
  DateTime? _deadline;
  ShowResultMode _showResultMode = ShowResultMode.scoreOnly;
  bool _isPublished = false;
  bool _shuffleQuestions = false;
  bool _shuffleOptions = false;

  /// Ручной выбор вопросов из банка (P2-17). Пусто → рандомайзер по банку.
  final Set<String> _questionIds = {};

  bool _isEdit = false;
  bool _seeded = false;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _isEdit = widget.quizId != null;
  }

  @override
  void dispose() {
    _title.dispose();
    _description.dispose();
    _weekId.dispose();
    _timeLimit.dispose();
    _attempts.dispose();
    _totalQuestions.dispose();
    super.dispose();
  }

  /// Заполняет поля данными квиза один раз (режим редактирования).
  void _seed(Quiz quiz) {
    if (_seeded) return;
    _seeded = true;
    _title.text = quiz.title;
    _description.text = quiz.description;
    _weekId.text = quiz.weekId ?? '';
    _timeLimit.text = quiz.timeLimitMinutes?.toString() ?? '';
    _attempts.text = quiz.attemptsAllowed.toString();
    _totalQuestions.text = quiz.randomizerSettings.totalQuestions.toString();
    _startDate = quiz.startDate;
    _deadline = quiz.deadline;
    _showResultMode = quiz.showResultMode;
    _isPublished = quiz.isPublished;
    _shuffleQuestions = quiz.randomizerSettings.shuffleQuestions;
    _shuffleOptions = quiz.randomizerSettings.shuffleOptions;
    _questionIds.addAll(quiz.questionIds);
  }

  /// Открывает выбор вопросов из банка преподавателя (P2-17).
  Future<void> _pickQuestions(String uid) async {
    final selected = await showDialog<Set<String>>(
      context: context,
      builder: (_) => _QuestionPickerDialog(
        ownerTeacherId: uid,
        initial: _questionIds,
      ),
    );
    if (selected == null) return;
    setState(() {
      _questionIds
        ..clear()
        ..addAll(selected);
    });
  }

  String _fmtDate(DateTime d) =>
      '${d.day.toString().padLeft(2, '0')}.${d.month.toString().padLeft(2, '0')}.${d.year} '
      '${d.hour.toString().padLeft(2, '0')}:${d.minute.toString().padLeft(2, '0')}';

  Future<void> _pickDate({required bool isStart}) async {
    final initial = (isStart ? _startDate : _deadline) ?? DateTime.now();
    final date = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (date == null || !mounted) return;
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(initial),
    );
    if (time == null) return;
    final picked =
        DateTime(date.year, date.month, date.day, time.hour, time.minute);
    setState(() {
      if (isStart) {
        _startDate = picked;
      } else {
        _deadline = picked;
      }
    });
  }

  Future<void> _save(Quiz? existing) async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    final uid = ref.read(appUserProvider).valueOrNull?.uid ?? '';
    setState(() => _saving = true);
    final repo = ref.read(quizRepositoryProvider);
    final now = DateTime.now();

    final weekId = _weekId.text.trim();
    final randomizer = RandomizerSettings(
      totalQuestions: int.tryParse(_totalQuestions.text.trim()) ?? 0,
      shuffleQuestions: _shuffleQuestions,
      shuffleOptions: _shuffleOptions,
    );

    // maxScore (P2-17): для ручного набора — сумма баллов выбранных вопросов,
    // иначе ориентировочно по числу вопросов рандомайзера (1 балл за вопрос).
    int maxScore;
    try {
      final questions = await ref.read(questionListProvider(uid).future);
      final selectedPoints = questions
          .where((q) => _questionIds.contains(q.questionId))
          .fold<int>(0, (s, q) => s + q.points);
      maxScore = _questionIds.isNotEmpty
          ? selectedPoints
          : (int.tryParse(_totalQuestions.text.trim()) ?? 0);
    } catch (_) {
      maxScore = _questionIds.length;
    }

    try {
      if (existing == null) {
        await repo.createQuiz(
          Quiz(
            quizId: '',
            courseId: widget.courseId,
            weekId: weekId.isEmpty ? null : weekId,
            ownerTeacherId: uid,
            title: _title.text.trim(),
            description: _description.text.trim(),
            questionIds: _questionIds.toList(),
            randomizerSettings: randomizer,
            categorySettings: const CategorySettings(),
            startDate: _startDate,
            deadline: _deadline,
            timeLimitMinutes: int.tryParse(_timeLimit.text.trim()),
            attemptsAllowed: int.tryParse(_attempts.text.trim()) ?? 1,
            showResultMode: _showResultMode,
            maxScore: maxScore,
            isPublished: _isPublished,
            createdAt: now,
            updatedAt: now,
          ),
        );
      } else {
        await repo.updateQuiz(
          existing.copyWith(
            weekId: weekId.isEmpty ? null : weekId,
            title: _title.text.trim(),
            description: _description.text.trim(),
            questionIds: _questionIds.toList(),
            randomizerSettings: existing.randomizerSettings.copyWith(
              totalQuestions: randomizer.totalQuestions,
              shuffleQuestions: randomizer.shuffleQuestions,
              shuffleOptions: randomizer.shuffleOptions,
            ),
            startDate: _startDate,
            deadline: _deadline,
            timeLimitMinutes: int.tryParse(_timeLimit.text.trim()),
            attemptsAllowed: int.tryParse(_attempts.text.trim()) ?? 1,
            showResultMode: _showResultMode,
            maxScore: maxScore,
            isPublished: _isPublished,
            updatedAt: now,
          ),
        );
      }
      ref.invalidate(courseQuizzesProvider(widget.courseId));
      if (existing != null) {
        ref.invalidate(quizByIdProvider(existing.quizId));
      }
      if (!mounted) return;
      AppSnackbar.show(
        context,
        existing == null ? 'Квиз создан' : 'Сохранено',
      );
      context.pop();
    } catch (e) {
      if (!mounted) return;
      AppSnackbar.showFailure(context, e as Failure);
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_isEdit) {
      return AppScaffold(
        title: 'Новый квиз',
        body: _form(existing: null),
      );
    }

    final quizAsync = ref.watch(quizByIdProvider(widget.quizId!));
    return AppScaffold(
      title: 'Квиз',
      body: quizAsync.when(
        data: (quiz) {
          if (quiz == null) {
            return const AppEmptyView(message: 'Квиз не найден');
          }
          _seed(quiz);
          return _form(existing: quiz);
        },
        loading: () => const AppLoader(),
        error: (e, _) => AppErrorView(
          failure: e as Failure,
          onRetry: () => ref.invalidate(quizByIdProvider(widget.quizId!)),
        ),
      ),
    );
  }

  Widget _form({required Quiz? existing}) {
    return Form(
      key: _formKey,
      child: ListView(
        children: [
          AppTextField(
            label: 'Название',
            controller: _title,
            validator: (v) =>
                (v == null || v.trim().isEmpty) ? 'Введите название' : null,
          ),
          AppSpacing.gapMd,
          TextFormField(
            controller: _description,
            maxLines: 4,
            decoration: const InputDecoration(labelText: 'Описание'),
          ),
          AppSpacing.gapMd,
          AppTextField(
            label: 'ID недели (необязательно)',
            controller: _weekId,
          ),
          AppSpacing.gapLg,
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text('Дата начала'),
            subtitle: Text(
              _startDate == null ? 'Не выбрана' : _fmtDate(_startDate!),
            ),
            trailing: const Icon(Icons.calendar_today),
            onTap: () => _pickDate(isStart: true),
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text('Дедлайн'),
            subtitle: Text(
              _deadline == null ? 'Не выбран' : _fmtDate(_deadline!),
            ),
            trailing: const Icon(Icons.calendar_today),
            onTap: () => _pickDate(isStart: false),
          ),
          AppSpacing.gapMd,
          AppTextField(
            label: 'Лимит времени, мин (необязательно)',
            controller: _timeLimit,
            keyboardType: TextInputType.number,
          ),
          AppSpacing.gapMd,
          AppTextField(
            label: 'Число попыток',
            controller: _attempts,
            keyboardType: TextInputType.number,
            validator: (v) {
              final n = int.tryParse((v ?? '').trim());
              if (n == null || n < 1) return 'Минимум 1 попытка';
              return null;
            },
          ),
          AppSpacing.gapMd,
          DropdownButtonFormField<ShowResultMode>(
            initialValue: _showResultMode,
            decoration: const InputDecoration(
              labelText: 'Показ результатов',
            ),
            items: [
              for (final mode in ShowResultMode.values)
                DropdownMenuItem<ShowResultMode>(
                  value: mode,
                  child: Text(mode.label),
                ),
            ],
            onChanged: (value) {
              if (value == null) return;
              setState(() => _showResultMode = value);
            },
          ),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text('Опубликован'),
            value: _isPublished,
            onChanged: (value) => setState(() => _isPublished = value),
          ),
          AppSpacing.gapLg,
          Text(
            'Рандомайзер',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          AppSpacing.gapMd,
          TextFormField(
            controller: _totalQuestions,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            decoration: const InputDecoration(
              labelText: 'Всего вопросов',
            ),
          ),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text('Перемешивать вопросы'),
            value: _shuffleQuestions,
            onChanged: (value) => setState(() => _shuffleQuestions = value),
          ),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text('Перемешивать варианты'),
            value: _shuffleOptions,
            onChanged: (value) => setState(() => _shuffleOptions = value),
          ),
          AppSpacing.gapLg,
          Text(
            'Вопросы вручную',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          AppSpacing.gapSm,
          Text(
            _questionIds.isEmpty
                ? 'Не выбрано — используется рандомайзер по банку'
                : 'Выбрано вопросов: ${_questionIds.length}',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          AppSpacing.gapSm,
          OutlinedButton.icon(
            onPressed: () {
              final uid = ref.read(appUserProvider).valueOrNull?.uid;
              if (uid != null) _pickQuestions(uid);
            },
            icon: const Icon(Icons.checklist),
            label: const Text('Выбрать вопросы из банка'),
          ),
          AppSpacing.gapXl,
          PrimaryButton(
            label: 'Сохранить',
            isLoading: _saving,
            onPressed: () => _save(existing),
          ),
        ],
      ),
    );
  }
}

/// Диалог выбора вопросов из банка преподавателя (P2-17). Возвращает набор id.
class _QuestionPickerDialog extends ConsumerStatefulWidget {
  const _QuestionPickerDialog({
    required this.ownerTeacherId,
    required this.initial,
  });

  final String ownerTeacherId;
  final Set<String> initial;

  @override
  ConsumerState<_QuestionPickerDialog> createState() =>
      _QuestionPickerDialogState();
}

class _QuestionPickerDialogState extends ConsumerState<_QuestionPickerDialog> {
  late final Set<String> _selected = {...widget.initial};

  @override
  Widget build(BuildContext context) {
    final questionsAsync =
        ref.watch(questionListProvider(widget.ownerTeacherId));
    return AlertDialog(
      title: const Text('Вопросы из банка'),
      content: SizedBox(
        width: double.maxFinite,
        child: questionsAsync.when(
          data: (questions) {
            if (questions.isEmpty) {
              return const Text('Банк вопросов пуст');
            }
            return ListView(
              shrinkWrap: true,
              children: [
                for (final q in questions)
                  CheckboxListTile(
                    contentPadding: EdgeInsets.zero,
                    dense: true,
                    value: _selected.contains(q.questionId),
                    title: Text(
                      q.text.isEmpty ? '(без текста)' : q.text,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: Text('${q.type.label} · ${q.points} б.'),
                    onChanged: (v) => setState(() {
                      if (v ?? false) {
                        _selected.add(q.questionId);
                      } else {
                        _selected.remove(q.questionId);
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
          error: (_, _) => const Text('Не удалось загрузить вопросы'),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Отмена'),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(_selected),
          child: const Text('Готово'),
        ),
      ],
    );
  }
}
