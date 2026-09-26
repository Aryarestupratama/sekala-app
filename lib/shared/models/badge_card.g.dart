// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'badge_card.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BadgeYear _$BadgeYearFromJson(Map<String, dynamic> json) => _BadgeYear(
      id: (json['id'] as num).toInt(),
      year: (json['year'] as num).toInt(),
      title: json['title'] as String,
    );

Map<String, dynamic> _$BadgeYearToJson(_BadgeYear instance) =>
    <String, dynamic>{
      'id': instance.id,
      'year': instance.year,
      'title': instance.title,
    };

_BadgeEra _$BadgeEraFromJson(Map<String, dynamic> json) => _BadgeEra(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      slug: json['slug'] as String,
    );

Map<String, dynamic> _$BadgeEraToJson(_BadgeEra instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'slug': instance.slug,
    };

_BadgeCard _$BadgeCardFromJson(Map<String, dynamic> json) => _BadgeCard(
      id: (json['id'] as num).toInt(),
      sectionId: (json['section_id'] as num).toInt(),
      name: json['name'] as String,
      description: json['description'] as String?,
      iconUrl: json['icon_url'] as String?,
      unlocked: json['unlocked'] as bool? ?? false,
      unlockedAt: json['unlocked_at'] == null
          ? null
          : DateTime.parse(json['unlocked_at'] as String),
      unseen: json['unseen'] as bool? ?? false,
      year: BadgeYear.fromJson(json['year'] as Map<String, dynamic>),
      era: BadgeEra.fromJson(json['era'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BadgeCardToJson(_BadgeCard instance) =>
    <String, dynamic>{
      'id': instance.id,
      'section_id': instance.sectionId,
      'name': instance.name,
      'description': instance.description,
      'icon_url': instance.iconUrl,
      'unlocked': instance.unlocked,
      'unlocked_at': instance.unlockedAt?.toIso8601String(),
      'unseen': instance.unseen,
      'year': instance.year,
      'era': instance.era,
    };
