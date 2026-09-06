import 'package:freezed_annotation/freezed_annotation.dart';
import 'content_block_type.dart';

part 'content_block.freezed.dart';
part 'content_block.g.dart';

/// Mengacu ContentBlockResource.php aktual (dicek 28 Agt 2026) — dikonfirmasi
/// match sama tebakan sebelumnya untuk id/type/content/resolved_url/order.
/// Field `section_id` yang sebelumnya ada di sini DIHAPUS karena nggak
/// pernah dikirim (block ini selalu muncul nested di dalam
/// SectionDetailResource.content_blocks, jadi section-nya udah jelas dari
/// konteks — field itu emang redundan).
///
/// PERUBAHAN (revisi Caption Media, baru):
/// - `caption` (BARU) — OPSIONAL, relevan untuk type `image`/`video` saja
///   (sumber/keterangan media, mis. "Foto: Arsip Nasional RI, 1920"). Null
///   kalau belum diisi admin, atau memang tidak relevan untuk type
///   `text`/`pdf` — cukup jangan dirender kalau null, tidak perlu placeholder.
@freezed
abstract class ContentBlock with _$ContentBlock {
  const factory ContentBlock({
    required int id,
    required ContentBlockType type,

    // Raw value apa adanya dari DB: teks/HTML untuk text,
    // link Drive mentah untuk image|pdf, link/ID YouTube mentah untuk video
    // (Schema.md §5 — konversi TIDAK disimpan di DB, cuma di layer API
    // response). Dipakai sebagai fallback kalau resolved_url null.
    required String content,

    // Accessor backend: direct-view/embed URL untuk image/video/pdf.
    // Null untuk type text (dikonfirmasi lewat komentar di
    // ContentBlockResource.php aslinya).
    @JsonKey(name: 'resolved_url') String? resolvedUrl,

    // (Baru) Caption — opsional, cuma relevan utk type image/video.
    String? caption,

    required int order,
  }) = _ContentBlock;

  factory ContentBlock.fromJson(Map<String, dynamic> json) =>
      _$ContentBlockFromJson(json);
}