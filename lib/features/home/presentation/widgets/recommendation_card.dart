import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/models/home_progress.dart';
import '../../../../shared/widgets/pressable_scale.dart';

/// Design.md §3.2 "Langkah Berikutnya" (dulu "Lanjutkan Membaca").
/// HomeController::recommendation() ngasih 2 tipe berbeda:
/// - next_year: ada tahun spesifik, R-PROG-04
/// - switch_era: cuma saran pindah era, R-PROG-05 (fallback)
///
/// CATATAN: dua-duanya nggak ngasih sectionId, jadi onTap cuma bisa
/// arahin ke roadmap era terkait, bukan langsung buka section. Ini satu
/// tap ekstra di aksi yang paling sering dipakai user — usul: backend
/// kirim `section_id` + posisi section (mis. "Materi 3 dari 9").
///
/// REVISI (design review):
/// - KONTRAS: teks putih di atas warna era gagal AA (dihitung dari hex:
///   Modern/Sky ~1.6:1, Kolonial/Orange ~2.0:1, Kemerdekaan/Green ~2.9:1;
///   butuh 4.5:1). Sekarang teks Ink (Sky ~12:1, Orange ~10:1, Green ~6.6:1)
///   dan tombol panah Ink dengan ikon putih.
/// - Label kecil huruf kapital semua 12sp diganti kalimat biasa 13sp.
/// - "tahun dibaca" -> "tahun tuntas": "completed" butuh kuis lulus
///   (R-PROG-07), bukan cuma dibaca, jadi copy lama menyesatkan.
/// - Semantics: satu tombol dengan label lengkap untuk screen reader.
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
    final textTheme = Theme.of(context).textTheme;

    final title = isNextYear && year != null
        ? '${year.year} — ${year.title}'
        : recommendation.era.name;

    final eraName = recommendation.era.name;
    final progressLabel = eraProgress != null
        ? '$eraName · ${eraProgress!.completed} dari ${eraProgress!.total} tahun tuntas'
        : (isNextYear ? eraName : 'Coba masa lain');

    return Semantics(
      button: true,
      onTap: onTap,
      label: '$progressLabel. $title',
      excludeSemantics: true,
      child: PressableScale(
        onTap: onTap,
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              // Gradasi ke arah lebih terang supaya teks Ink tetap kontras.
              colors: [accent, Color.lerp(accent, Colors.white, 0.2)!],
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
                      style: textTheme.bodyMedium?.copyWith(
                        fontSize: 13,
                        color: AppColors.ink.withValues(alpha: 0.8),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: textTheme.titleLarge?.copyWith(
                        color: AppColors.ink,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Container(
                width: 48,
                height: 48,
                decoration: const BoxDecoration(
                  color: AppColors.ink,
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
      ),
    );
  }
}