import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/error/failure.dart';
import '../../theme/app_spacing.dart';
import '../../theme/theme_mode_provider.dart';
import 'widgets.dart';

/// Витрина компонентов (storybook-lite) — debug-экран для визуальной проверки
/// UI-кита в светлой/тёмной теме. Доступен по маршруту `/gallery`.
class WidgetGalleryScreen extends ConsumerWidget {
  const WidgetGalleryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mode = ref.watch(themeModeControllerProvider);
    return AppScaffold(
      title: 'UI-кит · витрина',
      actions: [
        IconButton(
          tooltip: 'Переключить тему',
          icon: Icon(
            mode == ThemeMode.dark ? Icons.light_mode : Icons.dark_mode,
          ),
          onPressed: () => ref.read(themeModeControllerProvider.notifier).toggle(),
        ),
      ],
      body: ListView(
        children: [
          const SectionHeader(title: 'Кнопки'),
          PrimaryButton(label: 'Primary', onPressed: () {}),
          AppSpacing.gapSm,
          const PrimaryButton(label: 'Primary loading', isLoading: true),
          AppSpacing.gapSm,
          SecondaryButton(label: 'Secondary', onPressed: () {}),
          AppSpacing.gapSm,
          AppTextButton(label: 'Text button', onPressed: () {}),
          const Divider(height: AppSpacing.xxl),

          const SectionHeader(title: 'Поля ввода'),
          const AppTextField(label: 'Email', prefixIcon: Icons.email_outlined),
          AppSpacing.gapMd,
          const AppPasswordField(label: 'Пароль'),
          const Divider(height: AppSpacing.xxl),

          const SectionHeader(title: 'Карточка и секции'),
          AppCard(
            onTap: () {},
            child: const Text('AppCard — единый стиль карточки.'),
          ),
          const Divider(height: AppSpacing.xxl),

          const SectionHeader(title: 'Состояния'),
          const SizedBox(height: 100, child: AppLoader(message: 'Загрузка…')),
          const SizedBox(
            height: 160,
            child: AppErrorView(failure: Failure.network()),
          ),
          const SizedBox(
            height: 160,
            child: AppEmptyView(message: 'Пока ничего нет'),
          ),
          AppSpacing.gapMd,
          const Row(
            children: [
              Expanded(child: SkeletonBox(height: 48)),
              SizedBox(width: AppSpacing.md),
              Expanded(child: SkeletonBox(height: 48)),
            ],
          ),
          const Divider(height: AppSpacing.xxl),

          const SectionHeader(title: 'Снэкбары / диалоги'),
          Wrap(
            spacing: AppSpacing.sm,
            children: [
              SecondaryButton(
                label: 'Snackbar',
                expand: false,
                onPressed: () => AppSnackbar.show(context, 'Привет из снэкбара'),
              ),
              SecondaryButton(
                label: 'Failure',
                expand: false,
                onPressed: () => AppSnackbar.showFailure(
                  context,
                  const Failure.permission(),
                ),
              ),
              SecondaryButton(
                label: 'Confirm',
                expand: false,
                onPressed: () => AppDialog.confirm(
                  context,
                  title: 'Подтверждение',
                  message: 'Выполнить действие?',
                ),
              ),
            ],
          ),
          AppSpacing.gapXl,
        ],
      ),
    );
  }
}
