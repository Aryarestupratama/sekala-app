import 'package:dio/dio.dart';
import '../../../core/network/api_result.dart';

/// GET /api/public/sekala-border — tanpa auth, sama alasan dgn
/// WabahIntroApi (border dipasang di layar Profil yang tetap boleh
/// dilihat guest, meski guest tidak bisa unlock/pasang beneran).
///
/// CATATAN bentuk response: BEDA dari WabahIntroApi — controller backend
/// ini mengembalikan JSON top-level langsung (`{is_published, image_url}`),
/// BUKAN dibungkus `{ data: {...} }`. Kalau ternyata backend Anda sudah
/// diubah untuk membungkus dengan Resource (jadi ikut pola `data`), ganti
/// baris `response.data as Map<String, dynamic>` di bawah jadi
/// `(response.data as Map<String, dynamic>)['data'] as Map<String, dynamic>`.
class SekalaBorderApi {
  SekalaBorderApi(this._dio);
  final Dio _dio;

  Future<Map<String, dynamic>> getSekalaBorder() {
    return unwrapApiCall(() async {
      final response = await _dio.get('/public/sekala-border');
      return response.data as Map<String, dynamic>;
    });
  }
}