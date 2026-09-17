import 'package:dio/dio.dart';
import '../../../core/network/api_result.dart';

/// Endpoint Rangkuman Interaktif (SUM-01–06) — mirror pola `QuizApi`
/// (progresif per-poin, bukan submit-di-akhir seperti kuis sumatif era).
class YearSummaryApi {
  YearSummaryApi(this._dio);
  final Dio _dio;

  /// GET /years/{year}/summary — UserYearSummaryController::show().
  /// Butuh auth:sanctum + verified (sama grup middleware dengan kuis
  /// year), bisa 403 kalau section belum semua completed.
  Future<Map<String, dynamic>> getSummary(int yearId) {
    return unwrapApiCall(() async {
      final response = await _dio.get('/years/$yearId/summary');
      return response.data as Map<String, dynamic>;
    });
  }

  /// POST /years/{year}/summary/points/{point}/answer (SUM-02) — feedback
  /// instan, TIDAK disimpan ke backend (YearSummaryService::checkAnswer()).
  Future<Map<String, dynamic>> checkAnswer({
    required int yearId,
    required int pointId,
    required int optionId,
  }) {
    return unwrapApiCall(() async {
      final response = await _dio.post(
        '/years/$yearId/summary/points/$pointId/answer',
        data: {'option_id': optionId},
      );
      return response.data as Map<String, dynamic>;
    });
  }

  /// POST /years/{year}/summary/complete — dipanggil setelah poin ke-7
  /// dijawab (pengerjaan pertama MAUPUN "Kerjakan Ulang", body sama,
  /// backend yang menentukan overwrite via R-SUM-11).
  ///
  /// [answers] format: `[{"point_id": <int>, "option_id": <int>}, ...]`
  /// wajib tepat 7 item (StoreYearSummaryAttemptRequest).
  Future<Map<String, dynamic>> submit({
    required int yearId,
    required List<Map<String, int>> answers,
  }) {
    return unwrapApiCall(() async {
      final response = await _dio.post(
        '/years/$yearId/summary/complete',
        data: {'answers': answers},
      );
      return response.data as Map<String, dynamic>;
    });
  }
}