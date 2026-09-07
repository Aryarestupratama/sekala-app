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
///   "result": { "correct": 7, "total": 10, "percentage": 70.0 }
/// }
/// ```
///
/// `GET /api/eras/{era}/quiz/result` (result):
/// ```json
/// {
///   "completed_at": "...",
///   "result": { ... }
/// }
/// ```
/// — TIDAK ada `message` di endpoint ini (controller tidak mengirimnya),
/// makanya `message` di model ini nullable. UI: kalau `message == null`
/// (mis. user tap ikon "sudah dikerjakan" dari roadmap, buka Hasil lewat
/// endpoint result() bukan submitAttempt()), Flutter perlu fallback ke
/// kalimat template sendiri atau cukup tampilkan skor tanpa kalimat
/// selamat — putuskan sesuai desain (Design.md belum dicek untuk detail
/// ini).
///
/// PENTING: skor SELALU dihitung on-the-fly dari attempt TERKINI
/// (R-ERAQUIZ-05) setiap endpoint ini dipanggil — retake mengubah angka
/// ini begitu di-fetch ulang, tidak ada histori attempt sebelumnya.
@freezed
abstract class EraQuizResultResponse with _$EraQuizResultResponse {
  const factory EraQuizResultResponse({
    String? message,
    @JsonKey(name: 'completed_at') required String completedAt,
    required EraQuizScore result,
  }) = _EraQuizResultResponse;

  factory EraQuizResultResponse.fromJson(Map<String, dynamic> json) =>
      _$EraQuizResultResponseFromJson(json);
}