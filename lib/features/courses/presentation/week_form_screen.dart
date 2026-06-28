import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/error/failure.dart';
import '../../../shared/widgets/widgets.dart';
import '../../../theme/app_spacing.dart';
import '../data/course_week_providers.dart';
import '../domain/course_week.dart';

/// Форма создания/редактирования недели курса (ТЗ §5.4.4, шаг 14).
///
/// [weekId] == null — создание, иначе редактирование (форма переиспользуется).
class WeekFormScreen extends ConsumerStatefulWidget {
  const WeekFormScreen({super.key, required this.courseId, this.weekId});

  final String courseId;
  final String? weekId;

  @override
  ConsumerState<WeekFormScreen> createState() => _WeekFormScreenState();
}

class _WeekFormScreenState extends ConsumerState<WeekFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _title = TextEditingController();
  final _description = TextEditingController();

  DateTime? _startDate;
  DateTime? _endDate;
  bool _isPublished = false;

  bool _isEdit = false;
  bool _seeded = false;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _isEdit = widget.weekId != null;
  }

  @override
  void dispose() {
    _title.dispose();
    _description.dispose();
    super.dispose();
  }

  /// Заполняет поля данными недели один раз (в режиме редактирования).
  void _seed(CourseWeek week) {
    if (_seeded) return;
    _seeded = true;
    _title.text = week.title;
    _description.text = week.description;
    _startDate = week.startDate;
    _endDate = week.endDate;
    _isPublished = week.isPublished;
  }

  String _fmtDate(DateTime d) => '${d.day}.${d.month}.${d.year}';

  Future<void> _pickDate({required bool isStart}) async {
    final initial = (isStart ? _startDate : _endDate) ?? DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (picked == null) return;
    setState(() {
      if (isStart) {
        _startDate = picked;
      } else {
        _endDate = picked;
      }
    });
  }

  Future<void> _save(CourseWeek? existing) async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    setState(() => _saving = true);
    final repo = ref.read(courseWeekRepositoryProvider);
    final now = DateTime.now();
    try {
      if (existing == null) {
        final orderIndex =
            ref.read(courseWeeksProvider(widget.courseId)).valueOrNull?.length ??
                0;
        await repo.addWeek(
          CourseWeek(
            weekId: '',
            courseId: widget.courseId,
            title: _title.text.trim(),
            description: _description.text.trim(),
            orderIndex: orderIndex,
            startDate: _startDate,
            endDate: _endDate,
            isPublished: _isPublished,
            createdAt: now,
            updatedAt: now,
          ),
        );
      } else {
        await repo.updateWeek(
          existing.copyWith(
            title: _title.text.trim(),
            description: _description.text.trim(),
            startDate: _startDate,
            endDate: _endDate,
            isPublished: _isPublished,
            updatedAt: now,
          ),
        );
      }
      ref.invalidate(courseWeeksProvider(widget.courseId));
      if (existing != null) {
        ref.invalidate(weekByIdProvider(existing.weekId));
      }
      if (!mounted) return;
      AppSnackbar.show(
        context,
        existing == null ? 'Неделя добавлена' : 'Сохранено',
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
        title: 'Новая неделя',
        body: _form(existing: null),
      );
    }

    final weekAsync = ref.watch(weekByIdProvider(widget.weekId!));
    return AppScaffold(
      title: 'Неделя',
      body: weekAsync.when(
        data: (week) {
          if (week == null) {
            return const AppEmptyView(message: 'Неделя не найдена');
          }
          _seed(week);
          return _form(existing: week);
        },
        loading: () => const AppLoader(),
        error: (e, _) => AppErrorView(
          failure: e as Failure,
          onRetry: () => ref.invalidate(weekByIdProvider(widget.weekId!)),
        ),
      ),
    );
  }

  Widget _form({required CourseWeek? existing}) {
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
            title: const Text('Дата окончания'),
            subtitle: Text(
              _endDate == null ? 'Не выбрана' : _fmtDate(_endDate!),
            ),
            trailing: const Icon(Icons.calendar_today),
            onTap: () => _pickDate(isStart: false),
          ),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text('Опубликована'),
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
