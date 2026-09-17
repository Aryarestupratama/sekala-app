import 'package:freezed_annotation/freezed_annotation.dart';
import 'quiz.dart';

part 'quiz_show_response.freezed.dart';
part 'quiz_show_response.g.dart';

/// REVISI BESAR (kuis formatif kini berskor + passing grade 75% + boleh
/// retake): DIKONFIRMASI ke `UserQuizController::show()` yang baru.
///
/// Shape:
/// ```json
/// {
///   "quiz": { "id": 1, "year_id": 3, "is_published": true, "questions": [...] },
///   "passing_grade": 75,
///   "question_count": 10,
///   "attempt_status": "not_started" | "in_progress" | "failed" | "passed",
///   "latest_score": 62.5
/// }
/// ```
///
/// `passing_grade`/`question_count` WAJIB ditampilkan ke user di layar
/// SEBELUM masuk soal pertama (requirement baru "minimum passing grade
/// ditampilkan sebelum masuk halaman quiz") — jangan langsung lompat ke
/// soal pertama tanpa layar info ini.
///
/// `attemptStatus` menentukan tombol apa yang ditampilkan:
/// - `not_started`: tombol "Mulai Kuis" -> langsung ke soal pertama
///   (endpoint answer akan otomatis bikin attempt baru, tidak perlu
///   panggil retry() dulu).
/// - `in_progress`: user pernah mulai tapi belum menjawab semua soal —
///   tombol "Lanjutkan" (Flutter idealnya sudah tahu progress lokal, tapi
///   kalau state lokal hilang/reinstall app, minimal tetap bisa lanjut
///   dari soal yang belum terjawab lewat endpoint answer per soal).
/// - `failed`: user sudah selesai tapi skor < passing_grade — tombol
///   "Kerjakan Ulang", WAJIB panggil `POST .../quiz/retry` dulu sebelum
///   menjawab soal pertama (endpoint answer akan 409 kalau belum retry).
/// - `passed`: user sudah lulus — tampilkan skor akhir, TIDAK ada tombol
///   kerjakan ulang (backend menolak retry kalau sudah lulus).
///
/// `latestScore` nullable — null kalau `attempt_status == not_started`.
@freezed
abstract class QuizShowResponse with _$QuizShowResponse {
  const factory QuizShowResponse({
    required Quiz quiz,
    @JsonKey(name: 'passing_grade') required int passingGrade,
    @JsonKey(name: 'question_count') required int questionCount,
    @JsonKey(name: 'attempt_status') required String attemptStatus,
    @JsonKey(name: 'latest_score') double? latestScore,
  }) = _QuizShowResponse;

  factory QuizShowResponse.fromJson(Map<String, dynamic> json) =>
      _$QuizShowResponseFromJson(json);
}

extension QuizShowResponseX on QuizShowResponse {
  bool get notStarted => attemptStatus == 'not_started';
  bool get inProgress => attemptStatus == 'in_progress';
  bool get failed => attemptStatus == 'failed';
  bool get passed => attemptStatus == 'passed';

  /// Boleh langsung jawab soal (tanpa panggil retry() dulu) hanya kalau
  /// belum pernah selesai (not_started/in_progress). Kalau `failed`,
  /// endpoint answer akan 409 sampai retry() dipanggil.
  bool get canAnswerDirectly => notStarted || inProgress;
}