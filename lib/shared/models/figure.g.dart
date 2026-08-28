// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'figure.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Figure _$FigureFromJson(Map<String, dynamic> json) => _Figure(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      photo: json['photo'] as String?,
      photoUrl: json['photo_url'] as String?,
      birthDate: json['birth_date'] as String?,
      deathDate: json['death_date'] as String?,
      family: json['family'] as String?,
      roleDescription: json['role_description'] as String,
      isUnlocked: json['is_unlocked'] as bool? ?? false,
      unlockedAt: json['unlocked_at'] as String?,
    );

Map<String, dynamic> _$FigureToJson(_Figure instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'photo': instance.photo,
      'photo_url': instance.photoUrl,
      'birth_date': instance.birthDate,
      'death_date': instance.deathDate,
      'family': instance.family,
      'role_description': instance.roleDescription,
      'is_unlocked': instance.isUnlocked,
      'unlocked_at': instance.unlockedAt,
    };
