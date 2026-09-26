import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/network/dio_client.dart';
import '../../../../shared/models/user.dart';
import '../../../auth/presentation/providers/auth_providers.dart';
import '../../data/avatar_api.dart';
import '../../data/avatar_repository_impl.dart';
import '../../domain/avatar_repository.dart';

final avatarApiProvider = Provider<AvatarApi>((ref) {
  return AvatarApi(DioClient.instance.dio);
});

final avatarRepositoryProvider = Provider<AvatarRepository>((ref) {
  return AvatarRepositoryImpl(ref.watch(avatarApiProvider));
});

/// Controller AKSI (upload/hapus/toggle) — SENGAJA tidak menyimpan data user
/// sendiri (itu tetap tanggung jawab `currentUserProvider` di
/// auth_providers.dart, sumber kebenaran tunggal data user di seluruh app).
/// State di sini cuma AsyncValue<void> buat status loading/error tombol,
/// supaya UI bisa kasih spinner per-aksi tanpa nge-block seluruh
/// ProfileScreen ikut ke state loading.
///
/// PENTING — TOLONG VERIFIKASI: baris `ref.invalidate(currentUserProvider)`
/// di bawah mengasumsikan currentUserProvider adalah provider yang refetch
/// ke server saat di-invalidate (mis. FutureProvider yang hit GET
/// /auth/me). Kalau ternyata currentUserProvider di auth_providers.dart
/// justru derive dari AuthController.state yang di-update manual (bukan
/// lewat network refetch), ganti baris itu dengan cara auth_providers.dart
/// biasa memperbarui user (mis. `ref.read(authControllerProvider.notifier)
/// .updateUser(newUser)`), supaya avatar_url/frame_equipped baru benar-benar
/// tampil ulang di ProfileScreen tanpa perlu restart app.
class AvatarController extends AsyncNotifier<void> {
  @override
  Future<void> build() async {}

  Future<void> upload(File file) => _run(
        () => ref.read(avatarRepositoryProvider).uploadAvatar(file),
      );

  Future<void> delete() => _run(
        () => ref.read(avatarRepositoryProvider).deleteAvatar(),
      );

  Future<void> toggleFrame(bool equipped) => _run(
        () => ref.read(avatarRepositoryProvider).updateFrame(equipped),
      );

  Future<void> _run(Future<User> Function() action) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await action();
      ref.invalidate(currentUserProvider);
    });
  }
}

final avatarControllerProvider =
    AsyncNotifierProvider<AvatarController, void>(AvatarController.new);