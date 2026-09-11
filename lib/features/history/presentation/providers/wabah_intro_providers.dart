import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../../../core/network/dio_client.dart';
import '../../../../core/router/auth_state.dart';
import '../../../../shared/models/wabah_intro.dart';
import '../../data/wabah_intro_api.dart';
import '../../data/wabah_intro_repository_impl.dart';
import '../../domain/wabah_intro_repository.dart';

const _kSeenStorageKey = 'wabah_intro_seen';

final wabahIntroApiProvider = Provider<WabahIntroApi>((ref) {
  return WabahIntroApi(DioClient.instance.dio);
});

final wabahIntroRepositoryProvider = Provider<WabahIntroRepository>((ref) {
  return WabahIntroRepositoryImpl(ref.watch(wabahIntroApiProvider));
});

/// Konten "Apa itu Wabah" — dipanggil untuk guest MAUPUN user login (beda
/// dari homeSummaryProvider yang cuma jalan kalau authenticated), karena
/// endpoint publiknya memang tidak butuh auth sama sekali (PRD.md INFO
/// intro wajib terjangkau guest juga). Null kalau admin belum publish
/// konten -> pemanggil (modal/ikon info) harus sembunyikan diri total.
final wabahIntroProvider = FutureProvider.autoDispose<WabahIntro?>((ref) {
  return ref.watch(wabahIntroRepositoryProvider).fetchWabahIntro();
});

/// NOTE: pakai FlutterSecureStorage (bukan shared_preferences) karena
/// package ini sudah jadi dependency project (dipakai auth token,
/// pubspec.yaml) -- sengaja tidak nambah dependency baru cuma untuk 1
/// boolean flag. Kalau project sudah punya wrapper storage sendiri (mis.
/// `secureStorageProvider` di core/), pakai itu saja, hapus instance
/// langsung di bawah ini.
class WabahIntroSeenNotifier extends AsyncNotifier<bool> {
  static const _storage = FlutterSecureStorage();

  @override
  Future<bool> build() async {
    final value = await _storage.read(key: _kSeenStorageKey);
    return value == 'true';
  }

  /// GAP YANG PERLU DIKETAHUI: status ini murni local flag per-device,
  /// berlaku sama untuk guest MAUPUN user login, meski backend sudah
  /// punya kolom `users.has_seen_wabah_intro` untuk user login. Kalau
  /// user login ganti device / reinstall app, flag ini balik ke false
  /// dan modal muncul lagi otomatis sekali walau backend sudah tahu dia
  /// pernah lihat -- trade-off sengaja diambil karena `User` model
  /// Flutter (`shared/models/user.dart`) & `UserResource` backend BELUM
  /// membawa field `has_seen_wabah_intro` (dicek 7 Sep 2026, User cuma
  /// punya id/name/email/role/isEmailVerified). Kalau field itu sudah
  /// ditambahkan di kedua sisi, notifier ini sebaiknya direvisi supaya
  /// user login membaca status dari `AuthState.user` alih-alih storage
  /// lokal (local flag cukup untuk guest saja). Untuk sekarang,
  /// `markAsSeen()` tetap memanggil `PATCH /wabah-intro/seen` untuk user
  /// login (fire-and-forget) supaya datanya tersimpan di backend, hanya
  /// saja belum dibaca balik dari sana.
  Future<void> markAsSeen() async {
    if (state.valueOrNull == true) return; // sudah true, tidak perlu ulang.

    await _storage.write(key: _kSeenStorageKey, value: 'true');
    state = const AsyncData(true);

    final authStatus = ref.read(authNotifierProvider).status;
    if (authStatus == AuthStatus.authenticated) {
      // Fire-and-forget -- kegagalan sinkronisasi ke backend tidak boleh
      // memblokir user menutup modal (sudah dianggap "lihat" secara lokal).
      unawaited(ref.read(wabahIntroRepositoryProvider).markSeen());
    }
  }
}

final wabahIntroSeenProvider = AsyncNotifierProvider<WabahIntroSeenNotifier, bool>(
  WabahIntroSeenNotifier.new,
);