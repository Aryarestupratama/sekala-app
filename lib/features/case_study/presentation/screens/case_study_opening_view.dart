import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../case_study_texts.dart';
import '../widgets/case_study_common.dart';

/// Layar 1 Studi Kasus — Opening (mockup Stitch, tema terang SEKALA).
///
/// Widget PRESENTASI murni: tidak membaca provider/router, hanya menerima
/// data & callback. Dengan begitu bisa dipakai apa adanya oleh
/// shell/container Studi Kasus nanti (yang mengatur perpindahan
/// Opening -> Briefing -> Ruang Keputusan -> Badge) dan gampang dipreview.
///
/// - [wabahName]: nama wabah untuk kalimat judul template — dari
///   `Year.title` (lihat `CaseStudyTexts`).
/// - [onStart]: tombol "Mulai briefing kasus".
/// - [onBack]: tombol kembali di kiri atas; null = tombol disembunyikan.
class CaseStudyOpeningView extends StatelessWidget {
  const CaseStudyOpeningView({
    super.key,
    required this.wabahName,
    required this.onStart,
    required this.accent,
    this.onBack,
  });

  final String wabahName;
  final VoidCallback onStart;

  /// Warna era (`EraAccents.ofSlug`), dioper dari shell — menggantikan
  /// oren hardcode supaya tampilan mengikuti era yang sedang dibaca.
  final Color accent;
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
            // Konten menempel ke bawah (ruang kosong di atas, sesuai
            // mockup), tapi tetap bisa di-scroll di layar pendek / font
            // besar supaya tidak overflow.
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  const vPad = 16.0;
                  final minHeight = (constraints.maxHeight - vPad * 2)
                      .clamp(0.0, double.infinity);
                  return SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                      horizontal: kCaseStudyHPad,
                      vertical: vPad,
                    ),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(minHeight: minHeight),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          caseStudyReveal(
                              context, 0, CaseStudyAccentBar(color: accent)),
                          const SizedBox(height: 12),
                          caseStudyReveal(
                            context,
                            1,
                            const CaseStudyEyebrow(
                                CaseStudyTexts.openingEyebrow),
                          ),
                          const SizedBox(height: 12),
                          caseStudyReveal(
                            context,
                            2,
                            Semantics(
                              header: true,
                              child: Text(
                                CaseStudyTexts.openingTitle(wabahName),
                                style: AppTextStyles.h1.copyWith(fontSize: 26),
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),
                          caseStudyReveal(
                            context,
                            3,
                            const _InfoCard(
                              heading: CaseStudyTexts.playerRoleHeading,
                              body: CaseStudyTexts.playerRoleBody,
                            ),
                          ),
                          const SizedBox(height: 12),
                          caseStudyReveal(
                            context,
                            4,
                            const _InfoCard(
                              heading: CaseStudyTexts.rulesHeading,
                              body: CaseStudyTexts.rulesBody,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(
                  kCaseStudyHPad, 8, kCaseStudyHPad, 20),
              child: caseStudyReveal(
                context,
                5,
                CaseStudyPrimaryButton(
                  label: CaseStudyTexts.startBriefingCta,
                  color: accent,
                  onTap: onStart,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({required this.heading, required this.body});

  final String heading;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CaseStudyEyebrow(heading, letterSpacing: 1.3),
          const SizedBox(height: 8),
          Text(
            body,
            style: AppTextStyles.body.copyWith(
              fontSize: 15,
              height: 1.5,
              color: AppColors.ink.withValues(alpha: 0.85),
            ),
          ),
        ],
      ),
    );
  }
}