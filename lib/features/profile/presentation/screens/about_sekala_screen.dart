import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../widgets/info_section_list.dart';

/// Teks statis (hardcode), konten diambil dari PRD.md §1 (Latar Belakang &
/// Tujuan) dan §3 (Scope MVP). Kalau nanti isinya sering berubah (mis.
/// versi app di-update tiap rilis), pertimbangkan pindah ke pola singleton
/// CMS seperti `wabah_intro`.
///
/// REVISI: daftar kartu + animasi dipindah ke [InfoSectionList] (dipakai
/// bersama `PanduanBelajarScreen`). Teks "Fitur Utama" DITAMBAH dua butir
/// yang sebelumnya tidak disebut sama sekali: Rangkuman Interaktif dan
/// Badge + Border SEKALA — mohon ditinjau tim konten.
class AboutSekalaScreen extends StatelessWidget {
  const AboutSekalaScreen({super.key});

  /// PRD.md belum menyebut nomor versi resmi — nilai ini disamakan dengan
  /// `pubspec.yaml` (version: 1.0.0+1). Update manual tiap rilis kalau
  /// belum ada mekanisme baca otomatis (mis. package_info_plus).
  static const String _appVersion = '1.0.0';

  static const _sections = <InfoSection>[
    InfoSection(
      icon: Icons.school_outlined,
      title: 'Tentang SEKALA',
      body:
          'SEKALA — Sejarah & Edukasi Kesehatan Alur Lintas Abad — adalah '
          'aplikasi edukasi yang menyajikan sejarah kesehatan Indonesia, '
          'termasuk wabah dan vaksin penanggulangannya, di tiga masa: '
          'Kolonial, Kemerdekaan, dan Modern.\n\n'
          'Tujuan utama SEKALA adalah membuat sejarah kesehatan Indonesia '
          'mudah diakses dan menarik dipelajari lewat roadmap tahun '
          'berurutan, studi kasus interaktif, kuis penutup wabah, dan '
          'koleksi kartu vaksin.',
    ),
    InfoSection(
      icon: Icons.map_outlined,
      title: 'Cakupan Materi',
      body:
          'Materi disusun mengikuti 3 masa perjalanan kesehatan Indonesia, '
          'dipelajari secara berurutan dari era paling awal:\n\n'
          '• Kolonial — masa kesehatan Indonesia di era penjajahan Belanda '
          'dan Jepang.\n'
          '• Kemerdekaan — masa awal kemerdekaan hingga masa Orde Baru.\n'
          '• Modern — masa reformasi hingga era kesehatan digital saat '
          'ini.',
    ),
    InfoSection(
      icon: Icons.stars_outlined,
      title: 'Fitur Utama',
      body:
          '• Roadmap tahun berurutan dengan sequential unlock — bagian '
          'berikutnya terbuka setelah bagian sebelumnya selesai dibaca.\n'
          '• Studi kasus problem-based learning — simulasi pengambilan '
          'keputusan penanganan wabah untuk mengasah analisis dan '
          'refleksi.\n'
          '• Rangkuman interaktif — pilih kalimat yang benar di setiap '
          'poin, lalu baca rangkuman lengkap sebelum masuk ke kuis.\n'
          '• Kuis formatif per wabah — berskor dengan passing grade '
          '75%, boleh dikerjakan ulang kapan saja.\n'
          '• Kuis sumatif era ("final boss") — muncul setelah seluruh '
          'wabah dalam satu era selesai, menguji pemahaman secara '
          'menyeluruh.\n'
          '• Koleksi kartu vaksin — terbuka otomatis begitu wabah '
          'terkait dinyatakan selesai.\n'
          '• Badge dan Border SEKALA — badge didapat dari studi kasus; '
          'kumpulkan semuanya untuk membuka Border SEKALA di foto '
          'profilmu.',
    ),
    InfoSection(
      icon: Icons.groups_outlined,
      title: 'Untuk Siapa',
      body:
          'SEKALA dirancang untuk pelajar/mahasiswa yang ingin memperdalam '
          'materi sejarah kesehatan, maupun masyarakat umum yang ingin '
          'belajar sambil menelusuri kembali perjalanan wabah dan vaksin '
          'di Indonesia dengan cara yang ringan dan interaktif.',
    ),
    InfoSection(
      icon: Icons.info_outline_rounded,
      title: 'Versi Aplikasi',
      body: 'SEKALA versi $_appVersion.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        title: const Text('Tentang SEKALA', style: TextStyle(fontWeight: FontWeight.w800)),
      ),
      body: const InfoSectionList(sections: _sections),
    );
  }
}