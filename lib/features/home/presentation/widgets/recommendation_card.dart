import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/models/home_progress.dart';

/// Design.md §3.2 "Lanjutkan membaca" (mockup Home terbaru). HomeController::
/// recommendation() ngasih 2 tipe berbeda (lihat komentar di HomeRecommendation
/// model):
/// - next_year: ada tahun spesifik, R-PROG-04
/// - switch_era: cuma saran pindah era, R-PROG-05 (fallback)
///
/// CATATAN: dua-duanya nggak ngasih sectionId, jadi onTap cuma bisa
/// arahin ke roadmap era terkait (bukan langsung buka section) — sama
/// kayak keterbatasan Year->Section yang sudah dibahas sebelumnya.
///
/// [eraProgress] opsional — dipakai buat nampilin label "KOLONIAL • 3 DARI
/// 12 TAHUN DIBACA" sesuai mockup. Kalau null (mis. belum ada data progress
/// buat era tsb), fallback ke label tanpa angka.
class RecommendationCard extends StatelessWidget {
  const RecommendationCard({
    super.key,
    required this.recommendation,
    required this.onTap,
    this.eraProgress,
  });

  final HomeRecommendation recommendation;
  final VoidCallback onTap;
  final EraProgress? eraProgress;

  @override
  Widget build(BuildContext context) {
    final isNextYear = recommendation.isNextYear;
    final year = recommendation.year;
    final accent = EraAccents.ofSlug(recommendation.era.slug);

    final title = isNextYear && year != null
        ? '${year.year} — ${year.title}'
        : recommendation.era.name;

    final eraLabel = recommendation.era.name.toUpperCase();
    final progressLabel = eraProgress != null
        ? '$eraLabel • ${eraProgress!.completed} DARI ${eraProgress!.total} TAHUN DIBACA'
        : (isNextYear ? eraLabel : 'COBA MASA LAIN');

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: accent,
        borderRadius: BorderRadius.circular(20),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      progressLabel,
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.5,
                          ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              CircleAvatar(
                backgroundColor: Colors.white.withValues(alpha: 0.25),
                child: const Icon(Icons.arrow_forward, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}