import 'package:freezed_annotation/freezed_annotation.dart';

part 'quiz_question_option.freezed.dart';
part 'quiz_question_option.g.dart';

/// Mengacu Schema.md §2.10 `quiz_question_options`.
///
/// PENTING: `is_correct` SENGAJA TIDAK ADA di model ini. Model ini dipakai
/// saat user MENGAMBIL soal untuk dijawab (GET quiz) — kalau `is_correct`
/// ikut dikirim di titik ini, itu bocor jawaban sebelum user menjawab.
/// `is_correct` cuma relevan sebagai SUMBER KEBENARAN backend saat submit
/// (R-QUIZ-04, R-QUIZ-07), dan hasil perbandingannya baru dikirim balik
/// ke client lewat `QuizAnswerFeedback` (lihat quiz_answer_feedback.dart),
/// bukan lewat model opsi ini.
///
/// ASUMSI (belum dicek ke source Resource asli): nama endpoint & shape
/// persis — tolong verifikasi ke `Api/Quiz/UserQuizController::show()`.
@freezed
abstract class QuizQuestionOption with _$QuizQuestionOption {
  const factory QuizQuestionOption({
    required int id,
    @JsonKey(name: 'option_text') required String optionText,
    required int order,
  }) = _QuizQuestionOption;

  factory QuizQuestionOption.fromJson(Map<String, dynamic> json) =>
      _$QuizQuestionOptionFromJson(json);
}