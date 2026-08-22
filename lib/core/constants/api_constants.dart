class ApiConstants {
  ApiConstants._();

  // Ganti sesuai environment kamu.
  // Emulator Android pakai 10.0.2.2 untuk akses localhost host.
  // Kalau test di Chrome/desktop, localhost biasa juga jalan.
  static const String baseUrl = 'http://127.0.0.1:8000/api';

  static const String tokenKey = 'sekala_auth_token';
  static const String userRoleKey = 'sekala_user_role';

  static const Duration connectTimeout = Duration(seconds: 15);
  static const Duration receiveTimeout = Duration(seconds: 15);
}