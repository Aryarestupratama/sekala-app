import 'package:freezed_annotation/freezed_annotation.dart';
import 'vaccine_card.dart' show VaccineEra;

part 'vaccine_detail.freezed.dart';
part 'vaccine_detail.g.dart';

/// Mengacu VaccineDetailResource.php — cuma bisa didapat kalau vaksin sudah
/// unlock (backend 404 kalau belum, R-VAC-01 turunan dari R-CARD-02 lama).
/// Tidak ada field `unlocked` di sini karena sampai bisa fetch endpoint ini
/// berarti pasti sudah unlock.
///
/// Field detail sesuai Rules.md VAC-02 / Schema.md §2.6 `vaccines`:
/// nama, foto, produsen, penyakit target, tahun diperkenalkan, deskripsi
/// peran dalam sejarah kesehatan — MENGGANTIKAN field tokoh lama
/// (birthDate/deathDate/family/roleDescription).
@freezed
abstract class VaccineDetail with _$VaccineDetail {
  const factory VaccineDetail({
    required int id,
    required String name,
    @JsonKey(name: 'photo_url') String? photoUrl,

    // Tetap disertakan untuk konsistensi field antar resource (progress.md:
    // "tambah photo_locked_url untuk konsistensi field antar resource" —
    // endpoint ini sendiri cuma diakses saat sudah unlock, jadi field ini
    // umumnya tidak dipakai di layar detail, tapi tersedia kalau nanti
    // dibutuhkan mis. transisi/animasi ulang).
    @JsonKey(name: 'photo_locked_url') String? photoLockedUrl,

    String? manufacturer,
    @JsonKey(name: 'disease_target') required String diseaseTarget,
    @JsonKey(name: 'year_introduced') int? yearIntroduced,
    required String description,

    // Konsisten dengan VaccineCard.eras — dikirim VaccineDetailResource
    // baru, belum dipakai di UI VaccineDetailScreen saat ini tapi tersedia
    // kalau nanti mau ditampilkan (mis. chip era di header detail).
    @Default(<VaccineEra>[]) List<VaccineEra> eras,
  }) = _VaccineDetail;

  factory VaccineDetail.fromJson(Map<String, dynamic> json) =>
      _$VaccineDetailFromJson(json);
}