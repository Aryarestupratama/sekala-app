import '../../../shared/models/card_list_response.dart';
import '../../../shared/models/figure_detail.dart';

abstract class CardRepository {
  /// GET /api/cards — CARD-01. Wajib auth:sanctum + verified (route
  /// digabung sama /home di api.php).
  Future<CardListResponse> fetchCards();

  /// GET /api/cards/{figure} — CARD-02. 404 kalau figure belum unlock
  /// (R-CARD-02, ditangani sebagai ApiException oleh unwrapApiCall).
  Future<FigureDetail> fetchFigureDetail(int figureId);
}
