import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

/// Teks statis (hardcode), sama pola dengan `PanduanBelajarScreen` — konten
/// diambil dari PRD.md §1 (Latar Belakang & Tujuan) dan §3 (Scope MVP).
/// Kalau nanti isinya sering berubah (mis. versi app di-update tiap rilis),
/// pertimbangkan pindah ke pola singleton CMS seperti `wabah_intro`.
///
/// REDESIGN: tiap section jadi kartu dengan ikon, bukan judul+teks polos,
/// dan muncul fade-up bertahap. Isi teks & `_appVersion` TIDAK berubah.
class AboutSekalaScreen extends StatefulWidget {
  const AboutSekalaScreen({super.key});

  @override
  State<AboutSekalaScreen> createState() => _AboutSekalaScreenState();
}

class _AboutSekalaScreenState extends State<AboutSekalaScreen> with SingleTickerProviderStateMixin {
  /// PRD.md belum menyebut nomor versi resmi — nilai ini disamakan dengan
  /// `pubspec.yaml` (version: 1.0.0+1). Update manual tiap rilis kalau
  /// belum ada mekanisme baca otomatis (mis. package_info_plus).
  static const String _appVersion = '1.0.0';

  static const _sections = <_AboutSection>[
    _AboutSection(
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
    _AboutSection(
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
    _AboutSection(
      icon: Icons.stars_outlined,
      title: 'Fitur Utama',
      body:
          '• Roadmap tahun berurutan dengan sequential unlock — bagian '
          'berikutnya terbuka setelah bagian sebelumnya selesai dibaca.\n'
          '• Studi kasus problem-based learning — simulasi pengambilan '
          'keputusan penanganan wabah untuk mengasah analisis dan '
          'refleksi.\n'
          '• Kuis formatif per wabah — berskor dengan passing grade '
          '75%, boleh dikerjakan ulang kapan saja.\n'
          '• Kuis sumatif era ("final boss") — muncul setelah seluruh '
          'wabah dalam satu era selesai, menguji pemahaman secara '
          'menyeluruh.\n'
          '• Koleksi kartu vaksin — terbuka otomatis begitu wabah '
          'terkait dinyatakan selesai.',
    ),
    _AboutSection(
      icon: Icons.groups_outlined,
      title: 'Untuk Siapa',
      body:
          'SEKALA dirancang untuk pelajar/mahasiswa yang ingin memperdalam '
          'materi sejarah kesehatan, maupun masyarakat umum yang ingin '
          'belajar sambil menelusuri kembali perjalanan wabah dan vaksin '
          'di Indonesia dengan cara yang ringan dan interaktif.',
    ),
    _AboutSection(
      icon: Icons.info_outline_rounded,
      title: 'Versi Aplikasi',
      body: 'SEKALA versi $_appVersion.',
    ),
  ];

  late final AnimationController _entrance = AnimationController(
    vsync: this,
    duration: Duration(milliseconds: 400 + _sections.length * 100),
  )..forward();

  @override
  void dispose() {
    _entrance.dispose();
    super.dispose();
  }

  Animation<double> _slot(int index) {
    final start = (index / _sections.length * 0.7).clamp(0.0, 0.85);
    final end = (start + 0.35).clamp(0.15, 1.0);
    return CurvedAnimation(parent: _entrance, curve: Interval(start, end, curve: Curves.easeOutCubic));
  }

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
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: _sections.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final section = _sections[index];
          final animation = _slot(index);
          return AnimatedBuilder(
            animation: animation,
            builder: (context, child) {
              return Opacity(
                opacity: animation.value.clamp(0.0, 1.0),
                child: Transform.translate(
                  offset: Offset(0, (1 - animation.value) * 14),
                  child: child,
                ),
              );
            },
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: AppColors.border),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(color: AppColors.ink.withValues(alpha: 0.08), shape: BoxShape.circle),
                        alignment: Alignment.center,
                        child: Icon(section.icon, size: 18, color: AppColors.ink),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          section.title,
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    section.body,
                    style: const TextStyle(color: AppColors.textSecondary, height: 1.5),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _AboutSection {
  const _AboutSection({required this.icon, required this.title, required this.body});
  final IconData icon;
  final String title;
  final String body;
}