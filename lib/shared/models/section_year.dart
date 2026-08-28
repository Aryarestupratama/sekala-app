import 'package:freezed_annotation/freezed_annotation.dart';

part 'section_year.freezed.dart';
part 'section_year.g.dart';

/// Mengacu SectionDetailResource.php aktual (dicek 28 Agt 2026) — versi
/// nested era di dalam year, dipakai khusus di dalam response Section.
/// BEDA dari Year (shared/models/year.dart) yang dipakai untuk roadmap
/// list — shape-nya lebih ringkas & nggak ada relasi ke Section lain.
@freezed
abstract class SectionEra with _$SectionEra {
  const factory SectionEra({
    required int id,
    required String name,
    required String slug,
  }) = _SectionEra;

  factory SectionEra.fromJson(Map<String, dynamic> json) =>
      _$SectionEraFromJson(json);
}

@freezed
abstract class SectionYear with _$SectionYear {
  const factory SectionYear({
    required int id,
    required int year,
    required String title,
    required SectionEra era,
  }) = _SectionYear;

  factory SectionYear.fromJson(Map<String, dynamic> json) =>
      _$SectionYearFromJson(json);
}
