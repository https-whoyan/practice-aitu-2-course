// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'role_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$currentRoleHash() => r'89b93b2569e406778b3324af6022dcdffb8e4a4c';

/// Текущая роль пользователя. Источник истины — `users.role` (через
/// [appUserProvider]). Серверная проверка — Security Rules (шаг 8).
///
/// Copied from [currentRole].
@ProviderFor(currentRole)
final currentRoleProvider = AutoDisposeProvider<UserRole?>.internal(
  currentRole,
  name: r'currentRoleProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$currentRoleHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CurrentRoleRef = AutoDisposeProviderRef<UserRole?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
