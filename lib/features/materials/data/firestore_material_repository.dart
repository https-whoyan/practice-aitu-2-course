import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../core/error/error_mapper.dart';
import '../domain/material.dart';
import '../domain/material_repository.dart';

/// Реализация [MaterialRepository] поверх Firestore. Ошибки → `Failure`.
class FirestoreMaterialRepository implements MaterialRepository {
  FirestoreMaterialRepository(this._db);

  final FirebaseFirestore _db;

  CollectionReference<CourseMaterial> get _materials =>
      _db.collection('materials').withConverter<CourseMaterial>(
            fromFirestore: (snap, _) =>
                CourseMaterial.fromJson({...?snap.data(), 'materialId': snap.id}),
            toFirestore: (material, _) => material.toJson()..remove('materialId'),
          );

  @override
  Stream<List<CourseMaterial>> watchMaterials(String weekId) => _materials
      .where('weekId', isEqualTo: weekId)
      .orderBy('orderIndex')
      .snapshots()
      .map((s) => s.docs.map((d) => d.data()).toList())
      .mapFailures();

  @override
  Stream<List<CourseMaterial>> watchPublishedMaterials(String weekId) =>
      _materials
          .where('weekId', isEqualTo: weekId)
          .where('isPublished', isEqualTo: true)
          .orderBy('orderIndex')
          .snapshots()
          .map((s) => s.docs.map((d) => d.data()).toList())
          .mapFailures();

  @override
  Future<CourseMaterial?> getMaterial(String id) async {
    try {
      final snap = await _materials.doc(id).get();
      return snap.data();
    } catch (error, stackTrace) {
      throw mapErrorToFailure(error, stackTrace);
    }
  }

  @override
  Future<String> addMaterial(CourseMaterial m) async {
    try {
      final ref = await _materials.add(m);
      return ref.id;
    } catch (error, stackTrace) {
      throw mapErrorToFailure(error, stackTrace);
    }
  }

  @override
  Future<void> updateMaterial(CourseMaterial m) async {
    try {
      await _materials.doc(m.materialId).set(
            m.copyWith(updatedAt: DateTime.now()),
            SetOptions(merge: true),
          );
    } catch (error, stackTrace) {
      throw mapErrorToFailure(error, stackTrace);
    }
  }

  @override
  Future<void> deleteMaterial(String id) async {
    try {
      await _db.collection('materials').doc(id).delete();
    } catch (error, stackTrace) {
      throw mapErrorToFailure(error, stackTrace);
    }
  }

  @override
  Future<void> reorder(String weekId, List<String> orderedIds) async {
    try {
      final batch = _db.batch();
      for (var i = 0; i < orderedIds.length; i++) {
        batch.update(_db.collection('materials').doc(orderedIds[i]), {
          'orderIndex': i,
          'updatedAt': FieldValue.serverTimestamp(),
        });
      }
      await batch.commit();
    } catch (error, stackTrace) {
      throw mapErrorToFailure(error, stackTrace);
    }
  }

  @override
  Future<void> setPublished(String id, bool value) async {
    try {
      await _db.collection('materials').doc(id).update({
        'isPublished': value,
        'updatedAt': FieldValue.serverTimestamp(),
      });
    } catch (error, stackTrace) {
      throw mapErrorToFailure(error, stackTrace);
    }
  }
}
