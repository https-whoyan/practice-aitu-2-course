import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/error/error_mapper.dart';
import '../../../core/utils/validators.dart';
import '../../../shared/widgets/widgets.dart';
import '../../../theme/app_spacing.dart';
import 'auth_controllers.dart';

/// Экран восстановления пароля (ТЗ §5.1.3): ввод email → отправка письма.
class ForgotPasswordScreen extends ConsumerStatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  ConsumerState<ForgotPasswordScreen> createState() =>
      _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends ConsumerState<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();

  @override
  void dispose() {
    _email.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      ref.read(forgotPasswordControllerProvider.notifier).sendReset(_email.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(forgotPasswordControllerProvider);
    ref.listen(forgotPasswordControllerProvider, (_, next) {
      if (next.hasError && !next.isLoading) {
        AppSnackbar.showFailure(context, mapErrorToFailure(next.error!));
      } else if (!next.isLoading && next.hasValue) {
        AppSnackbar.show(context, 'Письмо со сбросом пароля отправлено.');
        context.pop();
      }
    });

    return AppScaffold(
      title: 'Восстановление пароля',
      body: Center(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 400),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Введите email — отправим ссылку для сброса пароля.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  AppSpacing.gapLg,
                  AppTextField(
                    label: 'Email',
                    controller: _email,
                    prefixIcon: Icons.email_outlined,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.done,
                    validator: Validators.email,
                    onFieldSubmitted: (_) => _submit(),
                  ),
                  AppSpacing.gapLg,
                  PrimaryButton(
                    label: 'Отправить',
                    isLoading: state.isLoading,
                    onPressed: _submit,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
