// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'era_quiz_result_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_EraQuizResultResponse _$EraQuizResultResponseFromJson(
        Map<String, dynamic> json) =>
    _EraQuizResultResponse(
      message: json['message'] as String?,
      completedAt: json['completed_at'] as String,
      passingGrade: (json['passing_grade'] as num).toInt(),
      result: EraQuizScore.fromJson(json['result'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$EraQuizResultResponseToJson(
        _EraQuizResultResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'completed_at': instance.completedAt,
      'passing_grade': instance.passingGrade,
      'result': instance.result,
    };
