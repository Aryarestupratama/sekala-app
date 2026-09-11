import 'package:dio/dio.dart';
import '../../../core/network/api_result.dart';

/// GET /api/public/wabah-intro — tanpa auth, guest & user login sama-sama
/// bisa panggil (Architecture.md §4.4 prinsip guest, diperluas ke konten
/// onboarding ini).
///
/// PATCH /api/wabah-intro/seen — auth:sanctum saja (bukan verified), hanya
/// dipanggil untuk user login. Guest TIDAK PERNAH memanggil endpoint ini
/// (status "sudah lihat" untuk guest murni local flag, lihat
/// wabah_intro_providers.dart).
class WabahIntroApi {
  WabahIntroApi(this._dio);
  final Dio _dio;

  /// Return null kalau backend mengembalikan `data: null` (belum diisi
  /// admin / belum di-publish) — bukan exception, karena ini kondisi
  /// normal (bukan error).
  Future<Map<String, dynamic>?> getWabahIntro() {
    return unwrapApiCall(() async {
      final response = await _dio.get('/public/wabah-intro');
      final data = response.data as Map<String, dynamic>;
      return data['data'] as Map<String, dynamic>?;
    });
  }

  Future<void> markSeen() {
    return unwrapApiCall(() async {
      await _dio.patch('/wabah-intro/seen');
      return null;
    });
  }
}