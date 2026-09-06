import 'package:freezed_annotation/freezed_annotation.dart';

part 'quiz_answer_check_result.freezed.dart';
part 'quiz_answer_check_result.g.dart';

/// DIKONFIRMASI ke `UserQuizController::answerQuestion()` (endpoint BARU
/// `POST /api/years/{year}/quiz/questions/{question}/answer`) — dipakai
/// untuk skema kuis "instan per soal" (BEDA dari `QuizAnswerFeedback` lama
/// yang dipakai alur submit-sekaligus-di-akhir + replay).
///
/// Shape response:
/// ```json
/// {
///   "question_id": 12,
///   "selected_option_id": 45,
///   "correct_option_id": 46,
///   "is_correct": false,
///   "explanation": "...",
///   "quiz_completed": false,
///   "newly_unlocked_vaccine_ids": []
/// }
/// ```
///
/// BEDA PENTING dari `QuizAnswerFeedback`: endpoint ini SENGAJA mengirim
/// `correct_option_id` — karena PRD.md QUIZ-03 / Rules.md R-QUIZ-04 memang
/// mensyaratkan opsi yang benar ikut di-highlight ke user saat jawaban
/// salah. Ini aman (tidak lagi "bocor jawaban sebelum menjawab") karena
/// endpoint ini baru dipanggil SETELAH user benar-benar memilih opsi untuk
/// soal itu — bukan dikirim di awal lewat GET quiz (lihat
/// quiz_question_option.dart, yang tetap tidak membawa `is_correct`).
///
/// `correctOptionId` tetap nullable sebagai jaring pengaman kalau suatu
/// saat ada soal published tanpa opsi `is_correct` (seharusnya tidak
/// mungkin lolos R-QUIZ-07, tapi backend defensifnya pakai `?->id`).
///
/// `quizCompleted` — true kalau jawaban ini adalah jawaban soal TERAKHIR
/// yang belum terjawab di kuis ini (attempt baru saja ditandai selesai di
/// backend, R-PROG-07/08 langsung dicek ulang saat itu juga). Flutter
/// pakai flag ini untuk mengganti label tombol "Lanjut" -> "Selesai" dan
/// memicu alur `_finish()` (banner unlock vaksin dsb).
///
/// `newlyUnlockedVaccineIds` cuma terisi kalau `quizCompleted == true`
/// (soal-soal sebelumnya selalu array kosong, karena unlock vaksin baru
/// dicek saat quiz benar-benar selesai).
@freezed
abstract class QuizAnswerCheckResult with _$QuizAnswerCheckResult {
  const factory QuizAnswerCheckResult({
    @JsonKey(name: 'question_id') required int questionId,
    @JsonKey(name: 'selected_option_id') required int selectedOptionId,
    @JsonKey(name: 'correct_option_id') int? correctOptionId,
    @JsonKey(name: 'is_correct') required bool isCorrect,
    required String explanation,
    @JsonKey(name: 'quiz_completed') @Default(false) bool quizCompleted,
    @JsonKey(name: 'newly_unlocked_vaccine_ids')
    @Default(<int>[])
    List<int> newlyUnlockedVaccineIds,
  }) = _QuizAnswerCheckResult;

  factory QuizAnswerCheckResult.fromJson(Map<String, dynamic> json) =>
      _$QuizAnswerCheckResultFromJson(json);
}