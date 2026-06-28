// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'import_issue.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ImportIssue {

 String get code; String get message; int? get line; bool get isWarning;
/// Create a copy of ImportIssue
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ImportIssueCopyWith<ImportIssue> get copyWith => _$ImportIssueCopyWithImpl<ImportIssue>(this as ImportIssue, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ImportIssue&&(identical(other.code, code) || other.code == code)&&(identical(other.message, message) || other.message == message)&&(identical(other.line, line) || other.line == line)&&(identical(other.isWarning, isWarning) || other.isWarning == isWarning));
}


@override
int get hashCode => Object.hash(runtimeType,code,message,line,isWarning);

@override
String toString() {
  return 'ImportIssue(code: $code, message: $message, line: $line, isWarning: $isWarning)';
}


}

/// @nodoc
abstract mixin class $ImportIssueCopyWith<$Res>  {
  factory $ImportIssueCopyWith(ImportIssue value, $Res Function(ImportIssue) _then) = _$ImportIssueCopyWithImpl;
@useResult
$Res call({
 String code, String message, int? line, bool isWarning
});




}
/// @nodoc
class _$ImportIssueCopyWithImpl<$Res>
    implements $ImportIssueCopyWith<$Res> {
  _$ImportIssueCopyWithImpl(this._self, this._then);

  final ImportIssue _self;
  final $Res Function(ImportIssue) _then;

/// Create a copy of ImportIssue
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = null,Object? message = null,Object? line = freezed,Object? isWarning = null,}) {
  return _then(_self.copyWith(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,line: freezed == line ? _self.line : line // ignore: cast_nullable_to_non_nullable
as int?,isWarning: null == isWarning ? _self.isWarning : isWarning // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [ImportIssue].
extension ImportIssuePatterns on ImportIssue {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ImportIssue value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ImportIssue() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ImportIssue value)  $default,){
final _that = this;
switch (_that) {
case _ImportIssue():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ImportIssue value)?  $default,){
final _that = this;
switch (_that) {
case _ImportIssue() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String code,  String message,  int? line,  bool isWarning)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ImportIssue() when $default != null:
return $default(_that.code,_that.message,_that.line,_that.isWarning);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String code,  String message,  int? line,  bool isWarning)  $default,) {final _that = this;
switch (_that) {
case _ImportIssue():
return $default(_that.code,_that.message,_that.line,_that.isWarning);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String code,  String message,  int? line,  bool isWarning)?  $default,) {final _that = this;
switch (_that) {
case _ImportIssue() when $default != null:
return $default(_that.code,_that.message,_that.line,_that.isWarning);case _:
  return null;

}
}

}

/// @nodoc


class _ImportIssue implements ImportIssue {
  const _ImportIssue({this.code = '', this.message = '', this.line, this.isWarning = false});
  

@override@JsonKey() final  String code;
@override@JsonKey() final  String message;
@override final  int? line;
@override@JsonKey() final  bool isWarning;

/// Create a copy of ImportIssue
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ImportIssueCopyWith<_ImportIssue> get copyWith => __$ImportIssueCopyWithImpl<_ImportIssue>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ImportIssue&&(identical(other.code, code) || other.code == code)&&(identical(other.message, message) || other.message == message)&&(identical(other.line, line) || other.line == line)&&(identical(other.isWarning, isWarning) || other.isWarning == isWarning));
}


@override
int get hashCode => Object.hash(runtimeType,code,message,line,isWarning);

@override
String toString() {
  return 'ImportIssue(code: $code, message: $message, line: $line, isWarning: $isWarning)';
}


}

/// @nodoc
abstract mixin class _$ImportIssueCopyWith<$Res> implements $ImportIssueCopyWith<$Res> {
  factory _$ImportIssueCopyWith(_ImportIssue value, $Res Function(_ImportIssue) _then) = __$ImportIssueCopyWithImpl;
@override @useResult
$Res call({
 String code, String message, int? line, bool isWarning
});




}
/// @nodoc
class __$ImportIssueCopyWithImpl<$Res>
    implements _$ImportIssueCopyWith<$Res> {
  __$ImportIssueCopyWithImpl(this._self, this._then);

  final _ImportIssue _self;
  final $Res Function(_ImportIssue) _then;

/// Create a copy of ImportIssue
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = null,Object? message = null,Object? line = freezed,Object? isWarning = null,}) {
  return _then(_ImportIssue(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,line: freezed == line ? _self.line : line // ignore: cast_nullable_to_non_nullable
as int?,isWarning: null == isWarning ? _self.isWarning : isWarning // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
