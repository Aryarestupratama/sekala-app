import 'package:freezed_annotation/freezed_annotation.dart';
import 'year_summary_completion.dart';
import 'year_summary_point.dart';

part 'year_summary_attempt.freezed.dart';
part 'year_summary_attempt.g.dart';

/// Response `GET /years/{year}/summary` — dipakai untuk 2 kasus sekaligus
/// (UserYearSummaryController::show()):
/// - `completion == null` -> user belum pernah selesai, langsung mulai
///   mengerjakan `points` (widget 7 poin, SUM-01).
/// - `completion != null` -> user SUDAH pernah selesai. `fullSummary`
///   (SUM-03) siap ditampilkan langsung tanpa perlu mengerjakan ulang,
///   TAPI `points` tetap dikirim (opsi teracak ulang) untuk kasus user
///   memilih "Kerjakan Ulang" (SUM-05) — jadi tidak perlu request kedua.
@freezed
abstract class YearSummaryAttempt with _$YearSummaryAttempt {
  const factory YearSummaryAttempt({
    YearSummaryCompletion? completion,
    @JsonKey(name: 'full_summary') List<String>? fullSummary,
    @JsonKey(name: 'points', defaultValue: <YearSummaryPoint>[])
    @Default(<YearSummaryPoint>[])
    List<YearSummaryPoint> points,
  }) = _YearSummaryAttempt;

  factory YearSummaryAttempt.fromJson(Map<String, dynamic> json) =>
      _$YearSummaryAttemptFromJson(json);
}