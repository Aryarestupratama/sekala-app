import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../widgets/info_section_list.dart';

/// Teks statis (hardcode) sesuai keputusan: cukup teks biasa, tidak perlu
/// dikelola lewat CMS/Admin Panel. Kalau nanti isinya sering berubah dan
/// perlu diedit tanpa release app baru, baru pertimbangkan pindah ke pola
/// singleton CMS seperti `wabah_intro` dulu.
///
/// REVISI ISI (mohon ditinjau tim konten) — panduan lama sudah tidak sesuai
/// dengan aplikasi:
/// - "Koleksi Card ... menuntaskan setiap materi": vaksin terbuka saat TAHUN
///   tuntas (lulus kuis tahun), bukan tiap materi; menu bernama Koleksi
///   Vaksin, bukan "Koleksi Card"/"Filter Koleksi".
/// - "Roadmap Sumatif" / "Rekap Jawaban Sumatif": di aplikasi tombolnya
///   node Kuis Sumatif di ujung roadmap era dan "Lihat Rekapan".
/// - "Kerjakan kuis formatif setelah satu materi": kuis tahun dikerjakan
///   setelah semua materi + Rangkuman Interaktif.
/// - Studi Kasus, Rangkuman Interaktif, Badge, dan Border SEKALA belum
///   disebut sama sekali.
class PanduanBelajarScreen extends StatelessWidget {
  const PanduanBelajarScreen({super.key});

  static const _sections = <InfoSection>[
    InfoSection(
      icon: Icons.route_outlined,
      title: 'Urutan Belajar',
      body:
          'Mulai perjalanan dari era paling awal hingga era modern secara '
          'bertahap.\n\n'
          '• Sebaiknya ikuti urutan era: kolonial, kemerdekaan, lalu '
          'modern. Selesaikan satu era sebelum lanjut ke era berikutnya.\n'
          '• Di dalam satu era, tahun terbuka berurutan: tahun berikutnya '
          'terbuka setelah tahun sebelumnya tuntas.\n'
          '• Telusuri roadmap era untuk melihat gambaran urutan peristiwa '
          'sebelum masuk ke materi.',
    ),
    InfoSection(
      icon: Icons.menu_book_outlined,
      title: 'Membaca Materi',
      body:
          'Pahami setiap wabah secara runtut dan manfaatkan media pendukung '
          'untuk memperkuat pemahaman.\n\n'
          '• Ikuti alur materi mulai dari identitas penyakit, awal '
          'kemunculan, karakteristik, dampak, hingga respons pemerintah.\n'
          '• Amati gambar dan video untuk membantu memvisualisasikan '
          'peristiwa sejarah yang dibahas.\n'
          '• Geser tombol di bagian bawah layar untuk lanjut ke materi '
          'berikutnya. Progresmu hanya tersimpan kalau kamu sudah login '
          'dan email-mu terverifikasi.',
    ),
    InfoSection(
      icon: Icons.psychology_alt_outlined,
      title: 'Studi Kasus',
      body:
          'Latih cara berpikir sebagai pengambil keputusan penanganan '
          'wabah.\n\n'
          '• Baca briefing kasus, lalu susun tiga prioritas penanganan '
          'dari opsi yang tersedia.\n'
          '• Urutan harus tepat agar berhasil. Kamu boleh mencoba lagi '
          'sebanyak yang kamu mau.\n'
          '• Tuliskan alasan pilihanmu. Itu bagian dari proses belajar.\n'
          '• Berhasil? Kamu mendapat badge untuk wabah tersebut.',
    ),
    InfoSection(
      icon: Icons.quiz_outlined,
      title: 'Rangkuman dan Kuis',
      body:
          'Uji pemahaman setelah semua materi satu tahun selesai, lalu '
          'tutup satu era dengan kuis sumatif.\n\n'
          '• Kerjakan Rangkuman Interaktif: pilih kalimat yang benar di '
          'setiap poin dan perhatikan penjelasannya, lalu baca rangkuman '
          'lengkapnya.\n'
          '• Lanjut ke kuis tahun. Kamu lulus dengan nilai 75% ke atas '
          'dan boleh mengulang kapan saja. Tahun dinyatakan tuntas setelah '
          'kuis lulus.\n'
          '• Setelah semua tahun dalam satu era tuntas, kerjakan Kuis '
          'Sumatif Era di ujung roadmap untuk menguji pemahaman secara '
          'menyeluruh.\n'
          '• Lihat pembahasan lengkap lewat tombol Lihat Rekapan di '
          'halaman hasil.',
    ),
    InfoSection(
      icon: Icons.style_outlined,
      title: 'Koleksi',
      body:
          'Kumpulkan vaksin dan badge selama perjalanan belajarmu.\n\n'
          '• Vaksin terbuka otomatis begitu tahun terkait tuntas (lulus '
          'kuisnya). Lihat semuanya di tab Koleksi dan saring berdasarkan '
          'status atau era.\n'
          '• Badge didapat dari menyelesaikan studi kasus dengan benar. '
          'Lihat di Profil, menu Koleksi Badge.\n'
          '• Kumpulkan semua badge untuk membuka Border SEKALA, lalu pasang '
          'di foto profilmu lewat menu Profil.',
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
        title: const Text('Panduan Belajar', style: TextStyle(fontWeight: FontWeight.w800)),
      ),
      body: const InfoSectionList(sections: _sections),
    );
  }
}