// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'era_quiz_start.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_EraQuizStart _$EraQuizStartFromJson(Map<String, dynamic> json) =>
    _EraQuizStart(
      eraQuizId: (json['era_quiz_id'] as num).toInt(),
      passingGrade: (json['passing_grade'] as num).toInt(),
      questionCount: (json['question_count'] as num).toInt(),
      questions: (json['questions'] as List<dynamic>?)
              ?.map((e) => EraQuizQuestion.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <EraQuizQuestion>[],
    );

Map<String, dynamic> _$EraQuizStartToJson(_EraQuizStart instance) =>
    <String, dynamic>{
      'era_quiz_id': instance.eraQuizId,
      'passing_grade': instance.passingGrade,
      'question_count': instance.questionCount,
      'questions': instance.questions,
    };
