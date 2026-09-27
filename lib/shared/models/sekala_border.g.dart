// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sekala_border.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SekalaBorder _$SekalaBorderFromJson(Map<String, dynamic> json) =>
    _SekalaBorder(
      isPublished: json['is_published'] as bool? ?? false,
      imageUrl: json['image_url'] as String?,
    );

Map<String, dynamic> _$SekalaBorderToJson(_SekalaBorder instance) =>
    <String, dynamic>{
      'is_published': instance.isPublished,
      'image_url': instance.imageUrl,
    };
