// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'figure_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FigureDetail _$FigureDetailFromJson(Map<String, dynamic> json) =>
    _FigureDetail(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      photoUrl: json['photo_url'] as String?,
      birthDate: json['birth_date'] as String?,
      deathDate: json['death_date'] as String?,
      family: json['family'] as String?,
      roleDescription: json['role_description'] as String,
    );

Map<String, dynamic> _$FigureDetailToJson(_FigureDetail instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'photo_url': instance.photoUrl,
      'birth_date': instance.birthDate,
      'death_date': instance.deathDate,
      'family': instance.family,
      'role_description': instance.roleDescription,
    };
