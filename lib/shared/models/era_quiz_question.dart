import 'package:freezed_annotation/freezed_annotation.dart';
import 'era_quiz_question_option.dart';

part 'era_quiz_question.freezed.dart';
part 'era_quiz_question.g.dart';

/// Mengacu Schema.md §2.15 `era_quiz_questions`.
///
/// TIDAK ADA batas jumlah maksimal (beda dari `QuizQuestion` kuis year
/// yang dibatasi 5 soal di aplikasi, R-QUIZ-07) — R-ERAQUIZ-06. Jangan
/// tambahkan validasi client-side apapun soal jumlah maksimal soal untuk
/// model/screen kuis sumatif era.
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