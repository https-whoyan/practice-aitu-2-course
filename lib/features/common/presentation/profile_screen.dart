import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/widgets/widgets.dart';
import '../../../theme/app_spacing.dart';
import '../../../theme/theme_mode_provider.dart';
import '../../auth/data/auth_providers.dart';
import 'settings_screen.dart';

/// Профиль: данные пользователя + переключатель темы и выход (общий раздел).
class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsync = ref.watch(appUserProvider);
    final profileAsync = ref.watch(appProfileProvider);
    final mode = ref.watch(themeModeControllerProvider);

    return ListView(
      padding: const EdgeInsets.all(AppSpacing.lg),
      children: [
        AppCard(
          child: Row(
            children: [
              CircleAvatar(
                radius: 28,
                child: Text(
                  (profileAsync.valueOrNull?.fullName.isNotEmpty ?? false)
                      ? profileAsync.value!.fullName.characters.first
                      : '?',
                ),
              ),
              const SizedBox(width: AppSpacing.lg),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      profileAsync.valueOrNull?.fullName.trim().isNotEmpty ??
                              false
                          ? profileAsync.value!.fullName
                          : 'Без имени',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(userAsync.valueOrNull?.email ?? ''),
                    if (userAsync.valueOrNull != null)
                      Chip(
                        label: Text(userAsync.value!.role.code),
                        visualDensity: VisualDensity.compact,
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
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
}

/// Заглушка уведомлений (общий раздел).
class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppEmptyView(
      message: 'Нет уведомлений',
      icon: Icons.notifications_none,
    );
  }
}
