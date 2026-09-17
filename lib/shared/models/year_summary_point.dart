import 'package:freezed_annotation/freezed_annotation.dart';
import 'year_summary_option.dart';

part 'year_summary_point.freezed.dart';
part 'year_summary_point.g.dart';

/// 1 poin (dari tepat 7) Rangkuman Interaktif — 3 opsi kalimat (1 benar +
/// 2 pengecoh), urutan opsi SUDAH diacak backend (R-SUM-05), tidak perlu
/// diacak ulang di client.
@freezed
abstract class YearSummaryPoint with _$YearSummaryPoint {
  const factory YearSummaryPoint({
    required int id,
    @Default(0) int order,
    @Default(<YearSummaryOption>[]) List<YearSummaryOption> options,
  }) = _YearSummaryPoint;

  factory YearSummaryPoint.fromJson(Map<String, dynamic> json) =>
      _$YearSummaryPointFromJson(json);
}