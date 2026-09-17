// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quiz_retry_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_QuizRetryResponse _$QuizRetryResponseFromJson(Map<String, dynamic> json) =>
    _QuizRetryResponse(
      message: json['message'] as String,
      attemptStatus: json['attempt_status'] as String,
    );

Map<String, dynamic> _$QuizRetryResponseToJson(_QuizRetryResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'attempt_status': instance.attemptStatus,
    };
