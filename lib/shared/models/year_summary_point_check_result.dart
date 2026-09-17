import 'package:freezed_annotation/freezed_annotation.dart';
import 'year_summary_option.dart';

part 'year_summary_point_check_result.freezed.dart';
part 'year_summary_point_check_result.g.dart';

/// Response `POST /years/{year}/summary/points/{point}/answer` (SUM-02) —
/// feedback instan 1 poin, TIDAK pernah disimpan ke backend
/// (YearSummaryService::checkAnswer()), murni buat ditampilkan langsung.
@freezed
abstract class YearSummaryPointCheckResult with _$YearSummaryPointCheckResult {
  const factory YearSummaryPointCheckResult({
    @JsonKey(name: 'point_id') required int pointId,
    @JsonKey(name: 'is_correct') required bool isCorrect,
    @JsonKey(name: 'correct_option') required YearSummaryOption correctOption,
  }) = _YearSummaryPointCheckResult;

  factory YearSummaryPointCheckResult.fromJson(Map<String, dynamic> json) =>
      _$YearSummaryPointCheckResultFromJson(json);
}