// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$userRepositoryHash() => r'5eb09d94753deef6e53f9358623faf8bc8263a6f';

/// Репозиторий пользователя поверх `firestoreProvider` (шаг 2).
///
/// Copied from [userRepository].
@ProviderFor(userRepository)
final userRepositoryProvider = Provider<UserRepository>.internal(
  userRepository,
  name: r'userRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$userRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef UserRepositoryRef = ProviderRef<UserRepository>;
String _$userStreamHash() => r'c0f4a4399eeb75051bddf6f3d0ec301f7b6b1fd3';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// Стрим документа пользователя по `uid`.
/// «Текущий» пользователь (по авторизации) собирается в шаге 7 (`appUserProvider`).
///
/// Copied from [userStream].
@ProviderFor(userStream)
const userStreamProvider = UserStreamFamily();

/// Стрим документа пользователя по `uid`.
/// «Текущий» пользователь (по авторизации) собирается в шаге 7 (`appUserProvider`).
///
/// Copied from [userStream].
class UserStreamFamily extends Family<AsyncValue<AppUser?>> {
  /// Стрим документа пользователя по `uid`.
  /// «Текущий» пользователь (по авторизации) собирается в шаге 7 (`appUserProvider`).
  ///
  /// Copied from [userStream].
  const UserStreamFamily();

  /// Стрим документа пользователя по `uid`.
  /// «Текущий» пользователь (по авторизации) собирается в шаге 7 (`appUserProvider`).
  ///
  /// Copied from [userStream].
  UserStreamProvider call(String uid) {
    return UserStreamProvider(uid);
  }

  @override
  UserStreamProvider getProviderOverride(
    covariant UserStreamProvider provider,
  ) {
    return call(provider.uid);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'userStreamProvider';
}

/// Стрим документа пользователя по `uid`.
/// «Текущий» пользователь (по авторизации) собирается в шаге 7 (`appUserProvider`).
///
/// Copied from [userStream].
class UserStreamProvider extends AutoDisposeStreamProvider<AppUser?> {
  /// Стрим документа пользователя по `uid`.
  /// «Текущий» пользователь (по авторизации) собирается в шаге 7 (`appUserProvider`).
  ///
  /// Copied from [userStream].
  UserStreamProvider(String uid)
    : this._internal(
        (ref) => userStream(ref as UserStreamRef, uid),
        from: userStreamProvider,
        name: r'userStreamProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$userStreamHash,
        dependencies: UserStreamFamily._dependencies,
        allTransitiveDependencies: UserStreamFamily._allTransitiveDependencies,
        uid: uid,
      );

  UserStreamProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.uid,
  }) : super.internal();

  final String uid;

  @override
  Override overrideWith(
    Stream<AppUser?> Function(UserStreamRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: UserStreamProvider._internal(
        (ref) => create(ref as UserStreamRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        uid: uid,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<AppUser?> createElement() {
    return _UserStreamProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is UserStreamProvider && other.uid == uid;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, uid.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin UserStreamRef on AutoDisposeStreamProviderRef<AppUser?> {
  /// The parameter `uid` of this provider.
  String get uid;
}

class _UserStreamProviderElement
    extends AutoDisposeStreamProviderElement<AppUser?>
    with UserStreamRef {
  _UserStreamProviderElement(super.provider);

  @override
  String get uid => (origin as UserStreamProvider).uid;
}

String _$profileStreamHash() => r'fd1d139537b9fb330e93827d2d85cae4bd54add7';

/// Стрим профиля по `uid`.
///
/// Copied from [profileStream].
@ProviderFor(profileStream)
const profileStreamProvider = ProfileStreamFamily();

/// Стрим профиля по `uid`.
///
/// Copied from [profileStream].
class ProfileStreamFamily extends Family<AsyncValue<UserProfile?>> {
  /// Стрим профиля по `uid`.
  ///
  /// Copied from [profileStream].
  const ProfileStreamFamily();

  /// Стрим профиля по `uid`.
  ///
  /// Copied from [profileStream].
  ProfileStreamProvider call(String uid) {
    return ProfileStreamProvider(uid);
  }

  @override
  ProfileStreamProvider getProviderOverride(
    covariant ProfileStreamProvider provider,
  ) {
    return call(provider.uid);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'profileStreamProvider';
}

/// Стрим профиля по `uid`.
///
/// Copied from [profileStream].
class ProfileStreamProvider extends AutoDisposeStreamProvider<UserProfile?> {
  /// Стрим профиля по `uid`.
  ///
  /// Copied from [profileStream].
  ProfileStreamProvider(String uid)
    : this._internal(
        (ref) => profileStream(ref as ProfileStreamRef, uid),
        from: profileStreamProvider,
        name: r'profileStreamProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$profileStreamHash,
        dependencies: ProfileStreamFamily._dependencies,
        allTransitiveDependencies:
            ProfileStreamFamily._allTransitiveDependencies,
        uid: uid,
      );

  ProfileStreamProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.uid,
  }) : super.internal();

  final String uid;

  @override
  Override overrideWith(
    Stream<UserProfile?> Function(ProfileStreamRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ProfileStreamProvider._internal(
        (ref) => create(ref as ProfileStreamRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        uid: uid,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<UserProfile?> createElement() {
    return _ProfileStreamProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ProfileStreamProvider && other.uid == uid;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, uid.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ProfileStreamRef on AutoDisposeStreamProviderRef<UserProfile?> {
  /// The parameter `uid` of this provider.
  String get uid;
}

class _ProfileStreamProviderElement
    extends AutoDisposeStreamProviderElement<UserProfile?>
    with ProfileStreamRef {
  _ProfileStreamProviderElement(super.provider);

  @override
  String get uid => (origin as ProfileStreamProvider).uid;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
