// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'example_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$exampleRepositoryHash() => r'8675f76386e4397c655f5380029f005410c0d518';

/// See also [exampleRepository].
@ProviderFor(exampleRepository)
final exampleRepositoryProvider =
    AutoDisposeProvider<ExampleRepository>.internal(
      exampleRepository,
      name: r'exampleRepositoryProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$exampleRepositoryHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ExampleRepositoryRef = AutoDisposeProviderRef<ExampleRepository>;
String _$examplePingHash() => r'7c4013346d5dfbfdc68e400be050cfd0d3d8d52c';

/// Демонстрирует обработку ошибок: исключение → [Failure] → `AsyncValue.error`.
///
/// Copied from [examplePing].
@ProviderFor(examplePing)
final examplePingProvider = AutoDisposeFutureProvider<String>.internal(
  examplePing,
  name: r'examplePingProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$examplePingHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ExamplePingRef = AutoDisposeFutureProviderRef<String>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
