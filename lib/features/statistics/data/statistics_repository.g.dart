// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'statistics_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$statisticsRepositoryHash() =>
    r'f78951cb23ee4b8b76c08aa16ad5da23ee62ceea';

/// Репозиторий статистики (read-only).
///
/// Copied from [statisticsRepository].
@ProviderFor(statisticsRepository)
final statisticsRepositoryProvider = Provider<StatisticsRepository>.internal(
  statisticsRepository,
  name: r'statisticsRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$statisticsRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef StatisticsRepositoryRef = ProviderRef<StatisticsRepository>;
String _$studentSummaryHash() => r'76b33d269fd422f6f979c2e665acfb4e000abf0a';

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

/// Сводка конкретного студента по id.
///
/// Copied from [studentSummary].
@ProviderFor(studentSummary)
const studentSummaryProvider = StudentSummaryFamily();

/// Сводка конкретного студента по id.
///
/// Copied from [studentSummary].
class StudentSummaryFamily extends Family<AsyncValue<StudentSummary?>> {
  /// Сводка конкретного студента по id.
  ///
  /// Copied from [studentSummary].
  const StudentSummaryFamily();

  /// Сводка конкретного студента по id.
  ///
  /// Copied from [studentSummary].
  StudentSummaryProvider call(String studentId) {
    return StudentSummaryProvider(studentId);
  }

  @override
  StudentSummaryProvider getProviderOverride(
    covariant StudentSummaryProvider provider,
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
  String? get name => r'studentSummaryProvider';
}

/// Сводка конкретного студента по id.
///
/// Copied from [studentSummary].
class StudentSummaryProvider
    extends AutoDisposeStreamProvider<StudentSummary?> {
  /// Сводка конкретного студента по id.
  ///
  /// Copied from [studentSummary].
  StudentSummaryProvider(String studentId)
    : this._internal(
        (ref) => studentSummary(ref as StudentSummaryRef, studentId),
        from: studentSummaryProvider,
        name: r'studentSummaryProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$studentSummaryHash,
        dependencies: StudentSummaryFamily._dependencies,
        allTransitiveDependencies:
            StudentSummaryFamily._allTransitiveDependencies,
        studentId: studentId,
      );

  StudentSummaryProvider._internal(
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
    Stream<StudentSummary?> Function(StudentSummaryRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: StudentSummaryProvider._internal(
        (ref) => create(ref as StudentSummaryRef),
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
  AutoDisposeStreamProviderElement<StudentSummary?> createElement() {
    return _StudentSummaryProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is StudentSummaryProvider && other.studentId == studentId;
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
mixin StudentSummaryRef on AutoDisposeStreamProviderRef<StudentSummary?> {
  /// The parameter `studentId` of this provider.
  String get studentId;
}

class _StudentSummaryProviderElement
    extends AutoDisposeStreamProviderElement<StudentSummary?>
    with StudentSummaryRef {
  _StudentSummaryProviderElement(super.provider);

  @override
  String get studentId => (origin as StudentSummaryProvider).studentId;
}

String _$mySummaryHash() => r'67237047e5bd93cd44c324b9befd64aa5a5fc980';

/// Сводка текущего пользователя (по `appUserProvider`).
///
/// Copied from [mySummary].
@ProviderFor(mySummary)
final mySummaryProvider = AutoDisposeStreamProvider<StudentSummary?>.internal(
  mySummary,
  name: r'mySummaryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$mySummaryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef MySummaryRef = AutoDisposeStreamProviderRef<StudentSummary?>;
String _$groupSummaryHash() => r'12715470fb090e904b84a9ab1df3d770b805bccc';

/// Сводка группы по id (P3-2).
///
/// Copied from [groupSummary].
@ProviderFor(groupSummary)
const groupSummaryProvider = GroupSummaryFamily();

/// Сводка группы по id (P3-2).
///
/// Copied from [groupSummary].
class GroupSummaryFamily extends Family<AsyncValue<GroupSummary?>> {
  /// Сводка группы по id (P3-2).
  ///
  /// Copied from [groupSummary].
  const GroupSummaryFamily();

  /// Сводка группы по id (P3-2).
  ///
  /// Copied from [groupSummary].
  GroupSummaryProvider call(String groupId) {
    return GroupSummaryProvider(groupId);
  }

  @override
  GroupSummaryProvider getProviderOverride(
    covariant GroupSummaryProvider provider,
  ) {
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
  String? get name => r'groupSummaryProvider';
}

/// Сводка группы по id (P3-2).
///
/// Copied from [groupSummary].
class GroupSummaryProvider extends AutoDisposeStreamProvider<GroupSummary?> {
  /// Сводка группы по id (P3-2).
  ///
  /// Copied from [groupSummary].
  GroupSummaryProvider(String groupId)
    : this._internal(
        (ref) => groupSummary(ref as GroupSummaryRef, groupId),
        from: groupSummaryProvider,
        name: r'groupSummaryProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$groupSummaryHash,
        dependencies: GroupSummaryFamily._dependencies,
        allTransitiveDependencies:
            GroupSummaryFamily._allTransitiveDependencies,
        groupId: groupId,
      );

  GroupSummaryProvider._internal(
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
  Override overrideWith(
    Stream<GroupSummary?> Function(GroupSummaryRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GroupSummaryProvider._internal(
        (ref) => create(ref as GroupSummaryRef),
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
  AutoDisposeStreamProviderElement<GroupSummary?> createElement() {
    return _GroupSummaryProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GroupSummaryProvider && other.groupId == groupId;
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
mixin GroupSummaryRef on AutoDisposeStreamProviderRef<GroupSummary?> {
  /// The parameter `groupId` of this provider.
  String get groupId;
}

class _GroupSummaryProviderElement
    extends AutoDisposeStreamProviderElement<GroupSummary?>
    with GroupSummaryRef {
  _GroupSummaryProviderElement(super.provider);

  @override
  String get groupId => (origin as GroupSummaryProvider).groupId;
}

String _$courseSummaryHash() => r'f5868e745519f716b426afc6a87eb97696cad93e';

/// Сводка курса по id (P3-3).
///
/// Copied from [courseSummary].
@ProviderFor(courseSummary)
const courseSummaryProvider = CourseSummaryFamily();

/// Сводка курса по id (P3-3).
///
/// Copied from [courseSummary].
class CourseSummaryFamily extends Family<AsyncValue<CourseSummary?>> {
  /// Сводка курса по id (P3-3).
  ///
  /// Copied from [courseSummary].
  const CourseSummaryFamily();

  /// Сводка курса по id (P3-3).
  ///
  /// Copied from [courseSummary].
  CourseSummaryProvider call(String courseId) {
    return CourseSummaryProvider(courseId);
  }

  @override
  CourseSummaryProvider getProviderOverride(
    covariant CourseSummaryProvider provider,
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
  String? get name => r'courseSummaryProvider';
}

/// Сводка курса по id (P3-3).
///
/// Copied from [courseSummary].
class CourseSummaryProvider extends AutoDisposeStreamProvider<CourseSummary?> {
  /// Сводка курса по id (P3-3).
  ///
  /// Copied from [courseSummary].
  CourseSummaryProvider(String courseId)
    : this._internal(
        (ref) => courseSummary(ref as CourseSummaryRef, courseId),
        from: courseSummaryProvider,
        name: r'courseSummaryProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$courseSummaryHash,
        dependencies: CourseSummaryFamily._dependencies,
        allTransitiveDependencies:
            CourseSummaryFamily._allTransitiveDependencies,
        courseId: courseId,
      );

  CourseSummaryProvider._internal(
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
    Stream<CourseSummary?> Function(CourseSummaryRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: CourseSummaryProvider._internal(
        (ref) => create(ref as CourseSummaryRef),
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
  AutoDisposeStreamProviderElement<CourseSummary?> createElement() {
    return _CourseSummaryProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CourseSummaryProvider && other.courseId == courseId;
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
mixin CourseSummaryRef on AutoDisposeStreamProviderRef<CourseSummary?> {
  /// The parameter `courseId` of this provider.
  String get courseId;
}

class _CourseSummaryProviderElement
    extends AutoDisposeStreamProviderElement<CourseSummary?>
    with CourseSummaryRef {
  _CourseSummaryProviderElement(super.provider);

  @override
  String get courseId => (origin as CourseSummaryProvider).courseId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
