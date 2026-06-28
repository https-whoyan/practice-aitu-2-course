// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'question_snapshot_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$QuestionSnapshotItem {

 String get questionId; String get text; String get type; List<String> get options; List<int> get optionOrder; int get points;
/// Create a copy of QuestionSnapshotItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QuestionSnapshotItemCopyWith<QuestionSnapshotItem> get copyWith => _$QuestionSnapshotItemCopyWithImpl<QuestionSnapshotItem>(this as QuestionSnapshotItem, _$identity);

  /// Serializes this QuestionSnapshotItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QuestionSnapshotItem&&(identical(other.questionId, questionId) || other.questionId == questionId)&&(identical(other.text, text) || other.text == text)&&(identical(other.type, type) || other.type == type)&&const DeepCollectionEquality().equals(other.options, options)&&const DeepCollectionEquality().equals(other.optionOrder, optionOrder)&&(identical(other.points, points) || other.points == points));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,questionId,text,type,const DeepCollectionEquality().hash(options),const DeepCollectionEquality().hash(optionOrder),points);

@override
String toString() {
  return 'QuestionSnapshotItem(questionId: $questionId, text: $text, type: $type, options: $options, optionOrder: $optionOrder, points: $points)';
}


}

/// @nodoc
abstract mixin class $QuestionSnapshotItemCopyWith<$Res>  {
  factory $QuestionSnapshotItemCopyWith(QuestionSnapshotItem value, $Res Function(QuestionSnapshotItem) _then) = _$QuestionSnapshotItemCopyWithImpl;
@useResult
$Res call({
 String questionId, String text, String type, List<String> options, List<int> optionOrder, int points
});




}
/// @nodoc
class _$QuestionSnapshotItemCopyWithImpl<$Res>
    implements $QuestionSnapshotItemCopyWith<$Res> {
  _$QuestionSnapshotItemCopyWithImpl(this._self, this._then);

  final QuestionSnapshotItem _self;
  final $Res Function(QuestionSnapshotItem) _then;

/// Create a copy of QuestionSnapshotItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? questionId = null,Object? text = null,Object? type = null,Object? options = null,Object? optionOrder = null,Object? points = null,}) {
  return _then(_self.copyWith(
questionId: null == questionId ? _self.questionId : questionId // ignore: cast_nullable_to_non_nullable
as String,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,options: null == options ? _self.options : options // ignore: cast_nullable_to_non_nullable
as List<String>,optionOrder: null == optionOrder ? _self.optionOrder : optionOrder // ignore: cast_nullable_to_non_nullable
as List<int>,points: null == points ? _self.points : points // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [QuestionSnapshotItem].
extension QuestionSnapshotItemPatterns on QuestionSnapshotItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _QuestionSnapshotItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _QuestionSnapshotItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _QuestionSnapshotItem value)  $default,){
final _that = this;
switch (_that) {
case _QuestionSnapshotItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _QuestionSnapshotItem value)?  $default,){
final _that = this;
switch (_that) {
case _QuestionSnapshotItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String questionId,  String text,  String type,  List<String> options,  List<int> optionOrder,  int points)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _QuestionSnapshotItem() when $default != null:
return $default(_that.questionId,_that.text,_that.type,_that.options,_that.optionOrder,_that.points);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String questionId,  String text,  String type,  List<String> options,  List<int> optionOrder,  int points)  $default,) {final _that = this;
switch (_that) {
case _QuestionSnapshotItem():
return $default(_that.questionId,_that.text,_that.type,_that.options,_that.optionOrder,_that.points);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String questionId,  String text,  String type,  List<String> options,  List<int> optionOrder,  int points)?  $default,) {final _that = this;
switch (_that) {
case _QuestionSnapshotItem() when $default != null:
return $default(_that.questionId,_that.text,_that.type,_that.options,_that.optionOrder,_that.points);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _QuestionSnapshotItem implements QuestionSnapshotItem {
  const _QuestionSnapshotItem({required this.questionId, this.text = '', this.type = '', final  List<String> options = const <String>[], final  List<int> optionOrder = const <int>[], this.points = 1}): _options = options,_optionOrder = optionOrder;
  factory _QuestionSnapshotItem.fromJson(Map<String, dynamic> json) => _$QuestionSnapshotItemFromJson(json);

@override final  String questionId;
@override@JsonKey() final  String text;
@override@JsonKey() final  String type;
 final  List<String> _options;
@override@JsonKey() List<String> get options {
  if (_options is EqualUnmodifiableListView) return _options;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_options);
}

 final  List<int> _optionOrder;
@override@JsonKey() List<int> get optionOrder {
  if (_optionOrder is EqualUnmodifiableListView) return _optionOrder;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_optionOrder);
}

@override@JsonKey() final  int points;

/// Create a copy of QuestionSnapshotItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$QuestionSnapshotItemCopyWith<_QuestionSnapshotItem> get copyWith => __$QuestionSnapshotItemCopyWithImpl<_QuestionSnapshotItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$QuestionSnapshotItemToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _QuestionSnapshotItem&&(identical(other.questionId, questionId) || other.questionId == questionId)&&(identical(other.text, text) || other.text == text)&&(identical(other.type, type) || other.type == type)&&const DeepCollectionEquality().equals(other._options, _options)&&const DeepCollectionEquality().equals(other._optionOrder, _optionOrder)&&(identical(other.points, points) || other.points == points));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,questionId,text,type,const DeepCollectionEquality().hash(_options),const DeepCollectionEquality().hash(_optionOrder),points);

@override
String toString() {
  return 'QuestionSnapshotItem(questionId: $questionId, text: $text, type: $type, options: $options, optionOrder: $optionOrder, points: $points)';
}


}

/// @nodoc
abstract mixin class _$QuestionSnapshotItemCopyWith<$Res> implements $QuestionSnapshotItemCopyWith<$Res> {
  factory _$QuestionSnapshotItemCopyWith(_QuestionSnapshotItem value, $Res Function(_QuestionSnapshotItem) _then) = __$QuestionSnapshotItemCopyWithImpl;
@override @useResult
$Res call({
 String questionId, String text, String type, List<String> options, List<int> optionOrder, int points
});




}
/// @nodoc
class __$QuestionSnapshotItemCopyWithImpl<$Res>
    implements _$QuestionSnapshotItemCopyWith<$Res> {
  __$QuestionSnapshotItemCopyWithImpl(this._self, this._then);

  final _QuestionSnapshotItem _self;
  final $Res Function(_QuestionSnapshotItem) _then;

/// Create a copy of QuestionSnapshotItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? questionId = null,Object? text = null,Object? type = null,Object? options = null,Object? optionOrder = null,Object? points = null,}) {
  return _then(_QuestionSnapshotItem(
questionId: null == questionId ? _self.questionId : questionId // ignore: cast_nullable_to_non_nullable
as String,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,options: null == options ? _self._options : options // ignore: cast_nullable_to_non_nullable
as List<String>,optionOrder: null == optionOrder ? _self._optionOrder : optionOrder // ignore: cast_nullable_to_non_nullable
as List<int>,points: null == points ? _self.points : points // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
