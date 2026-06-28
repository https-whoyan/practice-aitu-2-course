import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/error/error_mapper.dart';
import '../../../firebase/firebase_providers.dart';

part 'avatar_storage_service.g.dart';

/// Загрузка аватара пользователя в Firebase Storage (ТЗ §5.2, P1-9).
///
/// Путь `avatars/<uid>/<fileName>` совпадает со Storage Rules: владелец пишет
/// свой аватар, читают авторизованные. `contentType` обязан быть image/* —
/// иначе правило `safeType` отклонит загрузку.
class AvatarStorageService {
  AvatarStorageService(this._storage);

  final FirebaseStorage _storage;

  Future<String> uploadAvatar({
    required String uid,
    required String fileName,
    required Uint8List bytes,
    required String contentType,
  }) async {
    try {
      final ref = _storage.ref('avatars/$uid/$fileName');
      await ref.putData(bytes, SettableMetadata(contentType: contentType));
      return await ref.getDownloadURL();
    } catch (error, stackTrace) {
      throw mapErrorToFailure(error, stackTrace);
    }
  }
}

@Riverpod(keepAlive: true)
AvatarStorageService avatarStorageService(Ref ref) =>
    AvatarStorageService(ref.watch(firebaseStorageProvider));
