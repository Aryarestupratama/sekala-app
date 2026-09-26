import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../shared/models/user.dart';
import '../providers/avatar_providers.dart';

enum _AvatarAction { gallery, camera, delete }

/// Avatar profil (Fase 3) — foto asli kalau `user.avatarUrl` ada, fallback
/// gradasi + inisial (SAMA gradient yang dipakai ProfileScreen sebelum Fase
/// 3, biar tidak ada "loncatan" visual buat user yang belum pernah upload).
///
/// Cincin Border SEKALA digambar DI LUAR foto (padding, bukan menimpa) —
/// PLACEHOLDER gradient dulu (belum ada aset final dari tim desain, lihat
/// progress.md "Poles visual"), gampang diganti jadi
/// `Image.asset('assets/frames/sekala_frame.png')` nanti tanpa mengubah
/// kontrak widget ini (tetap terima `user`, cincin tetap sama posisinya).
///
/// DEPENDENSI: butuh package `image_picker` — kalau belum ada di
/// pubspec.yaml, tambahkan dulu (`flutter pub add image_picker`).
class ProfileAvatar extends ConsumerWidget {
  const ProfileAvatar({
    super.key,
    required this.user,
    required this.initials,
    this.size = 84,
    this.editable = true,
  });

  final User user;
  final String initials;
  final double size;
  final bool editable;

  Future<void> _showEditSheet(BuildContext context, WidgetRef ref) async {
    final action = await showModalBottomSheet<_AvatarAction>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 8),
            ListTile(
              leading: const Icon(Icons.photo_library_outlined),
              title: const Text('Pilih dari Galeri'),
              onTap: () => Navigator.of(ctx).pop(_AvatarAction.gallery),
            ),
            ListTile(
              leading: const Icon(Icons.photo_camera_outlined),
              title: const Text('Ambil Foto'),
              onTap: () => Navigator.of(ctx).pop(_AvatarAction.camera),
            ),
            if (user.avatarUrl != null)
              ListTile(
                leading: const Icon(Icons.delete_outline_rounded,
                    color: AppColors.destructive),
                title: const Text('Hapus Foto',
                    style: TextStyle(color: AppColors.destructive)),
                onTap: () => Navigator.of(ctx).pop(_AvatarAction.delete),
              ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );

    if (action == null || !context.mounted) return;

    final controller = ref.read(avatarControllerProvider.notifier);

    if (action == _AvatarAction.delete) {
      await controller.delete();
      return;
    }

    final source =
        action == _AvatarAction.camera ? ImageSource.camera : ImageSource.gallery;

    // Kompresi ringan di sisi client — BUKAN pengganti resize 512x512 di
    // server (AvatarService::MAX_DIMENSION), cuma memperkecil payload
    // supaya tidak mepet limit 2 MB (UpdateAvatarRequest).
    final picked = await ImagePicker().pickImage(source: source, imageQuality: 85);
    if (picked == null) return;

    await controller.upload(File(picked.path));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isBusy = ref.watch(avatarControllerProvider).isLoading;

    final circle = Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: user.avatarUrl == null
            ? LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [AppColors.ink, AppColors.ink.withValues(alpha: 0.75)],
              )
            : null,
        image: user.avatarUrl != null
            ? DecorationImage(
                image: NetworkImage(user.avatarUrl!),
                fit: BoxFit.cover,
              )
            : null,
        boxShadow: [
          BoxShadow(
            color: AppColors.ink.withValues(alpha: 0.25),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      alignment: Alignment.center,
      child: user.avatarUrl == null
          ? Text(
              initials,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
            )
          : null,
    );

    return SizedBox(
      // Ruang ekstra di luar `size` buat cincin border + tombol edit —
      // sengaja tidak clip persis ke ukuran foto.
      width: size + 24,
      height: size + 24,
      child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          // shouldShowFrame (bukan cuma frameEquipped mentah) — jaga-jaga
          // kondisi tidak konsisten, cincin tidak pernah tampil tanpa
          // frameUnlocked true (lihat User.shouldShowFrame).
          if (user.shouldShowFrame)
            Container(
              width: size + 20,
              height: size + 20,
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [AppColors.gamify, AppColors.sky, AppColors.gamify],
                ),
              ),
              child: const DecoratedBox(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.background,
                ),
              ),
            ),
          circle,
          if (editable)
            Positioned(
              bottom: 0,
              right: 0,
              child: GestureDetector(
                onTap: isBusy ? null : () => _showEditSheet(context, ref),
                child: Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.border),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.ink.withValues(alpha: 0.1),
                        blurRadius: 6,
                      ),
                    ],
                  ),
                  alignment: Alignment.center,
                  child: isBusy
                      ? const SizedBox(
                          width: 12,
                          height: 12,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.edit_rounded,
                          size: 14, color: AppColors.ink),
                ),
              ),
            ),
        ],
      ),
    );
  }
}