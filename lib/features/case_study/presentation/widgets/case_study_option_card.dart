import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import 'case_study_common.dart';

/// 1 kartu opsi (A–E) di Ruang Keputusan langkah 1.
///
/// Semua kartu tampil SETARA — tidak ada penanda benar/salah/pengecoh
/// (R-CASE-09, backend memang tidak mengirim `correct_rank`). Satu-satunya
/// perbedaan tampilan adalah status pilihan user:
/// - [priority] != null -> sudah dipilih: border ink + badge nomor orange.
/// - [dimmed] true -> semua slot sudah terisi dan kartu ini belum dipilih:
///   diredupkan (sinyal "lepas salah satu dulu"), tap dinonaktifkan lewat
///   [onTap] null dari pemanggil.
class CaseStudyOptionCard extends StatelessWidget {
  const CaseStudyOptionCard({
    super.key,
    required this.letter,
    required this.title,
    required this.description,
    required this.onTap,
    required this.accent,
    this.priority,
    this.dimmed = false,
  });

  final String letter;
  final String title;
  final String description;
  final VoidCallback? onTap;

  /// Warna era — dipakai badge nomor prioritas saat kartu ini dipilih.
  final Color accent;

  /// 1..3 kalau sudah ditaruh di slot prioritas, null kalau belum.
  final int? priority;
  final bool dimmed;

  @override
  Widget build(BuildContext context) {
    final selected = priority != null;

    return Semantics(
      button: true,
      selected: selected,
      hint: selected
          ? 'Prioritas $priority. Ketuk untuk melepas'
          : dimmed
              ? 'Semua prioritas sudah terisi. Lepas salah satu dulu'
              : 'Ketuk untuk memilih',
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 180),
        // 0.72 (bukan 0.5): user masih perlu membaca opsi ini untuk
        // membandingkan sebelum menukar prioritas.
        opacity: dimmed ? 0.72 : 1,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(14),
            // Lebar border konstan supaya kartu tidak "loncat" 0.5px
            // saat berpindah status.
            border: Border.all(
              color: selected ? AppColors.ink : AppColors.border,
              width: 1.5,
            ),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(14),
              onTap: onTap,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 32,
                      height: 32,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        color: AppColors.ink,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        letter,
                        style: AppTextStyles.button.copyWith(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: AppTextStyles.body.copyWith(
                              color: AppColors.ink,
                              fontSize: 14.5,
                              fontWeight: FontWeight.w700,
                              height: 1.3,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            description,
                            style: AppTextStyles.body.copyWith(
                              fontSize: 14,
                              height: 1.45,
                              color: AppColors.ink.withValues(alpha: 0.85),
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (selected) ...[
                      const SizedBox(width: 8),
                      _PriorityBadge(number: priority!, accent: accent),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _PriorityBadge extends StatelessWidget {
  const _PriorityBadge({required this.number, required this.accent});

  final int number;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    final onAccent = caseStudyOnColor(accent);
    return Container(
      width: 26,
      height: 26,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: accent,
        shape: BoxShape.circle,
      ),
      child: Text(
        '$number',
        style: AppTextStyles.caption.copyWith(
          color: onAccent,
          fontSize: 13,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}