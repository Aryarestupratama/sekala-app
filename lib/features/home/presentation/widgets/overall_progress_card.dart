import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

/// Design.md §3.2 (mockup Home terbaru): card "Progress Belajarmu" —
/// ring progress custom (bukan `CircularProgressIndicator` bawaan biar
/// bisa atur besar stroke, warna track, dan teks di tengah persis
/// mockup), menampilkan total tahun yang sudah dibaca dari SELURUH era
/// (gabungan `progressByEra`), beda dengan `EraCard` yang per-era.
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
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          SizedBox(
            width: 220,
            height: 220,
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 220,
                  height: 220,
                  child: CircularProgressIndicator(
                    value: 1,
                    strokeWidth: 16,
                    strokeCap: StrokeCap.round,
                    valueColor: const AlwaysStoppedAnimation(AppColors.border),
                  ),
                ),
                SizedBox(
                  width: 220,
                  height: 220,
                  child: CircularProgressIndicator(
                    value: _ratio,
                    strokeWidth: 16,
                    strokeCap: StrokeCap.round,
                    backgroundColor: Colors.transparent,
                    valueColor: const AlwaysStoppedAnimation(AppColors.ink),
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
                    RichText(
                      text: TextSpan(
                        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                              color: AppColors.ink,
                              fontWeight: FontWeight.bold,
                            ),
                        children: [
                          TextSpan(text: '$completed'),
                          TextSpan(
                            text: '/$total',
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                  color: AppColors.textSecondary,
                                  fontWeight: FontWeight.normal,
                                ),
                          ),
                        ],
                      ),
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