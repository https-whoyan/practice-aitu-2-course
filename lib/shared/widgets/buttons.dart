import 'package:flutter/material.dart';

import '../../theme/app_spacing.dart';

/// Главная кнопка действия (filled). Поддерживает состояние loading.
class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.label,
    this.onPressed,
    this.isLoading = false,
    this.icon,
    this.expand = true,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;
  final IconData? icon;
  final bool expand;

  @override
  Widget build(BuildContext context) {
    final child = isLoading
        ? const _ButtonSpinner()
        : (icon != null
            ? Row(
                mainAxisSize: MainAxisSize.min,
                children: [Icon(icon, size: 18), AppSpacing.gapSm, Text(label)],
              )
            : Text(label));
    final button = FilledButton(
      onPressed: isLoading ? null : onPressed,
      child: child,
    );
    return expand ? SizedBox(width: double.infinity, child: button) : button;
  }
}

/// Второстепенная кнопка (outlined).
class SecondaryButton extends StatelessWidget {
  const SecondaryButton({
    super.key,
    required this.label,
    this.onPressed,
    this.isLoading = false,
    this.expand = true,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool expand;

  @override
  Widget build(BuildContext context) {
    final button = OutlinedButton(
      onPressed: isLoading ? null : onPressed,
      child: isLoading ? const _ButtonSpinner() : Text(label),
    );
    return expand ? SizedBox(width: double.infinity, child: button) : button;
  }
}

/// Текстовая кнопка-ссылка (например «Забыли пароль?»).
class AppTextButton extends StatelessWidget {
  const AppTextButton({super.key, required this.label, this.onPressed});

  final String label;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(onPressed: onPressed, child: Text(label));
  }
}

class _ButtonSpinner extends StatelessWidget {
  const _ButtonSpinner();

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 20,
      height: 20,
      child: CircularProgressIndicator(strokeWidth: 2),
    );
  }
}
