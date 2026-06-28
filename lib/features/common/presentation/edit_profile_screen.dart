import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/error/failure.dart';
import '../../../shared/widgets/widgets.dart';
import '../../../theme/app_spacing.dart';
import '../../auth/data/auth_providers.dart';
import '../../auth/data/user_providers.dart';
import '../../auth/domain/user_profile.dart';
import '../data/avatar_storage_service.dart';

/// Редактирование профиля пользователя (ТЗ §5.2, P1-9).
///
/// Правит имя/фамилию/отображаемое имя и фото (через `file_picker` → Storage
/// `avatars/<uid>/...`). Системные поля (роль/статус/email) здесь не меняются —
/// они под Security Rules.
class EditProfileScreen extends ConsumerStatefulWidget {
  const EditProfileScreen({super.key});

  @override
  ConsumerState<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends ConsumerState<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _firstName = TextEditingController();
  final _lastName = TextEditingController();
  final _displayName = TextEditingController();

  bool _seeded = false;
  bool _saving = false;
  bool _uploading = false;
  String? _photoUrl;

  @override
  void dispose() {
    _firstName.dispose();
    _lastName.dispose();
    _displayName.dispose();
    super.dispose();
  }

  void _seed(UserProfile? profile) {
    if (_seeded) return;
    _seeded = true;
    if (profile == null) return;
    _firstName.text = profile.firstName;
    _lastName.text = profile.lastName;
    _displayName.text = profile.displayName ?? '';
    _photoUrl = profile.photoUrl;
  }

  Future<void> _pickPhoto(String uid) async {
    final result = await FilePicker.pickFiles(
      type: FileType.image,
      withData: true,
    );
    final file = result?.files.singleOrNull;
    final bytes = file?.bytes;
    if (file == null || bytes == null) return;
    final ext = (file.extension ?? 'jpg').toLowerCase();
    final mime = switch (ext) {
      'png' => 'image/png',
      'webp' => 'image/webp',
      'gif' => 'image/gif',
      _ => 'image/jpeg',
    };
    setState(() => _uploading = true);
    try {
      final url = await ref.read(avatarStorageServiceProvider).uploadAvatar(
            uid: uid,
            fileName: 'avatar.$ext',
            bytes: bytes,
            contentType: mime,
          );
      if (!mounted) return;
      setState(() => _photoUrl = url);
    } catch (e) {
      if (!mounted) return;
      AppSnackbar.showFailure(context, e as Failure);
    } finally {
      if (mounted) setState(() => _uploading = false);
    }
  }

  Future<void> _save(String uid, UserProfile? existing) async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    setState(() => _saving = true);
    final now = DateTime.now();
    final display = _displayName.text.trim();
    final profile = (existing ??
            UserProfile(uid: uid, createdAt: now, updatedAt: now))
        .copyWith(
      uid: uid,
      firstName: _firstName.text.trim(),
      lastName: _lastName.text.trim(),
      displayName: display.isEmpty ? null : display,
      photoUrl: _photoUrl,
      updatedAt: now,
    );
    try {
      await ref.read(userRepositoryProvider).updateProfile(profile);
      if (!mounted) return;
      AppSnackbar.show(context, 'Профиль сохранён');
      context.pop();
    } catch (e) {
      if (!mounted) return;
      AppSnackbar.showFailure(context, e as Failure);
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final uid = ref.watch(appUserProvider).valueOrNull?.uid;
    final profile = ref.watch(appProfileProvider).valueOrNull;
    if (uid == null) {
      return const AppScaffold(title: 'Профиль', body: AppLoader());
    }
    _seed(profile);

    return AppScaffold(
      title: 'Редактировать профиль',
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 44,
                    backgroundImage: (_photoUrl != null && _photoUrl!.isNotEmpty)
                        ? NetworkImage(_photoUrl!)
                        : null,
                    child: (_photoUrl == null || _photoUrl!.isEmpty)
                        ? const Icon(Icons.person, size: 44)
                        : null,
                  ),
                  AppSpacing.gapSm,
                  TextButton.icon(
                    onPressed: _uploading ? null : () => _pickPhoto(uid),
                    icon: _uploading
                        ? const SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Icon(Icons.photo_camera_outlined),
                    label: const Text('Изменить фото'),
                  ),
                ],
              ),
            ),
            AppSpacing.gapMd,
            AppTextField(
              label: 'Имя',
              controller: _firstName,
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'Введите имя' : null,
            ),
            AppSpacing.gapMd,
            AppTextField(label: 'Фамилия', controller: _lastName),
            AppSpacing.gapMd,
            AppTextField(
              label: 'Отображаемое имя (необязательно)',
              controller: _displayName,
            ),
            AppSpacing.gapXl,
            PrimaryButton(
              label: 'Сохранить',
              isLoading: _saving,
              onPressed: _saving ? null : () => _save(uid, profile),
            ),
          ],
        ),
      ),
    );
  }
}
