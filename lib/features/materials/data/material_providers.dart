import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../firebase/firebase_providers.dart';
import '../domain/material.dart';
import '../domain/material_repository.dart';
import 'firestore_material_repository.dart';

part 'material_providers.g.dart';

/// Репозиторий материалов недели.
@Riverpod(keepAlive: true)
MaterialRepository materialRepository(Ref ref) =>
    FirestoreMaterialRepository(ref.watch(firestoreProvider));

/// Все материалы недели по порядку (преподаватель).
@riverpod
Stream<List<CourseMaterial>> materials(Ref ref, String weekId) =>
    ref.watch(materialRepositoryProvider).watchMaterials(weekId);

/// Только опубликованные материалы недели (студент).
@riverpod
Stream<List<CourseMaterial>> publishedMaterials(Ref ref, String weekId) =>
    ref.watch(materialRepositoryProvider).watchPublishedMaterials(weekId);

/// Один материал по id (форма редактирования).
@riverpod
Future<CourseMaterial?> materialById(Ref ref, String materialId) =>
    ref.watch(materialRepositoryProvider).getMaterial(materialId);
