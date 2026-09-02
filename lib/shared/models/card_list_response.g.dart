// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CardListMeta _$CardListMetaFromJson(Map<String, dynamic> json) =>
    _CardListMeta(
      total: (json['total'] as num).toInt(),
      unlocked: (json['unlocked'] as num).toInt(),
    );

Map<String, dynamic> _$CardListMetaToJson(_CardListMeta instance) =>
    <String, dynamic>{
      'total': instance.total,
      'unlocked': instance.unlocked,
    };

_CardListResponse _$CardListResponseFromJson(Map<String, dynamic> json) =>
    _CardListResponse(
      data: (json['data'] as List<dynamic>?)
              ?.map((e) => VaccineCard.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <VaccineCard>[],
      meta: CardListMeta.fromJson(json['meta'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CardListResponseToJson(_CardListResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'meta': instance.meta,
    };
