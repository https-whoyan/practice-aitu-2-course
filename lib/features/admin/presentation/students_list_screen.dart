import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/error/failure.dart';
import '../../../shared/widgets/widgets.dart';
import '../../auth/domain/user_role.dart';
import '../data/admin_user_providers.dart';
import 'users_list_screen.dart' show AdminUserTile;

/// Список студентов (ТЗ §10). Студенты регистрируются сами — кнопки создания нет.
class StudentsListScreen extends ConsumerWidget {
  const StudentsListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final studentsAsync =
        ref.watch(adminUsersByRoleProvider(UserRole.student));

    return AppScaffold(
      title: 'Студенты',
      body: studentsAsync.when(
        loading: () => const AppLoader(),
        error: (e, _) => AppErrorView(
          failure: e as Failure,
          onRetry: () =>
              ref.invalidate(adminUsersByRoleProvider(UserRole.student)),
        ),
        data: (rows) {
          if (rows.isEmpty) {
            return const AppEmptyView(message: 'Студентов нет');
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
