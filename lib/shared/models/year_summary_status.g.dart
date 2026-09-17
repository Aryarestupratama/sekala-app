// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'year_summary_status.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_YearSummaryStatus _$YearSummaryStatusFromJson(Map<String, dynamic> json) =>
    _YearSummaryStatus(
      id: (json['id'] as num).toInt(),
      isPublished: json['is_published'] as bool? ?? false,
    );

Map<String, dynamic> _$YearSummaryStatusToJson(_YearSummaryStatus instance) =>
    <String, dynamic>{
      'id': instance.id,
      'is_published': instance.isPublished,
    };
