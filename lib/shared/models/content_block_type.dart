import 'package:json_annotation/json_annotation.dart';

/// Mengacu Schema.md §2.5 `content_blocks.type` enum('text','image','video','pdf','summary').
///
/// R-CMS-03: blok bertipe `summary` selalu di urutan (`order`) paling akhir
/// dalam satu section — divalidasi di backend, tapi UI section detail
/// (nanti di features/history) bisa pakai enum ini untuk styling khusus
/// blok summary (mis. beda background) tanpa hardcode string 'summary'.
enum ContentBlockType {
  @JsonValue('text')
  text,
  @JsonValue('image')
  image,
  @JsonValue('video')
  video,
  @JsonValue('pdf')
  pdf,
  @JsonValue('summary')
  summary,
}
