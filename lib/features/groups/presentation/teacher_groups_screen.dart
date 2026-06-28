import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/error/failure.dart';
import '../../../shared/widgets/widgets.dart';
import '../../../theme/app_spacing.dart';
import '../../auth/data/auth_providers.dart';
import '../data/group_providers.dart';

/// «Мои группы» преподавателя (ТЗ §5.6, P1-3).
///
/// Список групп, связанных с курсами преподавателя (`group.teacherIds` не
/// заполняется, поэтому идём через курсы). Тап → детали группы с кодами
/// приглашения (P1-2).
class TeacherGroupsScreen extends ConsumerWidget {
  const TeacherGroupsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final uid = ref.watch(appUserProvider).valueOrNull?.uid;
    if (uid == null) {
      return const AppScaffold(title: 'Мои группы', body: AppLoader());
    }

    final groupsAsync = ref.watch(teacherGroupsByCoursesProvider(uid));
    return AppScaffold(
      title: 'Мои группы',
      body: groupsAsync.when(
        data: (groups) {
          if (groups.isEmpty) {
            return const AppEmptyView(
              message: 'Нет групп. Группы появляются после привязки курса к группе.',
            );
          }
          return ListView.separated(
            itemCount: groups.length,
            separatorBuilder: (_, _) => AppSpacing.gapSm,
            itemBuilder: (context, index) {
              final g = groups[index];
              return AppCard(
                onTap: () => context.push('/teacher/groups/${g.groupId}'),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(g.title.isEmpty ? g.groupId : g.title,
                        style: Theme.of(context).textTheme.titleMedium),
                    AppSpacing.gapXs,
                    Text(
                      'Студентов: ${g.studentIds.length} · Курсов: ${g.courseIds.length}',
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
          onRetry: () => ref.invalidate(teacherGroupsByCoursesProvider(uid)),
        ),
      ),
    );
  }
}
