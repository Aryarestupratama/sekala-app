import 'dart:io';

import 'package:dio/dio.dart';

import '../../../core/network/api_result.dart';

/// Endpoint Foto Profil & Border SEKALA (Fase 3). Semua 3 aksi balikin
/// UserResource TERBARU langsung dari response (sama pola dgn
/// AvatarController: store()/destroy()/FrameController::update() semua
/// return `new UserResource(...)`) — jadi repository tidak perlu request
/// kedua buat refresh data user.
///
/// PENTING — SHAPE RESPONSE: `new UserResource(...)` dibungkus Laravel
/// jadi `{ "data": {...} }`, BEDA dari `/auth/me` yang dibungkus manual
/// `{ "user": {...} }`. [_unwrapUser] menangani keduanya (plus kasus tanpa
/// pembungkus sama sekali, mis. kalau suatu saat
/// JsonResource::withoutWrapping() diaktifkan).
class AvatarApi {
  AvatarApi(this._dio);
  final Dio _dio;

  /// Ambil map user dari body response, apa pun pembungkusnya.
  Map<String, dynamic> _unwrapUser(Response response) {
    final body = response.data as Map<String, dynamic>;
    final data = body['data'];
    if (data is Map<String, dynamic>) return data;
    final user = body['user'];
    if (user is Map<String, dynamic>) return user;
    return body;
  }

  /// POST /api/auth/profile/avatar (multipart) — dipakai juga untuk GANTI foto,
  /// backend tidak punya endpoint terpisah "ganti" (lihat
  /// AvatarController::store()).
  Future<Map<String, dynamic>> uploadAvatar(File file) {
    return unwrapApiCall(() async {
      final formData = FormData.fromMap({
        'avatar': await MultipartFile.fromFile(
          file.path,
          filename: file.path.split('/').last,
        ),
      });
      final response = await _dio.post('/auth/profile/avatar', data: formData);
      return _unwrapUser(response);
    });
  }

  /// DELETE /api/auth/profile/avatar — idempotent di backend, aman dipanggil
  /// walau user belum pernah upload.
  Future<Map<String, dynamic>> deleteAvatar() {
    return unwrapApiCall(() async {
      final response = await _dio.delete('/auth/profile/avatar');
      return _unwrapUser(response);
    });
  }

  /// PATCH /api/auth/profile/frame — pasang/lepas Border SEKALA. Backend
  /// menolak 422 (UpdateFrameRequest) kalau equipped=true padahal
  /// frame_unlocked_at masih null; error DioException diteruskan apa
  /// adanya, ditangani di layer provider/UI (tidak perlu dicek dobel di
  /// sini karena UI sudah menyembunyikan toggle kalau belum unlocked).
  Future<Map<String, dynamic>> updateFrame(bool equipped) {
    return unwrapApiCall(() async {
      final response = await _dio.patch(
        '/auth/profile/frame',
        data: {'frame_equipped': equipped},
      );
      return _unwrapUser(response);
    });
  }
}