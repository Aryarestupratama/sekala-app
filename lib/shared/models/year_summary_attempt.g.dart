// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'year_summary_attempt.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_YearSummaryAttempt _$YearSummaryAttemptFromJson(Map<String, dynamic> json) =>
    _YearSummaryAttempt(
      completion: json['completion'] == null
          ? null
          : YearSummaryCompletion.fromJson(
              json['completion'] as Map<String, dynamic>),
      fullSummary: (json['full_summary'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      points: (json['points'] as List<dynamic>?)
              ?.map((e) => YearSummaryPoint.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$YearSummaryAttemptToJson(_YearSummaryAttempt instance) =>
    <String, dynamic>{
      'completion': instance.completion,
      'full_summary': instance.fullSummary,
      'points': instance.points,
    };
