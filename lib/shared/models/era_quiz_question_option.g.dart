// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'era_quiz_question_option.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_EraQuizQuestionOption _$EraQuizQuestionOptionFromJson(
        Map<String, dynamic> json) =>
    _EraQuizQuestionOption(
      id: (json['id'] as num).toInt(),
      optionText: json['option_text'] as String,
      order: (json['order'] as num).toInt(),
    );

Map<String, dynamic> _$EraQuizQuestionOptionToJson(
        _EraQuizQuestionOption instance) =>
    <String, dynamic>{
      'id': instance.id,
      'option_text': instance.optionText,
      'order': instance.order,
    };
