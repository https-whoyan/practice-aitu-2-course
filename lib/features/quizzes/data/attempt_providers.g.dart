// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attempt_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$quizAttemptRepositoryHash() =>
    r'20204b99fc2abebcf3a9c8cabd554103a1d9b9b7';

/// Репозиторий попыток прохождения квиза (шаги 23–24).
///
/// Copied from [quizAttemptRepository].
@ProviderFor(quizAttemptRepository)
final quizAttemptRepositoryProvider = Provider<QuizAttemptRepository>.internal(
  quizAttemptRepository,
  name: r'quizAttemptRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$quizAttemptRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef QuizAttemptRepositoryRef = ProviderRef<QuizAttemptRepository>;
String _$attemptByIdHash() => r'acaba1c961741f6c3e81d688d8e01cd64e0e8250';

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

/// Одна попытка по id (экран прохождения/результата).
///
/// Copied from [attemptById].
@ProviderFor(attemptById)
const attemptByIdProvider = AttemptByIdFamily();

/// Одна попытка по id (экран прохождения/результата).
///
/// Copied from [attemptById].
class AttemptByIdFamily extends Family<AsyncValue<QuizAttempt?>> {
  /// Одна попытка по id (экран прохождения/результата).
  ///
  /// Copied from [attemptById].
  const AttemptByIdFamily();

  /// Одна попытка по id (экран прохождения/результата).
  ///
  /// Copied from [attemptById].
  AttemptByIdProvider call(String attemptId) {
    return AttemptByIdProvider(attemptId);
  }

  @override
  AttemptByIdProvider getProviderOverride(
    covariant AttemptByIdProvider provider,
  ) {
    return call(provider.attemptId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'attemptByIdProvider';
}

/// Одна попытка по id (экран прохождения/результата).
///
/// Copied from [attemptById].
class AttemptByIdProvider extends AutoDisposeStreamProvider<QuizAttempt?> {
  /// Одна попытка по id (экран прохождения/результата).
  ///
  /// Copied from [attemptById].
  AttemptByIdProvider(String attemptId)
    : this._internal(
        (ref) => attemptById(ref as AttemptByIdRef, attemptId),
        from: attemptByIdProvider,
        name: r'attemptByIdProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$attemptByIdHash,
        dependencies: AttemptByIdFamily._dependencies,
        allTransitiveDependencies: AttemptByIdFamily._allTransitiveDependencies,
        attemptId: attemptId,
      );

  AttemptByIdProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.attemptId,
  }) : super.internal();

  final String attemptId;

  @override
  Override overrideWith(
    Stream<QuizAttempt?> Function(AttemptByIdRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: AttemptByIdProvider._internal(
        (ref) => create(ref as AttemptByIdRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        attemptId: attemptId,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<QuizAttempt?> createElement() {
    return _AttemptByIdProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is AttemptByIdProvider && other.attemptId == attemptId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, attemptId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin AttemptByIdRef on AutoDisposeStreamProviderRef<QuizAttempt?> {
  /// The parameter `attemptId` of this provider.
  String get attemptId;
}

class _AttemptByIdProviderElement
    extends AutoDisposeStreamProviderElement<QuizAttempt?>
    with AttemptByIdRef {
  _AttemptByIdProviderElement(super.provider);

  @override
  String get attemptId => (origin as AttemptByIdProvider).attemptId;
}

String _$activeAttemptHash() => r'16471a9533f5b45bf38e059ecc3665dbd0120e4b';

/// Активная (незавершённая) попытка текущего студента по квизу.
///
/// Copied from [activeAttempt].
@ProviderFor(activeAttempt)
const activeAttemptProvider = ActiveAttemptFamily();

/// Активная (незавершённая) попытка текущего студента по квизу.
///
/// Copied from [activeAttempt].
class ActiveAttemptFamily extends Family<AsyncValue<QuizAttempt?>> {
  /// Активная (незавершённая) попытка текущего студента по квизу.
  ///
  /// Copied from [activeAttempt].
  const ActiveAttemptFamily();

  /// Активная (незавершённая) попытка текущего студента по квизу.
  ///
  /// Copied from [activeAttempt].
  ActiveAttemptProvider call(String quizId) {
    return ActiveAttemptProvider(quizId);
  }

  @override
  ActiveAttemptProvider getProviderOverride(
    covariant ActiveAttemptProvider provider,
  ) {
    return call(provider.quizId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'activeAttemptProvider';
}

/// Активная (незавершённая) попытка текущего студента по квизу.
///
/// Copied from [activeAttempt].
class ActiveAttemptProvider extends AutoDisposeStreamProvider<QuizAttempt?> {
  /// Активная (незавершённая) попытка текущего студента по квизу.
  ///
  /// Copied from [activeAttempt].
  ActiveAttemptProvider(String quizId)
    : this._internal(
        (ref) => activeAttempt(ref as ActiveAttemptRef, quizId),
        from: activeAttemptProvider,
        name: r'activeAttemptProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$activeAttemptHash,
        dependencies: ActiveAttemptFamily._dependencies,
        allTransitiveDependencies:
            ActiveAttemptFamily._allTransitiveDependencies,
        quizId: quizId,
      );

  ActiveAttemptProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.quizId,
  }) : super.internal();

  final String quizId;

  @override
  Override overrideWith(
    Stream<QuizAttempt?> Function(ActiveAttemptRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ActiveAttemptProvider._internal(
        (ref) => create(ref as ActiveAttemptRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        quizId: quizId,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<QuizAttempt?> createElement() {
    return _ActiveAttemptProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ActiveAttemptProvider && other.quizId == quizId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, quizId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ActiveAttemptRef on AutoDisposeStreamProviderRef<QuizAttempt?> {
  /// The parameter `quizId` of this provider.
  String get quizId;
}

class _ActiveAttemptProviderElement
    extends AutoDisposeStreamProviderElement<QuizAttempt?>
    with ActiveAttemptRef {
  _ActiveAttemptProviderElement(super.provider);

  @override
  String get quizId => (origin as ActiveAttemptProvider).quizId;
}

String _$myAttemptsHash() => r'2d4df217f047492e4fdba159754f702b91113be3';

/// История попыток текущего студента по квизу.
///
/// Copied from [myAttempts].
@ProviderFor(myAttempts)
const myAttemptsProvider = MyAttemptsFamily();

/// История попыток текущего студента по квизу.
///
/// Copied from [myAttempts].
class MyAttemptsFamily extends Family<AsyncValue<List<QuizAttempt>>> {
  /// История попыток текущего студента по квизу.
  ///
  /// Copied from [myAttempts].
  const MyAttemptsFamily();

  /// История попыток текущего студента по квизу.
  ///
  /// Copied from [myAttempts].
  MyAttemptsProvider call(String quizId) {
    return MyAttemptsProvider(quizId);
  }

  @override
  MyAttemptsProvider getProviderOverride(
    covariant MyAttemptsProvider provider,
  ) {
    return call(provider.quizId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'myAttemptsProvider';
}

/// История попыток текущего студента по квизу.
///
/// Copied from [myAttempts].
class MyAttemptsProvider extends AutoDisposeStreamProvider<List<QuizAttempt>> {
  /// История попыток текущего студента по квизу.
  ///
  /// Copied from [myAttempts].
  MyAttemptsProvider(String quizId)
    : this._internal(
        (ref) => myAttempts(ref as MyAttemptsRef, quizId),
        from: myAttemptsProvider,
        name: r'myAttemptsProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$myAttemptsHash,
        dependencies: MyAttemptsFamily._dependencies,
        allTransitiveDependencies: MyAttemptsFamily._allTransitiveDependencies,
        quizId: quizId,
      );

  MyAttemptsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.quizId,
  }) : super.internal();

  final String quizId;

  @override
  Override overrideWith(
    Stream<List<QuizAttempt>> Function(MyAttemptsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: MyAttemptsProvider._internal(
        (ref) => create(ref as MyAttemptsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        quizId: quizId,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<List<QuizAttempt>> createElement() {
    return _MyAttemptsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is MyAttemptsProvider && other.quizId == quizId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, quizId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin MyAttemptsRef on AutoDisposeStreamProviderRef<List<QuizAttempt>> {
  /// The parameter `quizId` of this provider.
  String get quizId;
}

class _MyAttemptsProviderElement
    extends AutoDisposeStreamProviderElement<List<QuizAttempt>>
    with MyAttemptsRef {
  _MyAttemptsProviderElement(super.provider);

  @override
  String get quizId => (origin as MyAttemptsProvider).quizId;
}

String _$quizAllAttemptsHash() => r'c26a0929aa862132cb8b12e1fb9a2b7457f6a0b1';

/// Все попытки по квизу — экран результатов преподавателя (P2-18).
///
/// Copied from [quizAllAttempts].
@ProviderFor(quizAllAttempts)
const quizAllAttemptsProvider = QuizAllAttemptsFamily();

/// Все попытки по квизу — экран результатов преподавателя (P2-18).
///
/// Copied from [quizAllAttempts].
class QuizAllAttemptsFamily extends Family<AsyncValue<List<QuizAttempt>>> {
  /// Все попытки по квизу — экран результатов преподавателя (P2-18).
  ///
  /// Copied from [quizAllAttempts].
  const QuizAllAttemptsFamily();

  /// Все попытки по квизу — экран результатов преподавателя (P2-18).
  ///
  /// Copied from [quizAllAttempts].
  QuizAllAttemptsProvider call(String quizId) {
    return QuizAllAttemptsProvider(quizId);
  }

  @override
  QuizAllAttemptsProvider getProviderOverride(
    covariant QuizAllAttemptsProvider provider,
  ) {
    return call(provider.quizId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'quizAllAttemptsProvider';
}

/// Все попытки по квизу — экран результатов преподавателя (P2-18).
///
/// Copied from [quizAllAttempts].
class QuizAllAttemptsProvider
    extends AutoDisposeStreamProvider<List<QuizAttempt>> {
  /// Все попытки по квизу — экран результатов преподавателя (P2-18).
  ///
  /// Copied from [quizAllAttempts].
  QuizAllAttemptsProvider(String quizId)
    : this._internal(
        (ref) => quizAllAttempts(ref as QuizAllAttemptsRef, quizId),
        from: quizAllAttemptsProvider,
        name: r'quizAllAttemptsProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$quizAllAttemptsHash,
        dependencies: QuizAllAttemptsFamily._dependencies,
        allTransitiveDependencies:
            QuizAllAttemptsFamily._allTransitiveDependencies,
        quizId: quizId,
      );

  QuizAllAttemptsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.quizId,
  }) : super.internal();

  final String quizId;

  @override
  Override overrideWith(
    Stream<List<QuizAttempt>> Function(QuizAllAttemptsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: QuizAllAttemptsProvider._internal(
        (ref) => create(ref as QuizAllAttemptsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        quizId: quizId,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<List<QuizAttempt>> createElement() {
    return _QuizAllAttemptsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is QuizAllAttemptsProvider && other.quizId == quizId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, quizId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin QuizAllAttemptsRef on AutoDisposeStreamProviderRef<List<QuizAttempt>> {
  /// The parameter `quizId` of this provider.
  String get quizId;
}

class _QuizAllAttemptsProviderElement
    extends AutoDisposeStreamProviderElement<List<QuizAttempt>>
    with QuizAllAttemptsRef {
  _QuizAllAttemptsProviderElement(super.provider);

  @override
  String get quizId => (origin as QuizAllAttemptsProvider).quizId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
