import 'package:freezed_annotation/freezed_annotation.dart';

part 'era_quiz_score.freezed.dart';
part 'era_quiz_score.g.dart';

/// DIKONFIRMASI ke `EraQuizAttemptService::buildResult()` — shape final:
/// ```json
/// { "total": 20, "correct": 15, "incorrect": 5, "percentage": 75, "is_passing": true }
/// ```
///
/// REVISI: tambah `incorrect` (int) & `is_passing` (bool) — dulu model ini
/// cuma correct/total/percentage (asumsi lama, belum terverifikasi).
/// `isPassing` BARU (passing grade 75%, `EraQuiz::PASSING_GRADE_PERCENTAGE`)
/// — dulu kuis sumatif cuma tampilkan skor tanpa status lulus/tidak,
/// sekarang halaman Hasil WAJIB tampilkan label lulus/tidak lulus juga.
///
/// `percentage` di source backend adalah `int` (dibulatkan
/// `round(...)` lalu di-cast `(int)`), BUKAN `double` seperti asumsi versi
/// sebelumnya — diperbaiki di sini jadi `int`. Kalau UI butuh tampilan
/// desimal, format sendiri di widget (`'$percentage%'` sudah cukup untuk
/// kebanyakan kasus karena sudah dibulatkan di backend).
@freezed
abstract class EraQuizScore with _$EraQuizScore {
  const factory EraQuizScore({
    required int total,
    required int correct,
    required int incorrect,
    required int percentage,
    @JsonKey(name: 'is_passing') required bool isPassing,
  }) = _EraQuizScore;

  factory EraQuizScore.fromJson(Map<String, dynamic> json) =>
      _$EraQuizScoreFromJson(json);
}