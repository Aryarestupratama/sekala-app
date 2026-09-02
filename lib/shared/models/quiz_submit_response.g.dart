// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quiz_submit_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_QuizSubmitResponse _$QuizSubmitResponseFromJson(Map<String, dynamic> json) =>
    _QuizSubmitResponse(
      message: json['message'] as String,
      completedAt: json['completed_at'] as String,
      feedback: (json['feedback'] as List<dynamic>?)
              ?.map(
                  (e) => QuizAnswerFeedback.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <QuizAnswerFeedback>[],
      newlyUnlockedVaccineIds:
          (json['newly_unlocked_vaccine_ids'] as List<dynamic>?)
                  ?.map((e) => (e as num).toInt())
                  .toList() ??
              const <int>[],
    );

Map<String, dynamic> _$QuizSubmitResponseToJson(_QuizSubmitResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'completed_at': instance.completedAt,
      'feedback': instance.feedback,
      'newly_unlocked_vaccine_ids': instance.newlyUnlockedVaccineIds,
    };
