import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../constants/api_constants.dart';

/// Wrapper tipis di atas flutter_secure_storage,
/// khusus menyimpan token Sanctum & role user.
class SecureStorageService {
  SecureStorageService._();
  static final SecureStorageService instance = SecureStorageService._();

  final _storage = const FlutterSecureStorage();

  Future<void> saveToken(String token) =>
      _storage.write(key: ApiConstants.tokenKey, value: token);

  Future<String?> getToken() => _storage.read(key: ApiConstants.tokenKey);

  Future<void> saveRole(String role) =>
      _storage.write(key: ApiConstants.userRoleKey, value: role);

  Future<String?> getRole() => _storage.read(key: ApiConstants.userRoleKey);

  /// Dipanggil saat logout atau token invalid (401).
  Future<void> clear() async {
    await _storage.delete(key: ApiConstants.tokenKey);
    await _storage.delete(key: ApiConstants.userRoleKey);
  }

  Future<bool> hasToken() async {
    final token = await getToken();
    return token != null && token.isNotEmpty;
  }
}