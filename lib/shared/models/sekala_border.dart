import 'package:freezed_annotation/freezed_annotation.dart';

part 'sekala_border.freezed.dart';
part 'sekala_border.g.dart';

/// Aset gambar Border SEKALA — mengacu endpoint publik
/// `GET /public/sekala-border` (`Api\SekalaBorder\SekalaBorderController::show()`).
///
/// BEDA dari `WabahIntro`: endpoint ini SELALU mengembalikan object (bukan
/// `data: null`) — gate publish ada DI DALAM object-nya sendiri lewat
/// `isPublished`, bukan lewat null envelope. Jadi model ini tidak pernah
/// null, tapi `imageUrl` bisa null walau `isPublished` true (link Drive
/// belum diisi/invalid) MAUPUN kalau `isPublished` false (memang sengaja
/// disembunyikan backend, lihat controller).
///
/// PENTING: response backend SAAT INI top-level langsung
/// (`{is_published, image_url}`), TIDAK dibungkus key `data` seperti
/// resource lain (WabahIntro, Vaccine, dst). Kalau nanti dipindah ke API
/// Resource dan ikut dibungkus `data`, sesuaikan `SekalaBorderApi` saja
/// (parsing satu baris), model & repository ini tidak perlu berubah.
@freezed
abstract class SekalaBorder with _$SekalaBorder {
  const factory SekalaBorder({
    @JsonKey(name: 'is_published') @Default(false) bool isPublished,
    @JsonKey(name: 'image_url') String? imageUrl,
  }) = _SekalaBorder;

  const SekalaBorder._();

  /// URL yang aman dipakai UI — null baik karena belum publish maupun
  /// karena link belum diisi/invalid. Pemanggil (ProfileAvatar) cukup
  /// pakai getter ini, tidak perlu cek `isPublished` sendiri-sendiri.
  String? get displayImageUrl => isPublished ? imageUrl : null;

  factory SekalaBorder.fromJson(Map<String, dynamic> json) =>
      _$SekalaBorderFromJson(json);
}