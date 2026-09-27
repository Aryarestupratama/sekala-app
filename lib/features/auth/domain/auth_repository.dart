import '../../../shared/models/user.dart';
 
abstract class AuthRepository {
  Future<User> register({
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
  });
 
  Future<User> login({required String email, required String password});
 
  Future<void> logout();
 
  Future<User> fetchMe();
 
  Future<void> resendVerificationEmail();
 
  /// BARU — ganti password untuk user yang sedang login.
  /// Melempar ApiException kalau current_password salah atau validasi
  /// backend gagal (lihat AuthService::changePassword di backend).
  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
    required String newPasswordConfirmation,
  });

  /// BARU — tandai tutorial onboarding sudah dilihat, level akun (user
  /// login saja — guest pakai flag lokal terpisah di
  /// TutorialTourController).
  Future<void> markTutorialSeen();
}