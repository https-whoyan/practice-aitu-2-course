import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/error/failure.dart';
import '../../../shared/widgets/widgets.dart';
import '../../../theme/app_spacing.dart';
import '../../auth/data/auth_providers.dart';
import '../data/question_providers.dart';
import '../domain/question.dart';
import '../domain/question_difficulty.dart';
import '../domain/question_status.dart';
import '../domain/question_type.dart';

/// Форма создания/редактирования вопроса банка (ТЗ §5.5).
///
/// [questionId] == null — создание, иначе редактирование. Поддержаны 4 типа
/// MVP: один ответ / несколько / верно-неверно / краткий текст.
class QuestionFormScreen extends ConsumerStatefulWidget {
  const QuestionFormScreen({super.key, this.questionId});

  final String? questionId;

  @override
  ConsumerState<QuestionFormScreen> createState() =>
      _QuestionFormScreenState();
}

class _QuestionFormScreenState extends ConsumerState<QuestionFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _text = TextEditingController();
  final _topic = TextEditingController();
  final _tags = TextEditingController();
  final _points = TextEditingController(text: '1');
  final _explanation = TextEditingController();
  final _accepted = TextEditingController();

  QuestionType _type = QuestionType.single;
  QuestionDifficulty _difficulty = QuestionDifficulty.basic;
  QuestionStatus _status = QuestionStatus.active;

  final List<TextEditingController> _options = [];
  int? _correctIndex;
  final Set<int> _correctIndexes = <int>{};
  bool _correctBool = true;
  bool _partialScoring = false;
  bool _caseSensitive = false;

  bool _isEdit = false;
  bool _seeded = false;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _isEdit = widget.questionId != null;
    if (!_isEdit) {
      _options.addAll([TextEditingController(), TextEditingController()]);
    }
  }

  @override
  void dispose() {
    _text.dispose();
    _topic.dispose();
    _tags.dispose();
    _points.dispose();
    _explanation.dispose();
    _accepted.dispose();
    for (final c in _options) {
      c.dispose();
    }
    super.dispose();
  }

  void _seed(Question q) {
    if (_seeded) return;
    _seeded = true;
    _text.text = q.text;
    _topic.text = q.topic;
    _tags.text = q.tags.join(', ');
    _points.text = q.points.toString();
    _explanation.text = q.explanation;
    _accepted.text = q.acceptedAnswers.join(', ');
    _type = q.type.isMvp ? q.type : QuestionType.single;
    _difficulty = q.difficulty;
    _status = q.status;
    _correctIndex = q.correctIndex;
    _correctIndexes
      ..clear()
      ..addAll(q.correctIndexes);
    _correctBool = q.correctBool ?? true;
    _partialScoring = q.partialScoring;
    _caseSensitive = q.caseSensitive;
    for (final c in _options) {
      c.dispose();
    }
    _options
      ..clear()
      ..addAll(q.options.map((o) => TextEditingController(text: o)));
    if (_options.isEmpty) {
      _options.addAll([TextEditingController(), TextEditingController()]);
    }
  }

  void _addOption() => setState(() => _options.add(TextEditingController()));

  void _removeOption(int index) {
    setState(() {
      _options.removeAt(index).dispose();
      _correctIndexes.remove(index);
      if (_correctIndex == index) _correctIndex = null;
    });
  }

  Future<void> _save(Question? existing, String uid) async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    final options = <String>[];
    for (final c in _options) {
      final t = c.text.trim();
      if (t.isNotEmpty) options.add(t);
    }

    // Проверки по типу.
    if (_type == QuestionType.single || _type == QuestionType.multiple) {
      if (options.length < 2) {
        AppSnackbar.show(context, 'Добавьте минимум два варианта');
        return;
      }
    }
    if (_type == QuestionType.single && _correctIndex == null) {
      AppSnackbar.show(context, 'Выберите правильный вариант');
      return;
    }
    if (_type == QuestionType.multiple && _correctIndexes.isEmpty) {
      AppSnackbar.show(context, 'Отметьте правильные варианты');
      return;
    }

    final acceptedAnswers = _type == QuestionType.shortText
        ? _accepted.text
            .split(RegExp(r'[|,]'))
            .map((e) => e.trim())
            .where((e) => e.isNotEmpty)
            .toList()
        : <String>[];
    if (_type == QuestionType.shortText && acceptedAnswers.isEmpty) {
      AppSnackbar.show(context, 'Укажите принимаемые ответы');
      return;
    }

    final tags = _tags.text
        .split(',')
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .toList();

    setState(() => _saving = true);
    final repo = ref.read(questionRepositoryProvider);
    final now = DateTime.now();
    final base = existing ??
        Question(questionId: '', createdAt: now, updatedAt: now);

    final question = base.copyWith(
      ownerTeacherId: uid,
      text: _text.text.trim(),
      type: _type,
      topic: _topic.text.trim(),
      tags: tags,
      difficulty: _difficulty,
      points: int.tryParse(_points.text.trim()) ?? 1,
      explanation: _explanation.text.trim(),
      status: _status,
      options: _type == QuestionType.single || _type == QuestionType.multiple
          ? options
          : <String>[],
      correctIndex: _type == QuestionType.single ? _correctIndex : null,
      correctIndexes: _type == QuestionType.multiple
          ? (_correctIndexes.where((i) => i < options.length).toList()..sort())
          : <int>[],
      correctBool: _type == QuestionType.trueFalse ? _correctBool : null,
      acceptedAnswers: acceptedAnswers,
      caseSensitive: _type == QuestionType.shortText && _caseSensitive,
      partialScoring: _type == QuestionType.multiple && _partialScoring,
      updatedAt: now,
    );

    try {
      if (existing == null) {
        await repo.createQuestion(question);
      } else {
        await repo.updateQuestion(question);
      }
      ref.invalidate(questionListProvider(uid));
      if (widget.questionId != null) {
        ref.invalidate(questionByIdProvider(widget.questionId!));
      }
      if (!mounted) return;
      AppSnackbar.show(
        context,
        existing == null ? 'Вопрос создан' : 'Сохранено',
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
    final uid = ref.watch(appUserProvider).valueOrNull?.uid;
    if (uid == null) {
      return const AppScaffold(title: 'Вопрос', body: AppLoader());
    }

    if (!_isEdit) {
      return AppScaffold(title: 'Новый вопрос', body: _form(null, uid));
    }

    final questionAsync = ref.watch(questionByIdProvider(widget.questionId!));
    return AppScaffold(
      title: 'Вопрос',
      body: questionAsync.when(
        loading: () => const AppLoader(),
        error: (e, _) => AppErrorView(
          failure: e as Failure,
          onRetry: () =>
              ref.invalidate(questionByIdProvider(widget.questionId!)),
        ),
        data: (question) {
          if (question == null) {
            return const AppEmptyView(message: 'Вопрос не найден');
          }
          _seed(question);
          return _form(question, uid);
        },
      ),
    );
  }

  Widget _form(Question? existing, String uid) {
    return Form(
      key: _formKey,
      child: ListView(
        children: [
          TextFormField(
            controller: _text,
            maxLines: 3,
            decoration: const InputDecoration(labelText: 'Текст вопроса'),
            validator: (v) =>
                (v == null || v.trim().isEmpty) ? 'Введите текст' : null,
          ),
          AppSpacing.gapMd,
          DropdownButtonFormField<QuestionType>(
            initialValue: _type,
            decoration: const InputDecoration(labelText: 'Тип'),
            items: [
              for (final t in QuestionType.values.where((t) => t.isMvp))
                DropdownMenuItem(value: t, child: Text(t.label)),
            ],
            onChanged: (t) {
              if (t != null) setState(() => _type = t);
            },
          ),
          AppSpacing.gapMd,
          AppTextField(label: 'Тема', controller: _topic),
          AppSpacing.gapMd,
          AppTextField(
            label: 'Теги',
            hint: 'через запятую',
            controller: _tags,
          ),
          AppSpacing.gapMd,
          DropdownButtonFormField<QuestionDifficulty>(
            initialValue: _difficulty,
            decoration: const InputDecoration(labelText: 'Сложность'),
            items: [
              for (final d in QuestionDifficulty.values)
                DropdownMenuItem(value: d, child: Text(d.label)),
            ],
            onChanged: (d) {
              if (d != null) setState(() => _difficulty = d);
            },
          ),
          AppSpacing.gapMd,
          AppTextField(
            label: 'Баллы',
            controller: _points,
            keyboardType: TextInputType.number,
            validator: (v) {
              final n = int.tryParse((v ?? '').trim());
              if (n == null || n <= 0) return 'Введите число больше нуля';
              return null;
            },
          ),
          AppSpacing.gapLg,
          ..._typeFields(),
          AppSpacing.gapMd,
          TextFormField(
            controller: _explanation,
            maxLines: 2,
            decoration:
                const InputDecoration(labelText: 'Пояснение (необязательно)'),
          ),
          AppSpacing.gapXl,
          PrimaryButton(
            label: 'Сохранить',
            isLoading: _saving,
            onPressed: () => _save(existing, uid),
          ),
        ],
      ),
    );
  }

  List<Widget> _typeFields() {
    switch (_type) {
      case QuestionType.single:
        return [
          const SectionHeader(title: 'Варианты ответа'),
          ..._optionRows(single: true),
          _addOptionButton(),
        ];
      case QuestionType.multiple:
        return [
          const SectionHeader(title: 'Варианты ответа'),
          ..._optionRows(single: false),
          _addOptionButton(),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text('Частичный балл'),
            subtitle: const Text('Засчитывать частично верный ответ'),
            value: _partialScoring,
            onChanged: (v) => setState(() => _partialScoring = v),
          ),
        ];
      case QuestionType.trueFalse:
        return [
          const SectionHeader(title: 'Правильный ответ'),
          SegmentedButton<bool>(
            segments: const [
              ButtonSegment(value: true, label: Text('Верно')),
              ButtonSegment(value: false, label: Text('Неверно')),
            ],
            selected: <bool>{_correctBool},
            onSelectionChanged: (s) =>
                setState(() => _correctBool = s.first),
          ),
        ];
      case QuestionType.shortText:
        return [
          const SectionHeader(title: 'Принимаемые ответы'),
          AppTextField(
            label: 'Ответы',
            hint: 'через | или запятую',
            controller: _accepted,
          ),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text('Учитывать регистр'),
            value: _caseSensitive,
            onChanged: (v) => setState(() => _caseSensitive = v),
          ),
        ];
      default:
        return const [];
    }
  }

  List<Widget> _optionRows({required bool single}) {
    final rows = <Widget>[
      for (var i = 0; i < _options.length; i++)
        Padding(
          padding: const EdgeInsets.only(bottom: AppSpacing.sm),
          child: Row(
            children: [
              if (single)
                Radio<int>(value: i)
              else
                Checkbox(
                  value: _correctIndexes.contains(i),
                  onChanged: (v) => setState(() {
                    if (v ?? false) {
                      _correctIndexes.add(i);
                    } else {
                      _correctIndexes.remove(i);
                    }
                  }),
                ),
              Expanded(
                child: TextFormField(
                  controller: _options[i],
                  decoration:
                      InputDecoration(labelText: 'Вариант ${i + 1}'),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close),
                tooltip: 'Удалить вариант',
                onPressed:
                    _options.length > 2 ? () => _removeOption(i) : null,
              ),
            ],
          ),
        ),
    ];
    if (!single) return rows;
    // Новый Radio-API: группа управляется через RadioGroup-предка.
    return [
      RadioGroup<int>(
        groupValue: _correctIndex,
        onChanged: (v) => setState(() => _correctIndex = v),
        child: Column(children: rows),
      ),
    ];
  }

  Widget _addOptionButton() => Align(
        alignment: Alignment.centerLeft,
        child: TextButton.icon(
          onPressed: _addOption,
          icon: const Icon(Icons.add),
          label: const Text('Добавить вариант'),
        ),
      );
}
