// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'section_completion_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SectionCompletionResult _$SectionCompletionResultFromJson(
        Map<String, dynamic> json) =>
    _SectionCompletionResult(
      completedAt: json['completed_at'] as String?,
      yearCompleted: json['year_completed'] as bool? ?? false,
      newlyUnlockedVaccineIds:
          (json['newly_unlocked_vaccine_ids'] as List<dynamic>?)
                  ?.map((e) => (e as num).toInt())
                  .toList() ??
              const <int>[],
    );

Map<String, dynamic> _$SectionCompletionResultToJson(
        _SectionCompletionResult instance) =>
    <String, dynamic>{
      'completed_at': instance.completedAt,
      'year_completed': instance.yearCompleted,
      'newly_unlocked_vaccine_ids': instance.newlyUnlockedVaccineIds,
    };
