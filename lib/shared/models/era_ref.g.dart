// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'era_ref.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_EraRef _$EraRefFromJson(Map<String, dynamic> json) => _EraRef(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      slug: json['slug'] as String,
    );

Map<String, dynamic> _$EraRefToJson(_EraRef instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'slug': instance.slug,
    };
