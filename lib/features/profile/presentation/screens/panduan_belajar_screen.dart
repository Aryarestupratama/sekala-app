import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

/// Teks statis (hardcode) sesuai keputusan: cukup teks biasa, tidak perlu
/// dikelola lewat CMS/Admin Panel. Kalau nanti isinya sering berubah dan
/// perlu diedit tanpa release app baru, baru pertimbangkan pindah ke pola
/// singleton CMS seperti `wabah_intro` dulu.
///
/// REDESIGN: sama pola dengan `AboutSekalaScreen` — tiap section jadi kartu
/// dengan ikon dan muncul fade-up bertahap. Isi teks TIDAK berubah.
class PanduanBelajarScreen extends StatefulWidget {
  const PanduanBelajarScreen({super.key});

  @override
  State<PanduanBelajarScreen> createState() => _PanduanBelajarScreenState();
}

class _PanduanBelajarScreenState extends State<PanduanBelajarScreen> with SingleTickerProviderStateMixin {
  static const _sections = <_GuideSection>[
    _GuideSection(
      icon: Icons.route_outlined,
      title: 'Urutan Belajar',
      body:
          'Mulai perjalanan dari era paling awal hingga era modern secara '
          'bertahap.\n\n'
          '• Ikuti urutan era dengan mempelajari materi mulai dari era '
          'kolonial, kemerdekaan, hingga modern. Selesaikan satu era '
          'terlebih dahulu sebelum melanjutkan ke era berikutnya.\n'
          '• Telusuri timeline melalui Perjalanan Era untuk melihat '
          'gambaran umum urutan peristiwa sebelum masuk ke materi.',
    ),
    _GuideSection(
      icon: Icons.menu_book_outlined,
      title: 'Membaca Materi',
      body:
          'Pahami setiap wabah secara runtut dan manfaatkan media pendukung '
          'untuk memperkuat pemahaman.\n\n'
          '• Ikuti alur materi mulai dari identitas penyakit, awal '
          'kemunculan, karakteristik, dampak, hingga respons pemerintah.\n'
          '• Amati media berupa gambar dan video untuk membantu '
          'memvisualisasikan peristiwa sejarah yang dibahas.\n'
          '• Cek ringkasan di akhir materi untuk mengingat kembali '
          'poin-poin penting sebelum melanjutkan ke kuis.',
    ),
    _GuideSection(
      icon: Icons.quiz_outlined,
      title: 'Mengerjakan Kuis',
      body:
          'Uji pemahaman setelah mempelajari setiap materi dan '
          'menyelesaikan satu era.\n\n'
          '• Kerjakan kuis formatif setelah satu materi selesai untuk '
          'mengukur pemahaman dan perhatikan feedback pada setiap '
          'jawaban.\n'
          '• Baca kasus dengan saksama dan hubungkan informasi dari '
          'beberapa bagian materi sebelum menentukan jawaban.\n'
          '• Kerjakan kuis sumatif setelah seluruh materi dalam satu era '
          'selesai melalui Roadmap Sumatif untuk menguji pemahaman secara '
          'menyeluruh.\n'
          '• Cek hasil melalui Rekap Jawaban Sumatif untuk melihat kembali '
          'jawaban dan hasil belajar.',
    ),
    _GuideSection(
      icon: Icons.style_outlined,
      title: 'Koleksi Card',
      body:
          'Kumpulkan dan lengkapi kartu selama perjalanan belajar di '
          'setiap era.\n\n'
          '• Kumpulkan card dengan menuntaskan setiap materi untuk '
          'mendapatkan collectible card berisi informasi vaksin terkait '
          'wabah tersebut.\n'
          '• Lihat koleksi melalui menu Koleksi Card untuk melihat '
          'seluruh kartu yang telah dikumpulkan.\n'
          '• Gunakan filter pada Filter Koleksi untuk mengelompokkan '
          'kartu berdasarkan era.',
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
        title: const Text('Panduan Belajar', style: TextStyle(fontWeight: FontWeight.w800)),
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

class _GuideSection {
  const _GuideSection({required this.icon, required this.title, required this.body});
  final IconData icon;
  final String title;
  final String body;
}