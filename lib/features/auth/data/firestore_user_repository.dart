import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../core/error/error_mapper.dart';
import '../domain/app_user.dart';
import '../domain/user_profile.dart';
import '../domain/user_repository.dart';

/// Реализация [UserRepository] поверх Firestore.
///
/// Типобезопасный доступ через `withConverter`; `uid` хранится как id документа
/// и инжектится в модель при чтении (в самом документе не дублируется).
/// Все ошибки маппятся в `Failure` (шаг 4).
class FirestoreUserRepository implements UserRepository {
  FirestoreUserRepository(this._db);

  final FirebaseFirestore _db;

  CollectionReference<AppUser> get _users =>
      _db.collection('users').withConverter<AppUser>(
            fromFirestore: (snap, _) =>
                AppUser.fromJson({...?snap.data(), 'uid': snap.id}),
            toFirestore: (user, _) => user.toJson()..remove('uid'),
          );

  CollectionReference<UserProfile> get _profiles =>
      _db.collection('profiles').withConverter<UserProfile>(
            fromFirestore: (snap, _) =>
                UserProfile.fromJson({...?snap.data(), 'uid': snap.id}),
            toFirestore: (profile, _) => profile.toJson()..remove('uid'),
          );

  @override
  Stream<AppUser?> watchUser(String uid) =>
      _users.doc(uid).snapshots().map((snap) => snap.data());

  @override
  Future<AppUser?> getUser(String uid) async {
    try {
      final snap = await _users.doc(uid).get();
      return snap.data();
    } catch (error, stackTrace) {
      throw mapErrorToFailure(error, stackTrace);
    }
  }

  @override
  Stream<UserProfile?> watchProfile(String uid) =>
      _profiles.doc(uid).snapshots().map((snap) => snap.data());

  @override
  Future<void> createUserWithProfile({
    required AppUser user,
    required UserProfile profile,
  }) async {
    try {
      final batch = _db.batch();
      batch.set(_users.doc(user.uid), user);
      batch.set(_profiles.doc(profile.uid), profile);
      await batch.commit();
    } catch (error, stackTrace) {
      throw mapErrorToFailure(error, stackTrace);
    }
  }

  @override
  Future<void> updateProfile(UserProfile profile) async {
    try {
      await _profiles.doc(profile.uid).set(
            profile.copyWith(updatedAt: DateTime.now()),
            SetOptions(merge: true),
          );
    } catch (error, stackTrace) {
      throw mapErrorToFailure(error, stackTrace);
    }
  }

  @override
  Future<void> updateLastLogin(String uid) async {
    try {
      await _db.collection('users').doc(uid).update({
        'lastLoginAt': FieldValue.serverTimestamp(),
      });
    } catch (error, stackTrace) {
      throw mapErrorToFailure(error, stackTrace);
    }
  }
}
