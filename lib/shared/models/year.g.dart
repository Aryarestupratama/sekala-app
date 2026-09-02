// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'year.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Year _$YearFromJson(Map<String, dynamic> json) => _Year(
      id: (json['id'] as num).toInt(),
      year: (json['year'] as num).toInt(),
      title: json['title'] as String,
      summary: json['summary'] as String?,
      publishedSectionsCount:
          (json['published_sections_count'] as num?)?.toInt(),
      locked: json['locked'] as bool? ?? true,
      isCompleted: json['is_completed'] as bool? ?? false,
      sections: (json['sections'] as List<dynamic>?)
              ?.map((e) => SectionSummary.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$YearToJson(_Year instance) => <String, dynamic>{
      'id': instance.id,
      'year': instance.year,
      'title': instance.title,
      'summary': instance.summary,
      'published_sections_count': instance.publishedSectionsCount,
      'locked': instance.locked,
      'is_completed': instance.isCompleted,
      'sections': instance.sections,
    };
