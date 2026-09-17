// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'year_summary_point_check_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_YearSummaryPointCheckResult _$YearSummaryPointCheckResultFromJson(
        Map<String, dynamic> json) =>
    _YearSummaryPointCheckResult(
      pointId: (json['point_id'] as num).toInt(),
      isCorrect: json['is_correct'] as bool,
      correctOption: YearSummaryOption.fromJson(
          json['correct_option'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$YearSummaryPointCheckResultToJson(
        _YearSummaryPointCheckResult instance) =>
    <String, dynamic>{
      'point_id': instance.pointId,
      'is_correct': instance.isCorrect,
      'correct_option': instance.correctOption,
    };
