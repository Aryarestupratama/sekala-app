import 'package:freezed_annotation/freezed_annotation.dart';
import 'era_quiz_score.dart';

part 'era_quiz_result_response.freezed.dart';
part 'era_quiz_result_response.g.dart';

/// DIKONFIRMASI ke `UserEraQuizController` — dipakai untuk DUA endpoint:
///
/// `POST /api/eras/{era}/quiz/attempt` (submitAttempt):
/// ```json
/// {
///   "message": "Selamat! Kamu sudah menyelesaikan kuis sumatif era ...",
///   "completed_at": "...",
///   "passing_grade": 75,
///   "result": { "total": 20, "correct": 15, "incorrect": 5, "percentage": 75, "is_passing": true }
/// }
/// ```
///
/// `GET /api/eras/{era}/quiz/result` (result):
/// ```json
/// {
///   "completed_at": "...",
///   "passing_grade": 75,
///   "result": { ... }
/// }
/// ```
/// — TIDAK ada `message` di endpoint ini (controller tidak mengirimnya),
/// makanya `message` di model ini nullable. `passingGrade` (BARU) SELALU
/// ada di kedua endpoint — dipakai bareng `result.isPassing`
/// (`EraQuizScore.isPassing`) untuk render label "Lulus"/"Belum Lulus"
/// di halaman Hasil, tanpa perlu simpan ulang dari `EraQuizStart`
/// sebelumnya.
///
/// PENTING: skor SELALU dihitung on-the-fly dari attempt TERKINI
/// (R-ERAQUIZ-05) setiap endpoint ini dipanggil — retake mengubah angka
/// ini begitu di-fetch ulang, tidak ada histori attempt sebelumnya.
@freezed
abstract class EraQuizResultResponse with _$EraQuizResultResponse {
  const factory EraQuizResultResponse({
    String? message,
    @JsonKey(name: 'completed_at') required String completedAt,
    @JsonKey(name: 'passing_grade') required int passingGrade,
    required EraQuizScore result,
  }) = _EraQuizResultResponse;

  factory EraQuizResultResponse.fromJson(Map<String, dynamic> json) =>
      _$EraQuizResultResponseFromJson(json);
}