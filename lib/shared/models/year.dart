import 'package:freezed_annotation/freezed_annotation.dart';
import 'section_summary.dart';
import 'vaccine_card.dart';
import 'year_summary_status.dart';

part 'year.freezed.dart';
part 'year.g.dart';

/// Mengacu Schema.md §2.3 + YearResource.php terbaru — sudah termasuk
/// status lock & completed di level TAHUN itu sendiri sejak Sequential
/// Year Unlock (Rules.md §4.2, R-YEAR-02–05), bukan cuma lock per section
/// seperti versi sebelumnya.
///
/// PERUBAHAN (revisi Rangkuman Interaktif, terbaru — menggantikan revisi
/// "Rangkuman jadi Infografis" sebelumnya):
/// - `summaryImageUrl` (String?, infografis statis) DIHAPUS TOTAL —
///   Rangkuman wabah sekarang widget interaktif 7 poin correct-statement
///   (PRD.md §4.3bis SUM-01–06), bukan lagi 1 gambar.
/// - `yearSummary` (BARU) — objek RINGKAS `{id, isPublished}`, cuma
///   nunjukin status tersedia/publish (catatan: model `Year` ini TIDAK
///   punya field `quiz` — status publish kuis diambil terpisah lewat
///   `quizProvider`, bukan dari sini). Isi 7 poinnya diambil terpisah
///   lewat `year_summary_providers.dart` (`GET /years/{year}/summary`) —
///   opsinya perlu diacak ulang tiap attempt dimulai, tidak cocok
///   di-embed statis di sini.
/// - `yearSummaryCompleted` (BARU) — status rangkuman SUDAH diselesaikan
///   user yang sedang login (SUM-05/06), dipakai buat: (1) tentukan
///   tombol "Kerjakan Kuis" boleh aktif atau belum, (2) tentukan
///   YearSummaryScreen langsung mulai widget 7 poin kosong atau
///   tampilkan pilihan "Lihat Rangkuman"/"Kerjakan Ulang" duluan. Selalu
///   false untuk guest.
/// - `quoteText` & `references` TIDAK berubah dari revisi sebelumnya.
/// - Urutan tampil di halaman Rangkuman Wabah (Design.md §3.3.4 revisi):
///   widget 7 poin (atau "Rangkuman Lengkap" kalau `yearSummaryCompleted`
///   true) -> `quoteText` -> `references` -> tombol "Kerjakan Kuis".
@freezed
abstract class Year with _$Year {
  const factory Year({
    required int id,
    required int year,
    required String title,

    @JsonKey(name: 'quote_text') String? quoteText,
    @JsonKey(name: 'references', defaultValue: <String>[])
    @Default(<String>[])
    List<String> references,

    @JsonKey(name: 'year_summary') YearSummaryStatus? yearSummary,
    @JsonKey(name: 'year_summary_completed') @Default(false) bool yearSummaryCompleted,

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