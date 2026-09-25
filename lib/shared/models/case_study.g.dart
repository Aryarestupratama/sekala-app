// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'case_study.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CaseStudy _$CaseStudyFromJson(Map<String, dynamic> json) => _CaseStudy(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      challengeText: json['challenge_text'] as String? ?? '',
      reasonDescription: json['reason_description'] as String? ?? '',
    );

Map<String, dynamic> _$CaseStudyToJson(_CaseStudy instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'challenge_text': instance.challengeText,
      'reason_description': instance.reasonDescription,
    };
