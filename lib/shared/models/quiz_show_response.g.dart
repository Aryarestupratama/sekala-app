// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quiz_show_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_QuizShowResponse _$QuizShowResponseFromJson(Map<String, dynamic> json) =>
    _QuizShowResponse(
      quiz: Quiz.fromJson(json['quiz'] as Map<String, dynamic>),
      passingGrade: (json['passing_grade'] as num).toInt(),
      questionCount: (json['question_count'] as num).toInt(),
      attemptStatus: json['attempt_status'] as String,
      latestScore: (json['latest_score'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$QuizShowResponseToJson(_QuizShowResponse instance) =>
    <String, dynamic>{
      'quiz': instance.quiz,
      'passing_grade': instance.passingGrade,
      'question_count': instance.questionCount,
      'attempt_status': instance.attemptStatus,
      'latest_score': instance.latestScore,
    };
