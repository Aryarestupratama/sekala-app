// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'section_summary.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SectionSummary _$SectionSummaryFromJson(Map<String, dynamic> json) =>
    _SectionSummary(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      order: (json['order'] as num?)?.toInt() ?? 0,
      locked: json['locked'] as bool? ?? true,
      completed: json['completed'] as bool? ?? false,
      type: json['type'] as String? ?? kSectionTypeReading,
    );

Map<String, dynamic> _$SectionSummaryToJson(_SectionSummary instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'order': instance.order,
      'locked': instance.locked,
      'completed': instance.completed,
      'type': instance.type,
    };
