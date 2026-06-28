// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'material_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$materialRepositoryHash() =>
    r'ec1481850324f8bd797644c2521d2e7804e7c20d';

/// Репозиторий материалов недели.
///
/// Copied from [materialRepository].
@ProviderFor(materialRepository)
final materialRepositoryProvider = Provider<MaterialRepository>.internal(
  materialRepository,
  name: r'materialRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$materialRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef MaterialRepositoryRef = ProviderRef<MaterialRepository>;
String _$materialsHash() => r'0b4467f7ec170ad8e0f1ebcab3761f2444e280f8';

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

/// Все материалы недели по порядку (преподаватель).
///
/// Copied from [materials].
@ProviderFor(materials)
const materialsProvider = MaterialsFamily();

/// Все материалы недели по порядку (преподаватель).
///
/// Copied from [materials].
class MaterialsFamily extends Family<AsyncValue<List<CourseMaterial>>> {
  /// Все материалы недели по порядку (преподаватель).
  ///
  /// Copied from [materials].
  const MaterialsFamily();

  /// Все материалы недели по порядку (преподаватель).
  ///
  /// Copied from [materials].
  MaterialsProvider call(String weekId) {
    return MaterialsProvider(weekId);
  }

  @override
  MaterialsProvider getProviderOverride(covariant MaterialsProvider provider) {
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
  String? get name => r'materialsProvider';
}

/// Все материалы недели по порядку (преподаватель).
///
/// Copied from [materials].
class MaterialsProvider
    extends AutoDisposeStreamProvider<List<CourseMaterial>> {
  /// Все материалы недели по порядку (преподаватель).
  ///
  /// Copied from [materials].
  MaterialsProvider(String weekId)
    : this._internal(
        (ref) => materials(ref as MaterialsRef, weekId),
        from: materialsProvider,
        name: r'materialsProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$materialsHash,
        dependencies: MaterialsFamily._dependencies,
        allTransitiveDependencies: MaterialsFamily._allTransitiveDependencies,
        weekId: weekId,
      );

  MaterialsProvider._internal(
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
    Stream<List<CourseMaterial>> Function(MaterialsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: MaterialsProvider._internal(
        (ref) => create(ref as MaterialsRef),
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
  AutoDisposeStreamProviderElement<List<CourseMaterial>> createElement() {
    return _MaterialsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is MaterialsProvider && other.weekId == weekId;
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
mixin MaterialsRef on AutoDisposeStreamProviderRef<List<CourseMaterial>> {
  /// The parameter `weekId` of this provider.
  String get weekId;
}

class _MaterialsProviderElement
    extends AutoDisposeStreamProviderElement<List<CourseMaterial>>
    with MaterialsRef {
  _MaterialsProviderElement(super.provider);

  @override
  String get weekId => (origin as MaterialsProvider).weekId;
}

String _$publishedMaterialsHash() =>
    r'e11bc4f6248f265cf13054eb2a6bff52cbaff01e';

/// Только опубликованные материалы недели (студент).
///
/// Copied from [publishedMaterials].
@ProviderFor(publishedMaterials)
const publishedMaterialsProvider = PublishedMaterialsFamily();

/// Только опубликованные материалы недели (студент).
///
/// Copied from [publishedMaterials].
class PublishedMaterialsFamily
    extends Family<AsyncValue<List<CourseMaterial>>> {
  /// Только опубликованные материалы недели (студент).
  ///
  /// Copied from [publishedMaterials].
  const PublishedMaterialsFamily();

  /// Только опубликованные материалы недели (студент).
  ///
  /// Copied from [publishedMaterials].
  PublishedMaterialsProvider call(String weekId) {
    return PublishedMaterialsProvider(weekId);
  }

  @override
  PublishedMaterialsProvider getProviderOverride(
    covariant PublishedMaterialsProvider provider,
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
  String? get name => r'publishedMaterialsProvider';
}

/// Только опубликованные материалы недели (студент).
///
/// Copied from [publishedMaterials].
class PublishedMaterialsProvider
    extends AutoDisposeStreamProvider<List<CourseMaterial>> {
  /// Только опубликованные материалы недели (студент).
  ///
  /// Copied from [publishedMaterials].
  PublishedMaterialsProvider(String weekId)
    : this._internal(
        (ref) => publishedMaterials(ref as PublishedMaterialsRef, weekId),
        from: publishedMaterialsProvider,
        name: r'publishedMaterialsProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$publishedMaterialsHash,
        dependencies: PublishedMaterialsFamily._dependencies,
        allTransitiveDependencies:
            PublishedMaterialsFamily._allTransitiveDependencies,
        weekId: weekId,
      );

  PublishedMaterialsProvider._internal(
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
    Stream<List<CourseMaterial>> Function(PublishedMaterialsRef provider)
    create,
  ) {
    return ProviderOverride(
      origin: this,
      override: PublishedMaterialsProvider._internal(
        (ref) => create(ref as PublishedMaterialsRef),
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
  AutoDisposeStreamProviderElement<List<CourseMaterial>> createElement() {
    return _PublishedMaterialsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PublishedMaterialsProvider && other.weekId == weekId;
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
mixin PublishedMaterialsRef
    on AutoDisposeStreamProviderRef<List<CourseMaterial>> {
  /// The parameter `weekId` of this provider.
  String get weekId;
}

class _PublishedMaterialsProviderElement
    extends AutoDisposeStreamProviderElement<List<CourseMaterial>>
    with PublishedMaterialsRef {
  _PublishedMaterialsProviderElement(super.provider);

  @override
  String get weekId => (origin as PublishedMaterialsProvider).weekId;
}

String _$materialByIdHash() => r'8af902082fa5c5b0d31742862f6720c46865c499';

/// Один материал по id (форма редактирования).
///
/// Copied from [materialById].
@ProviderFor(materialById)
const materialByIdProvider = MaterialByIdFamily();

/// Один материал по id (форма редактирования).
///
/// Copied from [materialById].
class MaterialByIdFamily extends Family<AsyncValue<CourseMaterial?>> {
  /// Один материал по id (форма редактирования).
  ///
  /// Copied from [materialById].
  const MaterialByIdFamily();

  /// Один материал по id (форма редактирования).
  ///
  /// Copied from [materialById].
  MaterialByIdProvider call(String materialId) {
    return MaterialByIdProvider(materialId);
  }

  @override
  MaterialByIdProvider getProviderOverride(
    covariant MaterialByIdProvider provider,
  ) {
    return call(provider.materialId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'materialByIdProvider';
}

/// Один материал по id (форма редактирования).
///
/// Copied from [materialById].
class MaterialByIdProvider extends AutoDisposeFutureProvider<CourseMaterial?> {
  /// Один материал по id (форма редактирования).
  ///
  /// Copied from [materialById].
  MaterialByIdProvider(String materialId)
    : this._internal(
        (ref) => materialById(ref as MaterialByIdRef, materialId),
        from: materialByIdProvider,
        name: r'materialByIdProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$materialByIdHash,
        dependencies: MaterialByIdFamily._dependencies,
        allTransitiveDependencies:
            MaterialByIdFamily._allTransitiveDependencies,
        materialId: materialId,
      );

  MaterialByIdProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.materialId,
  }) : super.internal();

  final String materialId;

  @override
  Override overrideWith(
    FutureOr<CourseMaterial?> Function(MaterialByIdRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: MaterialByIdProvider._internal(
        (ref) => create(ref as MaterialByIdRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        materialId: materialId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<CourseMaterial?> createElement() {
    return _MaterialByIdProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is MaterialByIdProvider && other.materialId == materialId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, materialId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin MaterialByIdRef on AutoDisposeFutureProviderRef<CourseMaterial?> {
  /// The parameter `materialId` of this provider.
  String get materialId;
}

class _MaterialByIdProviderElement
    extends AutoDisposeFutureProviderElement<CourseMaterial?>
    with MaterialByIdRef {
  _MaterialByIdProviderElement(super.provider);

  @override
  String get materialId => (origin as MaterialByIdProvider).materialId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
