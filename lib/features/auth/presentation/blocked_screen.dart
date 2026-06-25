import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/widgets/widgets.dart';
import '../../../theme/app_spacing.dart';
import '../data/auth_providers.dart';

/// Заглушка для заблокированного аккаунта (ТЗ §5.1.2): вход запрещён,
/// предлагается выйти.
class BlockedScreen extends ConsumerWidget {
  const BlockedScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppScaffold(
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 420),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.block,
                size: 56,
                color: Theme.of(context).colorScheme.error,
              ),
              AppSpacing.gapLg,
              Text(
                'Аккаунт заблокирован',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              AppSpacing.gapSm,
              Text(
                'Обратитесь к администратору для разблокировки.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              AppSpacing.gapXl,
              SecondaryButton(
                label: 'Выйти',
                expand: false,
                onPressed: () => ref.read(authRepositoryProvider).signOut(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
