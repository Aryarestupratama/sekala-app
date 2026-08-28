// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'section.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Section _$SectionFromJson(Map<String, dynamic> json) => _Section(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      year: SectionYear.fromJson(json['year'] as Map<String, dynamic>),
      quizLink: json['quiz_link'] as String?,
      contentBlocks: (json['content_blocks'] as List<dynamic>?)
              ?.map((e) => ContentBlock.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <ContentBlock>[],
      figures: (json['figures'] as List<dynamic>?)
              ?.map((e) => FigureCard.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <FigureCard>[],
    );

Map<String, dynamic> _$SectionToJson(_Section instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'year': instance.year,
      'quiz_link': instance.quizLink,
      'content_blocks': instance.contentBlocks,
      'figures': instance.figures,
    };
