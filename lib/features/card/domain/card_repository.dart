import '../../../shared/models/card_list_response.dart';
import '../../../shared/models/vaccine_detail.dart';

abstract class CardRepository {
  /// GET /api/cards — CARD-01. Wajib auth:sanctum + verified (route
  /// digabung sama /home di api.php).
  Future<CardListResponse> fetchCards();

  /// GET /api/cards/{vaccine} — CARD-02. 404 kalau vaccine belum unlock
  /// (R-VAC-04/05, ditangani sebagai ApiException oleh unwrapApiCall).
  Future<VaccineDetail> fetchVaccineDetail(int vaccineId);

  /// POST /api/cards/{vaccine}/seen — tandai sudah dilihat, dipanggil
  /// begitu animasi reveal locked->unlocked selesai diputar.
  Future<void> markVaccineSeen(int vaccineId);
}