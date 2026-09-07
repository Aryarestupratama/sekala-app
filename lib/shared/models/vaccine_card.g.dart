// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vaccine_card.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_VaccineEra _$VaccineEraFromJson(Map<String, dynamic> json) => _VaccineEra(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      slug: json['slug'] as String,
    );

Map<String, dynamic> _$VaccineEraToJson(_VaccineEra instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'slug': instance.slug,
    };

_VaccineCard _$VaccineCardFromJson(Map<String, dynamic> json) => _VaccineCard(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      photoUrl: json['photo_url'] as String?,
      photoLockedUrl: json['photo_locked_url'] as String?,
      unlocked: json['unlocked'] as bool? ?? false,
      unseen: json['unseen'] as bool? ?? false,
      eras: (json['eras'] as List<dynamic>?)
              ?.map((e) => VaccineEra.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <VaccineEra>[],
    );

Map<String, dynamic> _$VaccineCardToJson(_VaccineCard instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'photo_url': instance.photoUrl,
      'photo_locked_url': instance.photoLockedUrl,
      'unlocked': instance.unlocked,
      'unseen': instance.unseen,
      'eras': instance.eras,
    };
