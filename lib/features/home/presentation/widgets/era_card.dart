import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/models/era.dart';
import '../../../../shared/models/home_progress.dart';
import '../../../../shared/widgets/pressable_scale.dart';

/// Kartu progress per era (Kolonial/Kemerdekaan/Modern).
///
/// CATATAN: home_screen.dart TIDAK memakai widget ini (tidak di-import).
/// Kalau juga tidak dipakai di layar lain, hapus file ini.
///
/// REVISI (design review):
/// - Bar progress: warna Sky (Modern) hampir sama terangnya dengan track
///   (~1.3:1) sehingga bar-nya nyaris tak terlihat. Fill sekarang
///   digelapkan (`_barColor`) supaya >= 3:1 terhadap track untuk ketiga era.
/// - "tahun dibaca" -> "tahun tuntas" (completed butuh kuis lulus, R-PROG-07).
/// - Animasi bar hormati reduce-motion; Semantics satu tombol.
class EraCard extends StatelessWidget {
  const EraCard({
    super.key,
    required this.era,
    required this.progress, // null = guest, atau belum ada data
    required this.onTap,
  });

  final Era era;
  final EraProgress? progress;
  final VoidCallback onTap;

  /// Aksen era digelapkan ke arah Ink untuk elemen grafis yang harus terbaca.
  static Color _barColor(Color accent) =>
      Color.lerp(accent, AppColors.ink, 0.45)!;

  @override
  Widget build(BuildContext context) {
    final accent = EraAccents.ofSlug(era.slug);
    final textTheme = Theme.of(context).textTheme;
    final reduceMotion = MediaQuery.disableAnimationsOf(context);

    final subtitle = progress != null
        ? '${progress!.completed}/${progress!.total} tahun tuntas'
        : 'Jelajahi sejarah masa ${era.name}';

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Semantics(
        button: true,
        onTap: onTap,
        label: '${era.name}. $subtitle',
        excludeSemantics: true,
        child: PressableScale(
          onTap: onTap,
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColors.border),
            ),
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  width: 46,
                  height: 46,
                  decoration: BoxDecoration(
                    color: accent.withValues(alpha: 0.14),
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: accent,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        era.name,
                        style: textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(height: 8),
                      if (progress != null) ...[
                        ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: TweenAnimationBuilder<double>(
                            tween:
                                Tween(begin: 0, end: progress!.progressRatio),
                            duration: reduceMotion
                                ? Duration.zero
                                : const Duration(milliseconds: 700),
                            curve: Curves.easeOutCubic,
                            builder: (context, value, _) {
                              return LinearProgressIndicator(
                                value: value,
                                minHeight: 8,
                                backgroundColor: AppColors.border,
                                valueColor:
                                    AlwaysStoppedAnimation(_barColor(accent)),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 6),
                      ],
                      Text(
                        subtitle,
                        style: textTheme.bodyMedium
                            ?.copyWith(color: AppColors.textSecondary),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 4),
                const Icon(
                  Icons.chevron_right_rounded,
                  color: AppColors.textSecondary,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}