// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'era_quiz_score.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_EraQuizScore _$EraQuizScoreFromJson(Map<String, dynamic> json) =>
    _EraQuizScore(
      total: (json['total'] as num).toInt(),
      correct: (json['correct'] as num).toInt(),
      incorrect: (json['incorrect'] as num).toInt(),
      percentage: (json['percentage'] as num).toInt(),
      isPassing: json['is_passing'] as bool,
    );

Map<String, dynamic> _$EraQuizScoreToJson(_EraQuizScore instance) =>
    <String, dynamic>{
      'total': instance.total,
      'correct': instance.correct,
      'incorrect': instance.incorrect,
      'percentage': instance.percentage,
      'is_passing': instance.isPassing,
    };
