import 'package:freezed_annotation/freezed_annotation.dart';
import 'content_block.dart';
import 'section_year.dart';

part 'section.freezed.dart';
part 'section.g.dart';

/// Mengacu SectionDetailResource.php aktual.
///
/// PERUBAHAN (revisi Sequential Year Unlock + Kuis/Vaksin naik level ke
/// year):
/// - `quizLink` DIHAPUS TOTAL — `sections.quiz_link` sudah dihapus dari
///   Schema.md (kuis kini custom internal, melekat ke `year`, bukan lagi
///   embed Upresenter per section — R-QUIZ-01, Architecture.md §4.2).
///   Tombol "Mulai Kuis" sekarang ditentukan dari status year (semua
///   section completed + ada quiz published), bukan dari field di sini.
/// - `figures` DIHAPUS TOTAL, bukan cuma diganti tipe ke `VaccineCard` —
///   relasi vaksin sudah naik level dari section ke year (CMS-05:
///   "relasi many-to-many year <-> vaccine, naik level dari section <->
///   figure"). Lihat `Year.vaccines` untuk penggantinya.
/// - `year_id` (flat int) -> `year` (nested SectionYear, termasuk era di
///   dalamnya) — dipakai buat invalidate roadmap era yang tepat setelah
///   completion (lihat SectionCompletionController).
/// - `is_published` DIHAPUS — nggak pernah dikirim endpoint publik (masuk
///   akal, sesuai R-CMS-01, cuma section published yang bisa nyampe di
///   sini sama sekali).
/// - `is_completed` DIHAPUS — backend nggak expose status ini ke client.
///   Status "selesai baca" buat keperluan UI (nampilin tombol kuis)
///   sekarang dilacak lokal per sesi lewat sectionJustCompletedProvider,
///   BUKAN dari field API ini lagi.
///
/// PERUBAHAN (revisi Header Gambar Section, baru):
/// - `title` DIPERTAHANKAN di response (backend tetap kirim), TAPI
///   **tidak lagi dirender sebagai judul** di layar Detail Section — posisi
///   paling atas digantikan `headerImageUrl` (lihat di bawah). Field ini
///   cuma dipakai kalau ada kebutuhan internal/debug, bukan untuk UI utama.
/// - `headerImageUrl` (BARU) — OPSIONAL murni per section (bisa null kalau
///   section ini tidak diisi header gambar oleh admin, BUKAN wajib per
///   section maupun 1x per year). Sudah di-resolve backend ke direct-view
///   URL (accessor `Section::getResolvedHeaderImageUrlAttribute()`), siap
///   dipakai langsung sebagai `src` <Image.network>.
@freezed
abstract class Section with _$Section {
  const factory Section({
    required int id,
    required String title,
    required SectionYear year,

    // (Baru) Header gambar — opsional, null kalau belum/tidak diisi admin.
    // Tampil di posisi paling atas layar Detail Section, menggantikan judul
    // teks (judul teks di atas TIDAK lagi dirender ke user).
    @JsonKey(name: 'header_image_url') String? headerImageUrl,

    @JsonKey(name: 'content_blocks')
    @Default(<ContentBlock>[])
    List<ContentBlock> contentBlocks,
  }) = _Section;

  factory Section.fromJson(Map<String, dynamic> json) =>
      _$SectionFromJson(json);
}