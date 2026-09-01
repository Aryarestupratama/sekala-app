import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/network/api_exception.dart';
import '../../../../core/network/dio_client.dart';
import '../../../../core/router/auth_state.dart';
import '../../../../shared/models/user.dart';
import '../../data/auth_api.dart';
import '../../data/auth_repository_impl.dart';
import '../../domain/auth_repository.dart';

final authApiProvider = Provider<AuthApi>((ref) {
  return AuthApi(DioClient.instance.dio);
});

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepositoryImpl(ref.watch(authApiProvider));
});

/// Data user lengkap (nama, email, status verifikasi) untuk ditampilkan
/// di Profile/banner verifikasi — beda dari `authNotifierProvider` (core/router)
/// yang cuma nyimpen status ringkas (token ada/nggak + role) buat keperluan
/// guard routing.
///
/// Otomatis re-fetch tiap kali `authNotifierProvider` berubah (login,
/// logout, guest) karena watch di bawah — nggak perlu manual trigger.
final currentUserProvider = FutureProvider.autoDispose<User?>((ref) async {
  final authStatus = ref.watch(authNotifierProvider).status;
  if (authStatus != AuthStatus.authenticated) return null;

  final repository = ref.watch(authRepositoryProvider);
  return repository.fetchMe();
});

/// State loading/error untuk aksi auth (login/register/google/logout).
/// Screen tinggal `ref.watch(authControllerProvider)` untuk tau lagi
/// loading atau nggak, dan panggil method-nya untuk trigger aksi.
class AuthController extends StateNotifier<AsyncValue<void>> {
  AuthController(this._ref) : super(const AsyncData(null));
  final Ref _ref;

  AuthRepository get _repository => _ref.read(authRepositoryProvider);

  Future<bool> login({required String email, required String password}) {
    return _run(() async {
      final user = await _repository.login(email: email, password: password);
      _ref.read(authNotifierProvider.notifier).setAuthenticated(user.role);
    });
  }

  Future<bool> register({
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
  }) {
    return _run(() async {
      // Sengaja TIDAK panggil setAuthenticated() di sini — register
      // (AuthController::register() Laravel) tidak mengembalikan token
      // sama sekali, karena user baru belum email_verified (R-AUTH-02/03),
      // jadi belum boleh dianggap login. AuthRepositoryImpl.register()
      // juga sudah tidak mencoba baca token lagi (lihat catatan di sana).
      // Screen (auth_screen.dart) yang menampilkan pesan "cek email"
      // & mengarahkan balik ke mode Login setelah ini sukses.
      await _repository.register(
        name: name,
        email: email,
        password: password,
        passwordConfirmation: passwordConfirmation,
      );
    });
  }

  Future<bool> loginWithGoogle({required String idToken}) {
    return _run(() async {
      final user = await _repository.loginWithGoogle(idToken: idToken);
      _ref.read(authNotifierProvider.notifier).setAuthenticated(user.role);
    });
  }

  Future<bool> logout() {
    return _run(() async {
      // AuthRepositoryImpl.logout() sudah bersihin secure storage;
      // AuthNotifier.logout() juga clear (idempotent) sekalian update
      // status jadi `unauthenticated` biar redirect guard jalan.
      await _repository.logout();
      await _ref.read(authNotifierProvider.notifier).logout();
    });
  }

  Future<bool> resendVerificationEmail() {
    return _run(() => _repository.resendVerificationEmail());
  }

  /// Design.md §3.1 poin 2 — "Lanjutkan sebagai Guest", tanpa API call.
  void continueAsGuest() {
    _ref.read(authNotifierProvider.notifier).continueAsGuest();
  }

  Future<bool> _run(Future<void> Function() action) async {
    // Jaga-jaga dobel tap (mis. Enter di keyboard + tap tombol hampir
    // bersamaan) sebelum UI sempat re-render buat nge-disable tombolnya —
    // ketauan pas testing, request register bisa kekirim 2x dengan body
    // yang sama.
    if (state.isLoading) return false;

    state = const AsyncLoading();
    try {
      await action();
      state = const AsyncData(null);
      return true;
    } on ApiException catch (e, st) {
      state = AsyncError(e, st);
      return false;
    }
    // CATATAN: sengaja TIDAK ada catch-all generik di sini. Kalau ada
    // exception lain (bukan ApiException) yang lolos dari sini, itu bug
    // riil yang harus kelihatan (mis. lewat Flutter error overlay/crash
    // log), bukan ditelan diam-diam jadi "loading macet tanpa error" —
    // itu persis yang terjadi sebelum register.register() diperbaiki agar
    // tidak lagi maksa cast json['token'] as String yang null.
  }
}

final authControllerProvider =
    StateNotifierProvider<AuthController, AsyncValue<void>>(
  (ref) => AuthController(ref),
);