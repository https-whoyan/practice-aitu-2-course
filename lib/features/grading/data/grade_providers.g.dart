// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'grade_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$gradeRepositoryHash() => r'a0bab988843ff469bf9916da1a3ff314146e5b73';

/// Репозиторий оценок (общий для проверки работ, журнала и экрана студента).
///
/// Copied from [gradeRepository].
@ProviderFor(gradeRepository)
final gradeRepositoryProvider = Provider<GradeRepository>.internal(
  gradeRepository,
  name: r'gradeRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$gradeRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef GradeRepositoryRef = ProviderRef<GradeRepository>;
String _$gradesForStudentHash() => r'7bfe016b9d861f071932ea2e7ac0d1af7d09f041';

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

/// Все оценки конкретного студента (по всем курсам).
///
/// Copied from [gradesForStudent].
@ProviderFor(gradesForStudent)
const gradesForStudentProvider = GradesForStudentFamily();

/// Все оценки конкретного студента (по всем курсам).
///
/// Copied from [gradesForStudent].
class GradesForStudentFamily extends Family<AsyncValue<List<Grade>>> {
  /// Все оценки конкретного студента (по всем курсам).
  ///
  /// Copied from [gradesForStudent].
  const GradesForStudentFamily();

  /// Все оценки конкретного студента (по всем курсам).
  ///
  /// Copied from [gradesForStudent].
  GradesForStudentProvider call(String studentId) {
    return GradesForStudentProvider(studentId);
  }

  @override
  GradesForStudentProvider getProviderOverride(
    covariant GradesForStudentProvider provider,
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
  String? get name => r'gradesForStudentProvider';
}

/// Все оценки конкретного студента (по всем курсам).
///
/// Copied from [gradesForStudent].
class GradesForStudentProvider extends AutoDisposeStreamProvider<List<Grade>> {
  /// Все оценки конкретного студента (по всем курсам).
  ///
  /// Copied from [gradesForStudent].
  GradesForStudentProvider(String studentId)
    : this._internal(
        (ref) => gradesForStudent(ref as GradesForStudentRef, studentId),
        from: gradesForStudentProvider,
        name: r'gradesForStudentProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$gradesForStudentHash,
        dependencies: GradesForStudentFamily._dependencies,
        allTransitiveDependencies:
            GradesForStudentFamily._allTransitiveDependencies,
        studentId: studentId,
      );

  GradesForStudentProvider._internal(
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
    Stream<List<Grade>> Function(GradesForStudentRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GradesForStudentProvider._internal(
        (ref) => create(ref as GradesForStudentRef),
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
  AutoDisposeStreamProviderElement<List<Grade>> createElement() {
    return _GradesForStudentProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GradesForStudentProvider && other.studentId == studentId;
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
mixin GradesForStudentRef on AutoDisposeStreamProviderRef<List<Grade>> {
  /// The parameter `studentId` of this provider.
  String get studentId;
}

class _GradesForStudentProviderElement
    extends AutoDisposeStreamProviderElement<List<Grade>>
    with GradesForStudentRef {
  _GradesForStudentProviderElement(super.provider);

  @override
  String get studentId => (origin as GradesForStudentProvider).studentId;
}

String _$gradesForCourseHash() => r'6bb1050f6862e4220609e7164c23ac0593b93462';

/// Все оценки конкретного курса (журнал преподавателя).
///
/// Copied from [gradesForCourse].
@ProviderFor(gradesForCourse)
const gradesForCourseProvider = GradesForCourseFamily();

/// Все оценки конкретного курса (журнал преподавателя).
///
/// Copied from [gradesForCourse].
class GradesForCourseFamily extends Family<AsyncValue<List<Grade>>> {
  /// Все оценки конкретного курса (журнал преподавателя).
  ///
  /// Copied from [gradesForCourse].
  const GradesForCourseFamily();

  /// Все оценки конкретного курса (журнал преподавателя).
  ///
  /// Copied from [gradesForCourse].
  GradesForCourseProvider call(String courseId) {
    return GradesForCourseProvider(courseId);
  }

  @override
  GradesForCourseProvider getProviderOverride(
    covariant GradesForCourseProvider provider,
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
  String? get name => r'gradesForCourseProvider';
}

/// Все оценки конкретного курса (журнал преподавателя).
///
/// Copied from [gradesForCourse].
class GradesForCourseProvider extends AutoDisposeStreamProvider<List<Grade>> {
  /// Все оценки конкретного курса (журнал преподавателя).
  ///
  /// Copied from [gradesForCourse].
  GradesForCourseProvider(String courseId)
    : this._internal(
        (ref) => gradesForCourse(ref as GradesForCourseRef, courseId),
        from: gradesForCourseProvider,
        name: r'gradesForCourseProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$gradesForCourseHash,
        dependencies: GradesForCourseFamily._dependencies,
        allTransitiveDependencies:
            GradesForCourseFamily._allTransitiveDependencies,
        courseId: courseId,
      );

  GradesForCourseProvider._internal(
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
    Stream<List<Grade>> Function(GradesForCourseRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GradesForCourseProvider._internal(
        (ref) => create(ref as GradesForCourseRef),
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
  AutoDisposeStreamProviderElement<List<Grade>> createElement() {
    return _GradesForCourseProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GradesForCourseProvider && other.courseId == courseId;
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
mixin GradesForCourseRef on AutoDisposeStreamProviderRef<List<Grade>> {
  /// The parameter `courseId` of this provider.
  String get courseId;
}

class _GradesForCourseProviderElement
    extends AutoDisposeStreamProviderElement<List<Grade>>
    with GradesForCourseRef {
  _GradesForCourseProviderElement(super.provider);

  @override
  String get courseId => (origin as GradesForCourseProvider).courseId;
}

String _$myGradesHash() => r'32a61d63ce10c48c8f388889887637e826c4e88f';

/// Оценки текущего студента (экран «Мои оценки»).
///
/// Copied from [myGrades].
@ProviderFor(myGrades)
final myGradesProvider = AutoDisposeStreamProvider<List<Grade>>.internal(
  myGrades,
  name: r'myGradesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$myGradesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef MyGradesRef = AutoDisposeStreamProviderRef<List<Grade>>;
String _$courseStudentsHash() => r'209e19cc8ea97fc31a47a5e08b4bfca5f0c5a7a8';

/// Список студентов курса (через его группы) с именами — для пикеров журнала
/// и ручных оценок (P1-6).
///
/// Copied from [courseStudents].
@ProviderFor(courseStudents)
const courseStudentsProvider = CourseStudentsFamily();

/// Список студентов курса (через его группы) с именами — для пикеров журнала
/// и ручных оценок (P1-6).
///
/// Copied from [courseStudents].
class CourseStudentsFamily extends Family<AsyncValue<List<CourseStudent>>> {
  /// Список студентов курса (через его группы) с именами — для пикеров журнала
  /// и ручных оценок (P1-6).
  ///
  /// Copied from [courseStudents].
  const CourseStudentsFamily();

  /// Список студентов курса (через его группы) с именами — для пикеров журнала
  /// и ручных оценок (P1-6).
  ///
  /// Copied from [courseStudents].
  CourseStudentsProvider call(String courseId) {
    return CourseStudentsProvider(courseId);
  }

  @override
  CourseStudentsProvider getProviderOverride(
    covariant CourseStudentsProvider provider,
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
  String? get name => r'courseStudentsProvider';
}

/// Список студентов курса (через его группы) с именами — для пикеров журнала
/// и ручных оценок (P1-6).
///
/// Copied from [courseStudents].
class CourseStudentsProvider
    extends AutoDisposeFutureProvider<List<CourseStudent>> {
  /// Список студентов курса (через его группы) с именами — для пикеров журнала
  /// и ручных оценок (P1-6).
  ///
  /// Copied from [courseStudents].
  CourseStudentsProvider(String courseId)
    : this._internal(
        (ref) => courseStudents(ref as CourseStudentsRef, courseId),
        from: courseStudentsProvider,
        name: r'courseStudentsProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$courseStudentsHash,
        dependencies: CourseStudentsFamily._dependencies,
        allTransitiveDependencies:
            CourseStudentsFamily._allTransitiveDependencies,
        courseId: courseId,
      );

  CourseStudentsProvider._internal(
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
    FutureOr<List<CourseStudent>> Function(CourseStudentsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: CourseStudentsProvider._internal(
        (ref) => create(ref as CourseStudentsRef),
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
  AutoDisposeFutureProviderElement<List<CourseStudent>> createElement() {
    return _CourseStudentsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CourseStudentsProvider && other.courseId == courseId;
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
mixin CourseStudentsRef on AutoDisposeFutureProviderRef<List<CourseStudent>> {
  /// The parameter `courseId` of this provider.
  String get courseId;
}

class _CourseStudentsProviderElement
    extends AutoDisposeFutureProviderElement<List<CourseStudent>>
    with CourseStudentsRef {
  _CourseStudentsProviderElement(super.provider);

  @override
  String get courseId => (origin as CourseStudentsProvider).courseId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
