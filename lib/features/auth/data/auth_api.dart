import 'package:dio/dio.dart';
import '../../../core/network/api_result.dart';

/// Pemanggilan Dio mentah ke `/api/auth/*`. Tidak ada logic penyimpanan
/// token di sini — itu tanggung jawab AuthRepositoryImpl. Class ini cuma
/// urusan HTTP.
///
/// PENTING — ASUMSI PATH & SHAPE RESPONSE:
/// Saya belum lihat `routes/api.php` & `UserResource` yang sebenarnya,
/// jadi path & nama field di bawah ini nebak dari konvensi Laravel standar
/// + catatan di progress.md (AuthController: register/login/logout/me/google,
/// EmailVerificationController: resend). Kalau meleset pas dites ke API
/// asli, cukup ubah string path/key di file ini — layer di atasnya
/// (repository, controller, UI) nggak perlu berubah sama sekali.
class AuthApi {
  AuthApi(this._dio);
  final Dio _dio;

  Future<Map<String, dynamic>> register({
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
  }) {
    return unwrapApiCall(() async {
      final response = await _dio.post('/auth/register', data: {
        'name': name,
        'email': email,
        'password': password,
        'password_confirmation': passwordConfirmation,
      });
      return response.data as Map<String, dynamic>;
    });
  }

  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) {
    return unwrapApiCall(() async {
      final response = await _dio.post('/auth/login', data: {
        'email': email,
        'password': password,
      });
      return response.data as Map<String, dynamic>;
    });
  }

  Future<void> logout() {
    return unwrapApiCall(() async {
      await _dio.post('/auth/logout');
    });
  }

  Future<Map<String, dynamic>> me() {
    return unwrapApiCall(() async {
      final response = await _dio.get('/auth/me');
      return response.data as Map<String, dynamic>;
    });
  }

  Future<void> resendVerificationEmail() {
    return unwrapApiCall(() async {
      await _dio.post('/auth/email/verify/resend');
    });
  }

  /// BARU — ganti password. Backend: POST /auth/password
  /// (lihat AuthController::changePassword di backend).
  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
    required String newPasswordConfirmation,
  }) {
    return unwrapApiCall(() async {
      await _dio.post('/auth/password', data: {
        'current_password': currentPassword,
        'password': newPassword,
        'password_confirmation': newPasswordConfirmation,
      });
    });
  }

  /// BARU — tandai tutorial onboarding sudah dilihat, level akun.
  /// Backend: PATCH /auth/profile/tutorial-seen (TutorialController::
  /// markSeen). Dipanggil TutorialTourController begitu step terakhir tur
  /// selesai, MENGGANTIKAN flag SharedPreferences murni-lokal untuk user
  /// login (guest tetap pakai flag lokal, tidak lewat method ini).
  Future<void> markTutorialSeen() {
    return unwrapApiCall(() async {
      await _dio.patch('/auth/profile/tutorial-seen');
    });
  }
}