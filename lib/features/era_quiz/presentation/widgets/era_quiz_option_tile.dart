import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/pressable_scale.dart';

/// Satu baris opsi jawaban (ERAQUIZ-02) — radio button + label, border &
/// background berubah warna accent saat terpilih. TIDAK ada state
/// benar/salah di sini sama sekali (beda dari kuis year) — kuis sumatif
/// era baru mengungkap benar/salah di halaman Rekap SETELAH submit.
///
/// REDESIGN: `GestureDetector` -> [PressableScale] (konsisten dengan
/// tap-feedback di kartu lain se-app), `withOpacity` -> `withValues`,
/// ukuran font disamakan dengan skala di layar induk (14, bukan 13.5).
class EraQuizOptionTile extends StatelessWidget {
  const EraQuizOptionTile({
    super.key,
    required this.label,
    required this.selected,
    required this.accent,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final Color accent;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: PressableScale(
        scale: 0.99,
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 160),
          curve: Curves.easeOut,
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
          decoration: BoxDecoration(
            color: selected ? accent.withValues(alpha: 0.10) : Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: selected ? accent : AppColors.border,
              width: selected ? 1.6 : 1,
            ),
          ),
          child: Row(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 160),
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: selected ? accent : Colors.white,
                  border: Border.all(color: selected ? accent : AppColors.border, width: 1.6),
                ),
                alignment: Alignment.center,
                child: selected
                    ? const Icon(Icons.circle, size: 8, color: Colors.white)
                    : null,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
                    color: AppColors.ink,
                    height: 1.3,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}