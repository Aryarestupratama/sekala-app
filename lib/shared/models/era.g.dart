// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'era.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Era _$EraFromJson(Map<String, dynamic> json) => _Era(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      slug: json['slug'] as String,
      description: json['description'] as String?,
      order: (json['order'] as num).toInt(),
    );

Map<String, dynamic> _$EraToJson(_Era instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'slug': instance.slug,
      'description': instance.description,
      'order': instance.order,
    };
