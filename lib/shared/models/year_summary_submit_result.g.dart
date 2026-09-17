// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'year_summary_submit_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_YearSummarySubmitResult _$YearSummarySubmitResultFromJson(
        Map<String, dynamic> json) =>
    _YearSummarySubmitResult(
      isPerfect: json['is_perfect'] as bool? ?? false,
      completedAt: json['completed_at'] == null
          ? null
          : DateTime.parse(json['completed_at'] as String),
      fullSummary: (json['full_summary'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      quizUnlocked: json['quiz_unlocked'] as bool? ?? false,
    );

Map<String, dynamic> _$YearSummarySubmitResultToJson(
        _YearSummarySubmitResult instance) =>
    <String, dynamic>{
      'is_perfect': instance.isPerfect,
      'completed_at': instance.completedAt?.toIso8601String(),
      'full_summary': instance.fullSummary,
      'quiz_unlocked': instance.quizUnlocked,
    };
