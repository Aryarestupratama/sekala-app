// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'badge_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BadgeListMeta _$BadgeListMetaFromJson(Map<String, dynamic> json) =>
    _BadgeListMeta(
      total: (json['total'] as num?)?.toInt() ?? 0,
      unlocked: (json['unlocked'] as num?)?.toInt() ?? 0,
      unseen: (json['unseen'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$BadgeListMetaToJson(_BadgeListMeta instance) =>
    <String, dynamic>{
      'total': instance.total,
      'unlocked': instance.unlocked,
      'unseen': instance.unseen,
    };

_BadgeListResponse _$BadgeListResponseFromJson(Map<String, dynamic> json) =>
    _BadgeListResponse(
      data: (json['data'] as List<dynamic>?)
              ?.map((e) => BadgeCard.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <BadgeCard>[],
      meta: BadgeListMeta.fromJson(json['meta'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BadgeListResponseToJson(_BadgeListResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'meta': instance.meta,
    };
