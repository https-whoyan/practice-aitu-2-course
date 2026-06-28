import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/error/error_mapper.dart';
import '../../../firebase/firebase_providers.dart';

part 'material_storage_service.g.dart';

/// Загрузка файлов материалов в Firebase Storage (ТЗ §7.6).
///
/// Путь: `materials/<courseId>/<weekId>/<uid>/<fileName>` — структура повторяет
/// иерархию курс → неделя → автор, упрощая правила доступа (шаг 27).
class MaterialStorageService {
  MaterialStorageService(this._storage);

  final FirebaseStorage _storage;

  /// Загружает байты файла и возвращает download URL.
  Future<String> uploadMaterialFile({
    required String courseId,
    required String weekId,
    required String uid,
    required String fileName,
    required Uint8List bytes,
    String? contentType,
  }) async {
    try {
      final path = 'materials/$courseId/$weekId/$uid/$fileName';
      final ref = _storage.ref(path);
      await ref.putData(bytes, SettableMetadata(contentType: contentType));
      return await ref.getDownloadURL();
    } catch (error, stackTrace) {
      throw mapErrorToFailure(error, stackTrace);
    }
  }
}

@Riverpod(keepAlive: true)
MaterialStorageService materialStorageService(Ref ref) =>
    MaterialStorageService(ref.watch(firebaseStorageProvider));
