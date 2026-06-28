// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'randomizer_settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RandomizerSettings _$RandomizerSettingsFromJson(Map<String, dynamic> json) =>
    _RandomizerSettings(
      totalQuestions: (json['totalQuestions'] as num?)?.toInt() ?? 0,
      byTopic:
          (json['byTopic'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, (e as num).toInt()),
          ) ??
          const <String, int>{},
      byType:
          (json['byType'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, (e as num).toInt()),
          ) ??
          const <String, int>{},
      byDifficulty:
          (json['byDifficulty'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, (e as num).toInt()),
          ) ??
          const <String, int>{},
      minHard: (json['minHard'] as num?)?.toInt(),
      maxBasic: (json['maxBasic'] as num?)?.toInt(),
      shuffleQuestions: json['shuffleQuestions'] as bool? ?? false,
      shuffleOptions: json['shuffleOptions'] as bool? ?? false,
      excludeDuplicates: json['excludeDuplicates'] as bool? ?? true,
    );

Map<String, dynamic> _$RandomizerSettingsToJson(_RandomizerSettings instance) =>
    <String, dynamic>{
      'totalQuestions': instance.totalQuestions,
      'byTopic': instance.byTopic,
      'byType': instance.byType,
      'byDifficulty': instance.byDifficulty,
      'minHard': instance.minHard,
      'maxBasic': instance.maxBasic,
      'shuffleQuestions': instance.shuffleQuestions,
      'shuffleOptions': instance.shuffleOptions,
      'excludeDuplicates': instance.excludeDuplicates,
    };
