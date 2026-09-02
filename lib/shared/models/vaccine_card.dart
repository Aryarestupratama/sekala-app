import 'package:freezed_annotation/freezed_annotation.dart';

part 'vaccine_card.freezed.dart';
part 'vaccine_card.g.dart';

/// Mengacu VaccineCardResource.php (Schema.md §2.6 `vaccines` + status unlock
/// dari §2.13 `user_vaccine_unlocks`, digabung jadi satu response oleh
/// backend — Schema.md §4 "Status card vaksin terkunci/siluet ... logic di
/// sisi Flutter/API response, bukan kolom database", R-VAC-04).
///
/// PENTING (beda dari Figure lama): `name` TIDAK pernah disamarkan jadi
/// "???" walau `unlocked == false` — R-VAC-04 cuma menyembunyikan FOTO asli
/// (via `photoUrl null` + `photoLockedUrl` siluet), bukan nama vaksin.
/// Vaksin yang belum unlock tetap muncul dalam list, tidak disembunyikan
/// total (R-VAC-04).
@freezed
abstract class VaccineCard with _$VaccineCard {
  const factory VaccineCard({
    required int id,
    required String name,

    // Foto asli. Sengaja NULL dari backend kalau belum unlock — kalau foto
    // asli ikut terkirim padahal masih terkunci, itu jadi celah spoiler
    // (user bisa buka URL-nya langsung sebelum earn unlock). Lihat
    // progress.md sesi "Vaksin Dual-Photo".
    @JsonKey(name: 'photo_url') String? photoUrl,

    // Foto siluet/placeholder (link Drive terpisah, bukan auto-generate).
    // Dikirim di KEDUA mode (locked & unlocked) supaya Flutter bisa
    // crossfade dari siluet -> asli tanpa perlu cache manual dari state
    // locked sebelumnya (lihat catatan VaccineCardResource di progress.md).
    @JsonKey(name: 'photo_locked_url') String? photoLockedUrl,

    // Turunan dari ada/tidaknya row di user_vaccine_unlocks untuk user ini
    // (R-VAC-01/02). Guest tidak pernah dapat true (R-GUEST-02) — tapi
    // guest juga seharusnya tidak pernah sampai render screen ini (guard
    // router menendang ke /auth, R-VAC-05/R-GUEST-03).
    @JsonKey(name: 'unlocked', defaultValue: false) required bool unlocked,
  }) = _VaccineCard;

  factory VaccineCard.fromJson(Map<String, dynamic> json) =>
      _$VaccineCardFromJson(json);
}