// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'firebase_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$firebaseAuthHash() => r'c8e57c3e164ad1c2cad48c4508e47f6097e350a7';

/// Инстансы Firebase отдаются через провайдеры, а не через глобальные
/// синглтоны (`FirebaseXxx.instance`) напрямую в коде фич. Это:
///   * упрощает тесты (override провайдера на фейк/эмулятор);
///   * даёт единую точку подключения эмуляторов (шаг 3);
///   * соответствует правилу «доступ к данным только через провайдеры».
///
/// Copied from [firebaseAuth].
@ProviderFor(firebaseAuth)
final firebaseAuthProvider = Provider<FirebaseAuth>.internal(
  firebaseAuth,
  name: r'firebaseAuthProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$firebaseAuthHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef FirebaseAuthRef = ProviderRef<FirebaseAuth>;
String _$firestoreHash() => r'4963ca786eb54685cef6453544040c7567e77c0f';

/// See also [firestore].
@ProviderFor(firestore)
final firestoreProvider = Provider<FirebaseFirestore>.internal(
  firestore,
  name: r'firestoreProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$firestoreHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef FirestoreRef = ProviderRef<FirebaseFirestore>;
String _$firebaseStorageHash() => r'9b239ccbfd0ef129cc8465924f751c6af8cb3563';

/// See also [firebaseStorage].
@ProviderFor(firebaseStorage)
final firebaseStorageProvider = Provider<FirebaseStorage>.internal(
  firebaseStorage,
  name: r'firebaseStorageProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$firebaseStorageHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef FirebaseStorageRef = ProviderRef<FirebaseStorage>;
String _$firebaseFunctionsHash() => r'2ebd0ceeffc2947a5636ac8869c9531edc3d053d';

/// See also [firebaseFunctions].
@ProviderFor(firebaseFunctions)
final firebaseFunctionsProvider = Provider<FirebaseFunctions>.internal(
  firebaseFunctions,
  name: r'firebaseFunctionsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$firebaseFunctionsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef FirebaseFunctionsRef = ProviderRef<FirebaseFunctions>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
