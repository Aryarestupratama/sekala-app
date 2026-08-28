// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_progress.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_EraProgress _$EraProgressFromJson(Map<String, dynamic> json) => _EraProgress(
      era: EraRef.fromJson(json['era'] as Map<String, dynamic>),
      completed: (json['completed'] as num).toInt(),
      total: (json['total'] as num).toInt(),
    );

Map<String, dynamic> _$EraProgressToJson(_EraProgress instance) =>
    <String, dynamic>{
      'era': instance.era,
      'completed': instance.completed,
      'total': instance.total,
    };

_HomeRecommendation _$HomeRecommendationFromJson(Map<String, dynamic> json) =>
    _HomeRecommendation(
      type: json['type'] as String,
      era: EraRef.fromJson(json['era'] as Map<String, dynamic>),
      year: json['year'] == null
          ? null
          : RecommendationYear.fromJson(json['year'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$HomeRecommendationToJson(_HomeRecommendation instance) =>
    <String, dynamic>{
      'type': instance.type,
      'era': instance.era,
      'year': instance.year,
    };

_RecommendationYear _$RecommendationYearFromJson(Map<String, dynamic> json) =>
    _RecommendationYear(
      id: (json['id'] as num).toInt(),
      year: (json['year'] as num).toInt(),
      title: json['title'] as String,
    );

Map<String, dynamic> _$RecommendationYearToJson(_RecommendationYear instance) =>
    <String, dynamic>{
      'id': instance.id,
      'year': instance.year,
      'title': instance.title,
    };

_HomeSummary _$HomeSummaryFromJson(Map<String, dynamic> json) => _HomeSummary(
      progressByEra: (json['progress_by_era'] as List<dynamic>?)
              ?.map((e) => EraProgress.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <EraProgress>[],
      recommendation: json['recommendation'] == null
          ? null
          : HomeRecommendation.fromJson(
              json['recommendation'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$HomeSummaryToJson(_HomeSummary instance) =>
    <String, dynamic>{
      'progress_by_era': instance.progressByEra,
      'recommendation': instance.recommendation,
    };
