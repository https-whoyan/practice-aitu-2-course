// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_QuizCategory _$QuizCategoryFromJson(Map<String, dynamic> json) =>
    _QuizCategory(
      basis: json['basis'] as String? ?? 'topic',
      questionCount: (json['questionCount'] as num?)?.toInt() ?? 0,
      pointsPerQuestion: (json['pointsPerQuestion'] as num?)?.toInt() ?? 1,
      required: json['required'] as bool? ?? true,
      order: (json['order'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$QuizCategoryToJson(_QuizCategory instance) =>
    <String, dynamic>{
      'basis': instance.basis,
      'questionCount': instance.questionCount,
      'pointsPerQuestion': instance.pointsPerQuestion,
      'required': instance.required,
      'order': instance.order,
    };

_CategorySettings _$CategorySettingsFromJson(Map<String, dynamic> json) =>
    _CategorySettings(
      categories:
          (json['categories'] as List<dynamic>?)
              ?.map((e) => QuizCategory.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <QuizCategory>[],
    );

Map<String, dynamic> _$CategorySettingsToJson(_CategorySettings instance) =>
    <String, dynamic>{'categories': instance.categories};
