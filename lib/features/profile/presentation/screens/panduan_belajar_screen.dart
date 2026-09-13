import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

/// Teks statis (hardcode) sesuai keputusan: cukup teks biasa, tidak perlu
/// dikelola lewat CMS/Admin Panel. Kalau nanti isinya sering berubah dan
/// perlu diedit tanpa release app baru, baru pertimbangkan pindah ke pola
/// singleton CMS seperti `wabah_intro` dulu.
class PanduanBelajarScreen extends StatelessWidget {
  const PanduanBelajarScreen({super.key});

  static const _sections = <_GuideSection>[
    _GuideSection(
      title: 'Alur Belajar per Tahun',
      body:
          'Setiap tahun wabah berisi beberapa bagian bacaan yang harus dibaca '
          'berurutan. Bagian berikutnya baru terbuka setelah kamu selesai '
          'membaca bagian sebelumnya sampai tuntas.',
    ),
    _GuideSection(
      title: 'Rangkuman & Kuis',
      body:
          'Setelah seluruh bagian dalam satu tahun selesai dibaca, kamu akan '
          'melihat rangkuman singkat, lalu mengerjakan kuis pilihan ganda '
          'terkait. Kuis ini wajib dikerjakan untuk menandai tahun tersebut '
          'selesai — tidak ada nilai atau status lulus/tidak lulus, jadi '
          'tidak perlu khawatir salah menjawab.',
    ),
    _GuideSection(
      title: 'Koleksi Vaksin',
      body:
          'Beberapa tahun memiliki vaksin terkait. Begitu tahun tersebut '
          'dinyatakan selesai (semua bagian + kuis), vaksin terkait akan '
          'otomatis terbuka di tab Koleksi.',
    ),
    _GuideSection(
      title: 'Kuis Sumatif Era',
      body:
          'Setelah menyelesaikan seluruh tahun dalam satu era (Kolonial, '
          'Kemerdekaan, atau Modern), kuis sumatif akan muncul di akhir '
          'roadmap. Berbeda dari kuis per-tahun, kuis ini punya skor akhir '
          'dan bisa dikerjakan ulang kapan saja.',
    ),
    _GuideSection(
      title: 'Mode Tamu',
      body:
          'Sebagai tamu, kamu tetap bisa membaca bagian pertama tiap tahun, '
          'tapi progres, kuis, dan koleksi vaksin hanya tersimpan untuk '
          'pengguna yang login. Daftar akun kapan saja untuk mulai menyimpan '
          'progresmu.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Panduan Belajar')),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: _sections.length,
        separatorBuilder: (_, __) => const SizedBox(height: 20),
        itemBuilder: (context, index) {
          final section = _sections[index];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                section.title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 6),
              Text(
                section.body,
                style: const TextStyle(color: AppColors.textSecondary, height: 1.5),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _GuideSection {
  const _GuideSection({required this.title, required this.body});
  final String title;
  final String body;
}