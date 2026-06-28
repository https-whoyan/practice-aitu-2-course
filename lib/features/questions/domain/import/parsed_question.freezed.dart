// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'parsed_question.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ParsedQuestion {

 Map<String, dynamic> get fields; int get sourceLineStart; List<ImportIssue> get issues;
/// Create a copy of ParsedQuestion
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ParsedQuestionCopyWith<ParsedQuestion> get copyWith => _$ParsedQuestionCopyWithImpl<ParsedQuestion>(this as ParsedQuestion, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ParsedQuestion&&const DeepCollectionEquality().equals(other.fields, fields)&&(identical(other.sourceLineStart, sourceLineStart) || other.sourceLineStart == sourceLineStart)&&const DeepCollectionEquality().equals(other.issues, issues));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(fields),sourceLineStart,const DeepCollectionEquality().hash(issues));

@override
String toString() {
  return 'ParsedQuestion(fields: $fields, sourceLineStart: $sourceLineStart, issues: $issues)';
}


}

/// @nodoc
abstract mixin class $ParsedQuestionCopyWith<$Res>  {
  factory $ParsedQuestionCopyWith(ParsedQuestion value, $Res Function(ParsedQuestion) _then) = _$ParsedQuestionCopyWithImpl;
@useResult
$Res call({
 Map<String, dynamic> fields, int sourceLineStart, List<ImportIssue> issues
});




}
/// @nodoc
class _$ParsedQuestionCopyWithImpl<$Res>
    implements $ParsedQuestionCopyWith<$Res> {
  _$ParsedQuestionCopyWithImpl(this._self, this._then);

  final ParsedQuestion _self;
  final $Res Function(ParsedQuestion) _then;

/// Create a copy of ParsedQuestion
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? fields = null,Object? sourceLineStart = null,Object? issues = null,}) {
  return _then(_self.copyWith(
fields: null == fields ? _self.fields : fields // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,sourceLineStart: null == sourceLineStart ? _self.sourceLineStart : sourceLineStart // ignore: cast_nullable_to_non_nullable
as int,issues: null == issues ? _self.issues : issues // ignore: cast_nullable_to_non_nullable
as List<ImportIssue>,
  ));
}

}


/// Adds pattern-matching-related methods to [ParsedQuestion].
extension ParsedQuestionPatterns on ParsedQuestion {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ParsedQuestion value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ParsedQuestion() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ParsedQuestion value)  $default,){
final _that = this;
switch (_that) {
case _ParsedQuestion():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ParsedQuestion value)?  $default,){
final _that = this;
switch (_that) {
case _ParsedQuestion() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Map<String, dynamic> fields,  int sourceLineStart,  List<ImportIssue> issues)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ParsedQuestion() when $default != null:
return $default(_that.fields,_that.sourceLineStart,_that.issues);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Map<String, dynamic> fields,  int sourceLineStart,  List<ImportIssue> issues)  $default,) {final _that = this;
switch (_that) {
case _ParsedQuestion():
return $default(_that.fields,_that.sourceLineStart,_that.issues);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Map<String, dynamic> fields,  int sourceLineStart,  List<ImportIssue> issues)?  $default,) {final _that = this;
switch (_that) {
case _ParsedQuestion() when $default != null:
return $default(_that.fields,_that.sourceLineStart,_that.issues);case _:
  return null;

}
}

}

/// @nodoc


class _ParsedQuestion extends ParsedQuestion {
  const _ParsedQuestion({required final  Map<String, dynamic> fields, required this.sourceLineStart, final  List<ImportIssue> issues = const <ImportIssue>[]}): _fields = fields,_issues = issues,super._();
  

 final  Map<String, dynamic> _fields;
@override Map<String, dynamic> get fields {
  if (_fields is EqualUnmodifiableMapView) return _fields;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_fields);
}

@override final  int sourceLineStart;
 final  List<ImportIssue> _issues;
@override@JsonKey() List<ImportIssue> get issues {
  if (_issues is EqualUnmodifiableListView) return _issues;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_issues);
}


/// Create a copy of ParsedQuestion
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ParsedQuestionCopyWith<_ParsedQuestion> get copyWith => __$ParsedQuestionCopyWithImpl<_ParsedQuestion>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ParsedQuestion&&const DeepCollectionEquality().equals(other._fields, _fields)&&(identical(other.sourceLineStart, sourceLineStart) || other.sourceLineStart == sourceLineStart)&&const DeepCollectionEquality().equals(other._issues, _issues));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_fields),sourceLineStart,const DeepCollectionEquality().hash(_issues));

@override
String toString() {
  return 'ParsedQuestion(fields: $fields, sourceLineStart: $sourceLineStart, issues: $issues)';
}


}

/// @nodoc
abstract mixin class _$ParsedQuestionCopyWith<$Res> implements $ParsedQuestionCopyWith<$Res> {
  factory _$ParsedQuestionCopyWith(_ParsedQuestion value, $Res Function(_ParsedQuestion) _then) = __$ParsedQuestionCopyWithImpl;
@override @useResult
$Res call({
 Map<String, dynamic> fields, int sourceLineStart, List<ImportIssue> issues
});




}
/// @nodoc
class __$ParsedQuestionCopyWithImpl<$Res>
    implements _$ParsedQuestionCopyWith<$Res> {
  __$ParsedQuestionCopyWithImpl(this._self, this._then);

  final _ParsedQuestion _self;
  final $Res Function(_ParsedQuestion) _then;

/// Create a copy of ParsedQuestion
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? fields = null,Object? sourceLineStart = null,Object? issues = null,}) {
  return _then(_ParsedQuestion(
fields: null == fields ? _self._fields : fields // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,sourceLineStart: null == sourceLineStart ? _self.sourceLineStart : sourceLineStart // ignore: cast_nullable_to_non_nullable
as int,issues: null == issues ? _self._issues : issues // ignore: cast_nullable_to_non_nullable
as List<ImportIssue>,
  ));
}


}

// dart format on
