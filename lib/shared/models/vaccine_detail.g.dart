// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vaccine_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_VaccineDetail _$VaccineDetailFromJson(Map<String, dynamic> json) =>
    _VaccineDetail(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      photoUrl: json['photo_url'] as String?,
      photoLockedUrl: json['photo_locked_url'] as String?,
      manufacturer: json['manufacturer'] as String?,
      diseaseTarget: json['disease_target'] as String,
      yearIntroduced: (json['year_introduced'] as num?)?.toInt(),
      description: json['description'] as String,
      eras: (json['eras'] as List<dynamic>?)
              ?.map((e) => VaccineEra.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <VaccineEra>[],
    );

Map<String, dynamic> _$VaccineDetailToJson(_VaccineDetail instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'photo_url': instance.photoUrl,
      'photo_locked_url': instance.photoLockedUrl,
      'manufacturer': instance.manufacturer,
      'disease_target': instance.diseaseTarget,
      'year_introduced': instance.yearIntroduced,
      'description': instance.description,
      'eras': instance.eras,
    };
