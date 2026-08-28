// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'figure_card.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FigureCard _$FigureCardFromJson(Map<String, dynamic> json) => _FigureCard(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      photoUrl: json['photo_url'] as String?,
      unlocked: json['unlocked'] as bool? ?? false,
    );

Map<String, dynamic> _$FigureCardToJson(_FigureCard instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'photo_url': instance.photoUrl,
      'unlocked': instance.unlocked,
    };
