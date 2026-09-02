import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../shared/models/year.dart';
import '../providers/history_providers.dart';

/// Halaman Rangkuman Wabah — muncul setelah SELURUH section dalam satu
/// `year` completed (Design.md §3.3 poin 4, INFO-04). Menampilkan
/// `years.summary` lalu CTA "Kerjakan Kuis" ke halaman Kuis (INFO-05).
///
/// SENGAJA tidak fetch endpoint baru — `Year.summary` sudah ikut di
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

  bool get _hasSummary => year.summary != null && year.summary!.trim().isNotEmpty;

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
        if (_hasSummary)
          Text(
            year.summary!,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(height: 1.5),
          )
        else
          const Text(
            'Rangkuman untuk wabah ini belum tersedia.',
            style: TextStyle(color: AppColors.textSecondary),
          ),
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