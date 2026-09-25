import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/models/era.dart';
import '../../../../shared/models/home_progress.dart';
import '../../../../shared/widgets/pressable_scale.dart';

/// Design.md §3.2: kartu progress per era untuk user login (3 kartu:
/// Kolonial/Kemerdekaan/Modern), tanpa progress bar untuk guest — tapi
/// tetap tampil sebagai entry point navigasi (HOME-03).
///
/// REDESIGN: dari `Card` Material bawaan jadi kartu flat custom (rounded
/// besar, border tipis, tanpa elevation/shadow default) senada dengan
/// home_screen.dart. Progress bar diberi animasi mengisi dari 0 ke nilai
/// asli, dan seluruh kartu punya efek tekan (scale) lewat [PressableScale].
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

  @override
  Widget build(BuildContext context) {
    final accent = EraAccents.ofSlug(era.slug);
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
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
                          tween: Tween(begin: 0, end: progress!.progressRatio),
                          duration: const Duration(milliseconds: 700),
                          curve: Curves.easeOutCubic,
                          builder: (context, value, _) {
                            return LinearProgressIndicator(
                              value: value,
                              minHeight: 7,
                              backgroundColor: AppColors.border,
                              valueColor: AlwaysStoppedAnimation(accent),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        '${progress!.completed}/${progress!.total} tahun dibaca',
                        style: textTheme.bodySmall
                            ?.copyWith(color: AppColors.textSecondary),
                      ),
                    ] else
                      Text(
                        'Jelajahi sejarah masa ${era.name}',
                        style: textTheme.bodySmall
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
    );
  }
}