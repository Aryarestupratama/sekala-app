import 'package:freezed_annotation/freezed_annotation.dart';

part 'era_quiz_question_option.freezed.dart';
part 'era_quiz_question_option.g.dart';

/// Mengacu shape JSON yang dikirim `UserEraQuizController::show()` —
/// TIDAK LAGI mengacu tabel `era_quiz_question_options` (dihapus total).
/// Opsi ini sekarang sumbernya `quiz_question_options` (bank FORMATIF
/// milik tiap year), tapi shape field (id/option_text/order) TIDAK
/// berubah — model ini tetap valid dipakai apa adanya.
///
/// Sama filosofi dengan `QuizQuestionOption` (quiz year): `is_correct`
/// SENGAJA TIDAK ADA di sini karena model ini dipakai saat soal
/// SEDANG DIKERJAKAN user (GET .../quiz, sebelum submit) — mengirim
/// `is_correct` di titik ini bocor jawaban.
///
/// BEDA dari kuis year: kuis sumatif era submit SEKALIGUS di akhir
/// (Architecture.md §4.9), bukan progresif per-soal — jadi tidak ada
/// endpoint "answer per soal" yang butuh `correct_option_id` seperti
/// `QuizAnswerCheckResult` di kuis year. Opsi benar baru terungkap lewat
/// `EraQuizRecapOption`/`EraQuizRecapItem.correctOptionId` di endpoint
/// recap (setelah submit).
@freezed
abstract class EraQuizQuestionOption with _$EraQuizQuestionOption {
  const factory EraQuizQuestionOption({
    required int id,
    @JsonKey(name: 'option_text') required String optionText,
    required int order,
  }) = _EraQuizQuestionOption;

  factory EraQuizQuestionOption.fromJson(Map<String, dynamic> json) =>
      _$EraQuizQuestionOptionFromJson(json);
}