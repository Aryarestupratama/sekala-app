// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'case_study_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CaseStudyDetail _$CaseStudyDetailFromJson(Map<String, dynamic> json) =>
    _CaseStudyDetail(
      caseStudy: CaseStudy.fromJson(json['case_study'] as Map<String, dynamic>),
      options: (json['options'] as List<dynamic>?)
              ?.map((e) => CaseStudyOption.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      completed: json['completed'] as bool? ?? false,
      completedAt: json['completed_at'] == null
          ? null
          : DateTime.parse(json['completed_at'] as String),
      badge: json['badge'] == null
          ? null
          : CaseStudyBadge.fromJson(json['badge'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CaseStudyDetailToJson(_CaseStudyDetail instance) =>
    <String, dynamic>{
      'case_study': instance.caseStudy,
      'options': instance.options,
      'completed': instance.completed,
      'completed_at': instance.completedAt?.toIso8601String(),
      'badge': instance.badge,
    };
