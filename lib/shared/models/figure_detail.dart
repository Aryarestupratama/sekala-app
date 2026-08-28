import 'package:freezed_annotation/freezed_annotation.dart';

part 'figure_detail.freezed.dart';
part 'figure_detail.g.dart';

/// Mengacu FigureDetailResource.php aktual — cuma bisa didapat kalau
/// figure sudah unlock (backend 404 kalau belum, R-CARD-02). Nggak ada
/// field `unlocked` di sini karena sampai bisa fetch ini berarti pasti
/// sudah unlock.
@freezed
abstract class FigureDetail with _$FigureDetail {
  const factory FigureDetail({
    required int id,
    required String name,
    @JsonKey(name: 'photo_url') String? photoUrl,
    @JsonKey(name: 'birth_date') String? birthDate,
    @JsonKey(name: 'death_date') String? deathDate,
    String? family,
    @JsonKey(name: 'role_description') required String roleDescription,
  }) = _FigureDetail;

  factory FigureDetail.fromJson(Map<String, dynamic> json) =>
      _$FigureDetailFromJson(json);
}
