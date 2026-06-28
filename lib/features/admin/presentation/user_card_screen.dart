import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/error/failure.dart';
import '../../../shared/widgets/widgets.dart';
import '../../../theme/app_spacing.dart';
import '../../auth/data/auth_providers.dart';
import '../../auth/domain/user_role.dart';
import '../data/admin_functions.dart';
import '../data/admin_user_providers.dart';
import 'users_list_screen.dart' show roleLabel, statusLabel;

/// Карточка пользователя с действиями администратора (ТЗ §10).
class UserCardScreen extends ConsumerWidget {
  const UserCardScreen({super.key, required this.uid});

  final String uid;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rowAsync = ref.watch(adminUserByIdProvider(uid));
    final currentUid = ref.watch(appUserProvider).valueOrNull?.uid;

    return AppScaffold(
      title: 'Пользователь',
      body: rowAsync.when(
        loading: () => const AppLoader(),
        error: (e, _) => AppErrorView(
          failure: e as Failure,
          onRetry: () => ref.invalidate(adminUserByIdProvider(uid)),
        ),
        data: (row) {
          if (row == null) {
            return const AppEmptyView(message: 'Пользователь не найден');
          }
          final user = row.user;
          final profile = row.profile;
          final theme = Theme.of(context);
          final isSelf = currentUid == uid;

          return ListView(
            children: [
              AppCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(row.displayName, style: theme.textTheme.titleLarge),
                    AppSpacing.gapXs,
                    Text(user.email, style: theme.textTheme.bodyMedium),
                    AppSpacing.gapMd,
                    Wrap(
                      spacing: AppSpacing.sm,
                      children: [
                        Chip(
                          label: Text(roleLabel(user.role)),
                          visualDensity: VisualDensity.compact,
                        ),
                        Chip(
                          label: Text(statusLabel(user.status)),
                          visualDensity: VisualDensity.compact,
                          backgroundColor: user.status.isBlocked
                              ? theme.colorScheme.errorContainer
                              : null,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              AppSpacing.gapMd,
              AppCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _InfoRow(
                      label: 'Зарегистрирован',
                      value: _formatDate(user.createdAt),
                    ),
                    _InfoRow(
                      label: 'Последний вход',
                      value: user.lastLoginAt == null
                          ? '—'
                          : _formatDate(user.lastLoginAt!),
                    ),
                    _InfoRow(
                      label: 'Групп',
                      value: '${profile?.groupIds.length ?? 0}',
                    ),
                    _InfoRow(
                      label: 'Курсов',
                      value: '${profile?.courseIds.length ?? 0}',
                    ),
                  ],
                ),
              ),
              if (!isSelf) ...[
                AppSpacing.gapLg,
                PrimaryButton(
                  label: 'Редактировать',
                  icon: Icons.edit,
                  onPressed: () => context.push('/admin/users/$uid/edit'),
                ),
                AppSpacing.gapMd,
                if (user.status.isBlocked)
                  SecondaryButton(
                    label: 'Разблокировать',
                    onPressed: () => _unblock(context, ref),
                  )
                else
                  SecondaryButton(
                    label: 'Заблокировать',
                    onPressed: () => _block(context, ref),
                  ),
                AppSpacing.gapMd,
                SecondaryButton(
                  label: 'Сменить роль',
                  onPressed: () => _changeRole(context, ref, user.role),
                ),
                AppSpacing.gapMd,
                SecondaryButton(
                  label: 'Удалить (мягко)',
                  onPressed: () => _delete(context, ref),
                ),
              ],
            ],
          );
        },
      ),
    );
  }

  void _refresh(WidgetRef ref) {
    ref.invalidate(adminUserByIdProvider(uid));
    ref.invalidate(adminUsersControllerProvider);
  }

  Future<void> _block(BuildContext context, WidgetRef ref) async {
    final ok = await AppDialog.confirm(
      context,
      title: 'Заблокировать пользователя?',
      message: 'Пользователь не сможет входить в систему.',
      confirmLabel: 'Заблокировать',
    );
    if (!ok || !context.mounted) return;
    try {
      await ref.read(adminFunctionsProvider).blockUser(uid);
      _refresh(ref);
      if (context.mounted) AppSnackbar.show(context, 'Пользователь заблокирован');
    } catch (e) {
      if (context.mounted) AppSnackbar.showFailure(context, e as Failure);
    }
  }

  Future<void> _unblock(BuildContext context, WidgetRef ref) async {
    try {
      await ref.read(adminFunctionsProvider).unblockUser(uid);
      _refresh(ref);
      if (context.mounted) {
        AppSnackbar.show(context, 'Пользователь разблокирован');
      }
    } catch (e) {
      if (context.mounted) AppSnackbar.showFailure(context, e as Failure);
    }
  }

  Future<void> _changeRole(
    BuildContext context,
    WidgetRef ref,
    UserRole current,
  ) async {
    final selected = await showDialog<UserRole>(
      context: context,
      builder: (context) {
        UserRole value = current;
        return StatefulBuilder(
          builder: (context, setState) => AlertDialog(
            title: const Text('Сменить роль'),
            content: RadioGroup<UserRole>(
              groupValue: value,
              onChanged: (v) => setState(() => value = v!),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  for (final role in UserRole.values)
                    RadioListTile<UserRole>(
                      value: role,
                      title: Text(roleLabel(role)),
                    ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Отмена'),
              ),
              FilledButton(
                onPressed: () => Navigator.of(context).pop(value),
                child: const Text('Сохранить'),
              ),
            ],
          ),
        );
      },
    );
    if (selected == null || selected == current || !context.mounted) return;
    try {
      await ref
          .read(adminFunctionsProvider)
          .setUserRole(uid: uid, role: selected);
      _refresh(ref);
      if (context.mounted) AppSnackbar.show(context, 'Роль изменена');
    } catch (e) {
      if (context.mounted) AppSnackbar.showFailure(context, e as Failure);
    }
  }

  Future<void> _delete(BuildContext context, WidgetRef ref) async {
    final ok = await AppDialog.confirm(
      context,
      title: 'Удалить пользователя?',
      message: 'Аккаунт будет скрыт (мягкое удаление). Данные сохранятся.',
      confirmLabel: 'Удалить',
    );
    if (!ok || !context.mounted) return;
    try {
      await ref.read(adminFunctionsProvider).softDeleteUser(uid);
      ref.invalidate(adminUsersControllerProvider);
      if (context.mounted) {
        AppSnackbar.show(context, 'Пользователь удалён');
        context.pop();
      }
    } catch (e) {
      if (context.mounted) AppSnackbar.showFailure(context, e as Failure);
    }
  }
}

String _formatDate(DateTime d) => '${d.day}.${d.month}.${d.year}';

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 160,
            child: Text(
              label,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          Expanded(child: Text(value, style: theme.textTheme.bodyMedium)),
        ],
      ),
    );
  }
}
