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
/// Ringkasan per-era (total & unlocked vaksin di era tsb) — mengacu
/// `meta.eras` baru di CardController::index(), dipakai buat badge angka
/// di chip filter era, mis. "Kolonial (3/5)".
@freezed
abstract class EraSummary with _$EraSummary {
  const factory EraSummary({
    required int id,
    required String name,
    required String slug,
    required int total,
    required int unlocked,
  }) = _EraSummary;

  factory EraSummary.fromJson(Map<String, dynamic> json) =>
      _$EraSummaryFromJson(json);
}

@freezed
abstract class CardListMeta with _$CardListMeta {
  const factory CardListMeta({
    required int total,
    required int unlocked,
    // Jumlah vaksin unlocked yang belum pernah dilihat (seen_at null).
    // Dipakai buat badge dot bottom nav tanpa perlu itung ulang dari
    // `data` sisi Flutter.
    required int unseen,
    // Daftar era yang benar-benar punya vaksin (bukan daftar semua era di
    // sistem) — jadi chip filter era di VaccineListScreen dibangun dinamis
    // dari sini, bukan hardcode 3 era.
    @Default(<EraSummary>[]) List<EraSummary> eras,
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