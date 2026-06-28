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
import '../../groups/domain/group.dart';
import '../data/admin_user_providers.dart';
import '../domain/admin_user_repository.dart';

/// Форма создания/редактирования группы (ТЗ §7.3).
///
/// [groupId] == null — создание, иначе редактирование (форма переиспользуется).
class GroupFormScreen extends ConsumerStatefulWidget {
  const GroupFormScreen({super.key, this.groupId});

  final String? groupId;

  @override
  ConsumerState<GroupFormScreen> createState() => _GroupFormScreenState();
}

class _GroupFormScreenState extends ConsumerState<GroupFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _title = TextEditingController();
  final _description = TextEditingController();

  bool _isEdit = false;
  bool _seeded = false;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _isEdit = widget.groupId != null;
  }

  @override
  void dispose() {
    _title.dispose();
    _description.dispose();
    super.dispose();
  }

  /// Заполняет контроллеры данными группы один раз (в режиме редактирования).
  void _seed(Group group) {
    if (_seeded) return;
    _seeded = true;
    _title.text = group.title;
    _description.text = group.description;
  }

  Future<void> _save(Group? existing) async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    setState(() => _saving = true);
    final repo = ref.read(groupRepositoryProvider);
    final now = DateTime.now();
    try {
      if (existing == null) {
        await repo.createGroup(
          Group(
            groupId: '',
            title: _title.text.trim(),
            description: _description.text.trim(),
            createdAt: now,
            updatedAt: now,
          ),
        );
      } else {
        await repo.updateGroup(
          existing.copyWith(
            title: _title.text.trim(),
            description: _description.text.trim(),
            updatedAt: now,
          ),
        );
      }
      ref.invalidate(adminGroupsProvider);
      if (!mounted) return;
      AppSnackbar.show(context, existing == null ? 'Группа создана' : 'Сохранено');
      context.pop();
    } catch (e) {
      if (!mounted) return;
      AppSnackbar.showFailure(context, e as Failure);
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  Future<void> _archive() async {
    final confirmed = await AppDialog.confirm(
      context,
      title: 'Архивировать группу',
      message: 'Группа будет перемещена в архив. Продолжить?',
      confirmLabel: 'Архивировать',
    );
    if (!confirmed) return;
    setState(() => _saving = true);
    try {
      await ref.read(groupRepositoryProvider).archiveGroup(widget.groupId!);
      ref.invalidate(adminGroupsProvider);
      if (!mounted) return;
      AppSnackbar.show(context, 'Группа архивирована');
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
        title: 'Новая группа',
        body: _form(existing: null),
      );
    }

    final groupAsync = ref.watch(groupByIdProvider(widget.groupId!));
    return AppScaffold(
      title: 'Группа',
      body: groupAsync.when(
        data: (group) {
          if (group == null) {
            return const AppEmptyView(message: 'Группа не найдена');
          }
          _seed(group);
          return _form(existing: group);
        },
        loading: () => const AppLoader(),
        error: (e, _) => AppErrorView(
          failure: e as Failure,
          onRetry: () => ref.invalidate(groupByIdProvider(widget.groupId!)),
        ),
      ),
    );
  }

  Widget _form({required Group? existing}) {
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
          if (existing != null) ...[
            AppSpacing.gapLg,
            _GroupMembersSection(group: existing),
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
              label: 'Архивировать',
              onPressed: _saving ? null : _archive,
            ),
          ],
        ],
      ),
    );
  }
}

/// Управление составом группы: связанные курсы и зачисленные студенты (P1-1).
///
/// Опирается на готовые методы репозитория `linkCourse`/`unlinkCourse`/
/// `addStudent`/`removeStudent` — зеркальные поля (`courses.groupIds`,
/// `profiles.groupIds/courseIds`) пишутся атомарно на стороне репозитория.
/// Без этой связи студент не получает курсы группы (критично).
class _GroupMembersSection extends ConsumerWidget {
  const _GroupMembersSection({required this.group});

  final Group group;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final coursesAsync = ref.watch(adminCoursesProvider());
    final studentsAsync = ref.watch(adminUsersByRoleProvider(UserRole.student));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionHeader(
          title: 'Курсы группы',
          count: group.courseIds.length,
          onAdd: () =>
              _addCourse(context, ref, coursesAsync.valueOrNull ?? const []),
        ),
        AppSpacing.gapSm,
        coursesAsync.when(
          data: (courses) => _courseChips(context, ref, courses),
          loading: () => const LinearProgressIndicator(),
          error: (_, _) => const Text('Не удалось загрузить курсы'),
        ),
        AppSpacing.gapLg,
        _SectionHeader(
          title: 'Студенты группы',
          count: group.studentIds.length,
          onAdd: () =>
              _addStudent(context, ref, studentsAsync.valueOrNull ?? const []),
        ),
        AppSpacing.gapSm,
        studentsAsync.when(
          data: (students) => _studentList(context, ref, students),
          loading: () => const LinearProgressIndicator(),
          error: (_, _) => const Text('Не удалось загрузить студентов'),
        ),
      ],
    );
  }

  Widget _courseChips(BuildContext context, WidgetRef ref, List<Course> all) {
    if (group.courseIds.isEmpty) {
      return Text('Курсы не назначены',
          style: Theme.of(context).textTheme.bodySmall);
    }
    final byId = {for (final c in all) c.courseId: c};
    return Wrap(
      spacing: AppSpacing.sm,
      runSpacing: AppSpacing.xs,
      children: [
        for (final id in group.courseIds)
          Chip(
            label: Text(byId[id]?.title ?? id),
            onDeleted: () => _run(
              context,
              () => ref
                  .read(groupRepositoryProvider)
                  .unlinkCourse(group.groupId, id),
              'Курс отвязан',
            ),
          ),
      ],
    );
  }

  Widget _studentList(
      BuildContext context, WidgetRef ref, List<AdminUserRow> all) {
    if (group.studentIds.isEmpty) {
      return Text('Студенты не зачислены',
          style: Theme.of(context).textTheme.bodySmall);
    }
    final byId = {for (final r in all) r.user.uid: r};
    return Column(
      children: [
        for (final uid in group.studentIds)
          ListTile(
            contentPadding: EdgeInsets.zero,
            dense: true,
            leading: const Icon(Icons.person_outline),
            title: Text(byId[uid]?.displayName ?? uid),
            trailing: PopupMenuButton<String>(
              tooltip: 'Действия',
              onSelected: (a) {
                if (a == 'remove') {
                  _run(
                    context,
                    () => ref
                        .read(groupRepositoryProvider)
                        .removeStudent(group.groupId, uid),
                    'Студент удалён из группы',
                  );
                } else if (a == 'transfer') {
                  _transferStudent(context, ref, uid);
                }
              },
              itemBuilder: (_) => const [
                PopupMenuItem(value: 'transfer', child: Text('Перевести')),
                PopupMenuItem(value: 'remove', child: Text('Удалить')),
              ],
            ),
          ),
      ],
    );
  }

  Future<void> _addCourse(
      BuildContext context, WidgetRef ref, List<Course> all) async {
    final available = all
        .where((c) => !group.courseIds.contains(c.courseId))
        .map((c) => (c.courseId, c.title.isEmpty ? c.courseId : c.title))
        .toList();
    final id = await _pickFromList(context, 'Добавить курс', available);
    if (id == null || !context.mounted) return;
    await _run(
      context,
      () => ref.read(groupRepositoryProvider).linkCourse(group.groupId, id),
      'Курс добавлен',
    );
  }

  Future<void> _addStudent(
      BuildContext context, WidgetRef ref, List<AdminUserRow> all) async {
    final available = all
        .where((r) => !group.studentIds.contains(r.user.uid))
        .map((r) => (r.user.uid, r.displayName))
        .toList();
    final uid = await _pickFromList(context, 'Добавить студента', available);
    if (uid == null || !context.mounted) return;
    await _run(
      context,
      () => ref.read(groupRepositoryProvider).addStudent(group.groupId, uid),
      'Студент зачислен',
    );
  }

  /// Переводит студента в другую группу (P2-6): удаляет из текущей и добавляет
  /// в выбранную (зеркала пишет репозиторий).
  Future<void> _transferStudent(
      BuildContext context, WidgetRef ref, String uid) async {
    final groups = await ref.read(adminGroupsProvider().future);
    if (!context.mounted) return;
    final targets = groups
        .where((g) => g.groupId != group.groupId)
        .map((g) => (g.groupId, g.title.isEmpty ? g.groupId : g.title))
        .toList();
    final targetId = await _pickFromList(context, 'Перевести в группу', targets);
    if (targetId == null || !context.mounted) return;
    final repo = ref.read(groupRepositoryProvider);
    await _run(
      context,
      () async {
        await repo.addStudent(targetId, uid);
        await repo.removeStudent(group.groupId, uid);
      },
      'Студент переведён',
    );
  }

  /// Выполняет операцию репозитория с тостом успеха/ошибки.
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
}

/// Заголовок секции состава с кнопкой «добавить».
class _SectionHeader extends StatelessWidget {
  const _SectionHeader({
    required this.title,
    required this.count,
    required this.onAdd,
  });

  final String title;
  final int count;
  final VoidCallback onAdd;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('$title · $count',
            style: Theme.of(context).textTheme.titleSmall),
        TextButton.icon(
          onPressed: onAdd,
          icon: const Icon(Icons.add, size: 18),
          label: const Text('Добавить'),
        ),
      ],
    );
  }
}

/// Модальный выбор одного элемента из списка `(id, label)`. Возвращает id.
Future<String?> _pickFromList(
  BuildContext context,
  String title,
  List<(String, String)> items,
) {
  if (items.isEmpty) {
    AppSnackbar.show(context, 'Нет доступных вариантов');
    return Future.value(null);
  }
  return showModalBottomSheet<String>(
    context: context,
    showDragHandle: true,
    builder: (ctx) => SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.lg, vertical: AppSpacing.sm),
            child: Text(title, style: Theme.of(ctx).textTheme.titleMedium),
          ),
          Flexible(
            child: ListView(
              shrinkWrap: true,
              children: [
                for (final (id, label) in items)
                  ListTile(
                    title: Text(label),
                    onTap: () => Navigator.of(ctx).pop(id),
                  ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
