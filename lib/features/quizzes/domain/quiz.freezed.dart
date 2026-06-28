// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'quiz.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Quiz {

 String get quizId; String get courseId; String? get weekId; String get ownerTeacherId; String get title; String get description; List<String> get questionIds; RandomizerSettings get randomizerSettings; CategorySettings get categorySettings;@NullableTimestampConverter() DateTime? get startDate;@NullableTimestampConverter() DateTime? get deadline; int? get timeLimitMinutes; int get attemptsAllowed; ShowResultMode get showResultMode; int get maxScore; bool get isPublished;@TimestampConverter() DateTime get createdAt;@TimestampConverter() DateTime get updatedAt;
/// Create a copy of Quiz
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QuizCopyWith<Quiz> get copyWith => _$QuizCopyWithImpl<Quiz>(this as Quiz, _$identity);

  /// Serializes this Quiz to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Quiz&&(identical(other.quizId, quizId) || other.quizId == quizId)&&(identical(other.courseId, courseId) || other.courseId == courseId)&&(identical(other.weekId, weekId) || other.weekId == weekId)&&(identical(other.ownerTeacherId, ownerTeacherId) || other.ownerTeacherId == ownerTeacherId)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&const DeepCollectionEquality().equals(other.questionIds, questionIds)&&(identical(other.randomizerSettings, randomizerSettings) || other.randomizerSettings == randomizerSettings)&&(identical(other.categorySettings, categorySettings) || other.categorySettings == categorySettings)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.deadline, deadline) || other.deadline == deadline)&&(identical(other.timeLimitMinutes, timeLimitMinutes) || other.timeLimitMinutes == timeLimitMinutes)&&(identical(other.attemptsAllowed, attemptsAllowed) || other.attemptsAllowed == attemptsAllowed)&&(identical(other.showResultMode, showResultMode) || other.showResultMode == showResultMode)&&(identical(other.maxScore, maxScore) || other.maxScore == maxScore)&&(identical(other.isPublished, isPublished) || other.isPublished == isPublished)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,quizId,courseId,weekId,ownerTeacherId,title,description,const DeepCollectionEquality().hash(questionIds),randomizerSettings,categorySettings,startDate,deadline,timeLimitMinutes,attemptsAllowed,showResultMode,maxScore,isPublished,createdAt,updatedAt);

@override
String toString() {
  return 'Quiz(quizId: $quizId, courseId: $courseId, weekId: $weekId, ownerTeacherId: $ownerTeacherId, title: $title, description: $description, questionIds: $questionIds, randomizerSettings: $randomizerSettings, categorySettings: $categorySettings, startDate: $startDate, deadline: $deadline, timeLimitMinutes: $timeLimitMinutes, attemptsAllowed: $attemptsAllowed, showResultMode: $showResultMode, maxScore: $maxScore, isPublished: $isPublished, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $QuizCopyWith<$Res>  {
  factory $QuizCopyWith(Quiz value, $Res Function(Quiz) _then) = _$QuizCopyWithImpl;
@useResult
$Res call({
 String quizId, String courseId, String? weekId, String ownerTeacherId, String title, String description, List<String> questionIds, RandomizerSettings randomizerSettings, CategorySettings categorySettings,@NullableTimestampConverter() DateTime? startDate,@NullableTimestampConverter() DateTime? deadline, int? timeLimitMinutes, int attemptsAllowed, ShowResultMode showResultMode, int maxScore, bool isPublished,@TimestampConverter() DateTime createdAt,@TimestampConverter() DateTime updatedAt
});


$RandomizerSettingsCopyWith<$Res> get randomizerSettings;$CategorySettingsCopyWith<$Res> get categorySettings;

}
/// @nodoc
class _$QuizCopyWithImpl<$Res>
    implements $QuizCopyWith<$Res> {
  _$QuizCopyWithImpl(this._self, this._then);

  final Quiz _self;
  final $Res Function(Quiz) _then;

/// Create a copy of Quiz
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? quizId = null,Object? courseId = null,Object? weekId = freezed,Object? ownerTeacherId = null,Object? title = null,Object? description = null,Object? questionIds = null,Object? randomizerSettings = null,Object? categorySettings = null,Object? startDate = freezed,Object? deadline = freezed,Object? timeLimitMinutes = freezed,Object? attemptsAllowed = null,Object? showResultMode = null,Object? maxScore = null,Object? isPublished = null,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_self.copyWith(
quizId: null == quizId ? _self.quizId : quizId // ignore: cast_nullable_to_non_nullable
as String,courseId: null == courseId ? _self.courseId : courseId // ignore: cast_nullable_to_non_nullable
as String,weekId: freezed == weekId ? _self.weekId : weekId // ignore: cast_nullable_to_non_nullable
as String?,ownerTeacherId: null == ownerTeacherId ? _self.ownerTeacherId : ownerTeacherId // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,questionIds: null == questionIds ? _self.questionIds : questionIds // ignore: cast_nullable_to_non_nullable
as List<String>,randomizerSettings: null == randomizerSettings ? _self.randomizerSettings : randomizerSettings // ignore: cast_nullable_to_non_nullable
as RandomizerSettings,categorySettings: null == categorySettings ? _self.categorySettings : categorySettings // ignore: cast_nullable_to_non_nullable
as CategorySettings,startDate: freezed == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime?,deadline: freezed == deadline ? _self.deadline : deadline // ignore: cast_nullable_to_non_nullable
as DateTime?,timeLimitMinutes: freezed == timeLimitMinutes ? _self.timeLimitMinutes : timeLimitMinutes // ignore: cast_nullable_to_non_nullable
as int?,attemptsAllowed: null == attemptsAllowed ? _self.attemptsAllowed : attemptsAllowed // ignore: cast_nullable_to_non_nullable
as int,showResultMode: null == showResultMode ? _self.showResultMode : showResultMode // ignore: cast_nullable_to_non_nullable
as ShowResultMode,maxScore: null == maxScore ? _self.maxScore : maxScore // ignore: cast_nullable_to_non_nullable
as int,isPublished: null == isPublished ? _self.isPublished : isPublished // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}
/// Create a copy of Quiz
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RandomizerSettingsCopyWith<$Res> get randomizerSettings {
  
  return $RandomizerSettingsCopyWith<$Res>(_self.randomizerSettings, (value) {
    return _then(_self.copyWith(randomizerSettings: value));
  });
}/// Create a copy of Quiz
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CategorySettingsCopyWith<$Res> get categorySettings {
  
  return $CategorySettingsCopyWith<$Res>(_self.categorySettings, (value) {
    return _then(_self.copyWith(categorySettings: value));
  });
}
}


/// Adds pattern-matching-related methods to [Quiz].
extension QuizPatterns on Quiz {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Quiz value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Quiz() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Quiz value)  $default,){
final _that = this;
switch (_that) {
case _Quiz():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Quiz value)?  $default,){
final _that = this;
switch (_that) {
case _Quiz() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String quizId,  String courseId,  String? weekId,  String ownerTeacherId,  String title,  String description,  List<String> questionIds,  RandomizerSettings randomizerSettings,  CategorySettings categorySettings, @NullableTimestampConverter()  DateTime? startDate, @NullableTimestampConverter()  DateTime? deadline,  int? timeLimitMinutes,  int attemptsAllowed,  ShowResultMode showResultMode,  int maxScore,  bool isPublished, @TimestampConverter()  DateTime createdAt, @TimestampConverter()  DateTime updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Quiz() when $default != null:
return $default(_that.quizId,_that.courseId,_that.weekId,_that.ownerTeacherId,_that.title,_that.description,_that.questionIds,_that.randomizerSettings,_that.categorySettings,_that.startDate,_that.deadline,_that.timeLimitMinutes,_that.attemptsAllowed,_that.showResultMode,_that.maxScore,_that.isPublished,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String quizId,  String courseId,  String? weekId,  String ownerTeacherId,  String title,  String description,  List<String> questionIds,  RandomizerSettings randomizerSettings,  CategorySettings categorySettings, @NullableTimestampConverter()  DateTime? startDate, @NullableTimestampConverter()  DateTime? deadline,  int? timeLimitMinutes,  int attemptsAllowed,  ShowResultMode showResultMode,  int maxScore,  bool isPublished, @TimestampConverter()  DateTime createdAt, @TimestampConverter()  DateTime updatedAt)  $default,) {final _that = this;
switch (_that) {
case _Quiz():
return $default(_that.quizId,_that.courseId,_that.weekId,_that.ownerTeacherId,_that.title,_that.description,_that.questionIds,_that.randomizerSettings,_that.categorySettings,_that.startDate,_that.deadline,_that.timeLimitMinutes,_that.attemptsAllowed,_that.showResultMode,_that.maxScore,_that.isPublished,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String quizId,  String courseId,  String? weekId,  String ownerTeacherId,  String title,  String description,  List<String> questionIds,  RandomizerSettings randomizerSettings,  CategorySettings categorySettings, @NullableTimestampConverter()  DateTime? startDate, @NullableTimestampConverter()  DateTime? deadline,  int? timeLimitMinutes,  int attemptsAllowed,  ShowResultMode showResultMode,  int maxScore,  bool isPublished, @TimestampConverter()  DateTime createdAt, @TimestampConverter()  DateTime updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _Quiz() when $default != null:
return $default(_that.quizId,_that.courseId,_that.weekId,_that.ownerTeacherId,_that.title,_that.description,_that.questionIds,_that.randomizerSettings,_that.categorySettings,_that.startDate,_that.deadline,_that.timeLimitMinutes,_that.attemptsAllowed,_that.showResultMode,_that.maxScore,_that.isPublished,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Quiz implements Quiz {
  const _Quiz({required this.quizId, this.courseId = '', this.weekId, this.ownerTeacherId = '', this.title = '', this.description = '', final  List<String> questionIds = const <String>[], this.randomizerSettings = const RandomizerSettings(), this.categorySettings = const CategorySettings(), @NullableTimestampConverter() this.startDate, @NullableTimestampConverter() this.deadline, this.timeLimitMinutes, this.attemptsAllowed = 1, this.showResultMode = ShowResultMode.scoreOnly, this.maxScore = 0, this.isPublished = false, @TimestampConverter() required this.createdAt, @TimestampConverter() required this.updatedAt}): _questionIds = questionIds;
  factory _Quiz.fromJson(Map<String, dynamic> json) => _$QuizFromJson(json);

@override final  String quizId;
@override@JsonKey() final  String courseId;
@override final  String? weekId;
@override@JsonKey() final  String ownerTeacherId;
@override@JsonKey() final  String title;
@override@JsonKey() final  String description;
 final  List<String> _questionIds;
@override@JsonKey() List<String> get questionIds {
  if (_questionIds is EqualUnmodifiableListView) return _questionIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_questionIds);
}

@override@JsonKey() final  RandomizerSettings randomizerSettings;
@override@JsonKey() final  CategorySettings categorySettings;
@override@NullableTimestampConverter() final  DateTime? startDate;
@override@NullableTimestampConverter() final  DateTime? deadline;
@override final  int? timeLimitMinutes;
@override@JsonKey() final  int attemptsAllowed;
@override@JsonKey() final  ShowResultMode showResultMode;
@override@JsonKey() final  int maxScore;
@override@JsonKey() final  bool isPublished;
@override@TimestampConverter() final  DateTime createdAt;
@override@TimestampConverter() final  DateTime updatedAt;

/// Create a copy of Quiz
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$QuizCopyWith<_Quiz> get copyWith => __$QuizCopyWithImpl<_Quiz>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$QuizToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Quiz&&(identical(other.quizId, quizId) || other.quizId == quizId)&&(identical(other.courseId, courseId) || other.courseId == courseId)&&(identical(other.weekId, weekId) || other.weekId == weekId)&&(identical(other.ownerTeacherId, ownerTeacherId) || other.ownerTeacherId == ownerTeacherId)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&const DeepCollectionEquality().equals(other._questionIds, _questionIds)&&(identical(other.randomizerSettings, randomizerSettings) || other.randomizerSettings == randomizerSettings)&&(identical(other.categorySettings, categorySettings) || other.categorySettings == categorySettings)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.deadline, deadline) || other.deadline == deadline)&&(identical(other.timeLimitMinutes, timeLimitMinutes) || other.timeLimitMinutes == timeLimitMinutes)&&(identical(other.attemptsAllowed, attemptsAllowed) || other.attemptsAllowed == attemptsAllowed)&&(identical(other.showResultMode, showResultMode) || other.showResultMode == showResultMode)&&(identical(other.maxScore, maxScore) || other.maxScore == maxScore)&&(identical(other.isPublished, isPublished) || other.isPublished == isPublished)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,quizId,courseId,weekId,ownerTeacherId,title,description,const DeepCollectionEquality().hash(_questionIds),randomizerSettings,categorySettings,startDate,deadline,timeLimitMinutes,attemptsAllowed,showResultMode,maxScore,isPublished,createdAt,updatedAt);

@override
String toString() {
  return 'Quiz(quizId: $quizId, courseId: $courseId, weekId: $weekId, ownerTeacherId: $ownerTeacherId, title: $title, description: $description, questionIds: $questionIds, randomizerSettings: $randomizerSettings, categorySettings: $categorySettings, startDate: $startDate, deadline: $deadline, timeLimitMinutes: $timeLimitMinutes, attemptsAllowed: $attemptsAllowed, showResultMode: $showResultMode, maxScore: $maxScore, isPublished: $isPublished, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$QuizCopyWith<$Res> implements $QuizCopyWith<$Res> {
  factory _$QuizCopyWith(_Quiz value, $Res Function(_Quiz) _then) = __$QuizCopyWithImpl;
@override @useResult
$Res call({
 String quizId, String courseId, String? weekId, String ownerTeacherId, String title, String description, List<String> questionIds, RandomizerSettings randomizerSettings, CategorySettings categorySettings,@NullableTimestampConverter() DateTime? startDate,@NullableTimestampConverter() DateTime? deadline, int? timeLimitMinutes, int attemptsAllowed, ShowResultMode showResultMode, int maxScore, bool isPublished,@TimestampConverter() DateTime createdAt,@TimestampConverter() DateTime updatedAt
});


@override $RandomizerSettingsCopyWith<$Res> get randomizerSettings;@override $CategorySettingsCopyWith<$Res> get categorySettings;

}
/// @nodoc
class __$QuizCopyWithImpl<$Res>
    implements _$QuizCopyWith<$Res> {
  __$QuizCopyWithImpl(this._self, this._then);

  final _Quiz _self;
  final $Res Function(_Quiz) _then;

/// Create a copy of Quiz
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? quizId = null,Object? courseId = null,Object? weekId = freezed,Object? ownerTeacherId = null,Object? title = null,Object? description = null,Object? questionIds = null,Object? randomizerSettings = null,Object? categorySettings = null,Object? startDate = freezed,Object? deadline = freezed,Object? timeLimitMinutes = freezed,Object? attemptsAllowed = null,Object? showResultMode = null,Object? maxScore = null,Object? isPublished = null,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_Quiz(
quizId: null == quizId ? _self.quizId : quizId // ignore: cast_nullable_to_non_nullable
as String,courseId: null == courseId ? _self.courseId : courseId // ignore: cast_nullable_to_non_nullable
as String,weekId: freezed == weekId ? _self.weekId : weekId // ignore: cast_nullable_to_non_nullable
as String?,ownerTeacherId: null == ownerTeacherId ? _self.ownerTeacherId : ownerTeacherId // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,questionIds: null == questionIds ? _self._questionIds : questionIds // ignore: cast_nullable_to_non_nullable
as List<String>,randomizerSettings: null == randomizerSettings ? _self.randomizerSettings : randomizerSettings // ignore: cast_nullable_to_non_nullable
as RandomizerSettings,categorySettings: null == categorySettings ? _self.categorySettings : categorySettings // ignore: cast_nullable_to_non_nullable
as CategorySettings,startDate: freezed == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime?,deadline: freezed == deadline ? _self.deadline : deadline // ignore: cast_nullable_to_non_nullable
as DateTime?,timeLimitMinutes: freezed == timeLimitMinutes ? _self.timeLimitMinutes : timeLimitMinutes // ignore: cast_nullable_to_non_nullable
as int?,attemptsAllowed: null == attemptsAllowed ? _self.attemptsAllowed : attemptsAllowed // ignore: cast_nullable_to_non_nullable
as int,showResultMode: null == showResultMode ? _self.showResultMode : showResultMode // ignore: cast_nullable_to_non_nullable
as ShowResultMode,maxScore: null == maxScore ? _self.maxScore : maxScore // ignore: cast_nullable_to_non_nullable
as int,isPublished: null == isPublished ? _self.isPublished : isPublished // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

/// Create a copy of Quiz
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RandomizerSettingsCopyWith<$Res> get randomizerSettings {
  
  return $RandomizerSettingsCopyWith<$Res>(_self.randomizerSettings, (value) {
    return _then(_self.copyWith(randomizerSettings: value));
  });
}/// Create a copy of Quiz
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CategorySettingsCopyWith<$Res> get categorySettings {
  
  return $CategorySettingsCopyWith<$Res>(_self.categorySettings, (value) {
    return _then(_self.copyWith(categorySettings: value));
  });
}
}

// dart format on
