import 'package:freezed_annotation/freezed_annotation.dart';

part 'era_quiz_score.freezed.dart';
part 'era_quiz_score.g.dart';

/// DIKONFIRMASI ke `UserEraQuizController::submitAttempt()`/`result()` —
/// ini shape dari key `result` di response, dibentuk
/// `EraQuizAttemptService::buildResult()` (isi field persisnya BELUM
/// terlihat dari controller — nama field `correct`/`total`/`percentage`
/// di bawah masih ASUMSI berdasarkan istilah ERAQUIZ-03 di PRD.md
/// "skor agregat (benar/total, persentase)". Tolong verifikasi ke
/// `EraQuizAttemptService::buildResult()` untuk nama field final.
@freezed
abstract class EraQuizScore with _$EraQuizScore {
  const factory EraQuizScore({
    required int correct,
    required int total,
    required double percentage,
  }) = _EraQuizScore;

  factory EraQuizScore.fromJson(Map<String, dynamic> json) =>
      _$EraQuizScoreFromJson(json);
}