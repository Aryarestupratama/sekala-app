import 'package:freezed_annotation/freezed_annotation.dart';
import 'content_block.dart';
import 'figure_card.dart';
import 'section_year.dart';

part 'section.freezed.dart';
part 'section.g.dart';

/// Mengacu SectionDetailResource.php aktual (dicek 28 Agt 2026).
///
/// PERUBAHAN dari versi sebelumnya (yang masih tebakan):
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
@freezed
abstract class Section with _$Section {
  const factory Section({
    required int id,
    required String title,
    required SectionYear year,

    // R-CMS-07: null/kosong berarti tombol "Mulai Kuis" gak ditampilkan.
    @JsonKey(name: 'quiz_link') String? quizLink,

    @JsonKey(name: 'content_blocks')
    @Default(<ContentBlock>[])
    List<ContentBlock> contentBlocks,

    // Cuma {id, name} per figure di context ini (SectionDetailResource) —
    // field lain di FigureCard (photoUrl, unlocked) otomatis null/false
    // lewat default masing-masing, aman dipakai ulang modelnya.
    @Default(<FigureCard>[]) List<FigureCard> figures,
  }) = _Section;

  factory Section.fromJson(Map<String, dynamic> json) =>
      _$SectionFromJson(json);
}
