// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'question.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Question {

 String get questionId; String get ownerTeacherId; List<String> get courseIds; String get text; QuestionType get type; String get topic; List<String> get tags; QuestionDifficulty get difficulty; int get points; String get explanation; QuestionStatus get status; List<String> get options; int? get correctIndex; List<int> get correctIndexes; bool? get correctBool; List<String> get acceptedAnswers; bool get caseSensitive; bool get partialScoring;@TimestampConverter() DateTime get createdAt;@TimestampConverter() DateTime get updatedAt;
/// Create a copy of Question
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QuestionCopyWith<Question> get copyWith => _$QuestionCopyWithImpl<Question>(this as Question, _$identity);

  /// Serializes this Question to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Question&&(identical(other.questionId, questionId) || other.questionId == questionId)&&(identical(other.ownerTeacherId, ownerTeacherId) || other.ownerTeacherId == ownerTeacherId)&&const DeepCollectionEquality().equals(other.courseIds, courseIds)&&(identical(other.text, text) || other.text == text)&&(identical(other.type, type) || other.type == type)&&(identical(other.topic, topic) || other.topic == topic)&&const DeepCollectionEquality().equals(other.tags, tags)&&(identical(other.difficulty, difficulty) || other.difficulty == difficulty)&&(identical(other.points, points) || other.points == points)&&(identical(other.explanation, explanation) || other.explanation == explanation)&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.options, options)&&(identical(other.correctIndex, correctIndex) || other.correctIndex == correctIndex)&&const DeepCollectionEquality().equals(other.correctIndexes, correctIndexes)&&(identical(other.correctBool, correctBool) || other.correctBool == correctBool)&&const DeepCollectionEquality().equals(other.acceptedAnswers, acceptedAnswers)&&(identical(other.caseSensitive, caseSensitive) || other.caseSensitive == caseSensitive)&&(identical(other.partialScoring, partialScoring) || other.partialScoring == partialScoring)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,questionId,ownerTeacherId,const DeepCollectionEquality().hash(courseIds),text,type,topic,const DeepCollectionEquality().hash(tags),difficulty,points,explanation,status,const DeepCollectionEquality().hash(options),correctIndex,const DeepCollectionEquality().hash(correctIndexes),correctBool,const DeepCollectionEquality().hash(acceptedAnswers),caseSensitive,partialScoring,createdAt,updatedAt]);

@override
String toString() {
  return 'Question(questionId: $questionId, ownerTeacherId: $ownerTeacherId, courseIds: $courseIds, text: $text, type: $type, topic: $topic, tags: $tags, difficulty: $difficulty, points: $points, explanation: $explanation, status: $status, options: $options, correctIndex: $correctIndex, correctIndexes: $correctIndexes, correctBool: $correctBool, acceptedAnswers: $acceptedAnswers, caseSensitive: $caseSensitive, partialScoring: $partialScoring, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $QuestionCopyWith<$Res>  {
  factory $QuestionCopyWith(Question value, $Res Function(Question) _then) = _$QuestionCopyWithImpl;
@useResult
$Res call({
 String questionId, String ownerTeacherId, List<String> courseIds, String text, QuestionType type, String topic, List<String> tags, QuestionDifficulty difficulty, int points, String explanation, QuestionStatus status, List<String> options, int? correctIndex, List<int> correctIndexes, bool? correctBool, List<String> acceptedAnswers, bool caseSensitive, bool partialScoring,@TimestampConverter() DateTime createdAt,@TimestampConverter() DateTime updatedAt
});




}
/// @nodoc
class _$QuestionCopyWithImpl<$Res>
    implements $QuestionCopyWith<$Res> {
  _$QuestionCopyWithImpl(this._self, this._then);

  final Question _self;
  final $Res Function(Question) _then;

/// Create a copy of Question
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? questionId = null,Object? ownerTeacherId = null,Object? courseIds = null,Object? text = null,Object? type = null,Object? topic = null,Object? tags = null,Object? difficulty = null,Object? points = null,Object? explanation = null,Object? status = null,Object? options = null,Object? correctIndex = freezed,Object? correctIndexes = null,Object? correctBool = freezed,Object? acceptedAnswers = null,Object? caseSensitive = null,Object? partialScoring = null,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_self.copyWith(
questionId: null == questionId ? _self.questionId : questionId // ignore: cast_nullable_to_non_nullable
as String,ownerTeacherId: null == ownerTeacherId ? _self.ownerTeacherId : ownerTeacherId // ignore: cast_nullable_to_non_nullable
as String,courseIds: null == courseIds ? _self.courseIds : courseIds // ignore: cast_nullable_to_non_nullable
as List<String>,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as QuestionType,topic: null == topic ? _self.topic : topic // ignore: cast_nullable_to_non_nullable
as String,tags: null == tags ? _self.tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,difficulty: null == difficulty ? _self.difficulty : difficulty // ignore: cast_nullable_to_non_nullable
as QuestionDifficulty,points: null == points ? _self.points : points // ignore: cast_nullable_to_non_nullable
as int,explanation: null == explanation ? _self.explanation : explanation // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as QuestionStatus,options: null == options ? _self.options : options // ignore: cast_nullable_to_non_nullable
as List<String>,correctIndex: freezed == correctIndex ? _self.correctIndex : correctIndex // ignore: cast_nullable_to_non_nullable
as int?,correctIndexes: null == correctIndexes ? _self.correctIndexes : correctIndexes // ignore: cast_nullable_to_non_nullable
as List<int>,correctBool: freezed == correctBool ? _self.correctBool : correctBool // ignore: cast_nullable_to_non_nullable
as bool?,acceptedAnswers: null == acceptedAnswers ? _self.acceptedAnswers : acceptedAnswers // ignore: cast_nullable_to_non_nullable
as List<String>,caseSensitive: null == caseSensitive ? _self.caseSensitive : caseSensitive // ignore: cast_nullable_to_non_nullable
as bool,partialScoring: null == partialScoring ? _self.partialScoring : partialScoring // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [Question].
extension QuestionPatterns on Question {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Question value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Question() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Question value)  $default,){
final _that = this;
switch (_that) {
case _Question():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Question value)?  $default,){
final _that = this;
switch (_that) {
case _Question() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String questionId,  String ownerTeacherId,  List<String> courseIds,  String text,  QuestionType type,  String topic,  List<String> tags,  QuestionDifficulty difficulty,  int points,  String explanation,  QuestionStatus status,  List<String> options,  int? correctIndex,  List<int> correctIndexes,  bool? correctBool,  List<String> acceptedAnswers,  bool caseSensitive,  bool partialScoring, @TimestampConverter()  DateTime createdAt, @TimestampConverter()  DateTime updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Question() when $default != null:
return $default(_that.questionId,_that.ownerTeacherId,_that.courseIds,_that.text,_that.type,_that.topic,_that.tags,_that.difficulty,_that.points,_that.explanation,_that.status,_that.options,_that.correctIndex,_that.correctIndexes,_that.correctBool,_that.acceptedAnswers,_that.caseSensitive,_that.partialScoring,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String questionId,  String ownerTeacherId,  List<String> courseIds,  String text,  QuestionType type,  String topic,  List<String> tags,  QuestionDifficulty difficulty,  int points,  String explanation,  QuestionStatus status,  List<String> options,  int? correctIndex,  List<int> correctIndexes,  bool? correctBool,  List<String> acceptedAnswers,  bool caseSensitive,  bool partialScoring, @TimestampConverter()  DateTime createdAt, @TimestampConverter()  DateTime updatedAt)  $default,) {final _that = this;
switch (_that) {
case _Question():
return $default(_that.questionId,_that.ownerTeacherId,_that.courseIds,_that.text,_that.type,_that.topic,_that.tags,_that.difficulty,_that.points,_that.explanation,_that.status,_that.options,_that.correctIndex,_that.correctIndexes,_that.correctBool,_that.acceptedAnswers,_that.caseSensitive,_that.partialScoring,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String questionId,  String ownerTeacherId,  List<String> courseIds,  String text,  QuestionType type,  String topic,  List<String> tags,  QuestionDifficulty difficulty,  int points,  String explanation,  QuestionStatus status,  List<String> options,  int? correctIndex,  List<int> correctIndexes,  bool? correctBool,  List<String> acceptedAnswers,  bool caseSensitive,  bool partialScoring, @TimestampConverter()  DateTime createdAt, @TimestampConverter()  DateTime updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _Question() when $default != null:
return $default(_that.questionId,_that.ownerTeacherId,_that.courseIds,_that.text,_that.type,_that.topic,_that.tags,_that.difficulty,_that.points,_that.explanation,_that.status,_that.options,_that.correctIndex,_that.correctIndexes,_that.correctBool,_that.acceptedAnswers,_that.caseSensitive,_that.partialScoring,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Question implements Question {
  const _Question({required this.questionId, this.ownerTeacherId = '', final  List<String> courseIds = const <String>[], this.text = '', this.type = QuestionType.single, this.topic = '', final  List<String> tags = const <String>[], this.difficulty = QuestionDifficulty.basic, this.points = 1, this.explanation = '', this.status = QuestionStatus.active, final  List<String> options = const <String>[], this.correctIndex, final  List<int> correctIndexes = const <int>[], this.correctBool, final  List<String> acceptedAnswers = const <String>[], this.caseSensitive = false, this.partialScoring = false, @TimestampConverter() required this.createdAt, @TimestampConverter() required this.updatedAt}): _courseIds = courseIds,_tags = tags,_options = options,_correctIndexes = correctIndexes,_acceptedAnswers = acceptedAnswers;
  factory _Question.fromJson(Map<String, dynamic> json) => _$QuestionFromJson(json);

@override final  String questionId;
@override@JsonKey() final  String ownerTeacherId;
 final  List<String> _courseIds;
@override@JsonKey() List<String> get courseIds {
  if (_courseIds is EqualUnmodifiableListView) return _courseIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_courseIds);
}

@override@JsonKey() final  String text;
@override@JsonKey() final  QuestionType type;
@override@JsonKey() final  String topic;
 final  List<String> _tags;
@override@JsonKey() List<String> get tags {
  if (_tags is EqualUnmodifiableListView) return _tags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tags);
}

@override@JsonKey() final  QuestionDifficulty difficulty;
@override@JsonKey() final  int points;
@override@JsonKey() final  String explanation;
@override@JsonKey() final  QuestionStatus status;
 final  List<String> _options;
@override@JsonKey() List<String> get options {
  if (_options is EqualUnmodifiableListView) return _options;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_options);
}

@override final  int? correctIndex;
 final  List<int> _correctIndexes;
@override@JsonKey() List<int> get correctIndexes {
  if (_correctIndexes is EqualUnmodifiableListView) return _correctIndexes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_correctIndexes);
}

@override final  bool? correctBool;
 final  List<String> _acceptedAnswers;
@override@JsonKey() List<String> get acceptedAnswers {
  if (_acceptedAnswers is EqualUnmodifiableListView) return _acceptedAnswers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_acceptedAnswers);
}

@override@JsonKey() final  bool caseSensitive;
@override@JsonKey() final  bool partialScoring;
@override@TimestampConverter() final  DateTime createdAt;
@override@TimestampConverter() final  DateTime updatedAt;

/// Create a copy of Question
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$QuestionCopyWith<_Question> get copyWith => __$QuestionCopyWithImpl<_Question>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$QuestionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Question&&(identical(other.questionId, questionId) || other.questionId == questionId)&&(identical(other.ownerTeacherId, ownerTeacherId) || other.ownerTeacherId == ownerTeacherId)&&const DeepCollectionEquality().equals(other._courseIds, _courseIds)&&(identical(other.text, text) || other.text == text)&&(identical(other.type, type) || other.type == type)&&(identical(other.topic, topic) || other.topic == topic)&&const DeepCollectionEquality().equals(other._tags, _tags)&&(identical(other.difficulty, difficulty) || other.difficulty == difficulty)&&(identical(other.points, points) || other.points == points)&&(identical(other.explanation, explanation) || other.explanation == explanation)&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other._options, _options)&&(identical(other.correctIndex, correctIndex) || other.correctIndex == correctIndex)&&const DeepCollectionEquality().equals(other._correctIndexes, _correctIndexes)&&(identical(other.correctBool, correctBool) || other.correctBool == correctBool)&&const DeepCollectionEquality().equals(other._acceptedAnswers, _acceptedAnswers)&&(identical(other.caseSensitive, caseSensitive) || other.caseSensitive == caseSensitive)&&(identical(other.partialScoring, partialScoring) || other.partialScoring == partialScoring)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,questionId,ownerTeacherId,const DeepCollectionEquality().hash(_courseIds),text,type,topic,const DeepCollectionEquality().hash(_tags),difficulty,points,explanation,status,const DeepCollectionEquality().hash(_options),correctIndex,const DeepCollectionEquality().hash(_correctIndexes),correctBool,const DeepCollectionEquality().hash(_acceptedAnswers),caseSensitive,partialScoring,createdAt,updatedAt]);

@override
String toString() {
  return 'Question(questionId: $questionId, ownerTeacherId: $ownerTeacherId, courseIds: $courseIds, text: $text, type: $type, topic: $topic, tags: $tags, difficulty: $difficulty, points: $points, explanation: $explanation, status: $status, options: $options, correctIndex: $correctIndex, correctIndexes: $correctIndexes, correctBool: $correctBool, acceptedAnswers: $acceptedAnswers, caseSensitive: $caseSensitive, partialScoring: $partialScoring, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$QuestionCopyWith<$Res> implements $QuestionCopyWith<$Res> {
  factory _$QuestionCopyWith(_Question value, $Res Function(_Question) _then) = __$QuestionCopyWithImpl;
@override @useResult
$Res call({
 String questionId, String ownerTeacherId, List<String> courseIds, String text, QuestionType type, String topic, List<String> tags, QuestionDifficulty difficulty, int points, String explanation, QuestionStatus status, List<String> options, int? correctIndex, List<int> correctIndexes, bool? correctBool, List<String> acceptedAnswers, bool caseSensitive, bool partialScoring,@TimestampConverter() DateTime createdAt,@TimestampConverter() DateTime updatedAt
});




}
/// @nodoc
class __$QuestionCopyWithImpl<$Res>
    implements _$QuestionCopyWith<$Res> {
  __$QuestionCopyWithImpl(this._self, this._then);

  final _Question _self;
  final $Res Function(_Question) _then;

/// Create a copy of Question
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? questionId = null,Object? ownerTeacherId = null,Object? courseIds = null,Object? text = null,Object? type = null,Object? topic = null,Object? tags = null,Object? difficulty = null,Object? points = null,Object? explanation = null,Object? status = null,Object? options = null,Object? correctIndex = freezed,Object? correctIndexes = null,Object? correctBool = freezed,Object? acceptedAnswers = null,Object? caseSensitive = null,Object? partialScoring = null,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_Question(
questionId: null == questionId ? _self.questionId : questionId // ignore: cast_nullable_to_non_nullable
as String,ownerTeacherId: null == ownerTeacherId ? _self.ownerTeacherId : ownerTeacherId // ignore: cast_nullable_to_non_nullable
as String,courseIds: null == courseIds ? _self._courseIds : courseIds // ignore: cast_nullable_to_non_nullable
as List<String>,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as QuestionType,topic: null == topic ? _self.topic : topic // ignore: cast_nullable_to_non_nullable
as String,tags: null == tags ? _self._tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,difficulty: null == difficulty ? _self.difficulty : difficulty // ignore: cast_nullable_to_non_nullable
as QuestionDifficulty,points: null == points ? _self.points : points // ignore: cast_nullable_to_non_nullable
as int,explanation: null == explanation ? _self.explanation : explanation // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as QuestionStatus,options: null == options ? _self._options : options // ignore: cast_nullable_to_non_nullable
as List<String>,correctIndex: freezed == correctIndex ? _self.correctIndex : correctIndex // ignore: cast_nullable_to_non_nullable
as int?,correctIndexes: null == correctIndexes ? _self._correctIndexes : correctIndexes // ignore: cast_nullable_to_non_nullable
as List<int>,correctBool: freezed == correctBool ? _self.correctBool : correctBool // ignore: cast_nullable_to_non_nullable
as bool?,acceptedAnswers: null == acceptedAnswers ? _self._acceptedAnswers : acceptedAnswers // ignore: cast_nullable_to_non_nullable
as List<String>,caseSensitive: null == caseSensitive ? _self.caseSensitive : caseSensitive // ignore: cast_nullable_to_non_nullable
as bool,partialScoring: null == partialScoring ? _self.partialScoring : partialScoring // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
