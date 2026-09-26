// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'case_study_submit_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CaseStudySubmitResult _$CaseStudySubmitResultFromJson(
        Map<String, dynamic> json) =>
    _CaseStudySubmitResult(
      isCorrect: json['is_correct'] as bool? ?? false,
      feedback: json['feedback'] as String? ?? '',
      badge: json['badge'] == null
          ? null
          : CaseStudyBadge.fromJson(json['badge'] as Map<String, dynamic>),
      yearCompleted: json['year_completed'] as bool? ?? false,
      newlyUnlockedVaccineIds: json['newly_unlocked_vaccine_ids'] == null
          ? const <int>[]
          : _idsFromJson(json['newly_unlocked_vaccine_ids']),
      borderUnlocked: json['border_unlocked'] as bool? ?? false,
    );

Map<String, dynamic> _$CaseStudySubmitResultToJson(
        _CaseStudySubmitResult instance) =>
    <String, dynamic>{
      'is_correct': instance.isCorrect,
      'feedback': instance.feedback,
      'badge': instance.badge,
      'year_completed': instance.yearCompleted,
      'newly_unlocked_vaccine_ids': instance.newlyUnlockedVaccineIds,
      'border_unlocked': instance.borderUnlocked,
    };
