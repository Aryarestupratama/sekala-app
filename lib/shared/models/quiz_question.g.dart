// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quiz_question.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_QuizQuestion _$QuizQuestionFromJson(Map<String, dynamic> json) =>
    _QuizQuestion(
      id: (json['id'] as num).toInt(),
      order: (json['order'] as num).toInt(),
      question: json['question'] as String,
      options: (json['options'] as List<dynamic>?)
              ?.map(
                  (e) => QuizQuestionOption.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <QuizQuestionOption>[],
    );

Map<String, dynamic> _$QuizQuestionToJson(_QuizQuestion instance) =>
    <String, dynamic>{
      'id': instance.id,
      'order': instance.order,
      'question': instance.question,
      'options': instance.options,
    };
