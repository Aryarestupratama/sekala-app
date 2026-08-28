import '../../../shared/models/home_progress.dart';

abstract class HomeRepository {
  /// GET /api/home — HOME-01 & HOME-02. Wajib login (endpoint ini nggak
  /// dipanggil sama sekali untuk guest, lihat home_providers.dart —
  /// R-GUEST-02: guest tidak punya progress record).
  Future<HomeSummary> fetchHomeSummary();
}
