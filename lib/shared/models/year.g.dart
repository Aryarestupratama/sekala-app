// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'year.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Year _$YearFromJson(Map<String, dynamic> json) => _Year(
      id: (json['id'] as num).toInt(),
      year: (json['year'] as num).toInt(),
      title: json['title'] as String,
      publishedSectionsCount:
          (json['published_sections_count'] as num?)?.toInt(),
      sections: (json['sections'] as List<dynamic>?)
              ?.map((e) => SectionSummary.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$YearToJson(_Year instance) => <String, dynamic>{
      'id': instance.id,
      'year': instance.year,
      'title': instance.title,
      'published_sections_count': instance.publishedSectionsCount,
      'sections': instance.sections,
    };
