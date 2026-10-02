import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

/// Design.md §3.2 — card "Progress Belajarmu": total tahun yang TUNTAS dari
/// SELURUH era (gabungan `progressByEra`).
///
/// REVISI (design review):
/// - Ring 200dp di tengah kartu (~300dp tinggi total, separuh layar 640dp
///   untuk satu angka) diganti layout horizontal: ring 92dp + teks. Tombol
///   "Jelajahi" di bawahnya tidak lagi terdorong keluar layar.
/// - "tahun dibaca" -> "tahun tuntas": "completed" mensyaratkan kuis lulus
///   (R-PROG-07). Copy lama membuat user yang sudah baca 1 tahun penuh
///   tapi belum lulus kuis melihat "0" dan bingung.
/// - State 0 tuntas: bukan cuma "0/22", tapi kalimat yang menjelaskan apa
///   yang membuka progres berikutnya (kartu vaksin & badge).
/// - Animasi mengisi hormati "reduce motion". Semantics: satu label.
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
    const ringSize = 92.0;
    const stroke = 10.0;

    final textTheme = Theme.of(context).textTheme;
    final reduceMotion = MediaQuery.disableAnimationsOf(context);
    final duration =
        reduceMotion ? Duration.zero : const Duration(milliseconds: 900);
    final percent = (_ratio * 100).round();

    final hint = completed == 0
        ? 'Tuntaskan satu tahun untuk mulai mengumpulkan kartu vaksin dan badge.'
        : 'Tuntas = semua materi dibaca dan kuis lulus.';

    return Semantics(
      container: true,
      label: 'Progress belajar: $completed dari $total tahun tuntas. $hint',
      excludeSemantics: true,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
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
        child: Row(
          children: [
            SizedBox(
              width: ringSize,
              height: ringSize,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  const SizedBox.expand(
                    child: CircularProgressIndicator(
                      value: 1,
                      strokeWidth: stroke,
                      strokeCap: StrokeCap.round,
                      valueColor: AlwaysStoppedAnimation(AppColors.border),
                    ),
                  ),
                  SizedBox.expand(
                    child: TweenAnimationBuilder<double>(
                      tween: Tween(begin: 0, end: _ratio),
                      duration: duration,
                      curve: Curves.easeOutCubic,
                      builder: (context, value, _) {
                        return CircularProgressIndicator(
                          value: value,
                          strokeWidth: stroke,
                          strokeCap: StrokeCap.round,
                          backgroundColor: Colors.transparent,
                          valueColor:
                              const AlwaysStoppedAnimation(AppColors.ink),
                        );
                      },
                    ),
                  ),
                  Text(
                    '$percent%',
                    style: textTheme.titleMedium?.copyWith(
                      color: AppColors.ink,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$completed dari $total tahun tuntas',
                    style: textTheme.titleMedium?.copyWith(
                      color: AppColors.ink,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    hint,
                    style: textTheme.bodyMedium?.copyWith(
                      color: AppColors.textSecondary,
                      height: 1.35,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}