// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quiz_question_option.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_QuizQuestionOption _$QuizQuestionOptionFromJson(Map<String, dynamic> json) =>
    _QuizQuestionOption(
      id: (json['id'] as num).toInt(),
      optionText: json['option_text'] as String,
      order: (json['order'] as num).toInt(),
    );

Map<String, dynamic> _$QuizQuestionOptionToJson(_QuizQuestionOption instance) =>
    <String, dynamic>{
      'id': instance.id,
      'option_text': instance.optionText,
      'order': instance.order,
    };
