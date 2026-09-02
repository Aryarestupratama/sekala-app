// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quiz.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Quiz _$QuizFromJson(Map<String, dynamic> json) => _Quiz(
      id: (json['id'] as num).toInt(),
      yearId: (json['year_id'] as num).toInt(),
      isPublished: json['is_published'] as bool,
      questions: (json['questions'] as List<dynamic>?)
              ?.map((e) => QuizQuestion.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <QuizQuestion>[],
    );

Map<String, dynamic> _$QuizToJson(_Quiz instance) => <String, dynamic>{
      'id': instance.id,
      'year_id': instance.yearId,
      'is_published': instance.isPublished,
      'questions': instance.questions,
    };
