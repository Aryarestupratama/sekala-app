import 'package:freezed_annotation/freezed_annotation.dart';

part 'wabah_intro.freezed.dart';
part 'wabah_intro.g.dart';

/// Konten singleton "Apa itu Wabah" — mengacu WabahIntroResource.php.
/// Nullable-friendly: endpoint publik mengembalikan `data: null` kalau
/// admin belum pernah mengisi konten ini / masih draft (belum publish),
/// jadi pemanggil (provider) yang menentukan apakah field ini ada isinya
/// sama sekali, bukan model ini.
@freezed
abstract class WabahIntro with _$WabahIntro {
  const factory WabahIntro({
    @JsonKey(name: 'image_url') String? imageUrl,
  }) = _WabahIntro;

  factory WabahIntro.fromJson(Map<String, dynamic> json) =>
      _$WabahIntroFromJson(json);
}