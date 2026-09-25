// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'case_study_option.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CaseStudyOption _$CaseStudyOptionFromJson(Map<String, dynamic> json) =>
    _CaseStudyOption(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
    );

Map<String, dynamic> _$CaseStudyOptionToJson(_CaseStudyOption instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
    };
