import 'package:dio/dio.dart';
import '../../../core/network/api_result.dart';

/// ASUMSI shape response: `{ "data": [...] }` untuk list (konvensi
/// Laravel API Resource Collection) dan `{ "data": {...} }` untuk single
/// resource. Kalau backend balikin tanpa wrapper "data", HistoryRepositoryImpl
/// sudah ditulis toleran ke dua-duanya — file ini nggak perlu berubah.
class HistoryApi {
  HistoryApi(this._dio);
  final Dio _dio;

  Future<dynamic> getEras() {
    return unwrapApiCall(() async {
      final response = await _dio.get('/public/eras');
      return response.data;
    });
  }

  Future<dynamic> getYears(String eraSlug) {
    return unwrapApiCall(() async {
      final response = await _dio.get('/public/eras/$eraSlug/years');
      return response.data;
    });
  }

  Future<dynamic> getSection(int sectionId) {
    return unwrapApiCall(() async {
      final response = await _dio.get('/public/sections/$sectionId');
      return response.data;
    });
  }

  /// Endpoint ini butuh auth:sanctum + verified (bukan di bawah /public).
  Future<void> completeSection(int sectionId) {
    return unwrapApiCall(() async {
      await _dio.post('/sections/$sectionId/complete');
    });
  }
}
