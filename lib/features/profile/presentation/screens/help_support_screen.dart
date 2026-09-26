import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/pressable_scale.dart';
import '../../../onboarding/tutorial_tour_controller.dart';
import 'panduan_belajar_screen.dart';

/// Isi dari menu "Bantuan & Dukungan" di ProfileScreen. Dua entry:
/// 1. "Lihat Tutorial Aplikasi" — replay coach mark yang sama dengan yang
///    auto-tampil pertama kali buka app (lihat TutorialTourController).
/// 2. "Panduan Belajar" — teks statis, murni penjelasan cara memakai fitur
///    belajar di aplikasi (bukan konten sejarah).
///
/// REDESIGN: `ListTile` diganti kartu + [PressableScale] konsisten dengan
/// menu di ProfileScreen. Urutan `Navigator.pop()` SEBELUM
/// `TutorialTourController.start()` di menu pertama TIDAK diubah — itu
/// penting supaya branch Profil tidak nyangkut di layar ini saat tur
/// sampai ke step terakhir (lihat catatan aslinya).
///
/// BARU: `StatelessWidget` -> `ConsumerWidget` — `TutorialTourController.
/// start()` sekarang butuh `WidgetRef` juga (bukan cuma `BuildContext`),
/// dipakai untuk baca status auth & panggil `authRepositoryProvider.
/// markTutorialSeen()` di akhir tur (lihat tutorial_tour_controller.dart).
class HelpSupportScreen extends ConsumerWidget {
  const HelpSupportScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        title: const Text('Bantuan & Dukungan', style: TextStyle(fontWeight: FontWeight.w800)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: AppColors.border),
            ),
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: [
                _HelpTile(
                  icon: Icons.play_circle_outline_rounded,
                  title: 'Lihat Tutorial Aplikasi',
                  subtitle: 'Panduan singkat cara memakai fitur utama',
                  onTap: () {
                    // PENTING: pop dulu keluar dari layar ini SEBELUM
                    // mulai tur. Kalau tidak, branch Profil masih
                    // "nyangkut" di HelpSupportScreen ini, jadi begitu tur
                    // nyampe step terakhir (balik ke tab Profil), yang
                    // kelihatan tetap layar ini, bukan ProfileScreen yang
                    // jadi target Showcase menu "Bantuan & Dukungan".
                    // Context ini masih valid dipakai sesaat setelah pop
                    // (Element belum langsung dibuang, transisi animasi
                    // pop masih jalan), cukup buat memulai tur.
                    Navigator.of(context).pop();
                    TutorialTourController.start(context, ref);
                  },
                ),
                const Divider(height: 1, color: AppColors.border),
                _HelpTile(
                  icon: Icons.menu_book_outlined,
                  title: 'Panduan Belajar',
                  subtitle: 'Tips memaksimalkan proses belajarmu di SEKALA',
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const PanduanBelajarScreen()),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _HelpTile extends StatelessWidget {
  const _HelpTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return PressableScale(
      scale: 0.99,
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(color: AppColors.ink.withValues(alpha: 0.06), shape: BoxShape.circle),
              alignment: Alignment.center,
              child: Icon(icon, size: 20, color: AppColors.ink),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14.5)),
                  const SizedBox(height: 2),
                  Text(subtitle, style: const TextStyle(color: AppColors.textSecondary, fontSize: 12.5)),
                ],
              ),
            ),
            const SizedBox(width: 8),
            const Icon(Icons.chevron_right_rounded, color: AppColors.textDisabled),
          ],
        ),
      ),
    );
  }
}