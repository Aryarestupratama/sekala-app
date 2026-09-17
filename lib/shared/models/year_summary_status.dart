import 'package:freezed_annotation/freezed_annotation.dart';

part 'year_summary_status.freezed.dart';
part 'year_summary_status.g.dart';

/// Objek ringkas `year_summary` di dalam response Year (YearResource.php)
/// — CUMA nunjukin status tersedia/publish, BUKAN isi 7 poinnya. Isi
/// poinnya diambil terpisah lewat `GET /years/{year}/summary`
/// (year_summary_providers.dart) karena opsinya perlu diacak ulang tiap
/// kali attempt dimulai, jadi tidak cocok di-embed statis di sini.
@freezed
abstract class YearSummaryStatus with _$YearSummaryStatus {
  const factory YearSummaryStatus({
    required int id,
    @JsonKey(name: 'is_published') @Default(false) bool isPublished,
  }) = _YearSummaryStatus;

  factory YearSummaryStatus.fromJson(Map<String, dynamic> json) =>
      _$YearSummaryStatusFromJson(json);
}