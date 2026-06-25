import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/error/error_mapper.dart';
import '../../../shared/widgets/widgets.dart';
import '../../../theme/app_spacing.dart';
import '../data/auth_providers.dart';

/// Экран подтверждения email (ТЗ §5.1.4): напоминание + повторная отправка
/// письма. Подтверждение — мягкий gate: вход разрешён, часть действий
/// блокируется до верификации (применяется в Сессии 2).
class VerifyEmailScreen extends ConsumerStatefulWidget {
  const VerifyEmailScreen({super.key});

  @override
  ConsumerState<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends ConsumerState<VerifyEmailScreen> {
  bool _busy = false;

  /// Выполняет действие, показывает его сообщение/ошибку. `context`
  /// используется только после единственной проверки `mounted` ниже.
  Future<void> _run(Future<String?> Function() action) async {
    setState(() => _busy = true);
    String? message;
    Object? error;
    try {
      message = await action();
    } catch (e) {
      error = e;
    } finally {
      if (mounted) setState(() => _busy = false);
    }
    if (!mounted) return;
    if (error != null) {
      AppSnackbar.showFailure(context, mapErrorToFailure(error));
    } else if (message != null) {
      AppSnackbar.show(context, message);
    }
  }

  @override
  Widget build(BuildContext context) {
    final auth = ref.read(authRepositoryProvider);
    final email = auth.currentUser?.email ?? '';

    return AppScaffold(
      title: 'Подтверждение email',
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 420),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.mark_email_unread_outlined, size: 56),
              AppSpacing.gapLg,
              Text(
                'Мы отправили письмо для подтверждения на\n$email',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              AppSpacing.gapXl,
              PrimaryButton(
                label: 'Я подтвердил(а) — продолжить',
                isLoading: _busy,
                onPressed: () => _run(() async {
                  final verified = await auth.reloadAndCheckVerified();
                  return verified
                      ? 'Email подтверждён.'
                      : 'Email ещё не подтверждён.';
                }),
              ),
              AppSpacing.gapSm,
              SecondaryButton(
                label: 'Отправить письмо повторно',
                isLoading: _busy,
                onPressed: () => _run(() async {
                  await auth.sendEmailVerification();
                  return 'Письмо отправлено повторно.';
                }),
              ),
              AppSpacing.gapMd,
              AppTextButton(
                label: 'Выйти',
                onPressed: () => _run(() async {
                  await auth.signOut();
                  return null;
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
