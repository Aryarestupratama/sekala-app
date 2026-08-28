// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'content_block.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ContentBlock _$ContentBlockFromJson(Map<String, dynamic> json) =>
    _ContentBlock(
      id: (json['id'] as num).toInt(),
      type: $enumDecode(_$ContentBlockTypeEnumMap, json['type']),
      content: json['content'] as String,
      resolvedUrl: json['resolved_url'] as String?,
      order: (json['order'] as num).toInt(),
    );

Map<String, dynamic> _$ContentBlockToJson(_ContentBlock instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': _$ContentBlockTypeEnumMap[instance.type]!,
      'content': instance.content,
      'resolved_url': instance.resolvedUrl,
      'order': instance.order,
    };

const _$ContentBlockTypeEnumMap = {
  ContentBlockType.text: 'text',
  ContentBlockType.image: 'image',
  ContentBlockType.video: 'video',
  ContentBlockType.pdf: 'pdf',
  ContentBlockType.summary: 'summary',
};
