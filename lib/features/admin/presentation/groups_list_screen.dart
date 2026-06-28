import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/error/failure.dart';
import '../../../shared/widgets/widgets.dart';
import '../../../theme/app_spacing.dart';
import '../../groups/data/group_providers.dart';

/// Список групп для админки (ТЗ §7.3). Создание — через FAB.
class GroupsListScreen extends ConsumerWidget {
  const GroupsListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final groupsAsync = ref.watch(adminGroupsProvider());

    return AppScaffold(
      title: 'Группы',
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/admin/groups/new'),
        icon: const Icon(Icons.add),
        label: const Text('Создать группу'),
      ),
      body: groupsAsync.when(
        data: (groups) {
          if (groups.isEmpty) {
            return const AppEmptyView(message: 'Групп пока нет');
          }
          return ListView.separated(
            itemCount: groups.length,
            separatorBuilder: (_, _) => AppSpacing.gapSm,
            itemBuilder: (context, index) {
              final group = groups[index];
              return AppCard(
                onTap: () => context.push('/admin/groups/${group.groupId}'),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            group.title,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          if (group.description.isNotEmpty) ...[
                            AppSpacing.gapXs,
                            Text(
                              group.description,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ],
                      ),
                    ),
                    AppSpacing.gapMd,
                    Text(
                      'Студентов: ${group.studentIds.length}',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              );
            },
          );
        },
        loading: () => const AppLoader(),
        error: (e, _) => AppErrorView(
          failure: e as Failure,
          onRetry: () => ref.invalidate(adminGroupsProvider),
        ),
      ),
    );
  }
}
