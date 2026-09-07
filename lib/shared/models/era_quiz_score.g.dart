// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'era_quiz_score.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_EraQuizScore _$EraQuizScoreFromJson(Map<String, dynamic> json) =>
    _EraQuizScore(
      correct: (json['correct'] as num).toInt(),
      total: (json['total'] as num).toInt(),
      percentage: (json['percentage'] as num).toDouble(),
    );

Map<String, dynamic> _$EraQuizScoreToJson(_EraQuizScore instance) =>
    <String, dynamic>{
      'correct': instance.correct,
      'total': instance.total,
      'percentage': instance.percentage,
    };
