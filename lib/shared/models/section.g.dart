// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'section.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Section _$SectionFromJson(Map<String, dynamic> json) => _Section(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      year: SectionYear.fromJson(json['year'] as Map<String, dynamic>),
      headerImageUrl: json['header_image_url'] as String?,
      contentBlocks: (json['content_blocks'] as List<dynamic>?)
              ?.map((e) => ContentBlock.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <ContentBlock>[],
      type: json['type'] as String? ?? kSectionTypeReading,
    );

Map<String, dynamic> _$SectionToJson(_Section instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'year': instance.year,
      'header_image_url': instance.headerImageUrl,
      'content_blocks': instance.contentBlocks,
      'type': instance.type,
    };
