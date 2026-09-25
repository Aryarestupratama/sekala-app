import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/models/home_progress.dart';
import '../../../../shared/widgets/pressable_scale.dart';

/// Design.md §3.2 "Lanjutkan membaca" (mockup Home terbaru). HomeController::
/// recommendation() ngasih 2 tipe berbeda (lihat komentar di HomeRecommendation
/// model):
/// - next_year: ada tahun spesifik, R-PROG-04
/// - switch_era: cuma saran pindah era, R-PROG-05 (fallback)
///
/// CATATAN: dua-duanya nggak ngasih sectionId, jadi onTap cuma bisa
/// arahin ke roadmap era terkait, bukan langsung buka section.
///
/// [eraProgress] opsional — dipakai buat nampilin label "KOLONIAL • 3 DARI
/// 12 TAHUN DIBACA". Kalau null, fallback ke label tanpa angka.
///
/// REDESIGN: warna solid diganti gradasi diagonal dari warna era yang
/// sama (lebih dalam di kanan-bawah) supaya terasa lebih premium, dan
/// panah dibungkus [PressableScale] agar seluruh kartu terasa interaktif.
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

    return PressableScale(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [accent, Color.lerp(accent, Colors.black, 0.28)!],
          ),
          boxShadow: [
            BoxShadow(
              color: accent.withValues(alpha: 0.30),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
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
                          color: Colors.white.withValues(alpha: 0.85),
                          fontWeight: FontWeight.w700,
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
            Container(
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.22),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.arrow_forward_rounded,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}