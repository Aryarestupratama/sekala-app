import 'package:freezed_annotation/freezed_annotation.dart';

part 'quiz_answer_check_result.freezed.dart';
part 'quiz_answer_check_result.g.dart';

/// DIKONFIRMASI ke `UserQuizController::answerQuestion()` — shape BARU
/// (kuis formatif kini berskor + passing grade 75%):
/// ```json
/// {
///   "question_id": 12,
///   "selected_option_id": 45,
///   "correct_option_id": 46,
///   "is_correct": false,
///   "explanation": "...",
///   "quiz_completed": false,
///   "final_score": null,
///   "is_passing": null,
///   "passing_grade": 75,
///   "newly_unlocked_vaccine_ids": []
/// }
/// ```
///
/// Feedback instan per-soal (question_id/selected_option_id/
/// correct_option_id/is_correct/explanation) TIDAK berubah dari versi
/// sebelumnya — tetap tampil segera setelah user menjawab.
///
/// BARU: `finalScore`/`isPassing` HANYA terisi kalau `quizCompleted ==
/// true` (soal ini adalah soal TERAKHIR yang belum terjawab) — di soal
/// sebelum itu, keduanya selalu null. `passingGrade` (75) SELALU terisi
/// (bukan cuma saat completed) supaya Flutter bisa tampilkan referensi
/// tanpa perlu simpan ulang dari `QuizShowResponse` sebelumnya.
///
/// Kalau `quizCompleted == true && isPassing == false`: year BELUM
/// completed (vaksin TIDAK unlock — `newlyUnlockedVaccineIds` kosong),
/// dan user perlu memanggil `POST .../quiz/retry` untuk mencoba lagi.
@freezed
abstract class QuizAnswerCheckResult with _$QuizAnswerCheckResult {
  const factory QuizAnswerCheckResult({
    @JsonKey(name: 'question_id') required int questionId,
    @JsonKey(name: 'selected_option_id') required int selectedOptionId,
    @JsonKey(name: 'correct_option_id') int? correctOptionId,
    @JsonKey(name: 'is_correct') required bool isCorrect,
    required String explanation,
    @JsonKey(name: 'quiz_completed') @Default(false) bool quizCompleted,
    @JsonKey(name: 'final_score') double? finalScore,
    @JsonKey(name: 'is_passing') bool? isPassing,
    @JsonKey(name: 'passing_grade') required int passingGrade,
    @JsonKey(name: 'newly_unlocked_vaccine_ids')
    @Default(<int>[])
    List<int> newlyUnlockedVaccineIds,
  }) = _QuizAnswerCheckResult;

  factory QuizAnswerCheckResult.fromJson(Map<String, dynamic> json) =>
      _$QuizAnswerCheckResultFromJson(json);
}