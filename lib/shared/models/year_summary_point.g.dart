// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'year_summary_point.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_YearSummaryPoint _$YearSummaryPointFromJson(Map<String, dynamic> json) =>
    _YearSummaryPoint(
      id: (json['id'] as num).toInt(),
      order: (json['order'] as num?)?.toInt() ?? 0,
      options: (json['options'] as List<dynamic>?)
              ?.map(
                  (e) => YearSummaryOption.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <YearSummaryOption>[],
    );

Map<String, dynamic> _$YearSummaryPointToJson(_YearSummaryPoint instance) =>
    <String, dynamic>{
      'id': instance.id,
      'order': instance.order,
      'options': instance.options,
    };
