import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/error/failure.dart';
import '../../../../shared/widgets/widgets.dart';
import '../../../../theme/app_spacing.dart';
import '../../../auth/data/auth_providers.dart';
import '../../data/question_import_service.dart';
import '../../data/question_providers.dart';
import '../../domain/import/import_validator.dart';
import '../../domain/import/parsed_question.dart';
import '../../domain/import/txt_parser.dart';
import '../../domain/question_type.dart';

/// Импорт вопросов из TXT (ТЗ §5.5.11): загрузка → предпросмотр → подтверждение.
///
/// Один экран совмещает выбор файла и предпросмотр, чтобы не плодить роуты.
class QuestionImportScreen extends ConsumerStatefulWidget {
  const QuestionImportScreen({super.key});

  @override
  ConsumerState<QuestionImportScreen> createState() =>
      _QuestionImportScreenState();
}

class _QuestionImportScreenState extends ConsumerState<QuestionImportScreen> {
  List<ParsedQuestion> _parsed = const [];
  bool _skipInvalid = true;
  bool _skipDuplicates = true;
  bool _picking = false;
  bool _importing = false;
  String? _fileName;

  /// Нормализованные тексты вопросов банка (для дедупликации, P2-16).
  Set<String> _bankTexts() {
    final uid = ref.read(appUserProvider).valueOrNull?.uid;
    if (uid == null) return const {};
    final questions = ref.read(questionListProvider(uid)).valueOrNull ?? const [];
    return questions
        .map((q) => q.text.trim().toLowerCase().replaceAll(RegExp(r'\s+'), ' '))
        .where((t) => t.isNotEmpty)
        .toSet();
  }

  Future<void> _pickFile() async {
    setState(() => _picking = true);
    try {
      final result = await FilePicker.pickFiles(withData: true);
      final file = result?.files.singleOrNull;
      if (file == null || file.bytes == null) return;
      final content = utf8.decode(file.bytes!);
      final parsed = parseQuestionsTxt(content)
          .map((q) => q.copyWith(
                issues: [...q.issues, ...validateParsed(q)],
              ))
          .toList();
      if (!mounted) return;
      setState(() {
        _fileName = file.name;
        _parsed = parsed;
      });
    } catch (e) {
      if (!mounted) return;
      AppSnackbar.show(context, 'Не удалось прочитать файл');
    } finally {
      if (mounted) setState(() => _picking = false);
    }
  }

  Map<String, dynamic> _toPayload(ParsedQuestion q) {
    final f = q.fields;
    return <String, dynamic>{
      'text': f['text'] ?? '',
      'type': f['type'] ?? QuestionType.single.code,
      'topic': f['topic'] ?? '',
      'tags': f['tags'] ?? <String>[],
      'difficulty': f['difficulty'] ?? 'basic',
      'points': f['points'] ?? 1,
      'explanation': f['explanation'] ?? '',
      'options': f['options'] ?? <String>[],
      'correctIndex': f['correctIndex'],
      'correctIndexes': f['correctIndexes'] ?? <int>[],
      'correctBool': f['correctBool'],
      'acceptedAnswers': f['acceptedAnswers'] ?? <String>[],
      'caseSensitive': false,
      'partialScoring': false,
      'courseIds': <String>[],
    };
  }

  Future<void> _import() async {
    final dups = _skipDuplicates
        ? duplicateIndices(_parsed, _bankTexts())
        : const <int>{};
    final toImport = <ParsedQuestion>[];
    for (var i = 0; i < _parsed.length; i++) {
      if (_skipInvalid && !_parsed[i].isValid) continue;
      if (dups.contains(i)) continue;
      toImport.add(_parsed[i]);
    }
    if (toImport.isEmpty) {
      AppSnackbar.show(context, 'Нет вопросов для импорта');
      return;
    }
    setState(() => _importing = true);
    try {
      final payload = toImport.map(_toPayload).toList();
      await ref
          .read(questionImportServiceProvider)
          .importQuestions(payload);
      if (!mounted) return;
      AppSnackbar.show(context, 'Импортировано вопросов: ${payload.length}');
      context.pop();
    } catch (e) {
      if (!mounted) return;
      AppSnackbar.showFailure(context, e as Failure);
    } finally {
      if (mounted) setState(() => _importing = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final hasData = _parsed.isNotEmpty;
    final summary = importSummary(_parsed);
    // Подписываемся на банк, чтобы тексты для дедупликации подгрузились.
    final uid = ref.watch(appUserProvider).valueOrNull?.uid;
    if (uid != null) ref.watch(questionListProvider(uid));
    final dups = hasData ? duplicateIndices(_parsed, _bankTexts()) : const <int>{};

    return AppScaffold(
      title: 'Импорт вопросов',
      body: ListView(
        children: [
          SecondaryButton(
            label: _fileName == null ? 'Выбрать TXT-файл' : 'Выбрать другой файл',
            isLoading: _picking,
            onPressed: _picking ? null : _pickFile,
          ),
          if (_fileName != null) ...[
            AppSpacing.gapSm,
            Text(_fileName!, style: Theme.of(context).textTheme.bodySmall),
          ],
          if (hasData) ...[
            AppSpacing.gapLg,
            _SummaryBar(
              found: summary.found,
              valid: summary.valid,
              withErrors: summary.withErrors,
            ),
            AppSpacing.gapSm,
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Пропускать некорректные'),
              value: _skipInvalid,
              onChanged: (v) => setState(() => _skipInvalid = v),
            ),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Пропускать дубли'),
              subtitle: Text('Найдено дублей: ${dups.length}'),
              value: _skipDuplicates,
              onChanged: (v) => setState(() => _skipDuplicates = v),
            ),
            AppSpacing.gapSm,
            for (var i = 0; i < _parsed.length; i++)
              _ParsedTile(
                question: _parsed[i],
                isDuplicate: dups.contains(i),
              ),
            AppSpacing.gapLg,
            PrimaryButton(
              label: 'Подтвердить импорт',
              isLoading: _importing,
              onPressed: _import,
            ),
            AppSpacing.gapSm,
            SecondaryButton(
              label: 'Отменить',
              onPressed: () => context.pop(),
            ),
          ],
        ],
      ),
    );
  }
}

class _SummaryBar extends StatelessWidget {
  const _SummaryBar({
    required this.found,
    required this.valid,
    required this.withErrors,
  });

  final int found;
  final int valid;
  final int withErrors;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AppCard(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _stat(theme, 'Найдено', found),
          _stat(theme, 'Корректно', valid),
          _stat(theme, 'С ошибками', withErrors),
        ],
      ),
    );
  }

  Widget _stat(ThemeData theme, String label, int value) => Column(
        children: [
          Text('$value', style: theme.textTheme.titleLarge),
          Text(label, style: theme.textTheme.bodySmall),
        ],
      );
}

class _ParsedTile extends StatelessWidget {
  const _ParsedTile({required this.question, this.isDuplicate = false});

  final ParsedQuestion question;
  final bool isDuplicate;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final text = (question.fields['text'] as String?)?.trim() ?? '';
    final ok = question.isValid;
    return Card(
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
        leading: Icon(
          ok ? Icons.check_circle_outline : Icons.error_outline,
          color: ok ? colors.primary : colors.error,
        ),
        title: Row(
          children: [
            Expanded(
              child: Text(
                text.isEmpty ? '(без текста)' : text,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (isDuplicate)
              Padding(
                padding: const EdgeInsets.only(left: AppSpacing.sm),
                child: Chip(
                  label: const Text('дубль'),
                  visualDensity: VisualDensity.compact,
                  backgroundColor: colors.tertiaryContainer,
                ),
              ),
          ],
        ),
        subtitle: Text(
          'Строка ${question.sourceLineStart} · ${ok ? 'корректно' : 'есть ошибки'}',
          style: theme.textTheme.bodySmall,
        ),
        children: [
          if (question.issues.isEmpty)
            const Padding(
              padding: EdgeInsets.all(AppSpacing.lg),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text('Проблем не найдено'),
              ),
            )
          else
            for (final issue in question.issues)
              ListTile(
                dense: true,
                leading: Icon(
                  issue.isWarning ? Icons.warning_amber : Icons.error,
                  color: issue.isWarning ? colors.tertiary : colors.error,
                  size: 20,
                ),
                title: Text(issue.message),
                subtitle:
                    issue.line == null ? null : Text('Строка ${issue.line}'),
              ),
        ],
      ),
    );
  }
}
