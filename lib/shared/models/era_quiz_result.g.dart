// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'era_quiz_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_EraQuizResult _$EraQuizResultFromJson(Map<String, dynamic> json) =>
    _EraQuizResult(
      correct: (json['correct'] as num).toInt(),
      total: (json['total'] as num).toInt(),
      percentage: (json['percentage'] as num).toDouble(),
      completedAt: json['completed_at'] as String,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$EraQuizResultToJson(_EraQuizResult instance) =>
    <String, dynamic>{
      'correct': instance.correct,
      'total': instance.total,
      'percentage': instance.percentage,
      'completed_at': instance.completedAt,
      'message': instance.message,
    };
