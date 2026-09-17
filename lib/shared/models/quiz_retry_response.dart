import 'package:freezed_annotation/freezed_annotation.dart';

part 'quiz_retry_response.freezed.dart';
part 'quiz_retry_response.g.dart';

/// DIKONFIRMASI ke `UserQuizController::retry()` (endpoint BARU —
/// `POST /api/years/{year}/quiz/retry`, R-QUIZ-08 kuis formatif boleh
/// dikerjakan ulang sampai lulus).
///
/// Shape sukses (200):
/// ```json
/// { "message": "Kuis siap dikerjakan ulang.", "attempt_status": "in_progress" }
/// ```
/// `attemptStatus` di sini SELALU "in_progress" begitu retry berhasil
/// (attempt di-reset ke kosong) — konsisten dengan enum di
/// `QuizShowResponse.attemptStatus`.
///
/// Backend menolak (422) kalau attempt SUDAH lulus (tidak ada gunanya
/// retry kuis yang sudah lulus) — tangani error 422 ini di layer
/// provider/repository, BUKAN lewat model ini (model ini cuma untuk
/// response sukses).
@freezed
abstract class QuizRetryResponse with _$QuizRetryResponse {
  const factory QuizRetryResponse({
    required String message,
    @JsonKey(name: 'attempt_status') required String attemptStatus,
  }) = _QuizRetryResponse;

  factory QuizRetryResponse.fromJson(Map<String, dynamic> json) =>
      _$QuizRetryResponseFromJson(json);
}