import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

/// Design.md §3.2 (mockup Home terbaru): card "Progress Belajarmu" —
/// ring progress custom, menampilkan total tahun yang sudah dibaca dari
/// SELURUH era (gabungan `progressByEra`), beda dengan `EraCard` yang
/// per-era.
///
/// REDESIGN: ring sekarang mengisi dengan animasi (0 -> nilai asli) tiap
/// kali widget ini pertama tampil atau [completed]/[total] berubah
/// (mis. setelah pull-to-refresh), pakai `TweenAnimationBuilder` — tidak
/// perlu AnimationController manual karena tidak ada state lain yang
/// perlu disimpan. Ring track & warna tetap sama, ukuran sedikit
/// diperkecil (200) supaya proporsinya lebih pas di kartu yang kini juga
/// punya bayangan lembut.
class OverallProgressCard extends StatelessWidget {
  const OverallProgressCard({
    super.key,
    required this.completed,
    required this.total,
  });

  final int completed;
  final int total;

  double get _ratio => total == 0 ? 0 : (completed / total).clamp(0, 1);

  @override
  Widget build(BuildContext context) {
    const ringSize = 200.0;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: AppColors.border),
        boxShadow: [
          BoxShadow(
            color: AppColors.ink.withValues(alpha: 0.04),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          SizedBox(
            width: ringSize,
            height: ringSize,
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: ringSize,
                  height: ringSize,
                  child: const CircularProgressIndicator(
                    value: 1,
                    strokeWidth: 16,
                    strokeCap: StrokeCap.round,
                    valueColor: AlwaysStoppedAnimation(AppColors.border),
                  ),
                ),
                SizedBox(
                  width: ringSize,
                  height: ringSize,
                  child: TweenAnimationBuilder<double>(
                    tween: Tween(begin: 0, end: _ratio),
                    duration: const Duration(milliseconds: 900),
                    curve: Curves.easeOutCubic,
                    builder: (context, value, _) {
                      return CircularProgressIndicator(
                        value: value,
                        strokeWidth: 16,
                        strokeCap: StrokeCap.round,
                        backgroundColor: Colors.transparent,
                        valueColor:
                            const AlwaysStoppedAnimation(AppColors.ink),
                      );
                    },
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Progress Keseluruhan',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppColors.textSecondary,
                          ),
                    ),
                    const SizedBox(height: 4),
                    TweenAnimationBuilder<int>(
                      tween: IntTween(begin: 0, end: completed),
                      duration: const Duration(milliseconds: 900),
                      curve: Curves.easeOutCubic,
                      builder: (context, value, _) {
                        return RichText(
                          text: TextSpan(
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium
                                ?.copyWith(
                                  color: AppColors.ink,
                                  fontWeight: FontWeight.bold,
                                ),
                            children: [
                              TextSpan(text: '$value'),
                              TextSpan(
                                text: '/$total',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(
                                      color: AppColors.textSecondary,
                                      fontWeight: FontWeight.normal,
                                    ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'tahun telah dibaca',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppColors.textSecondary,
                          ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Rincian per periode ada di halaman\nInformasi Sejarah',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.textSecondary,
                ),
          ),
        ],
      ),
    );
  }
}