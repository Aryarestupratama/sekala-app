import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

/// Satu baris opsi jawaban (ERAQUIZ-02) — tampilan mengikuti mockup
/// "Kuis Sumatif" (radio button + label, border & background berubah
/// warna accent saat terpilih). TIDAK ada state benar/salah di sini sama
/// sekali (beda dari kuis year) — kuis sumatif era baru mengungkap
/// benar/salah di halaman Rekap SETELAH submit, bukan saat memilih.
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
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: selected ? accent.withOpacity(0.10) : Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: selected ? accent : AppColors.border,
            width: selected ? 1.6 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
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
                  fontSize: 13.5,
                  fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
                  color: AppColors.ink,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}