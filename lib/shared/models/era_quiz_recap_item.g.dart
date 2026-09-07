// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'era_quiz_recap_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_EraQuizRecapItem _$EraQuizRecapItemFromJson(Map<String, dynamic> json) =>
    _EraQuizRecapItem(
      questionId: (json['question_id'] as num).toInt(),
      question: json['question'] as String,
      options: (json['options'] as List<dynamic>?)
              ?.map(
                  (e) => EraQuizRecapOption.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <EraQuizRecapOption>[],
      selectedOptionId: (json['selected_option_id'] as num?)?.toInt(),
      correctOptionId: (json['correct_option_id'] as num?)?.toInt(),
      isCorrect: json['is_correct'] as bool,
      explanation: json['explanation'] as String,
    );

Map<String, dynamic> _$EraQuizRecapItemToJson(_EraQuizRecapItem instance) =>
    <String, dynamic>{
      'question_id': instance.questionId,
      'question': instance.question,
      'options': instance.options,
      'selected_option_id': instance.selectedOptionId,
      'correct_option_id': instance.correctOptionId,
      'is_correct': instance.isCorrect,
      'explanation': instance.explanation,
    };
