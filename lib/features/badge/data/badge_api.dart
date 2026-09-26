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
}