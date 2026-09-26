import 'package:freezed_annotation/freezed_annotation.dart';

part 'wabah_intro.freezed.dart';
part 'wabah_intro.g.dart';

/// Konten singleton "Apa itu Wabah" — mengacu WabahIntroResource.php.
/// Kontennya teks biasa (`content`), bukan lagi infografis/link gambar.
/// Nullable-friendly: endpoint publik mengembalikan `data: null` kalau
/// admin belum pernah mengisi konten ini / masih draft (belum publish),
/// jadi pemanggil (provider) yang menentukan apakah field ini ada isinya
/// sama sekali, bukan model ini.
@freezed
abstract class WabahIntro with _$WabahIntro {
  const factory WabahIntro({
    String? content,
  }) = _WabahIntro;

  factory WabahIntro.fromJson(Map<String, dynamic> json) =>
      _$WabahIntroFromJson(json);
}