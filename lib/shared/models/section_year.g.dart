// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'section_year.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SectionEra _$SectionEraFromJson(Map<String, dynamic> json) => _SectionEra(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      slug: json['slug'] as String,
    );

Map<String, dynamic> _$SectionEraToJson(_SectionEra instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'slug': instance.slug,
    };

_SectionYear _$SectionYearFromJson(Map<String, dynamic> json) => _SectionYear(
      id: (json['id'] as num).toInt(),
      year: (json['year'] as num).toInt(),
      title: json['title'] as String,
      era: SectionEra.fromJson(json['era'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SectionYearToJson(_SectionYear instance) =>
    <String, dynamic>{
      'id': instance.id,
      'year': instance.year,
      'title': instance.title,
      'era': instance.era,
    };
