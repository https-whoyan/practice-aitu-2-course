import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/error/failure.dart';
import '../../../shared/widgets/widgets.dart';
import '../../../theme/app_spacing.dart';
import '../data/assignment_providers.dart';
import '../domain/assignment.dart';
import '../domain/submission_type.dart';

/// Форма создания/редактирования задания (ТЗ §5.4.5, шаг 17).
///
/// [assignmentId] == null — создание, иначе редактирование (форма
/// переиспользуется).
class AssignmentFormScreen extends ConsumerStatefulWidget {
  const AssignmentFormScreen({
    super.key,
    required this.courseId,
    required this.weekId,
    this.assignmentId,
  });

  final String courseId;
  final String weekId;
  final String? assignmentId;

  @override
  ConsumerState<AssignmentFormScreen> createState() =>
      _AssignmentFormScreenState();
}

class _AssignmentFormScreenState extends ConsumerState<AssignmentFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _title = TextEditingController();
  final _description = TextEditingController();
  final _instruction = TextEditingController();
  final _maxScore = TextEditingController(text: '100');
  final _latePenalty = TextEditingController(text: '0');

  DateTime? _deadline;
  SubmissionType _submissionType = SubmissionType.text;
  bool _allowLateSubmission = false;
  bool _isPublished = false;

  bool _isEdit = false;
  bool _seeded = false;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _isEdit = widget.assignmentId != null;
  }

  @override
  void dispose() {
    _title.dispose();
    _description.dispose();
    _instruction.dispose();
    _maxScore.dispose();
    _latePenalty.dispose();
    super.dispose();
  }

  /// Заполняет поля данными задания один раз (в режиме редактирования).
  void _seed(Assignment a) {
    if (_seeded) return;
    _seeded = true;
    _title.text = a.title;
    _description.text = a.description;
    _instruction.text = a.instruction;
    _maxScore.text = a.maxScore.toString();
    _deadline = a.deadline;
    _submissionType = a.submissionType;
    _allowLateSubmission = a.allowLateSubmission;
    _latePenalty.text = a.latePenalty.toString();
    _isPublished = a.isPublished;
  }

  String _fmtDate(DateTime d) =>
      '${d.day.toString().padLeft(2, '0')}.${d.month.toString().padLeft(2, '0')}.${d.year} '
      '${d.hour.toString().padLeft(2, '0')}:${d.minute.toString().padLeft(2, '0')}';

  Future<void> _pickDeadline() async {
    final base = _deadline ?? DateTime.now();
    final date = await showDatePicker(
      context: context,
      initialDate: base,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (date == null || !mounted) return;
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(base),
    );
    if (time == null) return;
    setState(() => _deadline =
        DateTime(date.year, date.month, date.day, time.hour, time.minute));
  }

  Future<void> _save(Assignment? existing) async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    setState(() => _saving = true);
    final repo = ref.read(assignmentRepositoryProvider);
    final now = DateTime.now();
    try {
      if (existing == null) {
        await repo.createAssignment(
          Assignment(
            assignmentId: '',
            courseId: widget.courseId,
            weekId: widget.weekId,
            title: _title.text.trim(),
            description: _description.text.trim(),
            instruction: _instruction.text.trim(),
            deadline: _deadline,
            maxScore: int.parse(_maxScore.text.trim()),
            submissionType: _submissionType,
            allowLateSubmission: _allowLateSubmission,
            latePenalty: _allowLateSubmission
                ? (int.tryParse(_latePenalty.text.trim()) ?? 0)
                : 0,
            isPublished: _isPublished,
            createdAt: now,
            updatedAt: now,
          ),
        );
      } else {
        await repo.updateAssignment(
          existing.copyWith(
            title: _title.text.trim(),
            description: _description.text.trim(),
            instruction: _instruction.text.trim(),
            deadline: _deadline,
            maxScore: int.parse(_maxScore.text.trim()),
            submissionType: _submissionType,
            allowLateSubmission: _allowLateSubmission,
            latePenalty: _allowLateSubmission
                ? (int.tryParse(_latePenalty.text.trim()) ?? 0)
                : 0,
            isPublished: _isPublished,
            updatedAt: now,
          ),
        );
      }
      ref.invalidate(assignmentsForCourseProvider(widget.courseId));
      ref.invalidate(assignmentsForWeekProvider(widget.weekId));
      if (existing != null) {
        ref.invalidate(assignmentByIdProvider(existing.assignmentId));
      }
      if (!mounted) return;
      AppSnackbar.show(
        context,
        existing == null ? 'Задание создано' : 'Сохранено',
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
        title: 'Новое задание',
        body: _form(existing: null),
      );
    }

    final assignmentAsync =
        ref.watch(assignmentByIdProvider(widget.assignmentId!));
    return AppScaffold(
      title: 'Задание',
      body: assignmentAsync.when(
        data: (assignment) {
          if (assignment == null) {
            return const AppEmptyView(message: 'Задание не найдено');
          }
          _seed(assignment);
          return _form(existing: assignment);
        },
        loading: () => const AppLoader(),
        error: (e, _) => AppErrorView(
          failure: e as Failure,
          onRetry: () =>
              ref.invalidate(assignmentByIdProvider(widget.assignmentId!)),
        ),
      ),
    );
  }

  Widget _form({required Assignment? existing}) {
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
          TextFormField(
            controller: _instruction,
            maxLines: 4,
            decoration: const InputDecoration(labelText: 'Инструкция'),
          ),
          AppSpacing.gapMd,
          DropdownButtonFormField<SubmissionType>(
            initialValue: _submissionType,
            decoration: const InputDecoration(labelText: 'Тип отправки'),
            items: [
              for (final type in SubmissionType.values)
                DropdownMenuItem(
                  value: type,
                  child: Text(type.label),
                ),
            ],
            onChanged: (value) {
              if (value == null) return;
              setState(() => _submissionType = value);
            },
          ),
          AppSpacing.gapMd,
          AppTextField(
            label: 'Максимальный балл',
            controller: _maxScore,
            keyboardType: TextInputType.number,
            validator: (v) {
              final parsed = int.tryParse((v ?? '').trim());
              if (parsed == null || parsed <= 0) {
                return 'Введите число больше 0';
              }
              return null;
            },
          ),
          AppSpacing.gapLg,
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text('Дедлайн'),
            subtitle: Text(
              _deadline == null ? 'Не выбран' : _fmtDate(_deadline!),
            ),
            trailing: const Icon(Icons.calendar_today),
            onTap: _pickDeadline,
          ),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text('Разрешить позднюю отправку'),
            value: _allowLateSubmission,
            onChanged: (value) =>
                setState(() => _allowLateSubmission = value),
          ),
          if (_allowLateSubmission) ...[
            AppSpacing.gapSm,
            AppTextField(
              label: 'Штраф за просрочку, %',
              controller: _latePenalty,
              keyboardType: TextInputType.number,
              validator: (v) {
                final n = int.tryParse((v ?? '').trim());
                if (n == null || n < 0 || n > 100) return 'От 0 до 100';
                return null;
              },
            ),
            AppSpacing.gapMd,
          ],
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text('Опубликовано'),
            value: _isPublished,
            onChanged: (value) => setState(() => _isPublished = value),
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
