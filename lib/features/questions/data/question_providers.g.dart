// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$questionRepositoryHash() =>
    r'9566b7a89b986e874e37ec13b01a88c16a7eb6f3';

/// Репозиторий банка вопросов.
///
/// Copied from [questionRepository].
@ProviderFor(questionRepository)
final questionRepositoryProvider = Provider<QuestionRepository>.internal(
  questionRepository,
  name: r'questionRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$questionRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef QuestionRepositoryRef = ProviderRef<QuestionRepository>;
String _$questionListHash() => r'2e27ff350cd67e3766c5ace7def912d2e28711e3';

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

/// Все вопросы преподавателя (новые сверху).
///
/// Copied from [questionList].
@ProviderFor(questionList)
const questionListProvider = QuestionListFamily();

/// Все вопросы преподавателя (новые сверху).
///
/// Copied from [questionList].
class QuestionListFamily extends Family<AsyncValue<List<Question>>> {
  /// Все вопросы преподавателя (новые сверху).
  ///
  /// Copied from [questionList].
  const QuestionListFamily();

  /// Все вопросы преподавателя (новые сверху).
  ///
  /// Copied from [questionList].
  QuestionListProvider call(String ownerTeacherId) {
    return QuestionListProvider(ownerTeacherId);
  }

  @override
  QuestionListProvider getProviderOverride(
    covariant QuestionListProvider provider,
  ) {
    return call(provider.ownerTeacherId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'questionListProvider';
}

/// Все вопросы преподавателя (новые сверху).
///
/// Copied from [questionList].
class QuestionListProvider extends AutoDisposeStreamProvider<List<Question>> {
  /// Все вопросы преподавателя (новые сверху).
  ///
  /// Copied from [questionList].
  QuestionListProvider(String ownerTeacherId)
    : this._internal(
        (ref) => questionList(ref as QuestionListRef, ownerTeacherId),
        from: questionListProvider,
        name: r'questionListProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$questionListHash,
        dependencies: QuestionListFamily._dependencies,
        allTransitiveDependencies:
            QuestionListFamily._allTransitiveDependencies,
        ownerTeacherId: ownerTeacherId,
      );

  QuestionListProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.ownerTeacherId,
  }) : super.internal();

  final String ownerTeacherId;

  @override
  Override overrideWith(
    Stream<List<Question>> Function(QuestionListRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: QuestionListProvider._internal(
        (ref) => create(ref as QuestionListRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        ownerTeacherId: ownerTeacherId,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<List<Question>> createElement() {
    return _QuestionListProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is QuestionListProvider &&
        other.ownerTeacherId == ownerTeacherId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, ownerTeacherId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin QuestionListRef on AutoDisposeStreamProviderRef<List<Question>> {
  /// The parameter `ownerTeacherId` of this provider.
  String get ownerTeacherId;
}

class _QuestionListProviderElement
    extends AutoDisposeStreamProviderElement<List<Question>>
    with QuestionListRef {
  _QuestionListProviderElement(super.provider);

  @override
  String get ownerTeacherId => (origin as QuestionListProvider).ownerTeacherId;
}

String _$questionByIdHash() => r'6421e389b0625a3f06c3012d68c833e6c5ca7c88';

/// Один вопрос по id (форма редактирования).
///
/// Copied from [questionById].
@ProviderFor(questionById)
const questionByIdProvider = QuestionByIdFamily();

/// Один вопрос по id (форма редактирования).
///
/// Copied from [questionById].
class QuestionByIdFamily extends Family<AsyncValue<Question?>> {
  /// Один вопрос по id (форма редактирования).
  ///
  /// Copied from [questionById].
  const QuestionByIdFamily();

  /// Один вопрос по id (форма редактирования).
  ///
  /// Copied from [questionById].
  QuestionByIdProvider call(String id) {
    return QuestionByIdProvider(id);
  }

  @override
  QuestionByIdProvider getProviderOverride(
    covariant QuestionByIdProvider provider,
  ) {
    return call(provider.id);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'questionByIdProvider';
}

/// Один вопрос по id (форма редактирования).
///
/// Copied from [questionById].
class QuestionByIdProvider extends AutoDisposeFutureProvider<Question?> {
  /// Один вопрос по id (форма редактирования).
  ///
  /// Copied from [questionById].
  QuestionByIdProvider(String id)
    : this._internal(
        (ref) => questionById(ref as QuestionByIdRef, id),
        from: questionByIdProvider,
        name: r'questionByIdProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$questionByIdHash,
        dependencies: QuestionByIdFamily._dependencies,
        allTransitiveDependencies:
            QuestionByIdFamily._allTransitiveDependencies,
        id: id,
      );

  QuestionByIdProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
  }) : super.internal();

  final String id;

  @override
  Override overrideWith(
    FutureOr<Question?> Function(QuestionByIdRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: QuestionByIdProvider._internal(
        (ref) => create(ref as QuestionByIdRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Question?> createElement() {
    return _QuestionByIdProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is QuestionByIdProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin QuestionByIdRef on AutoDisposeFutureProviderRef<Question?> {
  /// The parameter `id` of this provider.
  String get id;
}

class _QuestionByIdProviderElement
    extends AutoDisposeFutureProviderElement<Question?>
    with QuestionByIdRef {
  _QuestionByIdProviderElement(super.provider);

  @override
  String get id => (origin as QuestionByIdProvider).id;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
