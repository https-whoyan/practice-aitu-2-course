import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/error/failure.dart';
import '../../../shared/widgets/widgets.dart';
import '../../../theme/app_spacing.dart';
import '../../auth/data/user_providers.dart';
import '../../courses/data/course_providers.dart';
import '../data/group_functions.dart';
import '../data/group_providers.dart';
import '../domain/group.dart';

/// Детали группы преподавателя: курсы, студенты и создание кода приглашения
/// (ТЗ §5.6.2, P1-2/P1-3).
class TeacherGroupDetailScreen extends ConsumerStatefulWidget {
  const TeacherGroupDetailScreen({super.key, required this.groupId});

  final String groupId;

  @override
  ConsumerState<TeacherGroupDetailScreen> createState() =>
      _TeacherGroupDetailScreenState();
}

class _TeacherGroupDetailScreenState
    extends ConsumerState<TeacherGroupDetailScreen> {
  bool _creating = false;

  Future<void> _createInviteCode() async {
    setState(() => _creating = true);
    try {
      final res = await ref.read(groupFunctionsProvider).createInviteCode(
            groupId: widget.groupId,
            expiresInDays: 7,
          );
      final code = res['code'] as String? ?? '';
      if (!mounted) return;
      await _showCodeDialog(code);
    } catch (e) {
      if (!mounted) return;
      AppSnackbar.showFailure(context, e as Failure);
    } finally {
      if (mounted) setState(() => _creating = false);
    }
  }

  Future<void> _showCodeDialog(String code) {
    return showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Код приглашения'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Передайте код студентам. Действует 7 дней.'),
            AppSpacing.gapMd,
            SelectableText(
              code,
              style: Theme.of(ctx)
                  .textTheme
                  .headlineSmall
                  ?.copyWith(letterSpacing: 4, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () async {
              await Clipboard.setData(ClipboardData(text: code));
              if (ctx.mounted) Navigator.of(ctx).pop();
            },
            child: const Text('Копировать'),
          ),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Закрыть'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final groupAsync = ref.watch(groupByIdProvider(widget.groupId));
    return AppScaffold(
      title: 'Группа',
      body: groupAsync.when(
        data: (group) {
          if (group == null) {
            return const AppEmptyView(message: 'Группа не найдена');
          }
          return _body(group);
        },
        loading: () => const AppLoader(),
        error: (e, _) => AppErrorView(
          failure: e as Failure,
          onRetry: () => ref.invalidate(groupByIdProvider(widget.groupId)),
        ),
      ),
    );
  }

  Widget _body(Group group) {
    final coursesAsync = ref.watch(coursesByIdsProvider(group.courseIds));
    return ListView(
      children: [
        Text(group.title.isEmpty ? group.groupId : group.title,
            style: Theme.of(context).textTheme.headlineSmall),
        if (group.description.isNotEmpty) ...[
          AppSpacing.gapXs,
          Text(group.description,
              style: Theme.of(context).textTheme.bodyMedium),
        ],
        AppSpacing.gapLg,
        Text('Курсы', style: Theme.of(context).textTheme.titleSmall),
        AppSpacing.gapSm,
        coursesAsync.when(
          data: (courses) {
            if (courses.isEmpty) {
              return Text('Курсы не привязаны',
                  style: Theme.of(context).textTheme.bodySmall);
            }
            return Wrap(
              spacing: AppSpacing.sm,
              runSpacing: AppSpacing.xs,
              children: [
                for (final c in courses)
                  Chip(label: Text(c.title.isEmpty ? c.courseId : c.title)),
              ],
            );
          },
          loading: () => const LinearProgressIndicator(),
          error: (_, _) => const Text('Не удалось загрузить курсы'),
        ),
        AppSpacing.gapLg,
        Text('Студенты · ${group.studentIds.length}',
            style: Theme.of(context).textTheme.titleSmall),
        AppSpacing.gapSm,
        if (group.studentIds.isEmpty)
          Text('Студентов пока нет',
              style: Theme.of(context).textTheme.bodySmall)
        else
          for (final uid in group.studentIds) _StudentTile(uid: uid),
        AppSpacing.gapXl,
        PrimaryButton(
          label: 'Создать код приглашения',
          isLoading: _creating,
          onPressed: _creating ? null : _createInviteCode,
        ),
      ],
    );
  }
}

/// Строка студента по uid: имя из профиля (преподаватель читает `profiles`).
class _StudentTile extends ConsumerWidget {
  const _StudentTile({required this.uid});

  final String uid;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(profileStreamProvider(uid)).valueOrNull;
    return ListTile(
      contentPadding: EdgeInsets.zero,
      dense: true,
      leading: const Icon(Icons.person_outline),
      title: Text(profile?.fullName.trim().isNotEmpty == true
          ? profile!.fullName
          : uid),
    );
  }
}
