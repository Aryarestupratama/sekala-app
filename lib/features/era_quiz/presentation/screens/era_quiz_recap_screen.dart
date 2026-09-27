import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/models/era.dart';
import '../../../../shared/widgets/pressable_scale.dart';
import '../../../history/presentation/providers/history_providers.dart';
import '../providers/era_quiz_providers.dart';
import '../widgets/era_quiz_recap_card.dart';

/// GET /api/eras/{era}/quiz/recap — ERAQUIZ-04. 1 layar scroll semua
/// soal, dibuka dari tombol "Lihat Rekapan" di `EraQuizResultScreen`.
///
/// REDESIGN: `withOpacity` -> `withValues`, tombol bawah jadi
/// [PressableScale], dan banner info "review jawaban..." yang sebelumnya
/// jadi kotak terpisah sekarang digabung ke subjudul header (satu blok
/// lebih sedikit, mengurangi kesan bertumpuk). Skala font disamakan
/// dengan `era_quiz_screen.dart`/`era_quiz_result_screen.dart`.
class EraQuizRecapScreen extends ConsumerWidget {
  const EraQuizRecapScreen({super.key, required this.eraId});

  final int eraId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recapAsync = ref.watch(eraQuizRecapProvider(eraId));
    final erasAsync = ref.watch(erasProvider);

    Era? era;
    for (final candidate in erasAsync.valueOrNull ?? const <Era>[]) {
      if (candidate.id == eraId) {
        era = candidate;
        break;
      }
    }
    final accent = era != null ? EraAccents.ofSlug(era.slug) : AppColors.primary;
    final eraName = era?.name ?? '';

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: recapAsync.when(
          loading: () => Center(child: CircularProgressIndicator(color: accent)),
          error: (error, _) => Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.error_outline_rounded, size: 40, color: AppColors.textSecondary.withValues(alpha: 0.6)),
                  const SizedBox(height: 12),
                  Text(
                    'Gagal memuat rekap: $error',
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: AppColors.textSecondary),
                  ),
                ],
              ),
            ),
          ),
          data: (recap) {
            final total = recap.questions.length;
            final correct = recap.questions.where((q) => q.isCorrect).length;
            final wrong = total - correct;
            final percent = total == 0 ? 0 : ((correct / total) * 100).round();

            return Column(
              children: [
                _Header(eraName: eraName, accent: accent, correct: correct, total: total),
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.fromLTRB(16, 14, 16, 12),
                    children: [
                      _SummaryCard(accent: accent, correct: correct, wrong: wrong, percent: percent),
                      const SizedBox(height: 18),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(Icons.info_outline_rounded, size: 15, color: AppColors.textSecondary),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'Review jawaban dan pelajari kembali pembahasan di bawah untuk memperkuat pemahamanmu.',
                              style: const TextStyle(fontSize: 12, color: AppColors.textSecondary, height: 1.4),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      for (var i = 0; i < recap.questions.length; i++)
                        EraQuizRecapCard(index: i, item: recap.questions[i]),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: PressableScale(
                    onTap: () => context.pop(),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      decoration: BoxDecoration(color: AppColors.ink, borderRadius: BorderRadius.circular(30)),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.arrow_back_rounded, size: 16, color: Colors.white),
                          SizedBox(width: 8),
                          Text('Kembali ke Ringkasan Hasil', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 13.5)),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.eraName, required this.accent, required this.correct, required this.total});

  final String eraName;
  final Color accent;
  final int correct;
  final int total;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 14),
      child: Row(
        children: [
          PressableScale(
            onTap: () => context.pop(),
            child: Container(
              width: 34,
              height: 34,
              decoration: BoxDecoration(color: AppColors.ink.withValues(alpha: 0.06), shape: BoxShape.circle),
              child: const Icon(Icons.arrow_back_rounded, size: 18, color: AppColors.ink),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text('Rekap Jawaban', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: AppColors.ink)),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(color: accent.withValues(alpha: 0.14), borderRadius: BorderRadius.circular(20)),
                      child: Text(
                        eraName.toUpperCase(),
                        style: TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: accent),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 3),
                Text(
                  '$correct dari $total soal terjawab tepat',
                  style: const TextStyle(fontSize: 12.5, color: AppColors.textSecondary),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  const _SummaryCard({required this.accent, required this.correct, required this.wrong, required this.percent});

  final Color accent;
  final int correct;
  final int wrong;
  final int percent;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(color: AppColors.ink.withValues(alpha: 0.04), blurRadius: 12, offset: const Offset(0, 5)),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(shape: BoxShape.circle, color: accent.withValues(alpha: 0.14)),
            alignment: Alignment.center,
            child: Icon(Icons.military_tech_rounded, size: 22, color: accent),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Ringkasan Evaluasi', style: TextStyle(fontSize: 13.5, fontWeight: FontWeight.w800, color: AppColors.ink)),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Container(width: 6, height: 6, decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColors.success)),
                    const SizedBox(width: 5),
                    Text('$correct Benar', style: const TextStyle(fontSize: 11.5, color: AppColors.textSecondary, fontWeight: FontWeight.w600)),
                    const SizedBox(width: 12),
                    Container(width: 6, height: 6, decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColors.destructive)),
                    const SizedBox(width: 5),
                    Text('$wrong Kurang Tepat', style: const TextStyle(fontSize: 11.5, color: AppColors.textSecondary, fontWeight: FontWeight.w600)),
                  ],
                ),
              ],
            ),
          ),
          Text('$percent%', style: TextStyle(fontSize: 26, fontWeight: FontWeight.w800, color: accent)),
        ],
      ),
    );
  }
}