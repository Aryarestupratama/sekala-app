import 'package:freezed_annotation/freezed_annotation.dart';

part 'section_summary.freezed.dart';
part 'section_summary.g.dart';

/// Versi ringkas Section — dipakai di dalam response Year (roadmap) buat
/// nentuin section mana yang dibuka saat tahun di-tap, dan sekarang juga
/// buat status lock/completed per section (Architecture.md §4.7,
/// R-SECT-01–04, R-YEAR-04). Section.dart (versi lengkap) dipakai di
/// halaman detail section sendiri.
@freezed
abstract class SectionSummary with _$SectionSummary {
  const factory SectionSummary({
    required int id,
    required String title,
    @Default(0) int order,

    // R-SECT-01-04/R-YEAR-04: locked=true kalau section belum bisa diakses
    // (baik karena tahunnya sendiri masih locked, atau karena sequential
    // lock section di dalam tahun tsb). Default true (locked) kalau field
    // ini nggak ada di response (fail-safe, bukan fail-open).
    @Default(true) bool locked,

    // R-PROG-03: sudah "selesai dibaca" oleh user yang sedang login.
    // Selalu false untuk guest.
    @Default(false) bool completed,
  }) = _SectionSummary;

  factory SectionSummary.fromJson(Map<String, dynamic> json) =>
      _$SectionSummaryFromJson(json);
}