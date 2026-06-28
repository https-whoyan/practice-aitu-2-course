// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_user_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$adminUserRepositoryHash() =>
    r'cdd246ad10702e46c11847ec060378d6093d193f';

/// Репозиторий чтения пользователей для админки.
///
/// Copied from [adminUserRepository].
@ProviderFor(adminUserRepository)
final adminUserRepositoryProvider = Provider<AdminUserRepository>.internal(
  adminUserRepository,
  name: r'adminUserRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$adminUserRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AdminUserRepositoryRef = ProviderRef<AdminUserRepository>;
String _$adminUsersByRoleHash() => r'dc8f7dbcee5b7f421d28cfcfa269be4a233eeb8d';

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

/// Отдельные списки преподавателей/студентов (роль фиксирована маршрутом).
///
/// Copied from [adminUsersByRole].
@ProviderFor(adminUsersByRole)
const adminUsersByRoleProvider = AdminUsersByRoleFamily();

/// Отдельные списки преподавателей/студентов (роль фиксирована маршрутом).
///
/// Copied from [adminUsersByRole].
class AdminUsersByRoleFamily extends Family<AsyncValue<List<AdminUserRow>>> {
  /// Отдельные списки преподавателей/студентов (роль фиксирована маршрутом).
  ///
  /// Copied from [adminUsersByRole].
  const AdminUsersByRoleFamily();

  /// Отдельные списки преподавателей/студентов (роль фиксирована маршрутом).
  ///
  /// Copied from [adminUsersByRole].
  AdminUsersByRoleProvider call(UserRole role) {
    return AdminUsersByRoleProvider(role);
  }

  @override
  AdminUsersByRoleProvider getProviderOverride(
    covariant AdminUsersByRoleProvider provider,
  ) {
    return call(provider.role);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'adminUsersByRoleProvider';
}

/// Отдельные списки преподавателей/студентов (роль фиксирована маршрутом).
///
/// Copied from [adminUsersByRole].
class AdminUsersByRoleProvider
    extends AutoDisposeFutureProvider<List<AdminUserRow>> {
  /// Отдельные списки преподавателей/студентов (роль фиксирована маршрутом).
  ///
  /// Copied from [adminUsersByRole].
  AdminUsersByRoleProvider(UserRole role)
    : this._internal(
        (ref) => adminUsersByRole(ref as AdminUsersByRoleRef, role),
        from: adminUsersByRoleProvider,
        name: r'adminUsersByRoleProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$adminUsersByRoleHash,
        dependencies: AdminUsersByRoleFamily._dependencies,
        allTransitiveDependencies:
            AdminUsersByRoleFamily._allTransitiveDependencies,
        role: role,
      );

  AdminUsersByRoleProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.role,
  }) : super.internal();

  final UserRole role;

  @override
  Override overrideWith(
    FutureOr<List<AdminUserRow>> Function(AdminUsersByRoleRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: AdminUsersByRoleProvider._internal(
        (ref) => create(ref as AdminUsersByRoleRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        role: role,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<AdminUserRow>> createElement() {
    return _AdminUsersByRoleProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is AdminUsersByRoleProvider && other.role == role;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, role.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin AdminUsersByRoleRef on AutoDisposeFutureProviderRef<List<AdminUserRow>> {
  /// The parameter `role` of this provider.
  UserRole get role;
}

class _AdminUsersByRoleProviderElement
    extends AutoDisposeFutureProviderElement<List<AdminUserRow>>
    with AdminUsersByRoleRef {
  _AdminUsersByRoleProviderElement(super.provider);

  @override
  UserRole get role => (origin as AdminUsersByRoleProvider).role;
}

String _$adminUserByIdHash() => r'8da2fe4560c9b67192e8fc63a71c5efdd8cc020a';

/// Карточка одного пользователя (user + profile).
///
/// Copied from [adminUserById].
@ProviderFor(adminUserById)
const adminUserByIdProvider = AdminUserByIdFamily();

/// Карточка одного пользователя (user + profile).
///
/// Copied from [adminUserById].
class AdminUserByIdFamily extends Family<AsyncValue<AdminUserRow?>> {
  /// Карточка одного пользователя (user + profile).
  ///
  /// Copied from [adminUserById].
  const AdminUserByIdFamily();

  /// Карточка одного пользователя (user + profile).
  ///
  /// Copied from [adminUserById].
  AdminUserByIdProvider call(String uid) {
    return AdminUserByIdProvider(uid);
  }

  @override
  AdminUserByIdProvider getProviderOverride(
    covariant AdminUserByIdProvider provider,
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
  String? get name => r'adminUserByIdProvider';
}

/// Карточка одного пользователя (user + profile).
///
/// Copied from [adminUserById].
class AdminUserByIdProvider extends AutoDisposeStreamProvider<AdminUserRow?> {
  /// Карточка одного пользователя (user + profile).
  ///
  /// Copied from [adminUserById].
  AdminUserByIdProvider(String uid)
    : this._internal(
        (ref) => adminUserById(ref as AdminUserByIdRef, uid),
        from: adminUserByIdProvider,
        name: r'adminUserByIdProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$adminUserByIdHash,
        dependencies: AdminUserByIdFamily._dependencies,
        allTransitiveDependencies:
            AdminUserByIdFamily._allTransitiveDependencies,
        uid: uid,
      );

  AdminUserByIdProvider._internal(
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
    Stream<AdminUserRow?> Function(AdminUserByIdRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: AdminUserByIdProvider._internal(
        (ref) => create(ref as AdminUserByIdRef),
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
  AutoDisposeStreamProviderElement<AdminUserRow?> createElement() {
    return _AdminUserByIdProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is AdminUserByIdProvider && other.uid == uid;
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
mixin AdminUserByIdRef on AutoDisposeStreamProviderRef<AdminUserRow?> {
  /// The parameter `uid` of this provider.
  String get uid;
}

class _AdminUserByIdProviderElement
    extends AutoDisposeStreamProviderElement<AdminUserRow?>
    with AdminUserByIdRef {
  _AdminUserByIdProviderElement(super.provider);

  @override
  String get uid => (origin as AdminUserByIdProvider).uid;
}

String _$adminUserFiltersControllerHash() =>
    r'46fab11519a21ae82c460eee117e37c3cb96a1a8';

/// Состояние фильтров/поиска списка пользователей.
///
/// Copied from [AdminUserFiltersController].
@ProviderFor(AdminUserFiltersController)
final adminUserFiltersControllerProvider =
    AutoDisposeNotifierProvider<
      AdminUserFiltersController,
      AdminUserFilters
    >.internal(
      AdminUserFiltersController.new,
      name: r'adminUserFiltersControllerProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$adminUserFiltersControllerHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$AdminUserFiltersController = AutoDisposeNotifier<AdminUserFilters>;
String _$adminUsersControllerHash() =>
    r'fc96264cb48b2c5d1b5b74613760a0a01a74ce2f';

/// Постраничный список пользователей с фильтрами и подгрузкой «ещё» (ТЗ §10).
///
/// Copied from [AdminUsersController].
@ProviderFor(AdminUsersController)
final adminUsersControllerProvider =
    AutoDisposeAsyncNotifierProvider<
      AdminUsersController,
      List<AdminUserRow>
    >.internal(
      AdminUsersController.new,
      name: r'adminUsersControllerProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$adminUsersControllerHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$AdminUsersController = AutoDisposeAsyncNotifier<List<AdminUserRow>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
