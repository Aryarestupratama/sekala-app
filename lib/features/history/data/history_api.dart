import 'package:dio/dio.dart';
import '../../../core/network/api_result.dart';

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
  ///
  /// BARU: sekarang mengembalikan body response (sebelumnya dibuang total
  /// lewat `await` tanpa return). ProgressController::complete() balikin
  /// `completed_at`/`year_completed`/`newly_unlocked_vaccine_ids` — dipakai
  /// HistoryRepositoryImpl buat parse ke SectionCompletionResult.
  Future<Map<String, dynamic>> completeSection(int sectionId) {
    return unwrapApiCall(() async {
      final response = await _dio.post('/sections/$sectionId/complete');
      return response.data as Map<String, dynamic>;
    });
  }
}