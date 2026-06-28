import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../shared/widgets/widgets.dart';
import '../../../theme/app_spacing.dart';
import '../../../theme/theme_mode_provider.dart';
import '../../auth/data/auth_providers.dart';
import '../../auth/domain/account_status.dart';
import '../../auth/domain/app_user.dart';
import '../../auth/domain/user_profile.dart';
import 'settings_screen.dart';

/// Профиль: данные пользователя, статус/даты, группы/курсы, фото, тема и выход
/// (общий раздел; редактирование — отдельный экран, P1-9).
class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  static String _statusLabel(AccountStatus s) => switch (s) {
        AccountStatus.active => 'Активен',
        AccountStatus.blocked => 'Заблокирован',
        AccountStatus.pendingVerification => 'Ожидает подтверждения',
      };

  static String _date(DateTime? d) => d == null
      ? '—'
      : '${d.day.toString().padLeft(2, '0')}.'
          '${d.month.toString().padLeft(2, '0')}.${d.year}';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(appUserProvider).valueOrNull;
    final profile = ref.watch(appProfileProvider).valueOrNull;
    final mode = ref.watch(themeModeControllerProvider);

    return ListView(
      padding: const EdgeInsets.all(AppSpacing.lg),
      children: [
        _headerCard(context, user, profile),
        AppSpacing.gapMd,
        AppCard(
          padding: EdgeInsets.zero,
          child: ListTile(
            leading: const Icon(Icons.edit_outlined),
            title: const Text('Редактировать профиль'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => context.push(
              '${GoRouterState.of(context).uri.path}/edit',
            ),
          ),
        ),
        if (user != null) ...[
          AppSpacing.gapMd,
          _detailsCard(context, user, profile),
        ],
        const Divider(height: AppSpacing.xxl),
        const SectionHeader(title: 'Оформление'),
        ThemeModeSelector(mode: mode),
        const Divider(height: AppSpacing.xxl),
        AppCard(
          padding: EdgeInsets.zero,
          child: ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Выйти'),
            onTap: () => ref.read(authRepositoryProvider).signOut(),
          ),
        ),
      ],
    );
  }

  Widget _headerCard(
      BuildContext context, AppUser? user, UserProfile? profile) {
    final photoUrl = profile?.photoUrl;
    final fullName = profile?.fullName.trim();
    return AppCard(
      child: Row(
        children: [
          CircleAvatar(
            radius: 28,
            backgroundImage: (photoUrl != null && photoUrl.isNotEmpty)
                ? NetworkImage(photoUrl)
                : null,
            child: (photoUrl == null || photoUrl.isEmpty)
                ? Text((fullName?.isNotEmpty ?? false)
                    ? fullName!.characters.first
                    : '?')
                : null,
          ),
          const SizedBox(width: AppSpacing.lg),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  (fullName?.isNotEmpty ?? false) ? fullName! : 'Без имени',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text(user?.email ?? ''),
                if (user != null)
                  Chip(
                    label: Text(user.role.code),
                    visualDensity: VisualDensity.compact,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _detailsCard(
      BuildContext context, AppUser user, UserProfile? profile) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _row(context, 'Статус', _statusLabel(user.status)),
          _row(context, 'Email подтверждён', user.emailVerified ? 'да' : 'нет'),
          _row(context, 'Регистрация', _date(user.createdAt)),
          _row(context, 'Последний вход', _date(user.lastLoginAt)),
          if (profile != null) ...[
            _row(context, 'Групп', '${profile.groupIds.length}'),
            _row(context, 'Курсов', '${profile.courseIds.length}'),
          ],
        ],
      ),
    );
  }

  Widget _row(BuildContext context, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: Theme.of(context).textTheme.bodyMedium),
          Text(value,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
