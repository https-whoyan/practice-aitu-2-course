// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assignment_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$assignmentRepositoryHash() =>
    r'4df852a9a7c71ca96f5f8fc2f2abb0266caa11a5';

/// Репозиторий заданий (общий для шагов 17 и 18).
///
/// Copied from [assignmentRepository].
@ProviderFor(assignmentRepository)
final assignmentRepositoryProvider = Provider<AssignmentRepository>.internal(
  assignmentRepository,
  name: r'assignmentRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$assignmentRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AssignmentRepositoryRef = ProviderRef<AssignmentRepository>;
String _$assignmentsForCourseHash() =>
    r'2c4c6345bb0493406a931e2f931ca468ca9ac788';

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

/// Все задания курса (преподаватель).
///
/// Copied from [assignmentsForCourse].
@ProviderFor(assignmentsForCourse)
const assignmentsForCourseProvider = AssignmentsForCourseFamily();

/// Все задания курса (преподаватель).
///
/// Copied from [assignmentsForCourse].
class AssignmentsForCourseFamily extends Family<AsyncValue<List<Assignment>>> {
  /// Все задания курса (преподаватель).
  ///
  /// Copied from [assignmentsForCourse].
  const AssignmentsForCourseFamily();

  /// Все задания курса (преподаватель).
  ///
  /// Copied from [assignmentsForCourse].
  AssignmentsForCourseProvider call(String courseId) {
    return AssignmentsForCourseProvider(courseId);
  }

  @override
  AssignmentsForCourseProvider getProviderOverride(
    covariant AssignmentsForCourseProvider provider,
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
  String? get name => r'assignmentsForCourseProvider';
}

/// Все задания курса (преподаватель).
///
/// Copied from [assignmentsForCourse].
class AssignmentsForCourseProvider
    extends AutoDisposeStreamProvider<List<Assignment>> {
  /// Все задания курса (преподаватель).
  ///
  /// Copied from [assignmentsForCourse].
  AssignmentsForCourseProvider(String courseId)
    : this._internal(
        (ref) => assignmentsForCourse(ref as AssignmentsForCourseRef, courseId),
        from: assignmentsForCourseProvider,
        name: r'assignmentsForCourseProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$assignmentsForCourseHash,
        dependencies: AssignmentsForCourseFamily._dependencies,
        allTransitiveDependencies:
            AssignmentsForCourseFamily._allTransitiveDependencies,
        courseId: courseId,
      );

  AssignmentsForCourseProvider._internal(
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
    Stream<List<Assignment>> Function(AssignmentsForCourseRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: AssignmentsForCourseProvider._internal(
        (ref) => create(ref as AssignmentsForCourseRef),
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
  AutoDisposeStreamProviderElement<List<Assignment>> createElement() {
    return _AssignmentsForCourseProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is AssignmentsForCourseProvider && other.courseId == courseId;
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
mixin AssignmentsForCourseRef
    on AutoDisposeStreamProviderRef<List<Assignment>> {
  /// The parameter `courseId` of this provider.
  String get courseId;
}

class _AssignmentsForCourseProviderElement
    extends AutoDisposeStreamProviderElement<List<Assignment>>
    with AssignmentsForCourseRef {
  _AssignmentsForCourseProviderElement(super.provider);

  @override
  String get courseId => (origin as AssignmentsForCourseProvider).courseId;
}

String _$publishedAssignmentsForCourseHash() =>
    r'069f7ef670b9adbe281ec6920606c42b0e64885b';

/// Только опубликованные задания курса (студент, ТЗ §5.6.4).
///
/// Copied from [publishedAssignmentsForCourse].
@ProviderFor(publishedAssignmentsForCourse)
const publishedAssignmentsForCourseProvider =
    PublishedAssignmentsForCourseFamily();

/// Только опубликованные задания курса (студент, ТЗ §5.6.4).
///
/// Copied from [publishedAssignmentsForCourse].
class PublishedAssignmentsForCourseFamily
    extends Family<AsyncValue<List<Assignment>>> {
  /// Только опубликованные задания курса (студент, ТЗ §5.6.4).
  ///
  /// Copied from [publishedAssignmentsForCourse].
  const PublishedAssignmentsForCourseFamily();

  /// Только опубликованные задания курса (студент, ТЗ §5.6.4).
  ///
  /// Copied from [publishedAssignmentsForCourse].
  PublishedAssignmentsForCourseProvider call(String courseId) {
    return PublishedAssignmentsForCourseProvider(courseId);
  }

  @override
  PublishedAssignmentsForCourseProvider getProviderOverride(
    covariant PublishedAssignmentsForCourseProvider provider,
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
  String? get name => r'publishedAssignmentsForCourseProvider';
}

/// Только опубликованные задания курса (студент, ТЗ §5.6.4).
///
/// Copied from [publishedAssignmentsForCourse].
class PublishedAssignmentsForCourseProvider
    extends AutoDisposeStreamProvider<List<Assignment>> {
  /// Только опубликованные задания курса (студент, ТЗ §5.6.4).
  ///
  /// Copied from [publishedAssignmentsForCourse].
  PublishedAssignmentsForCourseProvider(String courseId)
    : this._internal(
        (ref) => publishedAssignmentsForCourse(
          ref as PublishedAssignmentsForCourseRef,
          courseId,
        ),
        from: publishedAssignmentsForCourseProvider,
        name: r'publishedAssignmentsForCourseProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$publishedAssignmentsForCourseHash,
        dependencies: PublishedAssignmentsForCourseFamily._dependencies,
        allTransitiveDependencies:
            PublishedAssignmentsForCourseFamily._allTransitiveDependencies,
        courseId: courseId,
      );

  PublishedAssignmentsForCourseProvider._internal(
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
    Stream<List<Assignment>> Function(PublishedAssignmentsForCourseRef provider)
    create,
  ) {
    return ProviderOverride(
      origin: this,
      override: PublishedAssignmentsForCourseProvider._internal(
        (ref) => create(ref as PublishedAssignmentsForCourseRef),
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
  AutoDisposeStreamProviderElement<List<Assignment>> createElement() {
    return _PublishedAssignmentsForCourseProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PublishedAssignmentsForCourseProvider &&
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
mixin PublishedAssignmentsForCourseRef
    on AutoDisposeStreamProviderRef<List<Assignment>> {
  /// The parameter `courseId` of this provider.
  String get courseId;
}

class _PublishedAssignmentsForCourseProviderElement
    extends AutoDisposeStreamProviderElement<List<Assignment>>
    with PublishedAssignmentsForCourseRef {
  _PublishedAssignmentsForCourseProviderElement(super.provider);

  @override
  String get courseId =>
      (origin as PublishedAssignmentsForCourseProvider).courseId;
}

String _$assignmentsForWeekHash() =>
    r'a222a915e4ed8dee642caafb9347510c251ef036';

/// Задания конкретной недели.
///
/// Copied from [assignmentsForWeek].
@ProviderFor(assignmentsForWeek)
const assignmentsForWeekProvider = AssignmentsForWeekFamily();

/// Задания конкретной недели.
///
/// Copied from [assignmentsForWeek].
class AssignmentsForWeekFamily extends Family<AsyncValue<List<Assignment>>> {
  /// Задания конкретной недели.
  ///
  /// Copied from [assignmentsForWeek].
  const AssignmentsForWeekFamily();

  /// Задания конкретной недели.
  ///
  /// Copied from [assignmentsForWeek].
  AssignmentsForWeekProvider call(String weekId) {
    return AssignmentsForWeekProvider(weekId);
  }

  @override
  AssignmentsForWeekProvider getProviderOverride(
    covariant AssignmentsForWeekProvider provider,
  ) {
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
  String? get name => r'assignmentsForWeekProvider';
}

/// Задания конкретной недели.
///
/// Copied from [assignmentsForWeek].
class AssignmentsForWeekProvider
    extends AutoDisposeStreamProvider<List<Assignment>> {
  /// Задания конкретной недели.
  ///
  /// Copied from [assignmentsForWeek].
  AssignmentsForWeekProvider(String weekId)
    : this._internal(
        (ref) => assignmentsForWeek(ref as AssignmentsForWeekRef, weekId),
        from: assignmentsForWeekProvider,
        name: r'assignmentsForWeekProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$assignmentsForWeekHash,
        dependencies: AssignmentsForWeekFamily._dependencies,
        allTransitiveDependencies:
            AssignmentsForWeekFamily._allTransitiveDependencies,
        weekId: weekId,
      );

  AssignmentsForWeekProvider._internal(
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
    Stream<List<Assignment>> Function(AssignmentsForWeekRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: AssignmentsForWeekProvider._internal(
        (ref) => create(ref as AssignmentsForWeekRef),
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
  AutoDisposeStreamProviderElement<List<Assignment>> createElement() {
    return _AssignmentsForWeekProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is AssignmentsForWeekProvider && other.weekId == weekId;
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
mixin AssignmentsForWeekRef on AutoDisposeStreamProviderRef<List<Assignment>> {
  /// The parameter `weekId` of this provider.
  String get weekId;
}

class _AssignmentsForWeekProviderElement
    extends AutoDisposeStreamProviderElement<List<Assignment>>
    with AssignmentsForWeekRef {
  _AssignmentsForWeekProviderElement(super.provider);

  @override
  String get weekId => (origin as AssignmentsForWeekProvider).weekId;
}

String _$assignmentByIdHash() => r'879fd996d771d50b5b0519814e75d2684071c83c';

/// Одно задание по id (форма редактирования / просмотр).
///
/// Copied from [assignmentById].
@ProviderFor(assignmentById)
const assignmentByIdProvider = AssignmentByIdFamily();

/// Одно задание по id (форма редактирования / просмотр).
///
/// Copied from [assignmentById].
class AssignmentByIdFamily extends Family<AsyncValue<Assignment?>> {
  /// Одно задание по id (форма редактирования / просмотр).
  ///
  /// Copied from [assignmentById].
  const AssignmentByIdFamily();

  /// Одно задание по id (форма редактирования / просмотр).
  ///
  /// Copied from [assignmentById].
  AssignmentByIdProvider call(String id) {
    return AssignmentByIdProvider(id);
  }

  @override
  AssignmentByIdProvider getProviderOverride(
    covariant AssignmentByIdProvider provider,
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
  String? get name => r'assignmentByIdProvider';
}

/// Одно задание по id (форма редактирования / просмотр).
///
/// Copied from [assignmentById].
class AssignmentByIdProvider extends AutoDisposeStreamProvider<Assignment?> {
  /// Одно задание по id (форма редактирования / просмотр).
  ///
  /// Copied from [assignmentById].
  AssignmentByIdProvider(String id)
    : this._internal(
        (ref) => assignmentById(ref as AssignmentByIdRef, id),
        from: assignmentByIdProvider,
        name: r'assignmentByIdProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$assignmentByIdHash,
        dependencies: AssignmentByIdFamily._dependencies,
        allTransitiveDependencies:
            AssignmentByIdFamily._allTransitiveDependencies,
        id: id,
      );

  AssignmentByIdProvider._internal(
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
    Stream<Assignment?> Function(AssignmentByIdRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: AssignmentByIdProvider._internal(
        (ref) => create(ref as AssignmentByIdRef),
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
  AutoDisposeStreamProviderElement<Assignment?> createElement() {
    return _AssignmentByIdProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is AssignmentByIdProvider && other.id == id;
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
mixin AssignmentByIdRef on AutoDisposeStreamProviderRef<Assignment?> {
  /// The parameter `id` of this provider.
  String get id;
}

class _AssignmentByIdProviderElement
    extends AutoDisposeStreamProviderElement<Assignment?>
    with AssignmentByIdRef {
  _AssignmentByIdProviderElement(super.provider);

  @override
  String get id => (origin as AssignmentByIdProvider).id;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
