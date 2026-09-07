// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'era_quiz.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_EraQuiz _$EraQuizFromJson(Map<String, dynamic> json) => _EraQuiz(
      id: (json['id'] as num).toInt(),
      eraId: (json['era_id'] as num).toInt(),
      isPublished: json['is_published'] as bool,
      questions: (json['questions'] as List<dynamic>?)
              ?.map((e) => EraQuizQuestion.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <EraQuizQuestion>[],
    );

Map<String, dynamic> _$EraQuizToJson(_EraQuiz instance) => <String, dynamic>{
      'id': instance.id,
      'era_id': instance.eraId,
      'is_published': instance.isPublished,
      'questions': instance.questions,
    };
