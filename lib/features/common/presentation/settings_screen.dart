import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/widgets/widgets.dart';
import '../../../theme/app_spacing.dart';
import '../../../theme/theme_mode_provider.dart';
import '../../auth/data/auth_providers.dart';

/// Настройки: переключение темы (шаг 5) и выход (шаг 7). Общий раздел для ролей.
class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mode = ref.watch(themeModeControllerProvider);
    return ListView(
      padding: const EdgeInsets.all(AppSpacing.lg),
      children: [
        const SectionHeader(title: 'Оформление'),
        ThemeModeSelector(mode: mode),
        const Divider(height: AppSpacing.xxl),
        const SectionHeader(title: 'Аккаунт'),
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

/// Переиспользуемый переключатель темы (system/light/dark).
class ThemeModeSelector extends ConsumerWidget {
  const ThemeModeSelector({super.key, required this.mode});

  final ThemeMode mode;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SegmentedButton<ThemeMode>(
      segments: const [
        ButtonSegment(
          value: ThemeMode.system,
          label: Text('Системная'),
          icon: Icon(Icons.brightness_auto),
        ),
        ButtonSegment(
          value: ThemeMode.light,
          label: Text('Светлая'),
          icon: Icon(Icons.light_mode),
        ),
        ButtonSegment(
          value: ThemeMode.dark,
          label: Text('Тёмная'),
          icon: Icon(Icons.dark_mode),
        ),
      ],
      selected: {mode},
      onSelectionChanged: (selection) =>
          ref.read(themeModeControllerProvider.notifier).set(selection.first),
    );
  }
}
