import 'dart:convert';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/error/failure.dart';
import '../../../shared/widgets/widgets.dart';
import '../../../theme/app_spacing.dart';
import '../../auth/data/auth_providers.dart';
import '../data/grade_providers.dart';
import '../domain/grade.dart';
import '../domain/grade_source_type.dart';

/// Журнал оценок курса (ТЗ §5.5.5, §5.4.7).
///
/// Фильтры по студенту и типу источника (P1-6), ручная оценка (P1-6) и история
/// переоценок в карточке (P1-7). Экспорт CSV — в диалоге (файловое сохранение —
/// P2-15).
class GradebookScreen extends ConsumerStatefulWidget {
  const GradebookScreen({super.key, this.courseId});

  final String? courseId;

  @override
  ConsumerState<GradebookScreen> createState() => _GradebookScreenState();
}

class _GradebookScreenState extends ConsumerState<GradebookScreen> {
  String? _studentId;
  GradeSourceType? _sourceType;

  @override
  Widget build(BuildContext context) {
    final id = widget.courseId;
    if (id == null) {
      return const AppScaffold(
        title: 'Журнал оценок',
        body: AppEmptyView(message: 'Выберите курс'),
      );
    }

    final gradesAsync = ref.watch(gradesForCourseProvider(id));
    final studentsAsync = ref.watch(courseStudentsProvider(id));
    final nameByUid = {
      for (final s in studentsAsync.valueOrNull ?? const <CourseStudent>[])
        s.uid: s.name,
    };

    return AppScaffold(
      title: 'Журнал оценок',
      actions: [
        gradesAsync.maybeWhen(
          data: (grades) => Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.save_alt),
                tooltip: 'Сохранить CSV',
                onPressed: grades.isEmpty
                    ? null
                    : () => _saveCsv(_buildCsv(grades, nameByUid)),
              ),
              IconButton(
                icon: const Icon(Icons.visibility),
                tooltip: 'Показать CSV',
                onPressed: grades.isEmpty
                    ? null
                    : () => _showCsv(context, _buildCsv(grades, nameByUid)),
              ),
            ],
          ),
          orElse: () => const SizedBox.shrink(),
        ),
      ],
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _addManualGrade(id),
        icon: const Icon(Icons.add),
        label: const Text('Ручная оценка'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _filters(studentsAsync.valueOrNull ?? const []),
          AppSpacing.gapMd,
          Expanded(
            child: gradesAsync.when(
              loading: () => const AppLoader(),
              error: (e, _) => AppErrorView(
                failure: e as Failure,
                onRetry: () => ref.invalidate(gradesForCourseProvider(id)),
              ),
              data: (grades) {
                final filtered = _apply(grades);
                if (filtered.isEmpty) {
                  return const AppEmptyView(message: 'Оценок нет');
                }
                return ListView.separated(
                  itemCount: filtered.length,
                  separatorBuilder: (_, _) => AppSpacing.gapMd,
                  itemBuilder: (context, i) => _GradeRow(
                    grade: filtered[i],
                    studentName: nameByUid[filtered[i].studentId],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  /// Фильтры журнала: студент + тип источника (P1-6).
  Widget _filters(List<CourseStudent> students) {
    return Row(
      children: [
        Expanded(
          child: DropdownButtonFormField<String?>(
            initialValue: _studentId,
            isExpanded: true,
            decoration: const InputDecoration(labelText: 'Студент'),
            items: [
              const DropdownMenuItem(value: null, child: Text('Все студенты')),
              for (final s in students)
                DropdownMenuItem(value: s.uid, child: Text(s.name)),
            ],
            onChanged: (v) => setState(() => _studentId = v),
          ),
        ),
        AppSpacing.gapSm,
        Expanded(
          child: DropdownButtonFormField<GradeSourceType?>(
            initialValue: _sourceType,
            isExpanded: true,
            decoration: const InputDecoration(labelText: 'Тип'),
            items: [
              const DropdownMenuItem(value: null, child: Text('Все типы')),
              for (final t in GradeSourceType.values)
                DropdownMenuItem(value: t, child: Text(t.label)),
            ],
            onChanged: (v) => setState(() => _sourceType = v),
          ),
        ),
      ],
    );
  }

  List<Grade> _apply(List<Grade> grades) {
    return grades.where((g) {
      if (_studentId != null && g.studentId != _studentId) return false;
      if (_sourceType != null && g.sourceType != _sourceType) return false;
      return true;
    }).toList();
  }

  Future<void> _addManualGrade(String courseId) async {
    final uid = ref.read(appUserProvider).valueOrNull?.uid;
    if (uid == null) return;
    final result = await showDialog<_ManualGradeResult>(
      context: context,
      builder: (_) => _ManualGradeDialog(courseId: courseId),
    );
    if (result == null) return;
    try {
      await ref.read(gradeRepositoryProvider).addManualGrade(
            studentId: result.studentId,
            courseId: courseId,
            teacherId: uid,
            score: result.score,
            maxScore: result.maxScore,
            comment: result.comment,
          );
      if (mounted) AppSnackbar.show(context, 'Оценка выставлена');
    } catch (e) {
      if (mounted) AppSnackbar.showFailure(context, e as Failure);
    }
  }

  /// Строит CSV вручную: заголовок + по строке на оценку.
  String _buildCsv(List<Grade> grades, Map<String, String> nameByUid) {
    final buffer = StringBuffer()
      ..writeln('student,score,maxScore,percentage,sourceType');
    for (final g in grades) {
      final name = nameByUid[g.studentId] ?? g.studentId;
      buffer.writeln(
        '$name,${g.score},${g.maxScore},'
        '${(g.percentage * 100).round()},${g.sourceType.code}',
      );
    }
    return buffer.toString();
  }

  /// Сохраняет журнал в CSV-файл (диалог сохранения, P2-15).
  Future<void> _saveCsv(String csv) async {
    try {
      final path = await FilePicker.saveFile(
        dialogTitle: 'Сохранить журнал оценок',
        fileName: 'gradebook_${widget.courseId}.csv',
        bytes: Uint8List.fromList(utf8.encode(csv)),
      );
      if (!mounted) return;
      AppSnackbar.show(
        context,
        path == null ? 'Сохранение отменено' : 'Файл сохранён',
      );
    } catch (e) {
      if (mounted) AppSnackbar.showFailure(context, e as Failure);
    }
  }

  void _showCsv(BuildContext context, String csv) {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Экспорт CSV'),
        content: SingleChildScrollView(child: SelectableText(csv)),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Закрыть'),
          ),
        ],
      ),
    );
  }
}

/// Строка оценки с раскрытием истории переоценок (P1-7).
class _GradeRow extends StatefulWidget {
  const _GradeRow({required this.grade, this.studentName});

  final Grade grade;
  final String? studentName;

  @override
  State<_GradeRow> createState() => _GradeRowState();
}

class _GradeRowState extends State<_GradeRow> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final g = widget.grade;
    final hasHistory = g.history.isNotEmpty;
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.studentName ?? g.studentId,
                        style: theme.textTheme.titleMedium),
                    AppSpacing.gapXs,
                    Text(
                      g.sourceType.label,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                    if (g.comment != null && g.comment!.isNotEmpty) ...[
                      AppSpacing.gapXs,
                      Text(g.comment!, style: theme.textTheme.bodySmall),
                    ],
                  ],
                ),
              ),
              AppSpacing.gapMd,
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('${g.score}/${g.maxScore}',
                      style: theme.textTheme.titleMedium),
                  AppSpacing.gapXs,
                  Text('${(g.percentage * 100).round()}%',
                      style: theme.textTheme.bodyMedium),
                ],
              ),
              if (hasHistory)
                IconButton(
                  tooltip: 'История изменений',
                  icon: Icon(_expanded ? Icons.expand_less : Icons.history),
                  onPressed: () => setState(() => _expanded = !_expanded),
                ),
            ],
          ),
          if (_expanded && hasHistory) ...[
            const Divider(),
            for (final h in g.history)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        '${_fmtDate(h.changedAt)} · ${h.changedBy}'
                        '${h.comment != null && h.comment!.isNotEmpty ? ' · ${h.comment}' : ''}',
                        style: theme.textTheme.bodySmall,
                      ),
                    ),
                    Text('${h.score}', style: theme.textTheme.bodySmall),
                  ],
                ),
              ),
          ],
        ],
      ),
    );
  }

  String _fmtDate(DateTime d) =>
      '${d.day.toString().padLeft(2, '0')}.${d.month.toString().padLeft(2, '0')}.${d.year} '
      '${d.hour.toString().padLeft(2, '0')}:${d.minute.toString().padLeft(2, '0')}';
}

/// Результат диалога ручной оценки.
typedef _ManualGradeResult = ({
  String studentId,
  num score,
  num maxScore,
  String? comment,
});

/// Диалог выставления ручной оценки (P1-6): выбор студента курса + балл.
class _ManualGradeDialog extends ConsumerStatefulWidget {
  const _ManualGradeDialog({required this.courseId});

  final String courseId;

  @override
  ConsumerState<_ManualGradeDialog> createState() => _ManualGradeDialogState();
}

class _ManualGradeDialogState extends ConsumerState<_ManualGradeDialog> {
  final _formKey = GlobalKey<FormState>();
  final _score = TextEditingController();
  final _maxScore = TextEditingController(text: '100');
  final _comment = TextEditingController();
  String? _studentId;

  @override
  void dispose() {
    _score.dispose();
    _maxScore.dispose();
    _comment.dispose();
    super.dispose();
  }

  void _submit() {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    if (_studentId == null) return;
    Navigator.of(context).pop((
      studentId: _studentId!,
      score: num.parse(_score.text.trim()),
      maxScore: num.parse(_maxScore.text.trim()),
      comment: _comment.text.trim().isEmpty ? null : _comment.text.trim(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    final studentsAsync = ref.watch(courseStudentsProvider(widget.courseId));
    return AlertDialog(
      title: const Text('Ручная оценка'),
      content: Form(
        key: _formKey,
        child: SizedBox(
          width: double.maxFinite,
          child: studentsAsync.when(
            data: (students) {
              if (students.isEmpty) {
                return const Text('В курсе нет студентов');
              }
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  DropdownButtonFormField<String>(
                    initialValue: _studentId,
                    isExpanded: true,
                    decoration: const InputDecoration(labelText: 'Студент'),
                    items: [
                      for (final s in students)
                        DropdownMenuItem(value: s.uid, child: Text(s.name)),
                    ],
                    validator: (v) => v == null ? 'Выберите студента' : null,
                    onChanged: (v) => setState(() => _studentId = v),
                  ),
                  AppSpacing.gapSm,
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _score,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(labelText: 'Балл'),
                          validator: _validateNum,
                        ),
                      ),
                      AppSpacing.gapSm,
                      Expanded(
                        child: TextFormField(
                          controller: _maxScore,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(labelText: 'Из'),
                          validator: _validateNum,
                        ),
                      ),
                    ],
                  ),
                  AppSpacing.gapSm,
                  TextFormField(
                    controller: _comment,
                    decoration:
                        const InputDecoration(labelText: 'Комментарий'),
                  ),
                ],
              );
            },
            loading: () => const Padding(
              padding: EdgeInsets.all(AppSpacing.lg),
              child: Center(child: CircularProgressIndicator()),
            ),
            error: (_, _) => const Text('Не удалось загрузить студентов'),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Отмена'),
        ),
        TextButton(onPressed: _submit, child: const Text('Выставить')),
      ],
    );
  }

  String? _validateNum(String? v) {
    final n = num.tryParse((v ?? '').trim());
    if (n == null) return 'Число';
    if (n < 0) return '≥ 0';
    return null;
  }
}
