import 'package:freezed_annotation/freezed_annotation.dart';
import 'era_ref.dart';

part 'home_progress.freezed.dart';
part 'home_progress.g.dart';

/// Mengacu HomeController::index() aktual (dicek 28 Agt 2026). Progress
/// per era untuk Home (HOME-01), mis. "Kolonial: 5/12 tahun dibaca".
@freezed
abstract class EraProgress with _$EraProgress {
  const factory EraProgress({
    required EraRef era,
    required int completed,
    required int total,
  }) = _EraProgress;

  const EraProgress._();

  /// 0.0–1.0, dihitung client-side. Guard div-by-zero kalau era belum
  /// punya section published sama sekali.
  double get progressRatio => total == 0 ? 0 : completed / total;

  factory EraProgress.fromJson(Map<String, dynamic> json) =>
      _$EraProgressFromJson(json);
}

/// Rekomendasi bacaan (HOME-02) — POLIMORFIK, 2 tipe dari
/// ProgressService::recommendation():
/// - `next_year` (R-PROG-04): lanjut tahun berikutnya kronologis di era
///   yang sama. Include `year`.
/// - `switch_era` (R-PROG-05, fallback): semua tahun di era ini sudah
///   completed, sarankan pindah ke era lain yang progress-nya paling
///   rendah. `year` null — CUMA kasih era, nggak ada tahun spesifik.
///
/// PENTING: dua-duanya TIDAK ngasih sectionId — paling jauh cuma bisa
/// arahin ke roadmap era terkait (bukan deep-link langsung ke section),
/// karena data itu memang nggak ada di endpoint ini (mirip gap Year->Section
/// yang sudah dibahas sebelumnya, cuma di sini nggak ada perbaikan
/// backend yang diperlukan — arahin ke roadmap emang cara yang wajar).
@freezed
abstract class HomeRecommendation with _$HomeRecommendation {
  const factory HomeRecommendation({
    required String type, // 'next_year' | 'switch_era'
    required EraRef era,
    RecommendationYear? year, // null kalau type == 'switch_era'
  }) = _HomeRecommendation;

  const HomeRecommendation._();

  bool get isNextYear => type == 'next_year';

  factory HomeRecommendation.fromJson(Map<String, dynamic> json) =>
      _$HomeRecommendationFromJson(json);
}

@freezed
abstract class RecommendationYear with _$RecommendationYear {
  const factory RecommendationYear({
    required int id,
    required int year,
    required String title,
  }) = _RecommendationYear;

  factory RecommendationYear.fromJson(Map<String, dynamic> json) =>
      _$RecommendationYearFromJson(json);
}

/// Bungkus response GET /api/home jadi satu objek.
@freezed
abstract class HomeSummary with _$HomeSummary {
  const factory HomeSummary({
    @JsonKey(name: 'progress_by_era')
    @Default(<EraProgress>[])
    List<EraProgress> progressByEra,
    HomeRecommendation? recommendation,
  }) = _HomeSummary;

  factory HomeSummary.fromJson(Map<String, dynamic> json) =>
      _$HomeSummaryFromJson(json);
}
