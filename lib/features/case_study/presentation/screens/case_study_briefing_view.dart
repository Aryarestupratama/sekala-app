import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../case_study_texts.dart';
import '../widgets/case_study_common.dart';

/// Layar 2 Studi Kasus — Briefing Kasus (mockup Stitch, tema terang).
///
/// Widget PRESENTASI murni, sama filosofi dengan `CaseStudyOpeningView`.
/// Tiga teks di bawah semuanya **diisi admin** (`CaseStudy.title`,
/// `.description`, `.challengeText`); eyebrow "BRIEFING KASUS UTAMA" &
/// lead-in "Tantangan Anda:" adalah template (`CaseStudyTexts`).
///
/// Konten di-scroll dari atas (beda dengan Opening yang menempel ke
/// bawah) karena panjang deskripsi bervariasi; tombol CTA selalu terpasang
/// di bawah layar, di luar area scroll, jadi teks panjang tidak pernah
/// tertutup tombol.
class CaseStudyBriefingView extends StatelessWidget {
  const CaseStudyBriefingView({
    super.key,
    required this.title,
    required this.description,
    required this.challengeText,
    required this.onNext,
    required this.accent,
    this.onBack,
  });

  final String title;
  final String description;
  final String challengeText;

  /// Warna era (`EraAccents.ofSlug`), dioper dari shell.
  final Color accent;

  /// Tombol "Buka matriks prioritas" -> layar Ruang Keputusan.
  final VoidCallback onNext;
  final VoidCallback? onBack;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            if (onBack != null)
              Padding(
                padding: const EdgeInsets.fromLTRB(
                    kCaseStudyHPad - 4, 12, kCaseStudyHPad, 0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: CaseStudyBackButton(onTap: onBack!),
                ),
              ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(
                    kCaseStudyHPad, 24, kCaseStudyHPad, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    caseStudyReveal(context, 0, CaseStudyAccentBar(color: accent)),
                    const SizedBox(height: 12),
                    caseStudyReveal(
                      context,
                      1,
                      const CaseStudyEyebrow(CaseStudyTexts.briefingEyebrow),
                    ),
                    const SizedBox(height: 12),
                    caseStudyReveal(
                      context,
                      2,
                      Semantics(
                        header: true,
                        child: Text(
                          title,
                          style: AppTextStyles.h1.copyWith(fontSize: 24),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    caseStudyReveal(
                      context,
                      3,
                      Text(
                        description,
                        style: AppTextStyles.bodySecondary.copyWith(fontSize: 16, height: 1.6),
                      ),
                    ),
                    const SizedBox(height: 24),
                    caseStudyReveal(
                      context,
                      4,
                      _ChallengeCallout(challengeText: challengeText, accent: accent),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(
                  kCaseStudyHPad, 8, kCaseStudyHPad, 20),
              child: caseStudyReveal(
                context,
                5,
                CaseStudyPrimaryButton(
                  label: CaseStudyTexts.openMatrixCta,
                  color: accent,
                  onTap: onNext,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Kotak tantangan: putih + border tipis + strip orange 4px di tepi kiri.
class _ChallengeCallout extends StatelessWidget {
  const _ChallengeCallout({required this.challengeText, required this.accent});

  final String challengeText;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    final bodyStyle = AppTextStyles.body.copyWith(
      fontSize: 15,
      height: 1.55,
      fontWeight: FontWeight.w500,
    );

    return Container(
      width: double.infinity,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border),
      ),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(width: 4, color: accent),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text.rich(
                  TextSpan(
                    style: bodyStyle,
                    children: [
                      TextSpan(
                        text: '${CaseStudyTexts.challengeLeadIn} ',
                        style: const TextStyle(fontWeight: FontWeight.w700),
                      ),
                      TextSpan(
                        text: CaseStudyTexts.challengeBody(challengeText),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}