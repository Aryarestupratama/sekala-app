import '../../../shared/models/user.dart';

/// Kontrak repository auth — presentation layer (AuthController) cuma
/// bergantung ke interface ini, bukan ke implementasi Dio-nya langsung.
/// Memudahkan kalau nanti mau ganti/mock untuk testing.
abstract class AuthRepository {
  Future<User> register({
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
  });

  Future<User> login({
    required String email,
    required String password,
  });

  /// [idToken] didapat dari `google_sign_in` di sisi Flutter, lalu
  /// ditukar ke backend jadi token Sanctum (Architecture.md §4.3).
  Future<User> loginWithGoogle({required String idToken});

  Future<void> logout();

  /// Dipanggil saat restore session (ada token tersimpan) untuk ambil
  /// data user terbaru (nama, email, status verifikasi) — token sendiri
  /// nggak nyimpen data itu.
  Future<User> fetchMe();

  /// R-AUTH-03: user belum verifikasi bisa minta kirim ulang email.
  Future<void> resendVerificationEmail();
}
