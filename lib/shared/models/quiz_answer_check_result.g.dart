// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quiz_answer_check_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_QuizAnswerCheckResult _$QuizAnswerCheckResultFromJson(
        Map<String, dynamic> json) =>
    _QuizAnswerCheckResult(
      questionId: (json['question_id'] as num).toInt(),
      selectedOptionId: (json['selected_option_id'] as num).toInt(),
      correctOptionId: (json['correct_option_id'] as num?)?.toInt(),
      isCorrect: json['is_correct'] as bool,
      explanation: json['explanation'] as String,
      quizCompleted: json['quiz_completed'] as bool? ?? false,
      finalScore: (json['final_score'] as num?)?.toDouble(),
      isPassing: json['is_passing'] as bool?,
      passingGrade: (json['passing_grade'] as num).toInt(),
      newlyUnlockedVaccineIds:
          (json['newly_unlocked_vaccine_ids'] as List<dynamic>?)
                  ?.map((e) => (e as num).toInt())
                  .toList() ??
              const <int>[],
    );

Map<String, dynamic> _$QuizAnswerCheckResultToJson(
        _QuizAnswerCheckResult instance) =>
    <String, dynamic>{
      'question_id': instance.questionId,
      'selected_option_id': instance.selectedOptionId,
      'correct_option_id': instance.correctOptionId,
      'is_correct': instance.isCorrect,
      'explanation': instance.explanation,
      'quiz_completed': instance.quizCompleted,
      'final_score': instance.finalScore,
      'is_passing': instance.isPassing,
      'passing_grade': instance.passingGrade,
      'newly_unlocked_vaccine_ids': instance.newlyUnlockedVaccineIds,
    };
