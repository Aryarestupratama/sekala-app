import 'package:freezed_annotation/freezed_annotation.dart';

part 'figure.freezed.dart';
part 'figure.g.dart';

/// Mengacu Schema.md §2.6 `figures` + status unlock dari §2.9 `user_card_unlocks`
/// (digabung jadi satu response oleh backend — lihat Schema.md §4 "Status
/// card terkunci/siluet ... logic di sisi Flutter/API response, bukan kolom DB").
@freezed
class Figure with _$Figure {
  const factory Figure({
    required int id,
    required String name,

    // Raw link Drive apa adanya (Schema.md §5). Null-safe karena kolom
    // `photo` nullable (data historis kadang belum ada foto).
    String? photo,

    // ASUMSI: sama seperti ContentBlock.resolvedUrl — versi direct-view
    // yang sudah dikonversi backend. Kalau figure belum unlock (siluet),
    // R-CARD-04 nyaranin nama boleh disamarkan/foto disembunyikan — itu
    // keputusan UI di layer widget nanti (pakai `isUnlocked`), BUKAN
    // backend nyembunyiin data (karena field ini tetap dikirim apa adanya).
    @JsonKey(name: 'photo_url') String? photoUrl,

    @JsonKey(name: 'birth_date') String? birthDate,
    @JsonKey(name: 'death_date') String? deathDate,
    String? family,
    @JsonKey(name: 'role_description') required String roleDescription,

    // Turunan dari ada/tidaknya row di user_card_unlocks untuk user ini.
    // Guest tidak pernah dapat true (R-GUEST-02) — tapi guest juga
    // seharusnya nggak pernah nyampe render screen ini (guard router
    // udah nendang ke /auth, lihat core/router/app_router.dart).
    @JsonKey(name: 'is_unlocked', defaultValue: false) required bool isUnlocked,
    @JsonKey(name: 'unlocked_at') String? unlockedAt,
  }) = _Figure;

  factory Figure.fromJson(Map<String, dynamic> json) => _$FigureFromJson(json);
}
