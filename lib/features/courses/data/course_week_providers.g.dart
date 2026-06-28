// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_week_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$courseWeekRepositoryHash() =>
    r'f62ab5daf2344a8332893c353220a237b9cf76ed';

/// Репозиторий недель курса (общий для шагов 14 и 16).
///
/// Copied from [courseWeekRepository].
@ProviderFor(courseWeekRepository)
final courseWeekRepositoryProvider = Provider<CourseWeekRepository>.internal(
  courseWeekRepository,
  name: r'courseWeekRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$courseWeekRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CourseWeekRepositoryRef = ProviderRef<CourseWeekRepository>;
String _$courseWeeksHash() => r'fade91330fe852e42793f5d2e136056ee83f4e8d';

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

/// Все недели курса по порядку (преподаватель).
///
/// Copied from [courseWeeks].
@ProviderFor(courseWeeks)
const courseWeeksProvider = CourseWeeksFamily();

/// Все недели курса по порядку (преподаватель).
///
/// Copied from [courseWeeks].
class CourseWeeksFamily extends Family<AsyncValue<List<CourseWeek>>> {
  /// Все недели курса по порядку (преподаватель).
  ///
  /// Copied from [courseWeeks].
  const CourseWeeksFamily();

  /// Все недели курса по порядку (преподаватель).
  ///
  /// Copied from [courseWeeks].
  CourseWeeksProvider call(String courseId) {
    return CourseWeeksProvider(courseId);
  }

  @override
  CourseWeeksProvider getProviderOverride(
    covariant CourseWeeksProvider provider,
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
  String? get name => r'courseWeeksProvider';
}

/// Все недели курса по порядку (преподаватель).
///
/// Copied from [courseWeeks].
class CourseWeeksProvider extends AutoDisposeStreamProvider<List<CourseWeek>> {
  /// Все недели курса по порядку (преподаватель).
  ///
  /// Copied from [courseWeeks].
  CourseWeeksProvider(String courseId)
    : this._internal(
        (ref) => courseWeeks(ref as CourseWeeksRef, courseId),
        from: courseWeeksProvider,
        name: r'courseWeeksProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$courseWeeksHash,
        dependencies: CourseWeeksFamily._dependencies,
        allTransitiveDependencies: CourseWeeksFamily._allTransitiveDependencies,
        courseId: courseId,
      );

  CourseWeeksProvider._internal(
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
    Stream<List<CourseWeek>> Function(CourseWeeksRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: CourseWeeksProvider._internal(
        (ref) => create(ref as CourseWeeksRef),
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
  AutoDisposeStreamProviderElement<List<CourseWeek>> createElement() {
    return _CourseWeeksProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CourseWeeksProvider && other.courseId == courseId;
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
mixin CourseWeeksRef on AutoDisposeStreamProviderRef<List<CourseWeek>> {
  /// The parameter `courseId` of this provider.
  String get courseId;
}

class _CourseWeeksProviderElement
    extends AutoDisposeStreamProviderElement<List<CourseWeek>>
    with CourseWeeksRef {
  _CourseWeeksProviderElement(super.provider);

  @override
  String get courseId => (origin as CourseWeeksProvider).courseId;
}

String _$publishedCourseWeeksHash() =>
    r'262a0d15cda288ce805fdb6a449148b81272c45c';

/// Только опубликованные недели (студент, ТЗ §5.6.3).
///
/// Copied from [publishedCourseWeeks].
@ProviderFor(publishedCourseWeeks)
const publishedCourseWeeksProvider = PublishedCourseWeeksFamily();

/// Только опубликованные недели (студент, ТЗ §5.6.3).
///
/// Copied from [publishedCourseWeeks].
class PublishedCourseWeeksFamily extends Family<AsyncValue<List<CourseWeek>>> {
  /// Только опубликованные недели (студент, ТЗ §5.6.3).
  ///
  /// Copied from [publishedCourseWeeks].
  const PublishedCourseWeeksFamily();

  /// Только опубликованные недели (студент, ТЗ §5.6.3).
  ///
  /// Copied from [publishedCourseWeeks].
  PublishedCourseWeeksProvider call(String courseId) {
    return PublishedCourseWeeksProvider(courseId);
  }

  @override
  PublishedCourseWeeksProvider getProviderOverride(
    covariant PublishedCourseWeeksProvider provider,
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
  String? get name => r'publishedCourseWeeksProvider';
}

/// Только опубликованные недели (студент, ТЗ §5.6.3).
///
/// Copied from [publishedCourseWeeks].
class PublishedCourseWeeksProvider
    extends AutoDisposeStreamProvider<List<CourseWeek>> {
  /// Только опубликованные недели (студент, ТЗ §5.6.3).
  ///
  /// Copied from [publishedCourseWeeks].
  PublishedCourseWeeksProvider(String courseId)
    : this._internal(
        (ref) => publishedCourseWeeks(ref as PublishedCourseWeeksRef, courseId),
        from: publishedCourseWeeksProvider,
        name: r'publishedCourseWeeksProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$publishedCourseWeeksHash,
        dependencies: PublishedCourseWeeksFamily._dependencies,
        allTransitiveDependencies:
            PublishedCourseWeeksFamily._allTransitiveDependencies,
        courseId: courseId,
      );

  PublishedCourseWeeksProvider._internal(
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
    Stream<List<CourseWeek>> Function(PublishedCourseWeeksRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: PublishedCourseWeeksProvider._internal(
        (ref) => create(ref as PublishedCourseWeeksRef),
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
  AutoDisposeStreamProviderElement<List<CourseWeek>> createElement() {
    return _PublishedCourseWeeksProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PublishedCourseWeeksProvider && other.courseId == courseId;
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
mixin PublishedCourseWeeksRef
    on AutoDisposeStreamProviderRef<List<CourseWeek>> {
  /// The parameter `courseId` of this provider.
  String get courseId;
}

class _PublishedCourseWeeksProviderElement
    extends AutoDisposeStreamProviderElement<List<CourseWeek>>
    with PublishedCourseWeeksRef {
  _PublishedCourseWeeksProviderElement(super.provider);

  @override
  String get courseId => (origin as PublishedCourseWeeksProvider).courseId;
}

String _$weekByIdHash() => r'9f374f039524930f6a7ba919c742451081da6693';

/// Одна неделя по id (форма редактирования).
///
/// Copied from [weekById].
@ProviderFor(weekById)
const weekByIdProvider = WeekByIdFamily();

/// Одна неделя по id (форма редактирования).
///
/// Copied from [weekById].
class WeekByIdFamily extends Family<AsyncValue<CourseWeek?>> {
  /// Одна неделя по id (форма редактирования).
  ///
  /// Copied from [weekById].
  const WeekByIdFamily();

  /// Одна неделя по id (форма редактирования).
  ///
  /// Copied from [weekById].
  WeekByIdProvider call(String weekId) {
    return WeekByIdProvider(weekId);
  }

  @override
  WeekByIdProvider getProviderOverride(covariant WeekByIdProvider provider) {
    return call(provider.weekId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'weekByIdProvider';
}

/// Одна неделя по id (форма редактирования).
///
/// Copied from [weekById].
class WeekByIdProvider extends AutoDisposeFutureProvider<CourseWeek?> {
  /// Одна неделя по id (форма редактирования).
  ///
  /// Copied from [weekById].
  WeekByIdProvider(String weekId)
    : this._internal(
        (ref) => weekById(ref as WeekByIdRef, weekId),
        from: weekByIdProvider,
        name: r'weekByIdProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$weekByIdHash,
        dependencies: WeekByIdFamily._dependencies,
        allTransitiveDependencies: WeekByIdFamily._allTransitiveDependencies,
        weekId: weekId,
      );

  WeekByIdProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.weekId,
  }) : super.internal();

  final String weekId;

  @override
  Override overrideWith(
    FutureOr<CourseWeek?> Function(WeekByIdRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: WeekByIdProvider._internal(
        (ref) => create(ref as WeekByIdRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        weekId: weekId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<CourseWeek?> createElement() {
    return _WeekByIdProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is WeekByIdProvider && other.weekId == weekId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, weekId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin WeekByIdRef on AutoDisposeFutureProviderRef<CourseWeek?> {
  /// The parameter `weekId` of this provider.
  String get weekId;
}

class _WeekByIdProviderElement
    extends AutoDisposeFutureProviderElement<CourseWeek?>
    with WeekByIdRef {
  _WeekByIdProviderElement(super.provider);

  @override
  String get weekId => (origin as WeekByIdProvider).weekId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
