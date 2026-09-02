import 'package:freezed_annotation/freezed_annotation.dart';
import 'section_summary.dart';

part 'year.freezed.dart';
part 'year.g.dart';

/// Mengacu Schema.md §2.3 + YearResource.php terbaru — sudah termasuk
/// status lock & completed di level TAHUN itu sendiri sejak Sequential
/// Year Unlock (Rules.md §4.2, R-YEAR-02–05), bukan cuma lock per section
/// seperti versi sebelumnya.
@freezed
abstract class Year with _$Year {
  const factory Year({
    required int id,
    required int year,
    required String title,
    String? summary,
    @JsonKey(name: 'published_sections_count') int? publishedSectionsCount,

    // R-YEAR-02/03 (baru): status lock DI LEVEL TAHUN itu sendiri —
    // mendahului lock per section di dalam `sections` (R-YEAR-04). Default
    // true (locked) kalau field ini nggak ada di response backend lama.
    @Default(true) bool locked,

    // R-PROG-07: apakah tahun ini sudah "completed" (semua section +
    // kuis selesai) oleh user yang sedang login. Selalu false untuk guest.
    @JsonKey(name: 'is_completed') @Default(false) bool isCompleted,

    // Dari YearResource — dipakai untuk navigasi roadmap -> detail
    // section, dan sekarang juga buat nentuin section target mana yang
    // dibuka duluan (section pertama yang belum locked & belum completed).
    @JsonKey(name: 'sections', defaultValue: <SectionSummary>[])
    required List<SectionSummary> sections,
  }) = _Year;

  factory Year.fromJson(Map<String, dynamic> json) => _$YearFromJson(json);
}