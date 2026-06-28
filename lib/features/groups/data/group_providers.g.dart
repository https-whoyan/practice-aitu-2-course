// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$groupRepositoryHash() => r'97454eaba2397c8180c6542663f38fced83f9942';

/// Репозиторий групп поверх `firestoreProvider` (шаг 2).
///
/// Copied from [groupRepository].
@ProviderFor(groupRepository)
final groupRepositoryProvider = Provider<GroupRepository>.internal(
  groupRepository,
  name: r'groupRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$groupRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef GroupRepositoryRef = ProviderRef<GroupRepository>;
String _$adminGroupsHash() => r'f0b44d05ca005ef86cdcf64c2fbaa6366e6d85be';

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

/// Список групп для админки (активные по умолчанию).
///
/// Copied from [adminGroups].
@ProviderFor(adminGroups)
const adminGroupsProvider = AdminGroupsFamily();

/// Список групп для админки (активные по умолчанию).
///
/// Copied from [adminGroups].
class AdminGroupsFamily extends Family<AsyncValue<List<Group>>> {
  /// Список групп для админки (активные по умолчанию).
  ///
  /// Copied from [adminGroups].
  const AdminGroupsFamily();

  /// Список групп для админки (активные по умолчанию).
  ///
  /// Copied from [adminGroups].
  AdminGroupsProvider call({bool includeArchived = false}) {
    return AdminGroupsProvider(includeArchived: includeArchived);
  }

  @override
  AdminGroupsProvider getProviderOverride(
    covariant AdminGroupsProvider provider,
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
  String? get name => r'adminGroupsProvider';
}

/// Список групп для админки (активные по умолчанию).
///
/// Copied from [adminGroups].
class AdminGroupsProvider extends AutoDisposeStreamProvider<List<Group>> {
  /// Список групп для админки (активные по умолчанию).
  ///
  /// Copied from [adminGroups].
  AdminGroupsProvider({bool includeArchived = false})
    : this._internal(
        (ref) => adminGroups(
          ref as AdminGroupsRef,
          includeArchived: includeArchived,
        ),
        from: adminGroupsProvider,
        name: r'adminGroupsProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$adminGroupsHash,
        dependencies: AdminGroupsFamily._dependencies,
        allTransitiveDependencies: AdminGroupsFamily._allTransitiveDependencies,
        includeArchived: includeArchived,
      );

  AdminGroupsProvider._internal(
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
    Stream<List<Group>> Function(AdminGroupsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: AdminGroupsProvider._internal(
        (ref) => create(ref as AdminGroupsRef),
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
  AutoDisposeStreamProviderElement<List<Group>> createElement() {
    return _AdminGroupsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is AdminGroupsProvider &&
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
mixin AdminGroupsRef on AutoDisposeStreamProviderRef<List<Group>> {
  /// The parameter `includeArchived` of this provider.
  bool get includeArchived;
}

class _AdminGroupsProviderElement
    extends AutoDisposeStreamProviderElement<List<Group>>
    with AdminGroupsRef {
  _AdminGroupsProviderElement(super.provider);

  @override
  bool get includeArchived => (origin as AdminGroupsProvider).includeArchived;
}

String _$groupByIdHash() => r'4a9c06d81838b99a160061144bb97799eeefc7c6';

/// Одна группа по id (карточка/форма).
///
/// Copied from [groupById].
@ProviderFor(groupById)
const groupByIdProvider = GroupByIdFamily();

/// Одна группа по id (карточка/форма).
///
/// Copied from [groupById].
class GroupByIdFamily extends Family<AsyncValue<Group?>> {
  /// Одна группа по id (карточка/форма).
  ///
  /// Copied from [groupById].
  const GroupByIdFamily();

  /// Одна группа по id (карточка/форма).
  ///
  /// Copied from [groupById].
  GroupByIdProvider call(String groupId) {
    return GroupByIdProvider(groupId);
  }

  @override
  GroupByIdProvider getProviderOverride(covariant GroupByIdProvider provider) {
    return call(provider.groupId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'groupByIdProvider';
}

/// Одна группа по id (карточка/форма).
///
/// Copied from [groupById].
class GroupByIdProvider extends AutoDisposeStreamProvider<Group?> {
  /// Одна группа по id (карточка/форма).
  ///
  /// Copied from [groupById].
  GroupByIdProvider(String groupId)
    : this._internal(
        (ref) => groupById(ref as GroupByIdRef, groupId),
        from: groupByIdProvider,
        name: r'groupByIdProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$groupByIdHash,
        dependencies: GroupByIdFamily._dependencies,
        allTransitiveDependencies: GroupByIdFamily._allTransitiveDependencies,
        groupId: groupId,
      );

  GroupByIdProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.groupId,
  }) : super.internal();

  final String groupId;

  @override
  Override overrideWith(Stream<Group?> Function(GroupByIdRef provider) create) {
    return ProviderOverride(
      origin: this,
      override: GroupByIdProvider._internal(
        (ref) => create(ref as GroupByIdRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        groupId: groupId,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<Group?> createElement() {
    return _GroupByIdProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GroupByIdProvider && other.groupId == groupId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, groupId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin GroupByIdRef on AutoDisposeStreamProviderRef<Group?> {
  /// The parameter `groupId` of this provider.
  String get groupId;
}

class _GroupByIdProviderElement extends AutoDisposeStreamProviderElement<Group?>
    with GroupByIdRef {
  _GroupByIdProviderElement(super.provider);

  @override
  String get groupId => (origin as GroupByIdProvider).groupId;
}

String _$teacherGroupsHash() => r'683ec129695d66a0b8dc52299bee4925edf4da00';

/// Группы текущего преподавателя.
///
/// Copied from [teacherGroups].
@ProviderFor(teacherGroups)
const teacherGroupsProvider = TeacherGroupsFamily();

/// Группы текущего преподавателя.
///
/// Copied from [teacherGroups].
class TeacherGroupsFamily extends Family<AsyncValue<List<Group>>> {
  /// Группы текущего преподавателя.
  ///
  /// Copied from [teacherGroups].
  const TeacherGroupsFamily();

  /// Группы текущего преподавателя.
  ///
  /// Copied from [teacherGroups].
  TeacherGroupsProvider call(String teacherId) {
    return TeacherGroupsProvider(teacherId);
  }

  @override
  TeacherGroupsProvider getProviderOverride(
    covariant TeacherGroupsProvider provider,
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
  String? get name => r'teacherGroupsProvider';
}

/// Группы текущего преподавателя.
///
/// Copied from [teacherGroups].
class TeacherGroupsProvider extends AutoDisposeStreamProvider<List<Group>> {
  /// Группы текущего преподавателя.
  ///
  /// Copied from [teacherGroups].
  TeacherGroupsProvider(String teacherId)
    : this._internal(
        (ref) => teacherGroups(ref as TeacherGroupsRef, teacherId),
        from: teacherGroupsProvider,
        name: r'teacherGroupsProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$teacherGroupsHash,
        dependencies: TeacherGroupsFamily._dependencies,
        allTransitiveDependencies:
            TeacherGroupsFamily._allTransitiveDependencies,
        teacherId: teacherId,
      );

  TeacherGroupsProvider._internal(
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
    Stream<List<Group>> Function(TeacherGroupsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: TeacherGroupsProvider._internal(
        (ref) => create(ref as TeacherGroupsRef),
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
  AutoDisposeStreamProviderElement<List<Group>> createElement() {
    return _TeacherGroupsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is TeacherGroupsProvider && other.teacherId == teacherId;
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
mixin TeacherGroupsRef on AutoDisposeStreamProviderRef<List<Group>> {
  /// The parameter `teacherId` of this provider.
  String get teacherId;
}

class _TeacherGroupsProviderElement
    extends AutoDisposeStreamProviderElement<List<Group>>
    with TeacherGroupsRef {
  _TeacherGroupsProviderElement(super.provider);

  @override
  String get teacherId => (origin as TeacherGroupsProvider).teacherId;
}

String _$studentGroupsHash() => r'82fc9e110ec23b8c12e0338c80bfa211730a0acc';

/// Группы текущего студента.
///
/// Copied from [studentGroups].
@ProviderFor(studentGroups)
const studentGroupsProvider = StudentGroupsFamily();

/// Группы текущего студента.
///
/// Copied from [studentGroups].
class StudentGroupsFamily extends Family<AsyncValue<List<Group>>> {
  /// Группы текущего студента.
  ///
  /// Copied from [studentGroups].
  const StudentGroupsFamily();

  /// Группы текущего студента.
  ///
  /// Copied from [studentGroups].
  StudentGroupsProvider call(String studentId) {
    return StudentGroupsProvider(studentId);
  }

  @override
  StudentGroupsProvider getProviderOverride(
    covariant StudentGroupsProvider provider,
  ) {
    return call(provider.studentId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'studentGroupsProvider';
}

/// Группы текущего студента.
///
/// Copied from [studentGroups].
class StudentGroupsProvider extends AutoDisposeStreamProvider<List<Group>> {
  /// Группы текущего студента.
  ///
  /// Copied from [studentGroups].
  StudentGroupsProvider(String studentId)
    : this._internal(
        (ref) => studentGroups(ref as StudentGroupsRef, studentId),
        from: studentGroupsProvider,
        name: r'studentGroupsProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$studentGroupsHash,
        dependencies: StudentGroupsFamily._dependencies,
        allTransitiveDependencies:
            StudentGroupsFamily._allTransitiveDependencies,
        studentId: studentId,
      );

  StudentGroupsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.studentId,
  }) : super.internal();

  final String studentId;

  @override
  Override overrideWith(
    Stream<List<Group>> Function(StudentGroupsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: StudentGroupsProvider._internal(
        (ref) => create(ref as StudentGroupsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        studentId: studentId,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<List<Group>> createElement() {
    return _StudentGroupsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is StudentGroupsProvider && other.studentId == studentId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, studentId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin StudentGroupsRef on AutoDisposeStreamProviderRef<List<Group>> {
  /// The parameter `studentId` of this provider.
  String get studentId;
}

class _StudentGroupsProviderElement
    extends AutoDisposeStreamProviderElement<List<Group>>
    with StudentGroupsRef {
  _StudentGroupsProviderElement(super.provider);

  @override
  String get studentId => (origin as StudentGroupsProvider).studentId;
}

String _$teacherGroupsByCoursesHash() =>
    r'24b88d271b4bf49cc07ffbb037be9857323e2b07';

/// «Мои группы» преподавателя — группы, связанные с его курсами (P1-3).
/// `group.teacherIds` не заполняется, поэтому идём через курсы преподавателя.
///
/// Copied from [teacherGroupsByCourses].
@ProviderFor(teacherGroupsByCourses)
const teacherGroupsByCoursesProvider = TeacherGroupsByCoursesFamily();

/// «Мои группы» преподавателя — группы, связанные с его курсами (P1-3).
/// `group.teacherIds` не заполняется, поэтому идём через курсы преподавателя.
///
/// Copied from [teacherGroupsByCourses].
class TeacherGroupsByCoursesFamily extends Family<AsyncValue<List<Group>>> {
  /// «Мои группы» преподавателя — группы, связанные с его курсами (P1-3).
  /// `group.teacherIds` не заполняется, поэтому идём через курсы преподавателя.
  ///
  /// Copied from [teacherGroupsByCourses].
  const TeacherGroupsByCoursesFamily();

  /// «Мои группы» преподавателя — группы, связанные с его курсами (P1-3).
  /// `group.teacherIds` не заполняется, поэтому идём через курсы преподавателя.
  ///
  /// Copied from [teacherGroupsByCourses].
  TeacherGroupsByCoursesProvider call(String teacherId) {
    return TeacherGroupsByCoursesProvider(teacherId);
  }

  @override
  TeacherGroupsByCoursesProvider getProviderOverride(
    covariant TeacherGroupsByCoursesProvider provider,
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
  String? get name => r'teacherGroupsByCoursesProvider';
}

/// «Мои группы» преподавателя — группы, связанные с его курсами (P1-3).
/// `group.teacherIds` не заполняется, поэтому идём через курсы преподавателя.
///
/// Copied from [teacherGroupsByCourses].
class TeacherGroupsByCoursesProvider
    extends AutoDisposeStreamProvider<List<Group>> {
  /// «Мои группы» преподавателя — группы, связанные с его курсами (P1-3).
  /// `group.teacherIds` не заполняется, поэтому идём через курсы преподавателя.
  ///
  /// Copied from [teacherGroupsByCourses].
  TeacherGroupsByCoursesProvider(String teacherId)
    : this._internal(
        (ref) =>
            teacherGroupsByCourses(ref as TeacherGroupsByCoursesRef, teacherId),
        from: teacherGroupsByCoursesProvider,
        name: r'teacherGroupsByCoursesProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$teacherGroupsByCoursesHash,
        dependencies: TeacherGroupsByCoursesFamily._dependencies,
        allTransitiveDependencies:
            TeacherGroupsByCoursesFamily._allTransitiveDependencies,
        teacherId: teacherId,
      );

  TeacherGroupsByCoursesProvider._internal(
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
    Stream<List<Group>> Function(TeacherGroupsByCoursesRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: TeacherGroupsByCoursesProvider._internal(
        (ref) => create(ref as TeacherGroupsByCoursesRef),
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
  AutoDisposeStreamProviderElement<List<Group>> createElement() {
    return _TeacherGroupsByCoursesProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is TeacherGroupsByCoursesProvider &&
        other.teacherId == teacherId;
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
mixin TeacherGroupsByCoursesRef on AutoDisposeStreamProviderRef<List<Group>> {
  /// The parameter `teacherId` of this provider.
  String get teacherId;
}

class _TeacherGroupsByCoursesProviderElement
    extends AutoDisposeStreamProviderElement<List<Group>>
    with TeacherGroupsByCoursesRef {
  _TeacherGroupsByCoursesProviderElement(super.provider);

  @override
  String get teacherId => (origin as TeacherGroupsByCoursesProvider).teacherId;
}

String _$courseGroupsHash() => r'817996d81d39570308aff16ab8728320c387a836';

/// Группы, связанные с конкретным курсом (для состава студентов курса).
///
/// Copied from [courseGroups].
@ProviderFor(courseGroups)
const courseGroupsProvider = CourseGroupsFamily();

/// Группы, связанные с конкретным курсом (для состава студентов курса).
///
/// Copied from [courseGroups].
class CourseGroupsFamily extends Family<AsyncValue<List<Group>>> {
  /// Группы, связанные с конкретным курсом (для состава студентов курса).
  ///
  /// Copied from [courseGroups].
  const CourseGroupsFamily();

  /// Группы, связанные с конкретным курсом (для состава студентов курса).
  ///
  /// Copied from [courseGroups].
  CourseGroupsProvider call(String courseId) {
    return CourseGroupsProvider(courseId);
  }

  @override
  CourseGroupsProvider getProviderOverride(
    covariant CourseGroupsProvider provider,
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
  String? get name => r'courseGroupsProvider';
}

/// Группы, связанные с конкретным курсом (для состава студентов курса).
///
/// Copied from [courseGroups].
class CourseGroupsProvider extends AutoDisposeStreamProvider<List<Group>> {
  /// Группы, связанные с конкретным курсом (для состава студентов курса).
  ///
  /// Copied from [courseGroups].
  CourseGroupsProvider(String courseId)
    : this._internal(
        (ref) => courseGroups(ref as CourseGroupsRef, courseId),
        from: courseGroupsProvider,
        name: r'courseGroupsProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$courseGroupsHash,
        dependencies: CourseGroupsFamily._dependencies,
        allTransitiveDependencies:
            CourseGroupsFamily._allTransitiveDependencies,
        courseId: courseId,
      );

  CourseGroupsProvider._internal(
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
    Stream<List<Group>> Function(CourseGroupsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: CourseGroupsProvider._internal(
        (ref) => create(ref as CourseGroupsRef),
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
  AutoDisposeStreamProviderElement<List<Group>> createElement() {
    return _CourseGroupsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CourseGroupsProvider && other.courseId == courseId;
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
mixin CourseGroupsRef on AutoDisposeStreamProviderRef<List<Group>> {
  /// The parameter `courseId` of this provider.
  String get courseId;
}

class _CourseGroupsProviderElement
    extends AutoDisposeStreamProviderElement<List<Group>>
    with CourseGroupsRef {
  _CourseGroupsProviderElement(super.provider);

  @override
  String get courseId => (origin as CourseGroupsProvider).courseId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
