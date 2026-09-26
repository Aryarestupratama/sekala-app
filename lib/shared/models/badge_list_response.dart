import 'package:freezed_annotation/freezed_annotation.dart';
import 'badge_card.dart';

part 'badge_list_response.freezed.dart';
part 'badge_list_response.g.dart';

/// Mengacu `meta` di BadgeController::index() — `total`/`unlocked`/`unseen`.
/// `unseen` ditambahkan mirror CardListMeta milik Vaksin, dipakai buat dot
/// merah bottom nav "Profil" (main_shell.dart) & menu "Koleksi Badge"
/// (profile_screen.dart). Beda dari CardListMeta: Koleksi Badge TETAP tidak
/// punya ringkasan `eras` per-era ataupun antrean reveal — cuma angka
/// `unseen` yang ditiru, bukan seluruh field vaksin (lihat keputusan produk
/// "locked cukup diredupkan, tanpa reveal/confetti" di progress.md).
@freezed
abstract class BadgeListMeta with _$BadgeListMeta {
  const factory BadgeListMeta({
    @Default(0) int total,
    @Default(0) int unlocked,
    @Default(0) int unseen,
  }) = _BadgeListMeta;

  factory BadgeListMeta.fromJson(Map<String, dynamic> json) =>
      _$BadgeListMetaFromJson(json);
}

/// Mengacu response GET /api/badges — { data: BadgeCard[], meta: {...} }.
@freezed
abstract class BadgeListResponse with _$BadgeListResponse {
  const factory BadgeListResponse({
    @Default(<BadgeCard>[]) List<BadgeCard> data,
    required BadgeListMeta meta,
  }) = _BadgeListResponse;

  factory BadgeListResponse.fromJson(Map<String, dynamic> json) =>
      _$BadgeListResponseFromJson(json);
}