import 'package:freezed_annotation/freezed_annotation.dart';
import 'era_quiz_recap_option.dart';
import 'era_quiz_recap_year.dart';

part 'era_quiz_recap_item.freezed.dart';
part 'era_quiz_recap_item.g.dart';

/// DIKONFIRMASI ke `UserEraQuizController::recap()`. Shape persis 1 item
/// dalam array `questions`:
/// ```json
/// {
///   "question_id": 12,
///   "question": "...",
///   "year": { "id": 3, "year": 1974 },
///   "options": [ { "id": 45, "option_text": "..." }, ... ],
///   "selected_option_id": 45,
///   "correct_option_id": 46,
///   "is_correct": false,
///   "explanation": "..."
/// }
/// ```
///
/// BARU: `year` (nullable) — info tahun asal soal ini (konsekuensi dari
/// revisi "soal sumatif ditarik dari bank formatif per year", lihat
/// `EraQuizRecapYear`). Opsional dipakai di UI atau tidak.
///
/// KOREKSI dari asumsi versi sebelumnya: opsi TIDAK membawa `is_correct`
/// masing-masing — sebaliknya `correctOptionId` di level item ini yang
/// jadi sumber kebenaran opsi mana yang benar (bandingkan `id` tiap opsi
/// di `options` dengan field ini untuk highlight hijau, ERAQUIZ-04).
/// `isCorrect` di sini murni bandingan `selectedOptionId == correctOptionId`
/// (dihitung backend, tapi hasilnya sama kalau mau dihitung ulang di
/// Flutter juga).
///
/// `explanation` SUDAH dipilih server dari `explanation_correct` atau
/// `explanation_incorrect` sesuai `isCorrect` (pola sama dengan
/// `QuizQuestion::explanationFor()` di kuis year) — tampilkan apa adanya.
///
/// `correctOptionId`/`selectedOptionId` nullable sebagai jaring pengaman
/// (tidak terlihat eksplisit non-nullable di controller), meski
/// `StoreEraQuizAttemptRequest` seharusnya menjamin semua soal terjawab
/// sebelum submit (R-ERAQUIZ-04) sehingga `selectedOptionId` praktis
/// selalu terisi.
@freezed
abstract class EraQuizRecapItem with _$EraQuizRecapItem {
  const factory EraQuizRecapItem({
    @JsonKey(name: 'question_id') required int questionId,
    required String question,
    EraQuizRecapYear? year,
    @Default(<EraQuizRecapOption>[]) List<EraQuizRecapOption> options,
    @JsonKey(name: 'selected_option_id') int? selectedOptionId,
    @JsonKey(name: 'correct_option_id') int? correctOptionId,
    @JsonKey(name: 'is_correct') required bool isCorrect,
    required String explanation,
  }) = _EraQuizRecapItem;

  factory EraQuizRecapItem.fromJson(Map<String, dynamic> json) =>
      _$EraQuizRecapItemFromJson(json);
}