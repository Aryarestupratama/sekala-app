import 'package:freezed_annotation/freezed_annotation.dart';

part 'section_summary.freezed.dart';
part 'section_summary.g.dart';

/// Versi ringkas Section — cuma id + title, dipakai di dalam response
/// Year (roadmap) buat nentuin section mana yang dibuka saat tahun di-tap.
/// Section.dart (versi lengkap) dipakai di halaman detail section sendiri.
@freezed
abstract class SectionSummary with _$SectionSummary {
  const factory SectionSummary({
    required int id,
    required String title,
  }) = _SectionSummary;

  factory SectionSummary.fromJson(Map<String, dynamic> json) =>
      _$SectionSummaryFromJson(json);
}
