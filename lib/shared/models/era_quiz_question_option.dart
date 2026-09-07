import 'package:freezed_annotation/freezed_annotation.dart';

part 'era_quiz_question_option.freezed.dart';
part 'era_quiz_question_option.g.dart';

/// Mengacu Schema.md §2.16 `era_quiz_question_options`.
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
/// `EraQuizRecapOption.isCorrect` di endpoint recap (setelah submit).
///
/// ASUMSI (belum dicek ke source `UserEraQuizController::show()`):
/// nama endpoint & shape field persis sama pola dengan quiz year — tolong
/// verifikasi ke controller aslinya.
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