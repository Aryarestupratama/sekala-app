import 'package:freezed_annotation/freezed_annotation.dart';
import 'badge_card.dart';

part 'badge_list_response.freezed.dart';
part 'badge_list_response.g.dart';

/// Mengacu `meta` di BadgeController::index() — cuma `total`/`unlocked`
/// (beda dari CardListMeta milik Vaksin yang juga bawa `unseen`/`eras`
/// ringkasan per-era: Koleksi Badge TIDAK punya animasi reveal/status
/// "belum dilihat", jadi tidak butuh field itu — lihat keputusan produk
/// "locked cukup diredupkan" di progress.md).
@freezed
abstract class BadgeListMeta with _$BadgeListMeta {
  const factory BadgeListMeta({
    @Default(0) int total,
    @Default(0) int unlocked,
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