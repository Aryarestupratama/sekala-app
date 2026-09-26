import '../../../core/storage/secure_storage_service.dart';
import '../../../shared/models/user.dart';
import '../domain/auth_repository.dart';
import 'auth_api.dart';

/// ASUMSI shape response untuk login/google — dugaan konvensi Laravel:
/// `{ "user": {...UserResource}, "token": "..." }`. Kalau backend
/// ternyata membungkusnya beda (mis. `{ "data": { "user": ..., "token": ... } }`),
/// cukup sesuaikan `_parseAuthPayload` di bawah — tidak usah ubah tempat lain.
class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this._api);
  final AuthApi _api;

  /// Dipakai untuk login/google — response-nya SELALU ada `token`
  /// (AuthController::login()/googleCallback()), jadi aman langsung
  /// simpan ke storage & anggap user sudah authenticated.
  Future<User> _parseAuthPayload(Map<String, dynamic> json) async {
    final user = User.fromJson(json['user'] as Map<String, dynamic>);
    final token = json['token'] as String;
    await SecureStorageService.instance.saveToken(token);
    await SecureStorageService.instance.saveRole(user.role);
    return user;
  }

  @override
  Future<User> register({
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
  }) async {
    final json = await _api.register(
      name: name,
      email: email,
      password: password,
      passwordConfirmation: passwordConfirmation,
    );
    // PENTING: dikonfirmasi lewat AuthController::register() (Laravel) —
    // response register CUMA berisi { message, user }, TIDAK ada "token".
    // Ini disengaja: user baru belum email_verified (R-AUTH-02/03), jadi
    // belum boleh dianggap "login". Jangan pakai _parseAuthPayload() di
    // sini (dulu inilah akar bug loading macet — json['token'] as String
    // dilempar ke null lalu TypeError nggak ketangkep di AuthController
    // provider, state nyangkut di AsyncLoading() selamanya).
    return User.fromJson(json['user'] as Map<String, dynamic>);
  }

  @override
  Future<User> login({required String email, required String password}) async {
    final json = await _api.login(email: email, password: password);
    return _parseAuthPayload(json);
  }

  @override
  Future<User> loginWithGoogle({required String idToken}) async {
    final json = await _api.loginWithGoogle(idToken: idToken);
    return _parseAuthPayload(json);
  }

  @override
  Future<void> logout() async {
    try {
      await _api.logout();
    } finally {
      // Tetap bersihin storage lokal meski request logout ke server gagal
      // (mis. sudah tidak ada koneksi) — user tetap harus bisa "keluar"
      // secara lokal.
      await SecureStorageService.instance.clear();
    }
  }

  @override
  Future<User> fetchMe() async {
    final json = await _api.me();
    // Dikonfirmasi lewat testing: dibungkus { "user": {...} }, sama
    // kayak response login/register — bukan { "data": {...} } seperti
    // dugaan awal.
    return User.fromJson(json['user'] as Map<String, dynamic>);
  }

  @override
  Future<void> resendVerificationEmail() => _api.resendVerificationEmail();

  /// BARU — ganti password. Token device ini sendiri tetap valid setelah
  /// sukses (backend mengecualikan token aktif dari pencabutan), jadi
  /// tidak perlu logout lokal di sini.
  @override
  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
    required String newPasswordConfirmation,
  }) {
    return _api.changePassword(
      currentPassword: currentPassword,
      newPassword: newPassword,
      newPasswordConfirmation: newPasswordConfirmation,
    );
  }

  @override
  Future<void> markTutorialSeen() => _api.markTutorialSeen();
}