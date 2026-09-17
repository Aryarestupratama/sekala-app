import 'package:freezed_annotation/freezed_annotation.dart';

part 'year_summary_completion.freezed.dart';
part 'year_summary_completion.g.dart';

/// Status "sudah pernah diselesaikan" (SUM-05) — null di level
/// `YearSummaryAttempt.completion` berarti user BELUM PERNAH menyelesaikan
/// Rangkuman Interaktif ini sama sekali (bukan berarti pernah tapi gagal).
@freezed
abstract class YearSummaryCompletion with _$YearSummaryCompletion {
  const factory YearSummaryCompletion({
    @JsonKey(name: 'is_perfect') @Default(false) bool isPerfect,
    @JsonKey(name: 'completed_at') DateTime? completedAt,
  }) = _YearSummaryCompletion;

  factory YearSummaryCompletion.fromJson(Map<String, dynamic> json) =>
      _$YearSummaryCompletionFromJson(json);
}