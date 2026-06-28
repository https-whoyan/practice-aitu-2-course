// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$courseRepositoryHash() => r'bca5d49bb7bba4dae62cb1faa8fae6a60e65386c';

/// Репозиторий курсов поверх `firestoreProvider` (шаг 2).
///
/// Copied from [courseRepository].
@ProviderFor(courseRepository)
final courseRepositoryProvider = Provider<CourseRepository>.internal(
  courseRepository,
  name: r'courseRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$courseRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CourseRepositoryRef = ProviderRef<CourseRepository>;
String _$adminCoursesHash() => r'bbe49973a8cf4b7fb1b14d127255ee81d5dc8233';

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

/// Список курсов для админки (активные по умолчанию).
///
/// Copied from [adminCourses].
@ProviderFor(adminCourses)
const adminCoursesProvider = AdminCoursesFamily();

/// Список курсов для админки (активные по умолчанию).
///
/// Copied from [adminCourses].
class AdminCoursesFamily extends Family<AsyncValue<List<Course>>> {
  /// Список курсов для админки (активные по умолчанию).
  ///
  /// Copied from [adminCourses].
  const AdminCoursesFamily();

  /// Список курсов для админки (активные по умолчанию).
  ///
  /// Copied from [adminCourses].
  AdminCoursesProvider call({bool includeArchived = false}) {
    return AdminCoursesProvider(includeArchived: includeArchived);
  }

  @override
  AdminCoursesProvider getProviderOverride(
    covariant AdminCoursesProvider provider,
  ) {
    return call(includeArchived: provider.includeArchived);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'adminCoursesProvider';
}

/// Список курсов для админки (активные по умолчанию).
///
/// Copied from [adminCourses].
class AdminCoursesProvider extends AutoDisposeStreamProvider<List<Course>> {
  /// Список курсов для админки (активные по умолчанию).
  ///
  /// Copied from [adminCourses].
  AdminCoursesProvider({bool includeArchived = false})
    : this._internal(
        (ref) => adminCourses(
          ref as AdminCoursesRef,
          includeArchived: includeArchived,
        ),
        from: adminCoursesProvider,
        name: r'adminCoursesProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$adminCoursesHash,
        dependencies: AdminCoursesFamily._dependencies,
        allTransitiveDependencies:
            AdminCoursesFamily._allTransitiveDependencies,
        includeArchived: includeArchived,
      );

  AdminCoursesProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.includeArchived,
  }) : super.internal();

  final bool includeArchived;

  @override
  Override overrideWith(
    Stream<List<Course>> Function(AdminCoursesRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: AdminCoursesProvider._internal(
        (ref) => create(ref as AdminCoursesRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        includeArchived: includeArchived,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<List<Course>> createElement() {
    return _AdminCoursesProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is AdminCoursesProvider &&
        other.includeArchived == includeArchived;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, includeArchived.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin AdminCoursesRef on AutoDisposeStreamProviderRef<List<Course>> {
  /// The parameter `includeArchived` of this provider.
  bool get includeArchived;
}

class _AdminCoursesProviderElement
    extends AutoDisposeStreamProviderElement<List<Course>>
    with AdminCoursesRef {
  _AdminCoursesProviderElement(super.provider);

  @override
  bool get includeArchived => (origin as AdminCoursesProvider).includeArchived;
}

String _$courseByIdHash() => r'cfb0dc87c3ad69ce444e74f12cc1d10027479180';

/// Один курс по id (карточка/форма).
///
/// Copied from [courseById].
@ProviderFor(courseById)
const courseByIdProvider = CourseByIdFamily();

/// Один курс по id (карточка/форма).
///
/// Copied from [courseById].
class CourseByIdFamily extends Family<AsyncValue<Course?>> {
  /// Один курс по id (карточка/форма).
  ///
  /// Copied from [courseById].
  const CourseByIdFamily();

  /// Один курс по id (карточка/форма).
  ///
  /// Copied from [courseById].
  CourseByIdProvider call(String courseId) {
    return CourseByIdProvider(courseId);
  }

  @override
  CourseByIdProvider getProviderOverride(
    covariant CourseByIdProvider provider,
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
  String? get name => r'courseByIdProvider';
}

/// Один курс по id (карточка/форма).
///
/// Copied from [courseById].
class CourseByIdProvider extends AutoDisposeStreamProvider<Course?> {
  /// Один курс по id (карточка/форма).
  ///
  /// Copied from [courseById].
  CourseByIdProvider(String courseId)
    : this._internal(
        (ref) => courseById(ref as CourseByIdRef, courseId),
        from: courseByIdProvider,
        name: r'courseByIdProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$courseByIdHash,
        dependencies: CourseByIdFamily._dependencies,
        allTransitiveDependencies: CourseByIdFamily._allTransitiveDependencies,
        courseId: courseId,
      );

  CourseByIdProvider._internal(
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
    Stream<Course?> Function(CourseByIdRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: CourseByIdProvider._internal(
        (ref) => create(ref as CourseByIdRef),
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
  AutoDisposeStreamProviderElement<Course?> createElement() {
    return _CourseByIdProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CourseByIdProvider && other.courseId == courseId;
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
mixin CourseByIdRef on AutoDisposeStreamProviderRef<Course?> {
  /// The parameter `courseId` of this provider.
  String get courseId;
}

class _CourseByIdProviderElement
    extends AutoDisposeStreamProviderElement<Course?>
    with CourseByIdRef {
  _CourseByIdProviderElement(super.provider);

  @override
  String get courseId => (origin as CourseByIdProvider).courseId;
}

String _$teacherCoursesHash() => r'e0aa49ff85cc61a1b6c7140b7e09830cda27b866';

/// Курсы, которые ведёт преподаватель (по `teacherIds`).
///
/// Copied from [teacherCourses].
@ProviderFor(teacherCourses)
const teacherCoursesProvider = TeacherCoursesFamily();

/// Курсы, которые ведёт преподаватель (по `teacherIds`).
///
/// Copied from [teacherCourses].
class TeacherCoursesFamily extends Family<AsyncValue<List<Course>>> {
  /// Курсы, которые ведёт преподаватель (по `teacherIds`).
  ///
  /// Copied from [teacherCourses].
  const TeacherCoursesFamily();

  /// Курсы, которые ведёт преподаватель (по `teacherIds`).
  ///
  /// Copied from [teacherCourses].
  TeacherCoursesProvider call(String teacherId) {
    return TeacherCoursesProvider(teacherId);
  }

  @override
  TeacherCoursesProvider getProviderOverride(
    covariant TeacherCoursesProvider provider,
  ) {
    return call(provider.teacherId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'teacherCoursesProvider';
}

/// Курсы, которые ведёт преподаватель (по `teacherIds`).
///
/// Copied from [teacherCourses].
class TeacherCoursesProvider extends AutoDisposeStreamProvider<List<Course>> {
  /// Курсы, которые ведёт преподаватель (по `teacherIds`).
  ///
  /// Copied from [teacherCourses].
  TeacherCoursesProvider(String teacherId)
    : this._internal(
        (ref) => teacherCourses(ref as TeacherCoursesRef, teacherId),
        from: teacherCoursesProvider,
        name: r'teacherCoursesProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$teacherCoursesHash,
        dependencies: TeacherCoursesFamily._dependencies,
        allTransitiveDependencies:
            TeacherCoursesFamily._allTransitiveDependencies,
        teacherId: teacherId,
      );

  TeacherCoursesProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.teacherId,
  }) : super.internal();

  final String teacherId;

  @override
  Override overrideWith(
    Stream<List<Course>> Function(TeacherCoursesRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: TeacherCoursesProvider._internal(
        (ref) => create(ref as TeacherCoursesRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        teacherId: teacherId,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<List<Course>> createElement() {
    return _TeacherCoursesProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is TeacherCoursesProvider && other.teacherId == teacherId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, teacherId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin TeacherCoursesRef on AutoDisposeStreamProviderRef<List<Course>> {
  /// The parameter `teacherId` of this provider.
  String get teacherId;
}

class _TeacherCoursesProviderElement
    extends AutoDisposeStreamProviderElement<List<Course>>
    with TeacherCoursesRef {
  _TeacherCoursesProviderElement(super.provider);

  @override
  String get teacherId => (origin as TeacherCoursesProvider).teacherId;
}

String _$ownerCoursesHash() => r'f8d5bec93d83710740b5c5cfed14ba41cd497f3d';

/// Курсы преподавателя-владельца (ТЗ §5.4.1, шаг 14).
///
/// Copied from [ownerCourses].
@ProviderFor(ownerCourses)
const ownerCoursesProvider = OwnerCoursesFamily();

/// Курсы преподавателя-владельца (ТЗ §5.4.1, шаг 14).
///
/// Copied from [ownerCourses].
class OwnerCoursesFamily extends Family<AsyncValue<List<Course>>> {
  /// Курсы преподавателя-владельца (ТЗ §5.4.1, шаг 14).
  ///
  /// Copied from [ownerCourses].
  const OwnerCoursesFamily();

  /// Курсы преподавателя-владельца (ТЗ §5.4.1, шаг 14).
  ///
  /// Copied from [ownerCourses].
  OwnerCoursesProvider call(String teacherId) {
    return OwnerCoursesProvider(teacherId);
  }

  @override
  OwnerCoursesProvider getProviderOverride(
    covariant OwnerCoursesProvider provider,
  ) {
    return call(provider.teacherId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'ownerCoursesProvider';
}

/// Курсы преподавателя-владельца (ТЗ §5.4.1, шаг 14).
///
/// Copied from [ownerCourses].
class OwnerCoursesProvider extends AutoDisposeStreamProvider<List<Course>> {
  /// Курсы преподавателя-владельца (ТЗ §5.4.1, шаг 14).
  ///
  /// Copied from [ownerCourses].
  OwnerCoursesProvider(String teacherId)
    : this._internal(
        (ref) => ownerCourses(ref as OwnerCoursesRef, teacherId),
        from: ownerCoursesProvider,
        name: r'ownerCoursesProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$ownerCoursesHash,
        dependencies: OwnerCoursesFamily._dependencies,
        allTransitiveDependencies:
            OwnerCoursesFamily._allTransitiveDependencies,
        teacherId: teacherId,
      );

  OwnerCoursesProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.teacherId,
  }) : super.internal();

  final String teacherId;

  @override
  Override overrideWith(
    Stream<List<Course>> Function(OwnerCoursesRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: OwnerCoursesProvider._internal(
        (ref) => create(ref as OwnerCoursesRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        teacherId: teacherId,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<List<Course>> createElement() {
    return _OwnerCoursesProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is OwnerCoursesProvider && other.teacherId == teacherId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, teacherId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin OwnerCoursesRef on AutoDisposeStreamProviderRef<List<Course>> {
  /// The parameter `teacherId` of this provider.
  String get teacherId;
}

class _OwnerCoursesProviderElement
    extends AutoDisposeStreamProviderElement<List<Course>>
    with OwnerCoursesRef {
  _OwnerCoursesProviderElement(super.provider);

  @override
  String get teacherId => (origin as OwnerCoursesProvider).teacherId;
}

String _$coursesByGroupsHash() => r'5f0651f9655c3d22f5365768ad14519bd67ca20a';

/// Активные курсы по группам студента (ТЗ §5.6.1, шаг 16).
///
/// Copied from [coursesByGroups].
@ProviderFor(coursesByGroups)
const coursesByGroupsProvider = CoursesByGroupsFamily();

/// Активные курсы по группам студента (ТЗ §5.6.1, шаг 16).
///
/// Copied from [coursesByGroups].
class CoursesByGroupsFamily extends Family<AsyncValue<List<Course>>> {
  /// Активные курсы по группам студента (ТЗ §5.6.1, шаг 16).
  ///
  /// Copied from [coursesByGroups].
  const CoursesByGroupsFamily();

  /// Активные курсы по группам студента (ТЗ §5.6.1, шаг 16).
  ///
  /// Copied from [coursesByGroups].
  CoursesByGroupsProvider call(List<String> groupIds) {
    return CoursesByGroupsProvider(groupIds);
  }

  @override
  CoursesByGroupsProvider getProviderOverride(
    covariant CoursesByGroupsProvider provider,
  ) {
    return call(provider.groupIds);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'coursesByGroupsProvider';
}

/// Активные курсы по группам студента (ТЗ §5.6.1, шаг 16).
///
/// Copied from [coursesByGroups].
class CoursesByGroupsProvider extends AutoDisposeStreamProvider<List<Course>> {
  /// Активные курсы по группам студента (ТЗ §5.6.1, шаг 16).
  ///
  /// Copied from [coursesByGroups].
  CoursesByGroupsProvider(List<String> groupIds)
    : this._internal(
        (ref) => coursesByGroups(ref as CoursesByGroupsRef, groupIds),
        from: coursesByGroupsProvider,
        name: r'coursesByGroupsProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$coursesByGroupsHash,
        dependencies: CoursesByGroupsFamily._dependencies,
        allTransitiveDependencies:
            CoursesByGroupsFamily._allTransitiveDependencies,
        groupIds: groupIds,
      );

  CoursesByGroupsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.groupIds,
  }) : super.internal();

  final List<String> groupIds;

  @override
  Override overrideWith(
    Stream<List<Course>> Function(CoursesByGroupsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: CoursesByGroupsProvider._internal(
        (ref) => create(ref as CoursesByGroupsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        groupIds: groupIds,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<List<Course>> createElement() {
    return _CoursesByGroupsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CoursesByGroupsProvider && other.groupIds == groupIds;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, groupIds.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin CoursesByGroupsRef on AutoDisposeStreamProviderRef<List<Course>> {
  /// The parameter `groupIds` of this provider.
  List<String> get groupIds;
}

class _CoursesByGroupsProviderElement
    extends AutoDisposeStreamProviderElement<List<Course>>
    with CoursesByGroupsRef {
  _CoursesByGroupsProviderElement(super.provider);

  @override
  List<String> get groupIds => (origin as CoursesByGroupsProvider).groupIds;
}

String _$coursesByIdsHash() => r'c52d4629b6a87fd147cc6aacff57194602f92b79';

/// Курсы по списку id (для студента).
///
/// Copied from [coursesByIds].
@ProviderFor(coursesByIds)
const coursesByIdsProvider = CoursesByIdsFamily();

/// Курсы по списку id (для студента).
///
/// Copied from [coursesByIds].
class CoursesByIdsFamily extends Family<AsyncValue<List<Course>>> {
  /// Курсы по списку id (для студента).
  ///
  /// Copied from [coursesByIds].
  const CoursesByIdsFamily();

  /// Курсы по списку id (для студента).
  ///
  /// Copied from [coursesByIds].
  CoursesByIdsProvider call(List<String> courseIds) {
    return CoursesByIdsProvider(courseIds);
  }

  @override
  CoursesByIdsProvider getProviderOverride(
    covariant CoursesByIdsProvider provider,
  ) {
    return call(provider.courseIds);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'coursesByIdsProvider';
}

/// Курсы по списку id (для студента).
///
/// Copied from [coursesByIds].
class CoursesByIdsProvider extends AutoDisposeStreamProvider<List<Course>> {
  /// Курсы по списку id (для студента).
  ///
  /// Copied from [coursesByIds].
  CoursesByIdsProvider(List<String> courseIds)
    : this._internal(
        (ref) => coursesByIds(ref as CoursesByIdsRef, courseIds),
        from: coursesByIdsProvider,
        name: r'coursesByIdsProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$coursesByIdsHash,
        dependencies: CoursesByIdsFamily._dependencies,
        allTransitiveDependencies:
            CoursesByIdsFamily._allTransitiveDependencies,
        courseIds: courseIds,
      );

  CoursesByIdsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.courseIds,
  }) : super.internal();

  final List<String> courseIds;

  @override
  Override overrideWith(
    Stream<List<Course>> Function(CoursesByIdsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: CoursesByIdsProvider._internal(
        (ref) => create(ref as CoursesByIdsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        courseIds: courseIds,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<List<Course>> createElement() {
    return _CoursesByIdsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CoursesByIdsProvider && other.courseIds == courseIds;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, courseIds.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin CoursesByIdsRef on AutoDisposeStreamProviderRef<List<Course>> {
  /// The parameter `courseIds` of this provider.
  List<String> get courseIds;
}

class _CoursesByIdsProviderElement
    extends AutoDisposeStreamProviderElement<List<Course>>
    with CoursesByIdsRef {
  _CoursesByIdsProviderElement(super.provider);

  @override
  List<String> get courseIds => (origin as CoursesByIdsProvider).courseIds;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
