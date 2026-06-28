import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/error/error_mapper.dart';
import '../../../firebase/firebase_providers.dart';

part 'course_cover_service.g.dart';

/// Загрузка обложки курса в Firebase Storage (ТЗ §5.4.3, P2-5).
///
/// Путь `covers/<uid>/<fileName>` — загружает владелец/преподаватель, читают
/// авторизованные (Storage Rules). `contentType` обязан быть image/*.
class CourseCoverService {
  CourseCoverService(this._storage);

  final FirebaseStorage _storage;

  Future<String> uploadCover({
    required String uid,
    required String fileName,
    required Uint8List bytes,
    required String contentType,
  }) async {
    try {
      final ref = _storage.ref('covers/$uid/$fileName');
      await ref.putData(bytes, SettableMetadata(contentType: contentType));
      return await ref.getDownloadURL();
    } catch (error, stackTrace) {
      throw mapErrorToFailure(error, stackTrace);
    }
  }
}

@Riverpod(keepAlive: true)
CourseCoverService courseCoverService(Ref ref) =>
    CourseCoverService(ref.watch(firebaseStorageProvider));
