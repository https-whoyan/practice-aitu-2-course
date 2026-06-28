// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quiz_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$quizRepositoryHash() => r'72f2c4ea66ba1d648cda8f7e5b9935c916dbfd64';

/// Репозиторий квизов (общий для конструктора и прохождения).
///
/// Copied from [quizRepository].
@ProviderFor(quizRepository)
final quizRepositoryProvider = Provider<QuizRepository>.internal(
  quizRepository,
  name: r'quizRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$quizRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef QuizRepositoryRef = ProviderRef<QuizRepository>;
String _$courseQuizzesHash() => r'49492e9679972ec3d15e4b8c553550f9905cb08a';

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

/// Все квизы курса (преподаватель, конструктор — шаг 22).
///
/// Copied from [courseQuizzes].
@ProviderFor(courseQuizzes)
const courseQuizzesProvider = CourseQuizzesFamily();

/// Все квизы курса (преподаватель, конструктор — шаг 22).
///
/// Copied from [courseQuizzes].
class CourseQuizzesFamily extends Family<AsyncValue<List<Quiz>>> {
  /// Все квизы курса (преподаватель, конструктор — шаг 22).
  ///
  /// Copied from [courseQuizzes].
  const CourseQuizzesFamily();

  /// Все квизы курса (преподаватель, конструктор — шаг 22).
  ///
  /// Copied from [courseQuizzes].
  CourseQuizzesProvider call(String courseId) {
    return CourseQuizzesProvider(courseId);
  }

  @override
  CourseQuizzesProvider getProviderOverride(
    covariant CourseQuizzesProvider provider,
  ) {
    return call(provider.courseId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'courseQuizzesProvider';
}

/// Все квизы курса (преподаватель, конструктор — шаг 22).
///
/// Copied from [courseQuizzes].
class CourseQuizzesProvider extends AutoDisposeStreamProvider<List<Quiz>> {
  /// Все квизы курса (преподаватель, конструктор — шаг 22).
  ///
  /// Copied from [courseQuizzes].
  CourseQuizzesProvider(String courseId)
    : this._internal(
        (ref) => courseQuizzes(ref as CourseQuizzesRef, courseId),
        from: courseQuizzesProvider,
        name: r'courseQuizzesProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$courseQuizzesHash,
        dependencies: CourseQuizzesFamily._dependencies,
        allTransitiveDependencies:
            CourseQuizzesFamily._allTransitiveDependencies,
        courseId: courseId,
      );

  CourseQuizzesProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.courseId,
  }) : super.internal();

  final String courseId;

  @override
  Override overrideWith(
    Stream<List<Quiz>> Function(CourseQuizzesRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: CourseQuizzesProvider._internal(
        (ref) => create(ref as CourseQuizzesRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        courseId: courseId,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<List<Quiz>> createElement() {
    return _CourseQuizzesProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CourseQuizzesProvider && other.courseId == courseId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, courseId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin CourseQuizzesRef on AutoDisposeStreamProviderRef<List<Quiz>> {
  /// The parameter `courseId` of this provider.
  String get courseId;
}

class _CourseQuizzesProviderElement
    extends AutoDisposeStreamProviderElement<List<Quiz>>
    with CourseQuizzesRef {
  _CourseQuizzesProviderElement(super.provider);

  @override
  String get courseId => (origin as CourseQuizzesProvider).courseId;
}

String _$publishedCourseQuizzesHash() =>
    r'e552fa591b1c7babf404f4136c649eb556d375b6';

/// Только опубликованные квизы (студент — шаг 23).
///
/// Copied from [publishedCourseQuizzes].
@ProviderFor(publishedCourseQuizzes)
const publishedCourseQuizzesProvider = PublishedCourseQuizzesFamily();

/// Только опубликованные квизы (студент — шаг 23).
///
/// Copied from [publishedCourseQuizzes].
class PublishedCourseQuizzesFamily extends Family<AsyncValue<List<Quiz>>> {
  /// Только опубликованные квизы (студент — шаг 23).
  ///
  /// Copied from [publishedCourseQuizzes].
  const PublishedCourseQuizzesFamily();

  /// Только опубликованные квизы (студент — шаг 23).
  ///
  /// Copied from [publishedCourseQuizzes].
  PublishedCourseQuizzesProvider call(String courseId) {
    return PublishedCourseQuizzesProvider(courseId);
  }

  @override
  PublishedCourseQuizzesProvider getProviderOverride(
    covariant PublishedCourseQuizzesProvider provider,
  ) {
    return call(provider.courseId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'publishedCourseQuizzesProvider';
}

/// Только опубликованные квизы (студент — шаг 23).
///
/// Copied from [publishedCourseQuizzes].
class PublishedCourseQuizzesProvider
    extends AutoDisposeStreamProvider<List<Quiz>> {
  /// Только опубликованные квизы (студент — шаг 23).
  ///
  /// Copied from [publishedCourseQuizzes].
  PublishedCourseQuizzesProvider(String courseId)
    : this._internal(
        (ref) =>
            publishedCourseQuizzes(ref as PublishedCourseQuizzesRef, courseId),
        from: publishedCourseQuizzesProvider,
        name: r'publishedCourseQuizzesProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$publishedCourseQuizzesHash,
        dependencies: PublishedCourseQuizzesFamily._dependencies,
        allTransitiveDependencies:
            PublishedCourseQuizzesFamily._allTransitiveDependencies,
        courseId: courseId,
      );

  PublishedCourseQuizzesProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.courseId,
  }) : super.internal();

  final String courseId;

  @override
  Override overrideWith(
    Stream<List<Quiz>> Function(PublishedCourseQuizzesRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: PublishedCourseQuizzesProvider._internal(
        (ref) => create(ref as PublishedCourseQuizzesRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        courseId: courseId,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<List<Quiz>> createElement() {
    return _PublishedCourseQuizzesProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PublishedCourseQuizzesProvider &&
        other.courseId == courseId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, courseId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin PublishedCourseQuizzesRef on AutoDisposeStreamProviderRef<List<Quiz>> {
  /// The parameter `courseId` of this provider.
  String get courseId;
}

class _PublishedCourseQuizzesProviderElement
    extends AutoDisposeStreamProviderElement<List<Quiz>>
    with PublishedCourseQuizzesRef {
  _PublishedCourseQuizzesProviderElement(super.provider);

  @override
  String get courseId => (origin as PublishedCourseQuizzesProvider).courseId;
}

String _$quizByIdHash() => r'6f2b28cb4addf0f26f4a39628ae26eb34de5a722';

/// Один квиз по id (форма редактирования / просмотр).
///
/// Copied from [quizById].
@ProviderFor(quizById)
const quizByIdProvider = QuizByIdFamily();

/// Один квиз по id (форма редактирования / просмотр).
///
/// Copied from [quizById].
class QuizByIdFamily extends Family<AsyncValue<Quiz?>> {
  /// Один квиз по id (форма редактирования / просмотр).
  ///
  /// Copied from [quizById].
  const QuizByIdFamily();

  /// Один квиз по id (форма редактирования / просмотр).
  ///
  /// Copied from [quizById].
  QuizByIdProvider call(String id) {
    return QuizByIdProvider(id);
  }

  @override
  QuizByIdProvider getProviderOverride(covariant QuizByIdProvider provider) {
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
  String? get name => r'quizByIdProvider';
}

/// Один квиз по id (форма редактирования / просмотр).
///
/// Copied from [quizById].
class QuizByIdProvider extends AutoDisposeStreamProvider<Quiz?> {
  /// Один квиз по id (форма редактирования / просмотр).
  ///
  /// Copied from [quizById].
  QuizByIdProvider(String id)
    : this._internal(
        (ref) => quizById(ref as QuizByIdRef, id),
        from: quizByIdProvider,
        name: r'quizByIdProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$quizByIdHash,
        dependencies: QuizByIdFamily._dependencies,
        allTransitiveDependencies: QuizByIdFamily._allTransitiveDependencies,
        id: id,
      );

  QuizByIdProvider._internal(
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
  Override overrideWith(Stream<Quiz?> Function(QuizByIdRef provider) create) {
    return ProviderOverride(
      origin: this,
      override: QuizByIdProvider._internal(
        (ref) => create(ref as QuizByIdRef),
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
  AutoDisposeStreamProviderElement<Quiz?> createElement() {
    return _QuizByIdProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is QuizByIdProvider && other.id == id;
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
mixin QuizByIdRef on AutoDisposeStreamProviderRef<Quiz?> {
  /// The parameter `id` of this provider.
  String get id;
}

class _QuizByIdProviderElement extends AutoDisposeStreamProviderElement<Quiz?>
    with QuizByIdRef {
  _QuizByIdProviderElement(super.provider);

  @override
  String get id => (origin as QuizByIdProvider).id;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
