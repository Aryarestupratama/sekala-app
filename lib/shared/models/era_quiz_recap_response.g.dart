// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'era_quiz_recap_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_EraQuizRecapResponse _$EraQuizRecapResponseFromJson(
        Map<String, dynamic> json) =>
    _EraQuizRecapResponse(
      completedAt: json['completed_at'] as String,
      questions: (json['questions'] as List<dynamic>?)
              ?.map((e) => EraQuizRecapItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <EraQuizRecapItem>[],
    );

Map<String, dynamic> _$EraQuizRecapResponseToJson(
        _EraQuizRecapResponse instance) =>
    <String, dynamic>{
      'completed_at': instance.completedAt,
      'questions': instance.questions,
    };
