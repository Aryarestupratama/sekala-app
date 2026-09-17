// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'year.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Year _$YearFromJson(Map<String, dynamic> json) => _Year(
      id: (json['id'] as num).toInt(),
      year: (json['year'] as num).toInt(),
      title: json['title'] as String,
      quoteText: json['quote_text'] as String?,
      references: (json['references'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      yearSummary: json['year_summary'] == null
          ? null
          : YearSummaryStatus.fromJson(
              json['year_summary'] as Map<String, dynamic>),
      yearSummaryCompleted: json['year_summary_completed'] as bool? ?? false,
      publishedSectionsCount:
          (json['published_sections_count'] as num?)?.toInt(),
      locked: json['locked'] as bool? ?? true,
      isCompleted: json['is_completed'] as bool? ?? false,
      sections: (json['sections'] as List<dynamic>?)
              ?.map((e) => SectionSummary.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      vaccines: (json['vaccines'] as List<dynamic>?)
              ?.map((e) => VaccineCard.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <VaccineCard>[],
    );

Map<String, dynamic> _$YearToJson(_Year instance) => <String, dynamic>{
      'id': instance.id,
      'year': instance.year,
      'title': instance.title,
      'quote_text': instance.quoteText,
      'references': instance.references,
      'year_summary': instance.yearSummary,
      'year_summary_completed': instance.yearSummaryCompleted,
      'published_sections_count': instance.publishedSectionsCount,
      'locked': instance.locked,
      'is_completed': instance.isCompleted,
      'sections': instance.sections,
      'vaccines': instance.vaccines,
    };
