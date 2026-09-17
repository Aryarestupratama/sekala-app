import 'package:freezed_annotation/freezed_annotation.dart';

part 'year_summary_submit_result.freezed.dart';
part 'year_summary_submit_result.g.dart';

/// Response `POST /years/{year}/summary/complete` (dipanggil setelah poin
/// ke-7 dijawab, baik pengerjaan pertama maupun "Kerjakan Ulang" — SUM-05/
/// R-SUM-11). `quizUnlocked` dikirim eksplisit oleh backend
/// (YearCompletionService::isQuizUnlocked()) supaya client tidak perlu
/// menebak sendiri kapan tombol "Kerjakan Kuis" boleh aktif.
@freezed
abstract class YearSummarySubmitResult with _$YearSummarySubmitResult {
  const factory YearSummarySubmitResult({
    @JsonKey(name: 'is_perfect') @Default(false) bool isPerfect,
    @JsonKey(name: 'completed_at') DateTime? completedAt,
    @JsonKey(name: 'full_summary', defaultValue: <String>[])
    @Default(<String>[])
    List<String> fullSummary,
    @JsonKey(name: 'quiz_unlocked') @Default(false) bool quizUnlocked,
  }) = _YearSummarySubmitResult;

  factory YearSummarySubmitResult.fromJson(Map<String, dynamic> json) =>
      _$YearSummarySubmitResultFromJson(json);
}