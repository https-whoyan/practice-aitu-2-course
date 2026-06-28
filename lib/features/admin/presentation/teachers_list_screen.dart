import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/error/failure.dart';
import '../../../shared/widgets/widgets.dart';
import '../../auth/domain/user_role.dart';
import '../data/admin_user_providers.dart';
import 'users_list_screen.dart' show AdminUserTile;

/// Список преподавателей (ТЗ §10).
class TeachersListScreen extends ConsumerWidget {
  const TeachersListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final teachersAsync =
        ref.watch(adminUsersByRoleProvider(UserRole.teacher));

    return AppScaffold(
      title: 'Преподаватели',
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/admin/users/new'),
        icon: const Icon(Icons.person_add),
        label: const Text('Создать преподавателя'),
      ),
      body: teachersAsync.when(
        loading: () => const AppLoader(),
        error: (e, _) => AppErrorView(
          failure: e as Failure,
          onRetry: () =>
              ref.invalidate(adminUsersByRoleProvider(UserRole.teacher)),
        ),
        data: (rows) {
          if (rows.isEmpty) {
            return const AppEmptyView(message: 'Преподавателей нет');
          }
          return ListView.builder(
            itemCount: rows.length,
            itemBuilder: (context, index) {
              final row = rows[index];
              return AdminUserTile(
                row: row,
                onTap: () => context.push('/admin/users/${row.user.uid}'),
              );
            },
          );
        },
      ),
    );
  }
}
