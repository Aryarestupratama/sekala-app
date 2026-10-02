import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../shared/models/user.dart';
import '../../../sekala_border/presentation/providers/sekala_border_providers.dart';
import '../providers/avatar_providers.dart';

/// Merah untuk teks/ikon destruktif — AppColors.destructive di atas putih
/// hanya ~4.2:1; ini ~6.5:1.
const Color _kDangerText = Color(0xFFB3261D);

enum _AvatarAction { gallery, camera, delete }

/// Avatar profil (Fase 3) — foto asli kalau `user.avatarUrl` ada, fallback
/// gradasi + inisial (SAMA gradient yang dipakai ProfileScreen sebelum Fase
/// 3, biar tidak ada "loncatan" visual buat user yang belum pernah upload).
///
/// Cincin Border SEKALA digambar DI LUAR foto (padding, bukan menimpa) —
/// sekarang mengambil `imageUrl` dari `sekalaBorderProvider` (aset CMS,
/// lihat progress.md "Border SEKALA & Foto Profil"). Kalau provider masih
/// loading/error, ATAU asetnya belum di-publish/link belum diisi
/// (`displayImageUrl` null), fallback ke gradient placeholder LAMA supaya
/// user yang sudah `shouldShowFrame` tetap lihat sesuatu (bukan kosong
/// polos) sambil menunggu tim desain mengisi aset final lewat Admin Panel.
///
/// UBAH: tombol pensil kecil di pojok foto DIHAPUS (menutupi cincin
/// border) — diganti tombol teks "Edit Foto Profil" di BAWAH foto. Foto
/// juga tidak lagi punya efek shadow supaya cincin border pas/rapat.
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

  /// Selisih diameter cincin terhadap foto (px). Naikkan kalau cincin
  /// terlihat terlalu mepet/menutupi foto, turunkan kalau ada celah putih
  /// antara foto dan cincin.
  static const double _ringExtra = 20;

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
                leading: const Icon(Icons.delete_outline_rounded, color: _kDangerText),
                title: const Text('Hapus Foto', style: TextStyle(color: _kDangerText)),
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
      // Konfirmasi dulu: sebelumnya satu ketukan di sheet langsung menghapus.
      final confirmed = await showDialog<bool>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Hapus foto profil?'),
          content: const Text('Kamu bisa mengunggah foto baru kapan saja.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(false),
              child: const Text('Batal'),
            ),
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(true),
              child: const Text('Hapus', style: TextStyle(color: _kDangerText, fontWeight: FontWeight.w700)),
            ),
          ],
        ),
      );
      if (confirmed == true) await controller.delete();
      return;
    }

    final source =
        action == _AvatarAction.camera ? ImageSource.camera : ImageSource.gallery;

    // Kompresi ringan di sisi client — BUKAN pengganti resize 512x512 di
    // server (AvatarService::MAX_DIMENSION), cuma memperkecil payload
    // supaya tidak mepet limit 2 MB (UpdateAvatarRequest).
    XFile? picked;
    try {
      picked = await ImagePicker().pickImage(source: source, imageQuality: 85);
    } catch (_) {
      // Izin kamera/galeri ditolak (PlatformException) — dulu tidak
      // ditangkap sehingga tidak ada umpan balik sama sekali.
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Tidak bisa membuka kamera atau galeri. Periksa izin aplikasi '
              'di Pengaturan perangkat.',
            ),
          ),
        );
      }
      return;
    }
    if (picked == null) return;

    await controller.upload(File(picked.path));
  }

  /// Ring border di sekitar avatar. Kalau [imageUrl] ada, render aset PNG
  /// asli (diasumsikan transparan di tengah, cuma cincinnya yang solid —
  /// sama asumsi visual dengan preview `PhonePreview.jsx` sisi Admin).
  /// Kalau null (loading/belum publish/link invalid), fallback ke gradient
  /// placeholder lama supaya tidak kosong polos.
  Widget _borderRing({required double size, required String? imageUrl}) {
    if (imageUrl != null) {
      return SizedBox(
        width: size + _ringExtra,
        height: size + _ringExtra,
        child: Image.network(
          imageUrl,
          fit: BoxFit.contain,
          // Kalau link rusak/gagal dimuat, fallback ke gradient placeholder
          // ketimbang icon broken-image bawaan Flutter.
          errorBuilder: (context, error, stackTrace) =>
              _gradientRingFallback(size: size),
        ),
      );
    }

    return _gradientRingFallback(size: size);
  }

  Widget _gradientRingFallback({required double size}) {
    return Container(
      width: size + _ringExtra,
      height: size + _ringExtra,
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
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isBusy = ref.watch(avatarControllerProvider).isLoading;
    final avatarLabel = user.shouldShowFrame
        ? 'Foto profil ${user.name}, dengan Border SEKALA'
        : 'Foto profil ${user.name}';

    // Null kalau masih loading/error, ATAU aset belum di-publish/link
    // belum diisi (SekalaBorder.displayImageUrl) — kasus itu di-fallback
    // ke gradient placeholder di bawah lewat _borderRing().
    final borderImageUrl =
        ref.watch(sekalaBorderProvider).valueOrNull?.displayImageUrl;

    // Tanpa boxShadow — shadow sebelumnya melebar di sekeliling foto dan
    // bikin cincin border kelihatan tidak rapat/pas.
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

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Semantics(image: true, label: avatarLabel, excludeSemantics: true, child: SizedBox(
          // Seukuran cincin border (size + _ringExtra) — tidak perlu ruang ekstra
          // lagi karena tombol pensil sudah dipindah ke bawah foto.
          width: size + _ringExtra,
          height: size + _ringExtra,
          child: Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.none,
            children: [
              circle,
              // Cincin DI ATAS foto (urutan Stack terakhir = paling atas)
              // supaya bagian dalam cincin (teks/ornamen) tidak tertimpa
              // foto. Aset PNG diasumsikan transparan di tengah.
              // shouldShowFrame (bukan cuma frameEquipped mentah) — jaga-jaga
              // kondisi tidak konsisten, cincin tidak pernah tampil tanpa
              // frameUnlocked true (lihat User.shouldShowFrame).
              if (user.shouldShowFrame)
                _borderRing(size: size, imageUrl: borderImageUrl),
            ],
          ),
        )),
        if (editable) ...[
          const SizedBox(height: 4),
          TextButton.icon(
            onPressed: isBusy ? null : () => _showEditSheet(context, ref),
            style: TextButton.styleFrom(
              foregroundColor: AppColors.ink,
              // Dulu `VisualDensity.compact` + padding 4 (~32dp tinggi).
              minimumSize: const Size(48, 48),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              textStyle: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 14,
              ),
            ),
            icon: isBusy
                ? const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.edit_rounded, size: 16),
            label: Text(isBusy ? 'Memproses...' : 'Edit Foto Profil'),
          ),
        ],
      ],
    );
  }
}