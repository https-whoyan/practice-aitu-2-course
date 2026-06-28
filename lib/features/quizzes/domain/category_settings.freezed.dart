// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'category_settings.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$QuizCategory {

 String get basis; int get questionCount; int get pointsPerQuestion; bool get required; int get order;
/// Create a copy of QuizCategory
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QuizCategoryCopyWith<QuizCategory> get copyWith => _$QuizCategoryCopyWithImpl<QuizCategory>(this as QuizCategory, _$identity);

  /// Serializes this QuizCategory to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QuizCategory&&(identical(other.basis, basis) || other.basis == basis)&&(identical(other.questionCount, questionCount) || other.questionCount == questionCount)&&(identical(other.pointsPerQuestion, pointsPerQuestion) || other.pointsPerQuestion == pointsPerQuestion)&&(identical(other.required, required) || other.required == required)&&(identical(other.order, order) || other.order == order));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,basis,questionCount,pointsPerQuestion,required,order);

@override
String toString() {
  return 'QuizCategory(basis: $basis, questionCount: $questionCount, pointsPerQuestion: $pointsPerQuestion, required: $required, order: $order)';
}


}

/// @nodoc
abstract mixin class $QuizCategoryCopyWith<$Res>  {
  factory $QuizCategoryCopyWith(QuizCategory value, $Res Function(QuizCategory) _then) = _$QuizCategoryCopyWithImpl;
@useResult
$Res call({
 String basis, int questionCount, int pointsPerQuestion, bool required, int order
});




}
/// @nodoc
class _$QuizCategoryCopyWithImpl<$Res>
    implements $QuizCategoryCopyWith<$Res> {
  _$QuizCategoryCopyWithImpl(this._self, this._then);

  final QuizCategory _self;
  final $Res Function(QuizCategory) _then;

/// Create a copy of QuizCategory
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? basis = null,Object? questionCount = null,Object? pointsPerQuestion = null,Object? required = null,Object? order = null,}) {
  return _then(_self.copyWith(
basis: null == basis ? _self.basis : basis // ignore: cast_nullable_to_non_nullable
as String,questionCount: null == questionCount ? _self.questionCount : questionCount // ignore: cast_nullable_to_non_nullable
as int,pointsPerQuestion: null == pointsPerQuestion ? _self.pointsPerQuestion : pointsPerQuestion // ignore: cast_nullable_to_non_nullable
as int,required: null == required ? _self.required : required // ignore: cast_nullable_to_non_nullable
as bool,order: null == order ? _self.order : order // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [QuizCategory].
extension QuizCategoryPatterns on QuizCategory {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _QuizCategory value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _QuizCategory() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _QuizCategory value)  $default,){
final _that = this;
switch (_that) {
case _QuizCategory():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _QuizCategory value)?  $default,){
final _that = this;
switch (_that) {
case _QuizCategory() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String basis,  int questionCount,  int pointsPerQuestion,  bool required,  int order)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _QuizCategory() when $default != null:
return $default(_that.basis,_that.questionCount,_that.pointsPerQuestion,_that.required,_that.order);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String basis,  int questionCount,  int pointsPerQuestion,  bool required,  int order)  $default,) {final _that = this;
switch (_that) {
case _QuizCategory():
return $default(_that.basis,_that.questionCount,_that.pointsPerQuestion,_that.required,_that.order);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String basis,  int questionCount,  int pointsPerQuestion,  bool required,  int order)?  $default,) {final _that = this;
switch (_that) {
case _QuizCategory() when $default != null:
return $default(_that.basis,_that.questionCount,_that.pointsPerQuestion,_that.required,_that.order);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _QuizCategory implements QuizCategory {
  const _QuizCategory({this.basis = 'topic', this.questionCount = 0, this.pointsPerQuestion = 1, this.required = true, this.order = 0});
  factory _QuizCategory.fromJson(Map<String, dynamic> json) => _$QuizCategoryFromJson(json);

@override@JsonKey() final  String basis;
@override@JsonKey() final  int questionCount;
@override@JsonKey() final  int pointsPerQuestion;
@override@JsonKey() final  bool required;
@override@JsonKey() final  int order;

/// Create a copy of QuizCategory
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$QuizCategoryCopyWith<_QuizCategory> get copyWith => __$QuizCategoryCopyWithImpl<_QuizCategory>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$QuizCategoryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _QuizCategory&&(identical(other.basis, basis) || other.basis == basis)&&(identical(other.questionCount, questionCount) || other.questionCount == questionCount)&&(identical(other.pointsPerQuestion, pointsPerQuestion) || other.pointsPerQuestion == pointsPerQuestion)&&(identical(other.required, required) || other.required == required)&&(identical(other.order, order) || other.order == order));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,basis,questionCount,pointsPerQuestion,required,order);

@override
String toString() {
  return 'QuizCategory(basis: $basis, questionCount: $questionCount, pointsPerQuestion: $pointsPerQuestion, required: $required, order: $order)';
}


}

/// @nodoc
abstract mixin class _$QuizCategoryCopyWith<$Res> implements $QuizCategoryCopyWith<$Res> {
  factory _$QuizCategoryCopyWith(_QuizCategory value, $Res Function(_QuizCategory) _then) = __$QuizCategoryCopyWithImpl;
@override @useResult
$Res call({
 String basis, int questionCount, int pointsPerQuestion, bool required, int order
});




}
/// @nodoc
class __$QuizCategoryCopyWithImpl<$Res>
    implements _$QuizCategoryCopyWith<$Res> {
  __$QuizCategoryCopyWithImpl(this._self, this._then);

  final _QuizCategory _self;
  final $Res Function(_QuizCategory) _then;

/// Create a copy of QuizCategory
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? basis = null,Object? questionCount = null,Object? pointsPerQuestion = null,Object? required = null,Object? order = null,}) {
  return _then(_QuizCategory(
basis: null == basis ? _self.basis : basis // ignore: cast_nullable_to_non_nullable
as String,questionCount: null == questionCount ? _self.questionCount : questionCount // ignore: cast_nullable_to_non_nullable
as int,pointsPerQuestion: null == pointsPerQuestion ? _self.pointsPerQuestion : pointsPerQuestion // ignore: cast_nullable_to_non_nullable
as int,required: null == required ? _self.required : required // ignore: cast_nullable_to_non_nullable
as bool,order: null == order ? _self.order : order // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$CategorySettings {

 List<QuizCategory> get categories;
/// Create a copy of CategorySettings
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CategorySettingsCopyWith<CategorySettings> get copyWith => _$CategorySettingsCopyWithImpl<CategorySettings>(this as CategorySettings, _$identity);

  /// Serializes this CategorySettings to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CategorySettings&&const DeepCollectionEquality().equals(other.categories, categories));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(categories));

@override
String toString() {
  return 'CategorySettings(categories: $categories)';
}


}

/// @nodoc
abstract mixin class $CategorySettingsCopyWith<$Res>  {
  factory $CategorySettingsCopyWith(CategorySettings value, $Res Function(CategorySettings) _then) = _$CategorySettingsCopyWithImpl;
@useResult
$Res call({
 List<QuizCategory> categories
});




}
/// @nodoc
class _$CategorySettingsCopyWithImpl<$Res>
    implements $CategorySettingsCopyWith<$Res> {
  _$CategorySettingsCopyWithImpl(this._self, this._then);

  final CategorySettings _self;
  final $Res Function(CategorySettings) _then;

/// Create a copy of CategorySettings
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? categories = null,}) {
  return _then(_self.copyWith(
categories: null == categories ? _self.categories : categories // ignore: cast_nullable_to_non_nullable
as List<QuizCategory>,
  ));
}

}


/// Adds pattern-matching-related methods to [CategorySettings].
extension CategorySettingsPatterns on CategorySettings {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CategorySettings value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CategorySettings() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CategorySettings value)  $default,){
final _that = this;
switch (_that) {
case _CategorySettings():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CategorySettings value)?  $default,){
final _that = this;
switch (_that) {
case _CategorySettings() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<QuizCategory> categories)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CategorySettings() when $default != null:
return $default(_that.categories);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<QuizCategory> categories)  $default,) {final _that = this;
switch (_that) {
case _CategorySettings():
return $default(_that.categories);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<QuizCategory> categories)?  $default,) {final _that = this;
switch (_that) {
case _CategorySettings() when $default != null:
return $default(_that.categories);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CategorySettings implements CategorySettings {
  const _CategorySettings({final  List<QuizCategory> categories = const <QuizCategory>[]}): _categories = categories;
  factory _CategorySettings.fromJson(Map<String, dynamic> json) => _$CategorySettingsFromJson(json);

 final  List<QuizCategory> _categories;
@override@JsonKey() List<QuizCategory> get categories {
  if (_categories is EqualUnmodifiableListView) return _categories;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_categories);
}


/// Create a copy of CategorySettings
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CategorySettingsCopyWith<_CategorySettings> get copyWith => __$CategorySettingsCopyWithImpl<_CategorySettings>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CategorySettingsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CategorySettings&&const DeepCollectionEquality().equals(other._categories, _categories));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_categories));

@override
String toString() {
  return 'CategorySettings(categories: $categories)';
}


}

/// @nodoc
abstract mixin class _$CategorySettingsCopyWith<$Res> implements $CategorySettingsCopyWith<$Res> {
  factory _$CategorySettingsCopyWith(_CategorySettings value, $Res Function(_CategorySettings) _then) = __$CategorySettingsCopyWithImpl;
@override @useResult
$Res call({
 List<QuizCategory> categories
});




}
/// @nodoc
class __$CategorySettingsCopyWithImpl<$Res>
    implements _$CategorySettingsCopyWith<$Res> {
  __$CategorySettingsCopyWithImpl(this._self, this._then);

  final _CategorySettings _self;
  final $Res Function(_CategorySettings) _then;

/// Create a copy of CategorySettings
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? categories = null,}) {
  return _then(_CategorySettings(
categories: null == categories ? _self._categories : categories // ignore: cast_nullable_to_non_nullable
as List<QuizCategory>,
  ));
}


}

// dart format on
