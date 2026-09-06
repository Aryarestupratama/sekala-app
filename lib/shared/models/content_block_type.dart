import 'package:json_annotation/json_annotation.dart';

/// Mengacu Schema.md §2.5 `content_blocks.type` enum('text','image','video','pdf').
///
/// FIX (bug lama, ditemukan & dibenarkan saat revisi Header/Rangkuman/Quote/
/// Referensi/Caption): value `summary` DIHAPUS dari enum ini. Tipe blok
/// `summary` sudah tidak ada di backend jauh sebelum revisi ini (lihat
/// Rules.md: "R-CMS-03 & R-CMS-04 dihapus karena rangkuman sudah naik level
/// ke `year`" — Architecture.md §4.2 juga menegaskan hal yang sama). Kalau
/// ada kode lain (widget render content block) yang masih punya branch
/// `case ContentBlockType.summary`, branch itu sekarang jadi dead code dan
/// perlu dihapus juga.
enum ContentBlockType {
  @JsonValue('text')
  text,
  @JsonValue('image')
  image,
  @JsonValue('video')
  video,
  @JsonValue('pdf')
  pdf,
}