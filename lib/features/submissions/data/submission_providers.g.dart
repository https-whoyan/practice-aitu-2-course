// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'submission_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$submissionRepositoryHash() =>
    r'9c84a6440759a1c3407bd0c60ff14d6a87fd2aad';

/// Репозиторий ответов студентов (общий для шагов 18 и 19).
///
/// Copied from [submissionRepository].
@ProviderFor(submissionRepository)
final submissionRepositoryProvider = Provider<SubmissionRepository>.internal(
  submissionRepository,
  name: r'submissionRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$submissionRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SubmissionRepositoryRef = ProviderRef<SubmissionRepository>;
String _$mySubmissionHash() => r'e78223a0aa08f2f78a713fa33f7e44daa1b6af05';

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

/// Ответ текущего студента на задание (для экрана отправки).
/// Если пользователь не определён — поток `null` (нечего показывать).
///
/// Copied from [mySubmission].
@ProviderFor(mySubmission)
const mySubmissionProvider = MySubmissionFamily();

/// Ответ текущего студента на задание (для экрана отправки).
/// Если пользователь не определён — поток `null` (нечего показывать).
///
/// Copied from [mySubmission].
class MySubmissionFamily extends Family<AsyncValue<Submission?>> {
  /// Ответ текущего студента на задание (для экрана отправки).
  /// Если пользователь не определён — поток `null` (нечего показывать).
  ///
  /// Copied from [mySubmission].
  const MySubmissionFamily();

  /// Ответ текущего студента на задание (для экрана отправки).
  /// Если пользователь не определён — поток `null` (нечего показывать).
  ///
  /// Copied from [mySubmission].
  MySubmissionProvider call(String assignmentId) {
    return MySubmissionProvider(assignmentId);
  }

  @override
  MySubmissionProvider getProviderOverride(
    covariant MySubmissionProvider provider,
  ) {
    return call(provider.assignmentId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'mySubmissionProvider';
}

/// Ответ текущего студента на задание (для экрана отправки).
/// Если пользователь не определён — поток `null` (нечего показывать).
///
/// Copied from [mySubmission].
class MySubmissionProvider extends AutoDisposeStreamProvider<Submission?> {
  /// Ответ текущего студента на задание (для экрана отправки).
  /// Если пользователь не определён — поток `null` (нечего показывать).
  ///
  /// Copied from [mySubmission].
  MySubmissionProvider(String assignmentId)
    : this._internal(
        (ref) => mySubmission(ref as MySubmissionRef, assignmentId),
        from: mySubmissionProvider,
        name: r'mySubmissionProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$mySubmissionHash,
        dependencies: MySubmissionFamily._dependencies,
        allTransitiveDependencies:
            MySubmissionFamily._allTransitiveDependencies,
        assignmentId: assignmentId,
      );

  MySubmissionProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.assignmentId,
  }) : super.internal();

  final String assignmentId;

  @override
  Override overrideWith(
    Stream<Submission?> Function(MySubmissionRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: MySubmissionProvider._internal(
        (ref) => create(ref as MySubmissionRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        assignmentId: assignmentId,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<Submission?> createElement() {
    return _MySubmissionProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is MySubmissionProvider && other.assignmentId == assignmentId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, assignmentId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin MySubmissionRef on AutoDisposeStreamProviderRef<Submission?> {
  /// The parameter `assignmentId` of this provider.
  String get assignmentId;
}

class _MySubmissionProviderElement
    extends AutoDisposeStreamProviderElement<Submission?>
    with MySubmissionRef {
  _MySubmissionProviderElement(super.provider);

  @override
  String get assignmentId => (origin as MySubmissionProvider).assignmentId;
}

String _$submissionsForAssignmentHash() =>
    r'aebdbadf721ff3d2594be5167337683af5f89c03';

/// Все ответы на задание (для преподавателя, шаг 19).
///
/// Copied from [submissionsForAssignment].
@ProviderFor(submissionsForAssignment)
const submissionsForAssignmentProvider = SubmissionsForAssignmentFamily();

/// Все ответы на задание (для преподавателя, шаг 19).
///
/// Copied from [submissionsForAssignment].
class SubmissionsForAssignmentFamily
    extends Family<AsyncValue<List<Submission>>> {
  /// Все ответы на задание (для преподавателя, шаг 19).
  ///
  /// Copied from [submissionsForAssignment].
  const SubmissionsForAssignmentFamily();

  /// Все ответы на задание (для преподавателя, шаг 19).
  ///
  /// Copied from [submissionsForAssignment].
  SubmissionsForAssignmentProvider call(String assignmentId) {
    return SubmissionsForAssignmentProvider(assignmentId);
  }

  @override
  SubmissionsForAssignmentProvider getProviderOverride(
    covariant SubmissionsForAssignmentProvider provider,
  ) {
    return call(provider.assignmentId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'submissionsForAssignmentProvider';
}

/// Все ответы на задание (для преподавателя, шаг 19).
///
/// Copied from [submissionsForAssignment].
class SubmissionsForAssignmentProvider
    extends AutoDisposeStreamProvider<List<Submission>> {
  /// Все ответы на задание (для преподавателя, шаг 19).
  ///
  /// Copied from [submissionsForAssignment].
  SubmissionsForAssignmentProvider(String assignmentId)
    : this._internal(
        (ref) => submissionsForAssignment(
          ref as SubmissionsForAssignmentRef,
          assignmentId,
        ),
        from: submissionsForAssignmentProvider,
        name: r'submissionsForAssignmentProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$submissionsForAssignmentHash,
        dependencies: SubmissionsForAssignmentFamily._dependencies,
        allTransitiveDependencies:
            SubmissionsForAssignmentFamily._allTransitiveDependencies,
        assignmentId: assignmentId,
      );

  SubmissionsForAssignmentProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.assignmentId,
  }) : super.internal();

  final String assignmentId;

  @override
  Override overrideWith(
    Stream<List<Submission>> Function(SubmissionsForAssignmentRef provider)
    create,
  ) {
    return ProviderOverride(
      origin: this,
      override: SubmissionsForAssignmentProvider._internal(
        (ref) => create(ref as SubmissionsForAssignmentRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        assignmentId: assignmentId,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<List<Submission>> createElement() {
    return _SubmissionsForAssignmentProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SubmissionsForAssignmentProvider &&
        other.assignmentId == assignmentId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, assignmentId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin SubmissionsForAssignmentRef
    on AutoDisposeStreamProviderRef<List<Submission>> {
  /// The parameter `assignmentId` of this provider.
  String get assignmentId;
}

class _SubmissionsForAssignmentProviderElement
    extends AutoDisposeStreamProviderElement<List<Submission>>
    with SubmissionsForAssignmentRef {
  _SubmissionsForAssignmentProviderElement(super.provider);

  @override
  String get assignmentId =>
      (origin as SubmissionsForAssignmentProvider).assignmentId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
