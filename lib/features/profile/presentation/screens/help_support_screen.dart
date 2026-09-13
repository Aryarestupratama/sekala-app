import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../onboarding/tutorial_tour_controller.dart';
import 'panduan_belajar_screen.dart';

/// Isi dari menu "Bantuan & Dukungan" di ProfileScreen — sebelumnya cuma
/// `_showComingSoon()`. Dua entry:
/// 1. "Lihat Tutorial Aplikasi" — replay coach mark yang sama dengan yang
///    auto-tampil pertama kali buka app (lihat TutorialTourController).
/// 2. "Panduan Belajar" — teks statis, murni penjelasan cara memakai fitur
///    belajar di aplikasi (bukan konten sejarah).
class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Bantuan & Dukungan')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.border),
            ),
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.play_circle_outline, color: AppColors.ink),
                  title: const Text('Lihat Tutorial Aplikasi'),
                  subtitle: const Text('Panduan singkat cara memakai fitur utama'),
                  trailing: const Icon(Icons.chevron_right, color: AppColors.textDisabled),
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
                    TutorialTourController.start(context);
                  },
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.menu_book_outlined, color: AppColors.ink),
                  title: const Text('Panduan Belajar'),
                  subtitle: const Text('Tips memaksimalkan proses belajarmu di SEKALA'),
                  trailing: const Icon(Icons.chevron_right, color: AppColors.textDisabled),
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