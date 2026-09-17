// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'year_summary_completion.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_YearSummaryCompletion _$YearSummaryCompletionFromJson(
        Map<String, dynamic> json) =>
    _YearSummaryCompletion(
      isPerfect: json['is_perfect'] as bool? ?? false,
      completedAt: json['completed_at'] == null
          ? null
          : DateTime.parse(json['completed_at'] as String),
    );

Map<String, dynamic> _$YearSummaryCompletionToJson(
        _YearSummaryCompletion instance) =>
    <String, dynamic>{
      'is_perfect': instance.isPerfect,
      'completed_at': instance.completedAt?.toIso8601String(),
    };
