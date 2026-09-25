import 'package:freezed_annotation/freezed_annotation.dart';

part 'section_summary.freezed.dart';
part 'section_summary.g.dart';

/// Versi ringkas Section — dipakai di dalam response Year (roadmap) buat
/// nentuin section mana yang dibuka saat tahun di-tap, dan sekarang juga
/// buat status lock/completed per section (Architecture.md §4.7,
/// R-SECT-01–04, R-YEAR-04). Section.dart (versi lengkap) dipakai di
/// halaman detail section sendiri.
///
/// PERUBAHAN (Studi Kasus, R-CASE-01): ditambah `type` — backend sudah
/// mengirimnya lewat `YearResource`/`YearController` (`sections.type`).
/// Section `case_study` selalu di `order = 8`.
@freezed
abstract class SectionSummary with _$SectionSummary {
  const SectionSummary._();

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

    // BARU (R-CASE-01): 'reading' | 'case_study'. Default 'reading'
    // (fail-safe kalau field tidak ada di response lama).
    @Default(kSectionTypeReading) String type,
  }) = _SectionSummary;

  factory SectionSummary.fromJson(Map<String, dynamic> json) =>
      _$SectionSummaryFromJson(json);

  bool get isCaseStudy => type == kSectionTypeCaseStudy;
}

/// Nilai `sections.type` dari backend (enum `reading`/`case_study`).
const String kSectionTypeReading = 'reading';
const String kSectionTypeCaseStudy = 'case_study';