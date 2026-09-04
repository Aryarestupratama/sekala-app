import 'package:freezed_annotation/freezed_annotation.dart';
import 'vaccine_card.dart';

part 'card_list_response.freezed.dart';
part 'card_list_response.g.dart';

/// Mengacu CardController::index() aktual — response dibungkus manual
/// (bukan JsonResource::collection biasa), jadi punya `meta` di luar
/// pola wrapper standar Laravel.
///
/// (Revisi: Figure -> Vaccine, VAC-01/R-VAC-04. Nama class `CardListResponse`
/// sengaja tidak diganti jadi `VaccineListResponse` karena sudah generik dan
/// endpoint-nya juga masih `/api/cards`, cukup tipe di dalamnya yang berubah.)
@freezed
abstract class CardListMeta with _$CardListMeta {
  const factory CardListMeta({
    required int total,
    required int unlocked,
    // Jumlah vaksin unlocked yang belum pernah dilihat (seen_at null).
    // Dipakai buat badge dot bottom nav tanpa perlu itung ulang dari
    // `data` sisi Flutter.
    required int unseen,
  }) = _CardListMeta;

  factory CardListMeta.fromJson(Map<String, dynamic> json) =>
      _$CardListMetaFromJson(json);
}

@freezed
abstract class CardListResponse with _$CardListResponse {
  const factory CardListResponse({
    @Default(<VaccineCard>[]) List<VaccineCard> data,
    required CardListMeta meta,
  }) = _CardListResponse;

  factory CardListResponse.fromJson(Map<String, dynamic> json) =>
      _$CardListResponseFromJson(json);
}