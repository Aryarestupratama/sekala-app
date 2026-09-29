class ApiConstants {
  ApiConstants._();

  // Default = production. Untuk development lokal, override saat run:
  //   flutter run --dart-define=API_BASE_URL=http://10.0.2.2:8000/api
  static const String baseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'https://sekalaapp.my.id/api',
  );

  static const String tokenKey = 'sekala_auth_token';
  static const String userRoleKey = 'sekala_user_role';

  // Shared hosting kadang lambat di request pertama (cold start),
  // jadi timeout dinaikkan dari 15 ke 30 detik.
  static const Duration connectTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);
}