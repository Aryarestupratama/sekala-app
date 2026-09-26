import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../case_study_texts.dart';
import 'case_study_common.dart';

/// Bottom sheet feedback setelah Submit yang SALAH.
///
/// [feedback] = `feedback_incorrect` tingkat kasus dari admin (R-CASE-06) —
/// sengaja tidak menunjukkan slot mana yang salah, arahan datang dari teks
/// admin. Future selesai saat sheet ditutup (tombol "Coba lagi" ATAU
/// digeser/tap di luar) — pemanggil memperlakukan keduanya sama.
///
/// DESAIN SHEET INI BELUM DIMOCKUP (bukan dari Stitch) — usulan sementara,
/// gampang diganti tanpa menyentuh alur.
Future<void> showCaseStudyIncorrectSheet(
  BuildContext context, {
  required String feedback,
  required Color accent,
}) {
  final text = feedback.trim().isEmpty
      ? CaseStudyTexts.incorrectFallback
      : feedback.trim();

  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: AppColors.surface,
    showDragHandle: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (sheetContext) {
      return SafeArea(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.sizeOf(sheetContext).height * 0.7,
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
                kCaseStudyHPad, 4, kCaseStudyHPad, 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CaseStudyAccentBar(color: accent),
                const SizedBox(height: 12),
                const CaseStudyEyebrow(CaseStudyTexts.incorrectEyebrow),
                const SizedBox(height: 12),
                Flexible(
                  child: SingleChildScrollView(
                    child: Text(text, style: AppTextStyles.body),
                  ),
                ),
                const SizedBox(height: 20),
                CaseStudyPrimaryButton(
                  label: CaseStudyTexts.retryCta,
                  icon: Icons.refresh_rounded,
                  color: accent,
                  onTap: () => Navigator.of(sheetContext).pop(),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}