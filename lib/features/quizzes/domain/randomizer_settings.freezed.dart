// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'randomizer_settings.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RandomizerSettings {

 int get totalQuestions; Map<String, int> get byTopic; Map<String, int> get byType; Map<String, int> get byDifficulty; int? get minHard; int? get maxBasic; bool get shuffleQuestions; bool get shuffleOptions; bool get excludeDuplicates;
/// Create a copy of RandomizerSettings
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RandomizerSettingsCopyWith<RandomizerSettings> get copyWith => _$RandomizerSettingsCopyWithImpl<RandomizerSettings>(this as RandomizerSettings, _$identity);

  /// Serializes this RandomizerSettings to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RandomizerSettings&&(identical(other.totalQuestions, totalQuestions) || other.totalQuestions == totalQuestions)&&const DeepCollectionEquality().equals(other.byTopic, byTopic)&&const DeepCollectionEquality().equals(other.byType, byType)&&const DeepCollectionEquality().equals(other.byDifficulty, byDifficulty)&&(identical(other.minHard, minHard) || other.minHard == minHard)&&(identical(other.maxBasic, maxBasic) || other.maxBasic == maxBasic)&&(identical(other.shuffleQuestions, shuffleQuestions) || other.shuffleQuestions == shuffleQuestions)&&(identical(other.shuffleOptions, shuffleOptions) || other.shuffleOptions == shuffleOptions)&&(identical(other.excludeDuplicates, excludeDuplicates) || other.excludeDuplicates == excludeDuplicates));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,totalQuestions,const DeepCollectionEquality().hash(byTopic),const DeepCollectionEquality().hash(byType),const DeepCollectionEquality().hash(byDifficulty),minHard,maxBasic,shuffleQuestions,shuffleOptions,excludeDuplicates);

@override
String toString() {
  return 'RandomizerSettings(totalQuestions: $totalQuestions, byTopic: $byTopic, byType: $byType, byDifficulty: $byDifficulty, minHard: $minHard, maxBasic: $maxBasic, shuffleQuestions: $shuffleQuestions, shuffleOptions: $shuffleOptions, excludeDuplicates: $excludeDuplicates)';
}


}

/// @nodoc
abstract mixin class $RandomizerSettingsCopyWith<$Res>  {
  factory $RandomizerSettingsCopyWith(RandomizerSettings value, $Res Function(RandomizerSettings) _then) = _$RandomizerSettingsCopyWithImpl;
@useResult
$Res call({
 int totalQuestions, Map<String, int> byTopic, Map<String, int> byType, Map<String, int> byDifficulty, int? minHard, int? maxBasic, bool shuffleQuestions, bool shuffleOptions, bool excludeDuplicates
});




}
/// @nodoc
class _$RandomizerSettingsCopyWithImpl<$Res>
    implements $RandomizerSettingsCopyWith<$Res> {
  _$RandomizerSettingsCopyWithImpl(this._self, this._then);

  final RandomizerSettings _self;
  final $Res Function(RandomizerSettings) _then;

/// Create a copy of RandomizerSettings
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? totalQuestions = null,Object? byTopic = null,Object? byType = null,Object? byDifficulty = null,Object? minHard = freezed,Object? maxBasic = freezed,Object? shuffleQuestions = null,Object? shuffleOptions = null,Object? excludeDuplicates = null,}) {
  return _then(_self.copyWith(
totalQuestions: null == totalQuestions ? _self.totalQuestions : totalQuestions // ignore: cast_nullable_to_non_nullable
as int,byTopic: null == byTopic ? _self.byTopic : byTopic // ignore: cast_nullable_to_non_nullable
as Map<String, int>,byType: null == byType ? _self.byType : byType // ignore: cast_nullable_to_non_nullable
as Map<String, int>,byDifficulty: null == byDifficulty ? _self.byDifficulty : byDifficulty // ignore: cast_nullable_to_non_nullable
as Map<String, int>,minHard: freezed == minHard ? _self.minHard : minHard // ignore: cast_nullable_to_non_nullable
as int?,maxBasic: freezed == maxBasic ? _self.maxBasic : maxBasic // ignore: cast_nullable_to_non_nullable
as int?,shuffleQuestions: null == shuffleQuestions ? _self.shuffleQuestions : shuffleQuestions // ignore: cast_nullable_to_non_nullable
as bool,shuffleOptions: null == shuffleOptions ? _self.shuffleOptions : shuffleOptions // ignore: cast_nullable_to_non_nullable
as bool,excludeDuplicates: null == excludeDuplicates ? _self.excludeDuplicates : excludeDuplicates // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [RandomizerSettings].
extension RandomizerSettingsPatterns on RandomizerSettings {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RandomizerSettings value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RandomizerSettings() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RandomizerSettings value)  $default,){
final _that = this;
switch (_that) {
case _RandomizerSettings():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RandomizerSettings value)?  $default,){
final _that = this;
switch (_that) {
case _RandomizerSettings() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int totalQuestions,  Map<String, int> byTopic,  Map<String, int> byType,  Map<String, int> byDifficulty,  int? minHard,  int? maxBasic,  bool shuffleQuestions,  bool shuffleOptions,  bool excludeDuplicates)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RandomizerSettings() when $default != null:
return $default(_that.totalQuestions,_that.byTopic,_that.byType,_that.byDifficulty,_that.minHard,_that.maxBasic,_that.shuffleQuestions,_that.shuffleOptions,_that.excludeDuplicates);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int totalQuestions,  Map<String, int> byTopic,  Map<String, int> byType,  Map<String, int> byDifficulty,  int? minHard,  int? maxBasic,  bool shuffleQuestions,  bool shuffleOptions,  bool excludeDuplicates)  $default,) {final _that = this;
switch (_that) {
case _RandomizerSettings():
return $default(_that.totalQuestions,_that.byTopic,_that.byType,_that.byDifficulty,_that.minHard,_that.maxBasic,_that.shuffleQuestions,_that.shuffleOptions,_that.excludeDuplicates);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int totalQuestions,  Map<String, int> byTopic,  Map<String, int> byType,  Map<String, int> byDifficulty,  int? minHard,  int? maxBasic,  bool shuffleQuestions,  bool shuffleOptions,  bool excludeDuplicates)?  $default,) {final _that = this;
switch (_that) {
case _RandomizerSettings() when $default != null:
return $default(_that.totalQuestions,_that.byTopic,_that.byType,_that.byDifficulty,_that.minHard,_that.maxBasic,_that.shuffleQuestions,_that.shuffleOptions,_that.excludeDuplicates);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RandomizerSettings implements RandomizerSettings {
  const _RandomizerSettings({this.totalQuestions = 0, final  Map<String, int> byTopic = const <String, int>{}, final  Map<String, int> byType = const <String, int>{}, final  Map<String, int> byDifficulty = const <String, int>{}, this.minHard, this.maxBasic, this.shuffleQuestions = false, this.shuffleOptions = false, this.excludeDuplicates = true}): _byTopic = byTopic,_byType = byType,_byDifficulty = byDifficulty;
  factory _RandomizerSettings.fromJson(Map<String, dynamic> json) => _$RandomizerSettingsFromJson(json);

@override@JsonKey() final  int totalQuestions;
 final  Map<String, int> _byTopic;
@override@JsonKey() Map<String, int> get byTopic {
  if (_byTopic is EqualUnmodifiableMapView) return _byTopic;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_byTopic);
}

 final  Map<String, int> _byType;
@override@JsonKey() Map<String, int> get byType {
  if (_byType is EqualUnmodifiableMapView) return _byType;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_byType);
}

 final  Map<String, int> _byDifficulty;
@override@JsonKey() Map<String, int> get byDifficulty {
  if (_byDifficulty is EqualUnmodifiableMapView) return _byDifficulty;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_byDifficulty);
}

@override final  int? minHard;
@override final  int? maxBasic;
@override@JsonKey() final  bool shuffleQuestions;
@override@JsonKey() final  bool shuffleOptions;
@override@JsonKey() final  bool excludeDuplicates;

/// Create a copy of RandomizerSettings
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RandomizerSettingsCopyWith<_RandomizerSettings> get copyWith => __$RandomizerSettingsCopyWithImpl<_RandomizerSettings>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RandomizerSettingsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RandomizerSettings&&(identical(other.totalQuestions, totalQuestions) || other.totalQuestions == totalQuestions)&&const DeepCollectionEquality().equals(other._byTopic, _byTopic)&&const DeepCollectionEquality().equals(other._byType, _byType)&&const DeepCollectionEquality().equals(other._byDifficulty, _byDifficulty)&&(identical(other.minHard, minHard) || other.minHard == minHard)&&(identical(other.maxBasic, maxBasic) || other.maxBasic == maxBasic)&&(identical(other.shuffleQuestions, shuffleQuestions) || other.shuffleQuestions == shuffleQuestions)&&(identical(other.shuffleOptions, shuffleOptions) || other.shuffleOptions == shuffleOptions)&&(identical(other.excludeDuplicates, excludeDuplicates) || other.excludeDuplicates == excludeDuplicates));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,totalQuestions,const DeepCollectionEquality().hash(_byTopic),const DeepCollectionEquality().hash(_byType),const DeepCollectionEquality().hash(_byDifficulty),minHard,maxBasic,shuffleQuestions,shuffleOptions,excludeDuplicates);

@override
String toString() {
  return 'RandomizerSettings(totalQuestions: $totalQuestions, byTopic: $byTopic, byType: $byType, byDifficulty: $byDifficulty, minHard: $minHard, maxBasic: $maxBasic, shuffleQuestions: $shuffleQuestions, shuffleOptions: $shuffleOptions, excludeDuplicates: $excludeDuplicates)';
}


}

/// @nodoc
abstract mixin class _$RandomizerSettingsCopyWith<$Res> implements $RandomizerSettingsCopyWith<$Res> {
  factory _$RandomizerSettingsCopyWith(_RandomizerSettings value, $Res Function(_RandomizerSettings) _then) = __$RandomizerSettingsCopyWithImpl;
@override @useResult
$Res call({
 int totalQuestions, Map<String, int> byTopic, Map<String, int> byType, Map<String, int> byDifficulty, int? minHard, int? maxBasic, bool shuffleQuestions, bool shuffleOptions, bool excludeDuplicates
});




}
/// @nodoc
class __$RandomizerSettingsCopyWithImpl<$Res>
    implements _$RandomizerSettingsCopyWith<$Res> {
  __$RandomizerSettingsCopyWithImpl(this._self, this._then);

  final _RandomizerSettings _self;
  final $Res Function(_RandomizerSettings) _then;

/// Create a copy of RandomizerSettings
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? totalQuestions = null,Object? byTopic = null,Object? byType = null,Object? byDifficulty = null,Object? minHard = freezed,Object? maxBasic = freezed,Object? shuffleQuestions = null,Object? shuffleOptions = null,Object? excludeDuplicates = null,}) {
  return _then(_RandomizerSettings(
totalQuestions: null == totalQuestions ? _self.totalQuestions : totalQuestions // ignore: cast_nullable_to_non_nullable
as int,byTopic: null == byTopic ? _self._byTopic : byTopic // ignore: cast_nullable_to_non_nullable
as Map<String, int>,byType: null == byType ? _self._byType : byType // ignore: cast_nullable_to_non_nullable
as Map<String, int>,byDifficulty: null == byDifficulty ? _self._byDifficulty : byDifficulty // ignore: cast_nullable_to_non_nullable
as Map<String, int>,minHard: freezed == minHard ? _self.minHard : minHard // ignore: cast_nullable_to_non_nullable
as int?,maxBasic: freezed == maxBasic ? _self.maxBasic : maxBasic // ignore: cast_nullable_to_non_nullable
as int?,shuffleQuestions: null == shuffleQuestions ? _self.shuffleQuestions : shuffleQuestions // ignore: cast_nullable_to_non_nullable
as bool,shuffleOptions: null == shuffleOptions ? _self.shuffleOptions : shuffleOptions // ignore: cast_nullable_to_non_nullable
as bool,excludeDuplicates: null == excludeDuplicates ? _self.excludeDuplicates : excludeDuplicates // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
