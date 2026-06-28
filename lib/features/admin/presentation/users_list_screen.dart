import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/error/failure.dart';
import '../../../shared/widgets/widgets.dart';
import '../../../theme/app_spacing.dart';
import '../../auth/domain/account_status.dart';
import '../../auth/domain/user_role.dart';
import '../data/admin_user_providers.dart';
import '../domain/admin_user_repository.dart';

/// Список пользователей с поиском, фильтром по роли и подгрузкой «ещё» (ТЗ §10).
class UsersListScreen extends ConsumerWidget {
  const UsersListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filters = ref.watch(adminUserFiltersControllerProvider);
    final filtersCtrl = ref.read(adminUserFiltersControllerProvider.notifier);
    final usersAsync = ref.watch(adminUsersControllerProvider);

    return AppScaffold(
      title: 'Пользователи',
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/admin/users/new'),
        icon: const Icon(Icons.person_add),
        label: const Text('Создать'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppTextField(
            label: 'Поиск',
            hint: 'Имя или email',
            prefixIcon: Icons.search,
            onChanged: filtersCtrl.setSearch,
          ),
          AppSpacing.gapMd,
          Wrap(
            spacing: AppSpacing.sm,
            children: [
              FilterChip(
                label: const Text('Все'),
                selected: filters.role == null,
                onSelected: (_) => filtersCtrl.setRole(null),
              ),
              FilterChip(
                label: const Text('Администраторы'),
                selected: filters.role == UserRole.admin,
                onSelected: (_) => filtersCtrl.setRole(UserRole.admin),
              ),
              FilterChip(
                label: const Text('Преподаватели'),
                selected: filters.role == UserRole.teacher,
                onSelected: (_) => filtersCtrl.setRole(UserRole.teacher),
              ),
              FilterChip(
                label: const Text('Студенты'),
                selected: filters.role == UserRole.student,
                onSelected: (_) => filtersCtrl.setRole(UserRole.student),
              ),
            ],
          ),
          AppSpacing.gapSm,
          Wrap(
            spacing: AppSpacing.sm,
            children: [
              FilterChip(
                label: const Text('Любой статус'),
                selected: filters.status == null,
                onSelected: (_) => filtersCtrl.setStatus(null),
              ),
              FilterChip(
                label: const Text('Активные'),
                selected: filters.status == AccountStatus.active,
                onSelected: (_) => filtersCtrl.setStatus(AccountStatus.active),
              ),
              FilterChip(
                label: const Text('Заблокированные'),
                selected: filters.status == AccountStatus.blocked,
                onSelected: (_) => filtersCtrl.setStatus(AccountStatus.blocked),
              ),
              FilterChip(
                label: const Text('Ожидают'),
                selected: filters.status == AccountStatus.pendingVerification,
                onSelected: (_) =>
                    filtersCtrl.setStatus(AccountStatus.pendingVerification),
              ),
            ],
          ),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text('Показать удалённых'),
            value: filters.includeDeleted,
            onChanged: filtersCtrl.setIncludeDeleted,
          ),
          AppSpacing.gapSm,
          Expanded(
            child: usersAsync.when(
              loading: () => const AppLoader(),
              error: (e, _) => AppErrorView(
                failure: e as Failure,
                onRetry: () => ref.invalidate(adminUsersControllerProvider),
              ),
              data: (rows) {
                if (rows.isEmpty) {
                  return const AppEmptyView(message: 'Пользователи не найдены');
                }
                final reachedEnd =
                    ref.read(adminUsersControllerProvider.notifier).reachedEnd;
                return ListView.builder(
                  itemCount: rows.length + (reachedEnd ? 0 : 1),
                  itemBuilder: (context, index) {
                    if (index >= rows.length) {
                      return Padding(
                        padding: const EdgeInsets.only(top: AppSpacing.sm),
                        child: SecondaryButton(
                          label: 'Загрузить ещё',
                          onPressed: () => ref
                              .read(adminUsersControllerProvider.notifier)
                              .loadMore(),
                        ),
                      );
                    }
                    final row = rows[index];
                    return AdminUserTile(
                      row: row,
                      onTap: () =>
                          context.push('/admin/users/${row.user.uid}'),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

/// Строка-карточка пользователя для админских списков (имя, email, чипы).
class AdminUserTile extends StatelessWidget {
  const AdminUserTile({super.key, required this.row, this.onTap});

  final AdminUserRow row;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final status = row.user.status;
    return AppCard(
      onTap: onTap,
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(row.displayName, style: theme.textTheme.titleMedium),
                Text(row.user.email, style: theme.textTheme.bodySmall),
              ],
            ),
          ),
          AppSpacing.gapSm,
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Chip(
                label: Text(roleLabel(row.user.role)),
                visualDensity: VisualDensity.compact,
              ),
              Chip(
                label: Text(statusLabel(status)),
                visualDensity: VisualDensity.compact,
                backgroundColor: status.isBlocked ? colors.errorContainer : null,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Русская подпись роли.
String roleLabel(UserRole role) => switch (role) {
      UserRole.admin => 'Администратор',
      UserRole.teacher => 'Преподаватель',
      UserRole.student => 'Студент',
    };

/// Русская подпись статуса аккаунта.
String statusLabel(AccountStatus status) => switch (status) {
      AccountStatus.active => 'Активен',
      AccountStatus.blocked => 'Заблокирован',
      AccountStatus.pendingVerification => 'Ожидает подтверждения',
    };
