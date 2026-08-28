import 'package:freezed_annotation/freezed_annotation.dart';

part 'figure_card.freezed.dart';
part 'figure_card.g.dart';

/// Mengacu FigureCardResource.php aktual (dicek 28 Agt 2026) — dipakai
/// untuk GET /api/cards (grid semua card) DAN untuk `figures` di dalam
/// Section (tokoh terkait satu section). R-CARD-04: figure yang belum
/// unlock tetap dikirim (bukan disembunyikan), cuma `name` disamarkan
/// jadi "???" dan `photoUrl` null oleh backend sendiri.
@freezed
abstract class FigureCard with _$FigureCard {
  const factory FigureCard({
    required int id,
    required String name, // "???" kalau belum unlock — apa adanya dari backend
    @JsonKey(name: 'photo_url') String? photoUrl,

    // defaultValue: false untuk jaga-jaga dipakai di konteks lain (mis.
    // nested di dalam Section) yang mungkin nggak selalu ngirim field ini.
    @JsonKey(name: 'unlocked', defaultValue: false) required bool unlocked,
  }) = _FigureCard;

  factory FigureCard.fromJson(Map<String, dynamic> json) =>
      _$FigureCardFromJson(json);
}
