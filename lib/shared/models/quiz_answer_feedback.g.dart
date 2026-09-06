// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quiz_answer_feedback.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_QuizAnswerFeedback _$QuizAnswerFeedbackFromJson(Map<String, dynamic> json) =>
    _QuizAnswerFeedback(
      questionId: (json['question_id'] as num).toInt(),
      selectedOptionId: (json['selected_option_id'] as num?)?.toInt(),
      isCorrect: json['is_correct'] as bool,
      explanation: json['explanation'] as String,
    );

Map<String, dynamic> _$QuizAnswerFeedbackToJson(_QuizAnswerFeedback instance) =>
    <String, dynamic>{
      'question_id': instance.questionId,
      'selected_option_id': instance.selectedOptionId,
      'is_correct': instance.isCorrect,
      'explanation': instance.explanation,
    };
