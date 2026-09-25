// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'case_study_badge.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CaseStudyBadge _$CaseStudyBadgeFromJson(Map<String, dynamic> json) =>
    _CaseStudyBadge(
      name: json['name'] as String? ?? '',
      description: json['description'] as String?,
      imageLink: json['image_link'] as String?,
      imageUrl: json['image_url'] as String?,
    );

Map<String, dynamic> _$CaseStudyBadgeToJson(_CaseStudyBadge instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'image_link': instance.imageLink,
      'image_url': instance.imageUrl,
    };
