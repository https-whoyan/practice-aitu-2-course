import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/error/failure.dart';
import '../../../shared/widgets/widgets.dart';
import '../../../theme/app_spacing.dart';
import '../../auth/domain/user_role.dart';
import '../../courses/data/course_providers.dart';
import '../../courses/domain/course.dart';
import '../../groups/data/group_providers.dart';
import '../data/admin_user_providers.dart';
import '../domain/admin_user_repository.dart';

/// Форма создания/редактирования курса (ТЗ §7.4).
///
/// [courseId] == null — создание, иначе редактирование (форма переиспользуется).
class CourseFormScreen extends ConsumerStatefulWidget {
  const CourseFormScreen({super.key, this.courseId});

  final String? courseId;

  @override
  ConsumerState<CourseFormScreen> createState() => _CourseFormScreenState();
}

class _CourseFormScreenState extends ConsumerState<CourseFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _title = TextEditingController();
  final _description = TextEditingController();

  DateTime? _startDate;
  DateTime? _endDate;

  bool _isEdit = false;
  bool _seeded = false;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _isEdit = widget.courseId != null;
  }

  @override
  void dispose() {
    _title.dispose();
    _description.dispose();
    super.dispose();
  }

  /// Заполняет контроллеры данными курса один раз (в режиме редактирования).
  void _seed(Course course) {
    if (_seeded) return;
    _seeded = true;
    _title.text = course.title;
    _description.text = course.description;
    _startDate = course.startDate;
    _endDate = course.endDate;
  }

  static String _fmtDate(DateTime? d) => d == null
      ? 'не задано'
      : '${d.day.toString().padLeft(2, '0')}.'
          '${d.month.toString().padLeft(2, '0')}.${d.year}';

  Future<void> _pickDate({required bool isStart}) async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: (isStart ? _startDate : _endDate) ?? now,
      firstDate: DateTime(now.year - 2),
      lastDate: DateTime(now.year + 5),
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

  Future<void> _delete(Course course) async {
    final ok = await AppDialog.confirm(
      context,
      title: 'Удалить курс?',
      message: 'Курс, недели и материалы будут удалены безвозвратно. '
          'Курс с оценками/отправками удалить нельзя — архивируйте его.',
      confirmLabel: 'Удалить',
    );
    if (!ok) return;
    setState(() => _saving = true);
    try {
      await ref.read(courseRepositoryProvider).deleteCourse(course.courseId);
      ref.invalidate(adminCoursesProvider);
      if (!mounted) return;
      AppSnackbar.show(context, 'Курс удалён');
      context.pop();
    } catch (e) {
      if (!mounted) return;
      AppSnackbar.showFailure(context, e as Failure);
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  Future<void> _toggleTeacher(Course course, String uid, bool add) async {
    final next = add
        ? ({...course.teacherIds, uid}.toList())
        : course.teacherIds.where((t) => t != uid).toList();
    try {
      await ref.read(courseRepositoryProvider).updateCourse(
            course.copyWith(teacherIds: next, updatedAt: DateTime.now()),
          );
    } catch (e) {
      if (mounted) AppSnackbar.showFailure(context, e as Failure);
    }
  }

  Future<void> _toggleGroup(Course course, String groupId, bool link) async {
    final repo = ref.read(groupRepositoryProvider);
    try {
      if (link) {
        await repo.linkCourse(groupId, course.courseId);
      } else {
        await repo.unlinkCourse(groupId, course.courseId);
      }
    } catch (e) {
      if (mounted) AppSnackbar.showFailure(context, e as Failure);
    }
  }

  Future<void> _save(Course? existing) async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    setState(() => _saving = true);
    final repo = ref.read(courseRepositoryProvider);
    final now = DateTime.now();
    try {
      if (existing == null) {
        await repo.createCourse(
          Course(
            courseId: '',
            title: _title.text.trim(),
            description: _description.text.trim(),
            startDate: _startDate,
            endDate: _endDate,
            createdAt: now,
            updatedAt: now,
          ),
        );
      } else {
        await repo.updateCourse(
          existing.copyWith(
            title: _title.text.trim(),
            description: _description.text.trim(),
            startDate: _startDate,
            endDate: _endDate,
            updatedAt: now,
          ),
        );
      }
      ref.invalidate(adminCoursesProvider);
      if (!mounted) return;
      AppSnackbar.show(context, existing == null ? 'Курс создан' : 'Сохранено');
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
        title: 'Новый курс',
        body: _form(existing: null),
      );
    }

    final courseAsync = ref.watch(courseByIdProvider(widget.courseId!));
    return AppScaffold(
      title: 'Курс',
      body: courseAsync.when(
        data: (course) {
          if (course == null) {
            return const AppEmptyView(message: 'Курс не найден');
          }
          _seed(course);
          return _form(existing: course);
        },
        loading: () => const AppLoader(),
        error: (e, _) => AppErrorView(
          failure: e as Failure,
          onRetry: () => ref.invalidate(courseByIdProvider(widget.courseId!)),
        ),
      ),
    );
  }

  Widget _form({required Course? existing}) {
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
          Row(
            children: [
              Expanded(
                child: _dateTile(
                    'Начало', _startDate, () => _pickDate(isStart: true)),
              ),
              AppSpacing.gapSm,
              Expanded(
                child: _dateTile(
                    'Завершение', _endDate, () => _pickDate(isStart: false)),
              ),
            ],
          ),
          if (existing != null) ...[
            AppSpacing.gapLg,
            _teachersSection(existing),
            AppSpacing.gapLg,
            _groupsSection(existing),
          ],
          AppSpacing.gapXl,
          PrimaryButton(
            label: 'Сохранить',
            isLoading: _saving,
            onPressed: () => _save(existing),
          ),
          if (existing != null) ...[
            AppSpacing.gapMd,
            SecondaryButton(
              label: 'Удалить курс',
              onPressed: _saving ? null : () => _delete(existing),
            ),
          ],
        ],
      ),
    );
  }

  Widget _dateTile(String label, DateTime? value, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: InputDecorator(
        decoration: InputDecoration(labelText: label),
        child: Text(_fmtDate(value)),
      ),
    );
  }

  /// Назначение преподавателей на курс (P2-21): чекбоксы из списка преподавателей.
  Widget _teachersSection(Course course) {
    final teachersAsync = ref.watch(adminUsersByRoleProvider(UserRole.teacher));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Преподаватели', style: Theme.of(context).textTheme.titleSmall),
        teachersAsync.when(
          data: (rows) {
            if (rows.isEmpty) return const Text('Нет преподавателей');
            return Column(
              children: [
                for (final AdminUserRow r in rows)
                  CheckboxListTile(
                    contentPadding: EdgeInsets.zero,
                    dense: true,
                    value: course.teacherIds.contains(r.user.uid),
                    title: Text(r.displayName),
                    onChanged: (v) =>
                        _toggleTeacher(course, r.user.uid, v ?? false),
                  ),
              ],
            );
          },
          loading: () => const LinearProgressIndicator(),
          error: (_, _) => const Text('Не удалось загрузить преподавателей'),
        ),
      ],
    );
  }

  /// Назначение курса группам (P2-2): чекбоксы из списка групп → link/unlink.
  Widget _groupsSection(Course course) {
    final groupsAsync = ref.watch(adminGroupsProvider());
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Группы', style: Theme.of(context).textTheme.titleSmall),
        groupsAsync.when(
          data: (groups) {
            if (groups.isEmpty) return const Text('Нет групп');
            return Column(
              children: [
                for (final g in groups)
                  CheckboxListTile(
                    contentPadding: EdgeInsets.zero,
                    dense: true,
                    value: course.groupIds.contains(g.groupId),
                    title: Text(g.title.isEmpty ? g.groupId : g.title),
                    onChanged: (v) =>
                        _toggleGroup(course, g.groupId, v ?? false),
                  ),
              ],
            );
          },
          loading: () => const LinearProgressIndicator(),
          error: (_, _) => const Text('Не удалось загрузить группы'),
        ),
      ],
    );
  }
}
