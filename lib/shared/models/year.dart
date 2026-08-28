import 'package:freezed_annotation/freezed_annotation.dart';
import 'section_summary.dart';

part 'year.freezed.dart';
part 'year.g.dart';

/// Mengacu Schema.md §2.3 + YearResource.php aktual (dicek 28 Agt 2026,
/// sudah di-patch buat include `sections`). Field `is_completed` MASIH
/// belum ada di backend — checkmark roadmap (Design.md §3.3 poin 1) masih
/// belum bisa jalan sampai itu ditambahin juga.
@freezed
abstract class Year with _$Year {
  const factory Year({
    required int id,
    required int year,
    required String title,
    @JsonKey(name: 'published_sections_count') int? publishedSectionsCount,

    // Dari YearResource yang sudah di-patch — dipakai untuk navigasi
    // roadmap -> detail section.
    @JsonKey(name: 'sections', defaultValue: <SectionSummary>[])
    required List<SectionSummary> sections,
  }) = _Year;

  factory Year.fromJson(Map<String, dynamic> json) => _$YearFromJson(json);
}
