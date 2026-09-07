import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/models/era.dart';
import '../../../history/presentation/providers/history_providers.dart';
import '../providers/era_quiz_providers.dart';
import '../widgets/era_quiz_recap_card.dart';

/// GET /api/eras/{era}/quiz/recap — ERAQUIZ-04. 1 layar scroll semua
/// soal, dibuka dari tombol "Lihat Rekapan" di `EraQuizResultScreen`.
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
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, _) => Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Text('Gagal memuat rekap: $error', textAlign: TextAlign.center),
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
                    padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
                    children: [
                      _SummaryCard(accent: accent, correct: correct, wrong: wrong, percent: percent),
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: AppColors.border.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Row(
                          children: [
                            Icon(Icons.info_outline, size: 16, color: AppColors.textSecondary),
                            SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                'Review jawaban dan pelajari kembali pembahasan di bawah ini untuk memperkuat pemahaman sejarahmu.',
                                style: TextStyle(fontSize: 11.5, color: AppColors.textSecondary),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      for (var i = 0; i < recap.questions.length; i++)
                        EraQuizRecapCard(index: i, item: recap.questions[i]),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => context.pop(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.ink,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.arrow_back, size: 16),
                          SizedBox(width: 8),
                          Text('Kembali ke Ringkasan Hasil', style: TextStyle(fontWeight: FontWeight.bold)),
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
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => context.pop(),
            child: const Icon(Icons.arrow_back, size: 20, color: AppColors.ink),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text('Rekap Jawaban', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: AppColors.ink)),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(color: accent.withOpacity(0.14), borderRadius: BorderRadius.circular(20)),
                      child: Text(
                        eraName.toUpperCase(),
                        style: TextStyle(fontSize: 9.5, fontWeight: FontWeight.bold, color: accent),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  'Kuis Sumatif Era $eraName • $correct/$total Terjawab Tepat',
                  style: const TextStyle(fontSize: 11.5, color: AppColors.textSecondary),
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
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10, offset: const Offset(0, 3)),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(shape: BoxShape.circle, color: accent.withOpacity(0.14)),
            alignment: Alignment.center,
            child: Icon(Icons.military_tech, size: 20, color: accent),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Ringkasan Evaluasi', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: AppColors.ink)),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Container(width: 6, height: 6, decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColors.success)),
                    const SizedBox(width: 4),
                    Text('$correct Benar', style: const TextStyle(fontSize: 11, color: AppColors.textSecondary)),
                    const SizedBox(width: 10),
                    Container(width: 6, height: 6, decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColors.destructive)),
                    const SizedBox(width: 4),
                    Text('$wrong Kurang Tepat', style: const TextStyle(fontSize: 11, color: AppColors.textSecondary)),
                  ],
                ),
              ],
            ),
          ),
          Text('$percent%', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: accent)),
        ],
      ),
    );
  }
}