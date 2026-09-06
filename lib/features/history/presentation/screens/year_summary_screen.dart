import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../shared/models/year.dart';
import '../providers/history_providers.dart';

/// Halaman Rangkuman Wabah — muncul setelah SELURUH section dalam satu
/// `year` completed (Design.md §3.3 poin 4, INFO-04). Menampilkan
/// rangkuman (infografis) -> quote -> referensi, lalu CTA "Kerjakan Kuis"
/// ke halaman Kuis (INFO-05).
///
/// REVISI (Rangkuman jadi Infografis + Quote + Referensi, baru):
/// - `years.summary` (teks) sudah diganti `summary_image_url` (gambar) di
///   backend — layar ini sekarang render `Year.summaryImageUrl` sebagai
///   gambar, BUKAN lagi teks paragraf.
/// - +Quote (`Year.quoteText`) & +Referensi (`Year.references`, list),
///   tampil di halaman yang sama, urutan: rangkuman -> quote -> referensi
///   -> tombol Kerjakan Kuis (Design.md §3.3.4).
///
/// SENGAJA tidak fetch endpoint baru — field-field di atas sudah ikut di
/// response roadmap (`yearsProvider`), jadi cukup numpang cache lewat
/// `yearInEraProvider` (lihat history_providers.dart). `eraSlug` datang
/// dari query param `?era=` (di-set oleh pemanggil, mis.
/// SectionDetailScreen), karena route ini sengaja di top-level
/// (`/year/:yearId/summary`) tanpa perlu nested di bawah `/history/:eraSlug`.
///
/// CATATAN: halaman ini SENGAJA TIDAK menyinggung/reveal unlock vaksin —
/// reveal-nya ada terpisah setelah kuis selesai (lihat QuizScreen),
/// sesuai catatan desain di progress.md (prompt Stitch Rangkuman Wabah).
class YearSummaryScreen extends ConsumerWidget {
  const YearSummaryScreen({
    super.key,
    required this.yearId,
    required this.eraSlug,
  });

  final int yearId;
  final String eraSlug;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final yearAsync =
        ref.watch(yearInEraProvider((eraSlug: eraSlug, yearId: yearId)));
    final accent = EraAccents.ofSlug(eraSlug);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('Rangkuman')),
      body: yearAsync.when(
        data: (year) {
          if (year == null) {
            return const Center(child: Text('Data tahun tidak ditemukan.'));
          }
          return _SummaryBody(year: year, eraSlug: eraSlug, accent: accent);
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('Gagal memuat rangkuman: $error')),
      ),
    );
  }
}

class _SummaryBody extends StatelessWidget {
  const _SummaryBody({required this.year, required this.eraSlug, required this.accent});

  final Year year;
  final String eraSlug;
  final Color accent;

  bool get _hasSummaryImage =>
      year.summaryImageUrl != null && year.summaryImageUrl!.trim().isNotEmpty;

  bool get _hasQuote => year.quoteText != null && year.quoteText!.trim().isNotEmpty;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
      children: [
        Row(
          children: [
            Text(
              '${eraSlug[0].toUpperCase()}${eraSlug.substring(1)} · ${year.year}',
              style: TextStyle(color: accent, fontWeight: FontWeight.bold, fontSize: 13),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(year.title, style: Theme.of(context).textTheme.headlineMedium),
        const SizedBox(height: 20),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: AppColors.orange.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              const Icon(Icons.check_circle, color: AppColors.success, size: 20),
              const SizedBox(width: 10),
              const Expanded(
                child: Text(
                  'Semua bagian sudah kamu baca',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        // (Revisi) Rangkuman sekarang infografis (gambar), bukan teks.
        if (_hasSummaryImage)
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: CachedNetworkImage(
              imageUrl: year.summaryImageUrl!,
              fit: BoxFit.cover,
              width: double.infinity,
              placeholder: (context, url) => const AspectRatio(
                aspectRatio: 16 / 9,
                child: Center(child: CircularProgressIndicator()),
              ),
              errorWidget: (context, url, error) => const AspectRatio(
                aspectRatio: 16 / 9,
                child: Center(child: Icon(Icons.broken_image_outlined)),
              ),
            ),
          )
        else
          const Text(
            'Rangkuman untuk wabah ini belum tersedia.',
            style: TextStyle(color: AppColors.textSecondary),
          ),

        // (Baru) Quote — 1 teks kutipan per wabah, opsional.
        if (_hasQuote) ...[
          const SizedBox(height: 24),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.border),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.format_quote, color: accent, size: 20),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    year.quoteText!,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontStyle: FontStyle.italic,
                          height: 1.5,
                        ),
                  ),
                ),
              ],
            ),
          ),
        ],

        // (Baru) Referensi — list teks, tampil mirip daftar pustaka. Cuma
        // dirender kalau ada isinya (opsional, boleh kosong).
        if (year.references.isNotEmpty) ...[
          const SizedBox(height: 24),
          const Text(
            'REFERENSI',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: AppColors.textSecondary,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 8),
          for (var i = 0; i < year.references.length; i++)
            Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${i + 1}. ',
                    style: const TextStyle(color: AppColors.textSecondary, fontSize: 12),
                  ),
                  Expanded(
                    child: Text(
                      year.references[i],
                      style: const TextStyle(color: AppColors.textSecondary, fontSize: 12, height: 1.4),
                    ),
                  ),
                ],
              ),
            ),
        ],
        const SizedBox(height: 40),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.border),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'LANGKAH TERAKHIR',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textSecondary,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                'Kerjakan kuis singkat untuk menyelesaikan wabah ini.',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
              ),
              const SizedBox(height: 4),
              const Text(
                'Kuis ini tidak dinilai — jawaban benar/salah cuma buat bantu kamu belajar.',
                style: TextStyle(fontSize: 12, color: AppColors.textSecondary, fontStyle: FontStyle.italic),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.ink,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
                  ),
                  // R-QUIZ-03: kuis WAJIB dikerjakan (bukan opsional) —
                  // jangan ubah label/nada tombol ini jadi kesan
                  // "boleh dilewati".
                  onPressed: () => context.go(
                    '/year/${year.id}/quiz?era=$eraSlug&title=${Uri.encodeComponent(year.title)}',
                  ),
                  icon: const Icon(Icons.edit_note, size: 20),
                  label: const Text('Kerjakan Kuis', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}