import 'package:freezed_annotation/freezed_annotation.dart';
import 'section_summary.dart';
import 'vaccine_card.dart';

part 'year.freezed.dart';
part 'year.g.dart';

/// Mengacu Schema.md §2.3 + YearResource.php terbaru — sudah termasuk
/// status lock & completed di level TAHUN itu sendiri sejak Sequential
/// Year Unlock (Rules.md §4.2, R-YEAR-02–05), bukan cuma lock per section
/// seperti versi sebelumnya.
///
/// PERUBAHAN (revisi Rangkuman Wabah jadi Infografis + Quote + Referensi,
/// baru):
/// - `summary` (String? teks) DIHAPUS TOTAL — rangkuman wabah sekarang
///   berupa infografis (gambar), bukan teks. Diganti `summaryImageUrl`.
/// - `summaryImageUrl` (BARU) — sudah di-resolve backend ke direct-view
///   URL (`years.summary_image`, accessor
///   `Year::getResolvedSummaryImageUrlAttribute()`), null kalau admin
///   belum mengisi. Wajib terisi sebelum quiz year ini bisa di-publish
///   (R-QUIZ-05), tapi TIDAK wajib sebelum section-section-nya publish.
/// - `quoteText` (BARU) — 1 teks kutipan per wabah, null kalau belum
///   diisi admin. Tampil di halaman yang sama dengan rangkuman.
/// - `references` (BARU) — list teks referensi (mis. daftar pustaka),
///   selalu berupa List (default `[]`, BUKAN null) supaya UI aman iterasi
///   tanpa null-check.
/// - Urutan tampil di halaman Rangkuman Wabah (Design.md §3.3.4):
///   `summaryImageUrl` -> `quoteText` -> `references` -> tombol "Kerjakan
///   Kuis".
@freezed
abstract class Year with _$Year {
  const factory Year({
    required int id,
    required int year,
    required String title,

    @JsonKey(name: 'summary_image_url') String? summaryImageUrl,
    @JsonKey(name: 'quote_text') String? quoteText,
    @JsonKey(name: 'references', defaultValue: <String>[])
    @Default(<String>[])
    List<String> references,

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

    // BARU (naik level dari Section.figures lama, CMS-05/Architecture.md
    // §4.8): vaksin terkait wabah/tahun ini via pivot `year_vaccine`.
    // Dipakai VAC-03 (1 year bisa punya banyak vaksin) & trigger animasi
    // "Vaksin baru terbuka!" (INFO-06) begitu status year "completed"
    // tercapai — bukan lagi diambil dari dalam section.
    //
    // ASUMSI (belum dicek langsung ke YearResource.php terbaru): nama key
    // JSON `vaccines`, dan tiap entry berbentuk sama seperti response
    // GET /api/cards (VaccineCard: id, name, photo_url, photo_locked_url,
    // unlocked) — tolong verifikasi ke source backend sebelum dipakai.
    @JsonKey(name: 'vaccines')
    @Default(<VaccineCard>[])
    List<VaccineCard> vaccines,
  }) = _Year;

  factory Year.fromJson(Map<String, dynamic> json) => _$YearFromJson(json);
}