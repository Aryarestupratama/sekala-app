// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vaccine_card.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_VaccineCard _$VaccineCardFromJson(Map<String, dynamic> json) => _VaccineCard(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      photoUrl: json['photo_url'] as String?,
      photoLockedUrl: json['photo_locked_url'] as String?,
      unlocked: json['unlocked'] as bool? ?? false,
    );

Map<String, dynamic> _$VaccineCardToJson(_VaccineCard instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'photo_url': instance.photoUrl,
      'photo_locked_url': instance.photoLockedUrl,
      'unlocked': instance.unlocked,
    };
