import 'package:dio/dio.dart';
import '../../../core/network/api_result.dart';

class BadgeApi {
  BadgeApi(this._dio);
  final Dio _dio;

  /// GET /api/badges — Koleksi Badge (Fase 2). Badge locked TETAP ikut di
  /// response (tidak disembunyikan/dipangkas) — sama pola dengan
  /// GET /cards, bedanya di sisi Vaksin nama/foto disamarkan kalau locked,
  /// di Badge tidak (lihat catatan class-level BadgeCard).
  Future<Map<String, dynamic>> getBadges() {
    return unwrapApiCall(() async {
      final response = await _dio.get('/badges');
      return response.data as Map<String, dynamic>;
    });
  }

  /// PATCH /api/badges/{caseStudy}/seen — tandai badge sudah dilihat user
  /// (dot merah/tag "Baru" hilang). Mirror CardApi.markVaccineSeen — beda
  /// method HTTP (PATCH, bukan POST) karena rute barunya memang didaftarkan
  /// PATCH (lihat routes/api.php). Idempotent & permisif di sisi backend
  /// (BadgeController::markSeen) — aman dipanggil walau sudah pernah
  /// ditandai sebelumnya.
  Future<void> markBadgeSeen(int caseStudyId) {
    return unwrapApiCall(() async {
      await _dio.patch('/badges/$caseStudyId/seen');
    });
  }
}