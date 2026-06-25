// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$authRepositoryHash() => r'b893eeb3490ad2c8d05abbc8d4c0c8990aab0243';

/// See also [authRepository].
@ProviderFor(authRepository)
final authRepositoryProvider = Provider<AuthRepository>.internal(
  authRepository,
  name: r'authRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$authRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AuthRepositoryRef = ProviderRef<AuthRepository>;
String _$authStateHash() => r'b95c14ac596ef569669af5c98963017db58dcd9e';

/// Источник истины авторизации — поток `authStateChanges()`.
/// На него реагируют роутер (redirect, шаг 8) и UI.
///
/// Copied from [authState].
@ProviderFor(authState)
final authStateProvider = StreamProvider<User?>.internal(
  authState,
  name: r'authStateProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$authStateHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AuthStateRef = StreamProviderRef<User?>;
String _$appUserHash() => r'56030adc99a9292fc3d2d04bfbc153f41e3ee0bf';

/// Текущий пользователь (системный документ `users`) по авторизации.
/// Вход для ролевых редиректов (шаг 8).
///
/// Copied from [appUser].
@ProviderFor(appUser)
final appUserProvider = StreamProvider<AppUser?>.internal(
  appUser,
  name: r'appUserProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$appUserHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AppUserRef = StreamProviderRef<AppUser?>;
String _$appProfileHash() => r'a0142a8a83458479352983dfb0f3e555a6f6eeb9';

/// Текущий профиль (редактируемые данные) по авторизации.
///
/// Copied from [appProfile].
@ProviderFor(appProfile)
final appProfileProvider = StreamProvider<UserProfile?>.internal(
  appProfile,
  name: r'appProfileProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$appProfileHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AppProfileRef = StreamProviderRef<UserProfile?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
