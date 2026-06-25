import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/error/error_mapper.dart';
import '../../../core/utils/validators.dart';
import '../../../shared/widgets/widgets.dart';
import '../../../theme/app_spacing.dart';
import 'auth_controllers.dart';

/// Экран регистрации (ТЗ §5.1.1): имя, фамилия, email, пароль, подтверждение.
/// Самостоятельная регистрация всегда создаёт роль **student**.
class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _firstName = TextEditingController();
  final _lastName = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _confirm = TextEditingController();

  @override
  void dispose() {
    _firstName.dispose();
    _lastName.dispose();
    _email.dispose();
    _password.dispose();
    _confirm.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      ref.read(registerControllerProvider.notifier).register(
            email: _email.text,
            password: _password.text,
            firstName: _firstName.text,
            lastName: _lastName.text,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(registerControllerProvider);
    ref.listen(registerControllerProvider, (_, next) {
      if (next.hasError && !next.isLoading) {
        AppSnackbar.showFailure(context, mapErrorToFailure(next.error!));
      }
    });

    return AppScaffold(
      title: 'Регистрация',
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
                    label: 'Имя',
                    controller: _firstName,
                    prefixIcon: Icons.person_outline,
                    textInputAction: TextInputAction.next,
                    validator: (v) => Validators.required(v, message: 'Введите имя'),
                  ),
                  AppSpacing.gapMd,
                  AppTextField(
                    label: 'Фамилия',
                    controller: _lastName,
                    prefixIcon: Icons.person_outline,
                    textInputAction: TextInputAction.next,
                    validator: (v) =>
                        Validators.required(v, message: 'Введите фамилию'),
                  ),
                  AppSpacing.gapMd,
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
                    textInputAction: TextInputAction.next,
                    validator: Validators.password,
                  ),
                  AppSpacing.gapMd,
                  AppPasswordField(
                    label: 'Подтверждение пароля',
                    controller: _confirm,
                    textInputAction: TextInputAction.done,
                    validator: (v) =>
                        Validators.confirmPassword(v, _password.text),
                    onFieldSubmitted: (_) => _submit(),
                  ),
                  AppSpacing.gapLg,
                  PrimaryButton(
                    label: 'Зарегистрироваться',
                    isLoading: state.isLoading,
                    onPressed: _submit,
                  ),
                  AppSpacing.gapMd,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Уже есть аккаунт?'),
                      AppTextButton(
                        label: 'Войти',
                        onPressed: () => context.pop(),
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
