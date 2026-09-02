import 'package:freezed_annotation/freezed_annotation.dart';
import 'quiz_answer_feedback.dart';

part 'quiz_submit_response.freezed.dart';
part 'quiz_submit_response.g.dart';

/// DIKONFIRMASI ke `UserQuizController::submitAttempt()` — response
/// `POST /api/years/{year}/quiz/attempt` (BUKAN `/quiz/submit`, koreksi
/// dari asumsi versi sebelumnya).
///
/// Shape asli:
/// ```json
/// {
///   "message": "Kuis berhasil dikerjakan." | "Kuis ini sudah pernah dikerjakan sebelumnya.",
///   "completed_at": "...",
///   "feedback": [ { question_id, selected_option_id, is_correct }, ... ],
///   "newly_unlocked_vaccine_ids": [1, 4, ...]
/// }
/// ```
///
/// PENTING (koreksi dari asumsi versi sebelumnya):
/// - `newly_unlocked_vaccine_ids` cuma array of ID (int), BUKAN objek
///   `VaccineCard` lengkap. Kalau mau animasi "Vaksin baru terbuka!"
///   (INFO-06, Design.md §3.3.6) menampilkan nama/foto vaksin, Flutter
///   perlu fetch detail terpisah (mis. `GET /api/cards` lalu filter by id,
///   atau `GET /api/cards/{id}` per id kalau endpoint itu ada) — tidak
///   didapat langsung dari response submit ini.
/// - Tidak ada field boolean eksplisit untuk "sudah pernah dikerjakan
///   sebelumnya" (R-QUIZ-08) — backend cuma membedakan lewat teks
///   `message`. Dibuat helper `isFirstSubmission` di bawah, TAPI ini
///   fragile (bergantung isi teks pesan) — kalau memungkinkan, lebih baik
///   minta backend menambah field eksplisit `already_attempted: bool`
///   di response ini untuk keandalan jangka panjang.
@freezed
abstract class QuizSubmitResponse with _$QuizSubmitResponse {
  const factory QuizSubmitResponse({
    required String message,
    @JsonKey(name: 'completed_at') required String completedAt,
    @JsonKey(name: 'feedback')
    @Default(<QuizAnswerFeedback>[])
    List<QuizAnswerFeedback> feedback,
    @JsonKey(name: 'newly_unlocked_vaccine_ids')
    @Default(<int>[])
    List<int> newlyUnlockedVaccineIds,
  }) = _QuizSubmitResponse;

  factory QuizSubmitResponse.fromJson(Map<String, dynamic> json) =>
      _$QuizSubmitResponseFromJson(json);
}

/// Helper non-generated, TIDAK ideal (parsing teks pesan) — lihat catatan
/// di atas kenapa field eksplisit dari backend lebih disarankan.
extension QuizSubmitResponseX on QuizSubmitResponse {
  bool get isFirstSubmission =>
      !message.toLowerCase().contains('sudah pernah dikerjakan');
}