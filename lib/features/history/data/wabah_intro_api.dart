import 'package:dio/dio.dart';
import '../../../core/network/api_result.dart';

/// GET /api/public/wabah-intro — tanpa auth, guest & user login sama-sama
/// bisa panggil (Architecture.md §4.4 prinsip guest, diperluas ke konten
/// onboarding ini).
///
/// CATATAN: dulu ada juga `PATCH /api/wabah-intro/seen` (+ method
/// `markSeen()` di sini), tapi endpoint itu sudah dihapus dari backend
/// bersamaan dengan penghapusan seluruh logic "sudah lihat" (INTRO-01
/// dihapus, auto-show tidak ada lagi). Jangan tambahkan lagi kecuali
/// fitur auto-show benar-benar dihidupkan kembali.
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
}