import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../storage/secure_storage_service.dart';

/// Status auth level-router. Ini SENGAJA disederhanakan dari status auth
/// sesungguhnya (yang nanti dikelola features/auth) — router cuma perlu
/// tahu 4 hal ini untuk menentukan boleh/tidaknya masuk ke suatu route.
enum AuthStatus {
  /// Baru pertama kali load app, lagi cek token di secure storage.
  checking,

  /// Belum login & belum pilih "lanjutkan sebagai guest".
  unauthenticated,

  /// Pilih "lanjutkan sebagai guest" (Design.md §3.1) — session-only,
  /// tidak disimpan ke secure storage. Guest = R-AUTH-07 (endpoint publik saja).
  guest,

  /// Punya token Sanctum tersimpan & valid (belum tentu email terverifikasi —
  /// verifikasi email dicek di level fitur/API, bukan di router, lihat R-AUTH-03).
  authenticated,
}

class AuthState {
  final AuthStatus status;
  final String? role; // 'user' | 'admin' — null kalau guest/unauthenticated

  const AuthState({required this.status, this.role});

  bool get isAdmin => role == 'admin';

  AuthState copyWith({AuthStatus? status, String? role}) {
    return AuthState(
      status: status ?? this.status,
      role: role ?? this.role,
    );
  }
}

/// Dipanggil sekali saat app start (splash) untuk cek token tersimpan,
/// dan dipanggil ulang oleh features/auth setelah login/register/logout
/// berhasil, supaya router langsung re-evaluate redirect.
class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier() : super(const AuthState(status: AuthStatus.checking)) {
    _restoreSession();
  }

  Future<void> _restoreSession() async {
    final hasToken = await SecureStorageService.instance.hasToken();
    if (hasToken) {
      final role = await SecureStorageService.instance.getRole();
      state = AuthState(status: AuthStatus.authenticated, role: role);
    } else {
      state = const AuthState(status: AuthStatus.unauthenticated);
    }
  }

  /// Dipanggil dari AuthService (features/auth) setelah login/register
  /// sukses & token sudah disimpan ke SecureStorageService.
  void setAuthenticated(String role) {
    state = AuthState(status: AuthStatus.authenticated, role: role);
  }

  /// User pilih "Lanjutkan sebagai Guest" di Auth screen.
  void continueAsGuest() {
    state = const AuthState(status: AuthStatus.guest);
  }

  /// Dipanggil saat logout manual, atau otomatis oleh DioClient
  /// saat menerima 401 (lihat onUnauthenticated callback).
  Future<void> logout() async {
    await SecureStorageService.instance.clear();
    state = const AuthState(status: AuthStatus.unauthenticated);
  }
}

final authNotifierProvider =
    StateNotifierProvider<AuthNotifier, AuthState>((ref) => AuthNotifier());
