// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'era_quiz_question.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_EraQuizQuestion _$EraQuizQuestionFromJson(Map<String, dynamic> json) =>
    _EraQuizQuestion(
      id: (json['id'] as num).toInt(),
      order: (json['order'] as num).toInt(),
      question: json['question'] as String,
      options: (json['options'] as List<dynamic>?)
              ?.map((e) =>
                  EraQuizQuestionOption.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <EraQuizQuestionOption>[],
    );

Map<String, dynamic> _$EraQuizQuestionToJson(_EraQuizQuestion instance) =>
    <String, dynamic>{
      'id': instance.id,
      'order': instance.order,
      'question': instance.question,
      'options': instance.options,
    };
