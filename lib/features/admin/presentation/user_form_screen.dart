import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/error/failure.dart';
import '../../../core/utils/validators.dart';
import '../../../shared/widgets/widgets.dart';
import '../../../theme/app_spacing.dart';
import '../../auth/data/user_providers.dart';
import '../../auth/domain/user_profile.dart';
import '../../auth/domain/user_role.dart';
import '../data/admin_functions.dart';
import '../data/admin_user_providers.dart';
import 'users_list_screen.dart' show roleLabel;

/// Форма создания/редактирования пользователя (ТЗ §10, §17.1).
///
/// Создание: имя/фамилия/email/роль → `createUser` (письмо установки пароля).
/// Редактирование: меняется только роль. Имя/фото пользователь правит сам в
/// своём профиле (профиль редактируется на стороне пользователя).
class UserFormScreen extends ConsumerStatefulWidget {
  const UserFormScreen({super.key, this.uid});

  /// `null` — режим создания, иначе режим редактирования по uid.
  final String? uid;

  @override
  ConsumerState<UserFormScreen> createState() => _UserFormScreenState();
}

class _UserFormScreenState extends ConsumerState<UserFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _firstName = TextEditingController();
  final _lastName = TextEditingController();
  final _email = TextEditingController();

  UserRole _role = UserRole.student;
  bool _submitting = false;
  bool _prefilled = false;

  bool get _isCreate => widget.uid == null;

  @override
  void dispose() {
    _firstName.dispose();
    _lastName.dispose();
    _email.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: _isCreate ? 'Создать пользователя' : 'Редактирование',
      body: _isCreate ? _buildCreate() : _buildEdit(),
    );
  }

  // --- Создание ----------------------------------------------------------

  Widget _buildCreate() {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
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
              textInputAction: TextInputAction.done,
              validator: Validators.email,
            ),
            AppSpacing.gapMd,
            _roleDropdown(),
            AppSpacing.gapLg,
            PrimaryButton(
              label: 'Создать',
              isLoading: _submitting,
              onPressed: _submitCreate,
            ),
          ],
        ),
      ),
    );
  }

  // --- Редактирование ----------------------------------------------------

  Widget _buildEdit() {
    final rowAsync = ref.watch(adminUserByIdProvider(widget.uid!));
    return rowAsync.when(
      loading: () => const AppLoader(),
      error: (e, _) => AppErrorView(
        failure: e as Failure,
        onRetry: () => ref.invalidate(adminUserByIdProvider(widget.uid!)),
      ),
      data: (row) {
        if (row == null) {
          return const AppEmptyView(message: 'Пользователь не найден');
        }
        if (!_prefilled) {
          _role = row.user.role;
          _firstName.text = row.profile?.firstName ?? '';
          _lastName.text = row.profile?.lastName ?? '';
          _prefilled = true;
        }
        final theme = Theme.of(context);
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AppCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(row.displayName, style: theme.textTheme.titleMedium),
                    Text(row.user.email, style: theme.textTheme.bodySmall),
                  ],
                ),
              ),
              AppSpacing.gapMd,
              // Имя/фамилию и роль правит админ; email меняется отдельно (P2-8).
              AppTextField(label: 'Имя', controller: _firstName),
              AppSpacing.gapMd,
              AppTextField(label: 'Фамилия', controller: _lastName),
              AppSpacing.gapMd,
              _roleDropdown(),
              AppSpacing.gapLg,
              PrimaryButton(
                label: 'Сохранить',
                isLoading: _submitting,
                onPressed: () => _submitEdit(row.profile),
              ),
              AppSpacing.gapMd,
              SecondaryButton(
                label: 'Сбросить пароль',
                onPressed: _submitting ? null : () => _resetPassword(),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _roleDropdown() {
    return DropdownButtonFormField<UserRole>(
      initialValue: _role,
      decoration: const InputDecoration(labelText: 'Роль'),
      items: [
        for (final role in UserRole.values)
          DropdownMenuItem(value: role, child: Text(roleLabel(role))),
      ],
      onChanged: _submitting
          ? null
          : (value) => setState(() => _role = value ?? _role),
    );
  }

  // --- Действия ----------------------------------------------------------

  Future<void> _submitCreate() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    setState(() => _submitting = true);
    try {
      final AdminFunctions functions = ref.read(adminFunctionsProvider);
      final res = await functions.createUser(
        email: _email.text.trim(),
        firstName: _firstName.text.trim(),
        lastName: _lastName.text.trim(),
        role: _role,
      );
      ref.invalidate(adminUsersControllerProvider);
      if (!mounted) return;
      await _showResetLinkDialog(res['resetLink']?.toString() ?? '');
      if (!mounted) return;
      AppSnackbar.show(context, 'Пользователь создан');
      context.pop();
    } catch (e) {
      if (mounted) AppSnackbar.showFailure(context, e as Failure);
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }

  Future<void> _submitEdit(UserProfile? existing) async {
    setState(() => _submitting = true);
    final now = DateTime.now();
    try {
      // Имя/фамилия → профиль (админ вправе править, Security Rules).
      final base = existing ??
          UserProfile(uid: widget.uid!, createdAt: now, updatedAt: now);
      await ref.read(userRepositoryProvider).updateProfile(
            base.copyWith(
              uid: widget.uid!,
              firstName: _firstName.text.trim(),
              lastName: _lastName.text.trim(),
              updatedAt: now,
            ),
          );
      // Роль → через CF (assertAdmin).
      await ref
          .read(adminFunctionsProvider)
          .setUserRole(uid: widget.uid!, role: _role);
      ref.invalidate(adminUserByIdProvider(widget.uid!));
      ref.invalidate(adminUsersControllerProvider);
      if (!mounted) return;
      AppSnackbar.show(context, 'Сохранено');
      context.pop();
    } catch (e) {
      if (mounted) AppSnackbar.showFailure(context, e as Failure);
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }

  Future<void> _resetPassword() async {
    setState(() => _submitting = true);
    try {
      final res =
          await ref.read(adminFunctionsProvider).resetUserPassword(widget.uid!);
      if (!mounted) return;
      await _showResetLinkDialog(res['resetLink']?.toString() ?? '');
    } catch (e) {
      if (mounted) AppSnackbar.showFailure(context, e as Failure);
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }

  Future<void> _showResetLinkDialog(String resetLink) {
    return showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Пользователь создан'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Ссылка для установки пароля отправлена на email. '
              'Её также можно скопировать ниже:',
            ),
            AppSpacing.gapMd,
            SelectableText(
              resetLink.isEmpty ? '—' : resetLink,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
        actions: [
          FilledButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Готово'),
          ),
        ],
      ),
    );
  }
}
