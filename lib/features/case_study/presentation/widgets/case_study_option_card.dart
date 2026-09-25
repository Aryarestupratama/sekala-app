import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

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
    this.priority,
    this.dimmed = false,
  });

  final String letter;
  final String title;
  final String description;
  final VoidCallback? onTap;

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
          : 'Ketuk untuk memilih',
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 180),
        opacity: dimmed ? 0.5 : 1,
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
                            title.toUpperCase(),
                            style: AppTextStyles.caption.copyWith(
                              color: AppColors.ink,
                              fontSize: 11.5,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 1.1,
                              height: 1.35,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            description,
                            style: AppTextStyles.body.copyWith(
                              fontSize: 13,
                              height: 1.45,
                              color: AppColors.ink.withValues(alpha: 0.8),
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (selected) ...[
                      const SizedBox(width: 8),
                      _PriorityBadge(number: priority!),
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
  const _PriorityBadge({required this.number});

  final int number;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 24,
      height: 24,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        color: AppColors.warning,
        shape: BoxShape.circle,
      ),
      child: Text(
        '$number',
        style: AppTextStyles.caption.copyWith(
          color: AppColors.ink,
          fontSize: 12,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}