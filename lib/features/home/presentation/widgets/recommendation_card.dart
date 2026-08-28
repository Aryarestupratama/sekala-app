import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/models/home_progress.dart';

/// Design.md §3.2 "Lanjutkan membaca". HomeController::recommendation()
/// ngasih 2 tipe berbeda (lihat komentar di HomeRecommendation model):
/// - next_year: ada tahun spesifik, R-PROG-04
/// - switch_era: cuma saran pindah era, R-PROG-05 (fallback)
///
/// CATATAN: dua-duanya nggak ngasih sectionId, jadi onTap cuma bisa
/// arahin ke roadmap era terkait (bukan langsung buka section) — sama
/// kayak keterbatasan Year->Section yang sudah dibahas sebelumnya.
class RecommendationCard extends StatelessWidget {
  const RecommendationCard({
    super.key,
    required this.recommendation,
    required this.onTap,
  });

  final HomeRecommendation recommendation;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final isNextYear = recommendation.isNextYear;
    final year = recommendation.year;

    final icon = isNextYear ? Icons.auto_stories : Icons.explore_outlined;
    final label = isNextYear ? 'Lanjutkan membaca' : 'Coba masa lain';
    final title = isNextYear && year != null
        ? '${year.year} — ${year.title}'
        : recommendation.era.name;

    return Card(
      color: AppColors.warning.withValues(alpha: 0.1),
      margin: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Icon(icon, color: AppColors.warning),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(label, style: Theme.of(context).textTheme.labelMedium),
                    const SizedBox(height: 2),
                    Text(title, style: Theme.of(context).textTheme.titleMedium),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right),
            ],
          ),
        ),
      ),
    );
  }
}
