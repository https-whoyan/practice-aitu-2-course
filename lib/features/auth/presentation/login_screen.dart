import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/error/error_mapper.dart';
import '../../../core/utils/validators.dart';
import '../../../routing/app_routes.dart';
import '../../../theme/app_spacing.dart';
import '../../../shared/widgets/widgets.dart';
import 'auth_controllers.dart';

/// Экран входа (ТЗ §14.1): email + пароль, ссылки на регистрацию/восстановление.
class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      ref.read(loginControllerProvider.notifier).signIn(
            email: _email.text,
            password: _password.text,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(loginControllerProvider);
    ref.listen(loginControllerProvider, (_, next) {
      if (next.hasError && !next.isLoading) {
        AppSnackbar.showFailure(context, mapErrorToFailure(next.error!));
      }
    });

    return AppScaffold(
      title: 'Вход',
      body: Center(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 400),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppTextField(
                    label: 'Email',
                    controller: _email,
                    prefixIcon: Icons.email_outlined,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    validator: Validators.email,
                  ),
                  AppSpacing.gapMd,
                  AppPasswordField(
                    label: 'Пароль',
                    controller: _password,
                    textInputAction: TextInputAction.done,
                    validator: Validators.password,
                    onFieldSubmitted: (_) => _submit(),
                  ),
                  AppSpacing.gapSm,
                  Align(
                    alignment: Alignment.centerRight,
                    child: AppTextButton(
                      label: 'Забыли пароль?',
                      onPressed: () => context.push(AppRoutes.forgotPassword),
                    ),
                  ),
                  AppSpacing.gapMd,
                  PrimaryButton(
                    label: 'Войти',
                    isLoading: state.isLoading,
                    onPressed: _submit,
                  ),
                  AppSpacing.gapMd,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Нет аккаунта?'),
                      AppTextButton(
                        label: 'Регистрация',
                        onPressed: () => context.push(AppRoutes.register),
                      ),
                    ],
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
