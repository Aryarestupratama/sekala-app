import 'package:freezed_annotation/freezed_annotation.dart';

part 'era_quiz_result.freezed.dart';
part 'era_quiz_result.g.dart';

/// ASUMSI, BELUM DIKONFIRMASI ke source `EraQuizAttemptService::buildResult()`
/// / `UserEraQuizController::submitAttempt()` & `result()`.
///
/// Dipakai untuk DUA endpoint sekaligus (diasumsikan shape sama persis):
/// - `POST /api/eras/{era}/quiz/attempt` (submit, R-ERAQUIZ-04)
/// - `GET /api/eras/{era}/quiz/result` (buka ulang halaman Hasil tanpa
///   submit baru, mis. dari roadmap setelah status "attempted")
///
/// BEDA PENTING dari `QuizSubmitResponse` (kuis year): skor DISENGAJA ada
/// di sini (Architecture.md §4.9, ERAQUIZ-03) — dan dihitung on-the-fly
/// dari attempt TERKINI setiap endpoint ini dipanggil (R-ERAQUIZ-05),
/// bukan kolom tersimpan. Kalau user retake, angka ini otomatis berubah
/// merefleksikan attempt paling baru begitu di-fetch ulang.
///
/// Shape yang diasumsikan (perlu verifikasi):
/// ```json
/// {
///   "correct": 7,
///   "total": 10,
///   "percentage": 70.0,
///   "completed_at": "2026-09-01T10:00:00Z"
/// }
/// ```
///
/// `message` dibuat nullable & opsional — kalau backend TIDAK mengirim
/// kalimat template selamat (ERAQUIZ-03) lewat API, Flutter perlu
/// menyusun sendiri berdasarkan `percentage` (mis. threshold tier
/// "Luar biasa!"/"Bagus, terus belajar!"). Kalau backend memang
/// mengirimnya, tinggal pakai field ini apa adanya.
@freezed
abstract class EraQuizResult with _$EraQuizResult {
  const factory EraQuizResult({
    required int correct,
    required int total,
    required double percentage,
    @JsonKey(name: 'completed_at') required String completedAt,
    String? message,
  }) = _EraQuizResult;

  factory EraQuizResult.fromJson(Map<String, dynamic> json) =>
      _$EraQuizResultFromJson(json);
}