import 'package:freezed_annotation/freezed_annotation.dart';
import 'era_quiz_question_option.dart';

part 'era_quiz_question.freezed.dart';
part 'era_quiz_question.g.dart';

/// Mengacu shape JSON yang dikirim `UserEraQuizController::show()` — TIDAK
/// LAGI mengacu tabel `era_quiz_questions` (tabel itu sudah DIHAPUS TOTAL
/// dari database). Soal sekarang berasal dari `quiz_questions` (bank
/// FORMATIF milik tiap year dalam era ini), ditarik & didistribusikan
/// proporsional sampai total EraQuiz::ATTEMPT_QUESTION_COUNT (20) — BUKAN
/// lagi "tanpa batas maksimal" seperti versi sebelumnya (R-ERAQUIZ-06
/// LAMA sudah tidak berlaku). Shape field (id/order/question/options)
/// TIDAK berubah, jadi model ini tetap valid dipakai apa adanya.
///
/// `explanationCorrect`/`explanationIncorrect` TIDAK ikut di model ini
/// (murni internal backend untuk membentuk `explanation` di recap,
/// sama seperti `QuizQuestion::explanationFor()` di kuis year) — Flutter
/// cukup terima `explanation` jadi lewat `EraQuizRecapItem`, bukan pilih
/// sendiri dari 2 kolom mentah.
@freezed
abstract class EraQuizQuestion with _$EraQuizQuestion {
  const factory EraQuizQuestion({
    required int id,
    required int order,
    required String question,
    @Default(<EraQuizQuestionOption>[]) List<EraQuizQuestionOption> options,
  }) = _EraQuizQuestion;

  factory EraQuizQuestion.fromJson(Map<String, dynamic> json) =>
      _$EraQuizQuestionFromJson(json);
}