import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/models/era_quiz_recap_item.dart';
import '../../../../shared/models/era_quiz_recap_option.dart';

/// Satu kartu soal di layar Rekap (ERAQUIZ-04). Logika highlight opsi
/// MENGIKUTI shape asli `EraQuizRecapItem` (dikonfirmasi ke
/// `UserEraQuizController::recap()`): opsi TIDAK membawa status
/// benar/salah masing-masing — dibandingkan manual di widget ini
/// terhadap `item.correctOptionId`/`item.selectedOptionId`:
/// - opsi == correctOptionId & == selectedOptionId -> hijau, tag "JAWABANMU"
/// - opsi == correctOptionId & != selectedOptionId -> hijau, tag "KUNCI BENAR"
///   (cuma muncul kalau jawaban user SALAH, menandakan opsi yang seharusnya)
/// - opsi == selectedOptionId & != correctOptionId -> merah, tag "PILIHANMU"
/// - selainnya -> polos, tidak ada tag
///
/// REDESIGN: perbandingan di atas TIDAK berubah — murni tampilan. Badge
/// "SOAL n"/"TAHUN"/"Benar-Salah" disamakan jadi satu ukuran caption (11),
/// `withOpacity` -> `withValues`, ikon dibulatkan, dan spacing dirapikan
/// supaya tidak terasa penuh sesak.
class EraQuizRecapCard extends StatelessWidget {
  const EraQuizRecapCard({super.key, required this.index, required this.item});

  final int index;
  final EraQuizRecapItem item;

  static const _correctGreen = Color(0xFF1C9C5A);
  static const _correctGreenBg = Color(0xFFEAF8EF);
  static const _wrongRed = Color(0xFFDC2626);
  static const _wrongRedBg = Color(0xFFFDEEEE);

  static const _tagLabelStyle = TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: AppColors.textSecondary);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(color: AppColors.ink.withValues(alpha: 0.04), blurRadius: 12, offset: const Offset(0, 5)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Text('SOAL ${index + 1}', style: _tagLabelStyle),
                    // BARU (opsional) — label tahun asal soal ini, konsekuensi
                    // dari soal sumatif yang sekarang ditarik dari bank
                    // formatif per year. Null-safe: kalau backend belum/tidak
                    // mengirim `year`, badge ini disembunyikan.
                    if (item.year != null) ...[
                      const Text('·', style: _tagLabelStyle),
                      Text('TAHUN ${item.year!.year}', style: _tagLabelStyle),
                    ],
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
                decoration: BoxDecoration(
                  color: item.isCorrect ? _correctGreenBg : _wrongRedBg,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      item.isCorrect ? Icons.check_rounded : Icons.close_rounded,
                      size: 12,
                      color: item.isCorrect ? _correctGreen : _wrongRed,
                    ),
                    const SizedBox(width: 3),
                    Text(
                      item.isCorrect ? 'Benar' : 'Kurang Tepat',
                      style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: item.isCorrect ? _correctGreen : _wrongRed),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            item.question,
            style: const TextStyle(fontSize: 14.5, fontWeight: FontWeight.w700, color: AppColors.ink, height: 1.4),
          ),
          const SizedBox(height: 14),
          for (final option in item.options) _buildOption(option),
          const SizedBox(height: 4),
          _buildExplanation(),
        ],
      ),
    );
  }

  Widget _buildOption(EraQuizRecapOption option) {
    final isCorrectOption = option.id == item.correctOptionId;
    final isSelectedOption = option.id == item.selectedOptionId;

    String? tag;
    Color borderColor = AppColors.border;
    Color bgColor = Colors.white;
    Color textColor = AppColors.ink;
    IconData? icon;
    Color iconColor = AppColors.border;

    if (isCorrectOption && isSelectedOption) {
      tag = 'JAWABANMU';
      borderColor = _correctGreen;
      bgColor = _correctGreenBg;
      textColor = _correctGreen;
      icon = Icons.check_circle_rounded;
      iconColor = _correctGreen;
    } else if (isCorrectOption && !isSelectedOption) {
      tag = 'KUNCI BENAR';
      borderColor = _correctGreen;
      bgColor = _correctGreenBg;
      textColor = _correctGreen;
      icon = Icons.check_circle_rounded;
      iconColor = _correctGreen;
    } else if (isSelectedOption && !isCorrectOption) {
      tag = 'PILIHANMU';
      borderColor = _wrongRed;
      bgColor = _wrongRedBg;
      textColor = _wrongRed;
      icon = Icons.cancel_rounded;
      iconColor = _wrongRed;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 11),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: borderColor, width: tag != null ? 1.4 : 1),
      ),
      child: Row(
        children: [
          if (icon != null)
            Icon(icon, size: 18, color: iconColor)
          else
            Container(
              width: 18,
              height: 18,
              decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: AppColors.border)),
            ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              option.optionText,
              style: TextStyle(
                fontSize: 13,
                fontWeight: tag != null ? FontWeight.w600 : FontWeight.w500,
                color: tag != null ? textColor : AppColors.ink,
              ),
            ),
          ),
          if (tag != null) ...[
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(color: borderColor, borderRadius: BorderRadius.circular(20)),
              child: Text(
                tag,
                style: const TextStyle(fontSize: 9.5, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildExplanation() {
    final color = item.isCorrect ? _correctGreen : _wrongRed;
    final bg = item.isCorrect ? _correctGreenBg : _wrongRedBg;
    final title = item.isCorrect ? 'Penjelasan Jawaban' : 'Pembahasan Kunci Jawaban';
    final icon = item.isCorrect ? Icons.lightbulb_outline_rounded : Icons.error_outline_rounded;

    return Container(
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 14, color: color),
              const SizedBox(width: 6),
              Text(title, style: TextStyle(fontSize: 11.5, fontWeight: FontWeight.w800, color: color)),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            item.explanation,
            style: const TextStyle(fontSize: 12.5, color: AppColors.textSecondary, height: 1.45),
          ),
        ],
      ),
    );
  }
}