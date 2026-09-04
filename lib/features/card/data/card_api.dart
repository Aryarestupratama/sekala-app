import 'package:dio/dio.dart';
import '../../../core/network/api_result.dart';

class CardApi {
  CardApi(this._dio);
  final Dio _dio;

  Future<Map<String, dynamic>> getCards() {
    return unwrapApiCall(() async {
      final response = await _dio.get('/cards');
      return response.data as Map<String, dynamic>;
    });
  }

  /// GET /api/cards/{vaccine} — CARD-02. Nama method disesuaikan ke
  /// Vaccine (dulu getFigureDetail); endpoint & path param backend tidak
  /// berubah, cuma penamaan sisi Flutter mengikuti migrasi Figure→Vaccine.
  Future<dynamic> getVaccineDetail(int vaccineId) {
    return unwrapApiCall(() async {
      final response = await _dio.get('/cards/$vaccineId');
      return response.data;
    });
  }

  /// POST /api/cards/{vaccine}/seen — tandai vaksin sudah dilihat user
  /// (animasi reveal locked->unlocked sudah diputar di halaman Koleksi).
  /// Idempotent di sisi backend (UserVaccineUnlock::markSeen()).
  Future<Map<String, dynamic>> markVaccineSeen(int vaccineId) {
    return unwrapApiCall(() async {
      final response = await _dio.post('/cards/$vaccineId/seen');
      return response.data as Map<String, dynamic>;
    });
  }
}