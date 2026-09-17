import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/models/era.dart';
import '../../../history/presentation/providers/history_providers.dart';
import '../providers/era_quiz_providers.dart';

/// GET /api/eras/{era}/quiz/result — ERAQUIZ-03.
///
/// Dipakai di DUA momen: (1) setelah submit sukses dari `EraQuizScreen`
/// (`pushReplacement`), dan (2) saat user tap node final-boss yang
/// berstatus "sudah dikerjakan" dari roadmap. Keduanya cukup lewat
/// `eraQuizResultProvider` (GET result) — TIDAK memakai response
/// `submitAttempt()` secara langsung sekalipun screen ini dibuka barusan
/// setelah submit, supaya satu-satunya sumber data konsisten (provider
/// sudah di-invalidate begitu submit sukses, jadi fetch di sini otomatis
/// dapat data terbaru, bukan stale).
///
/// `EraQuizResultResponse.message` SELALU null lewat jalur GET result()
/// ini (server memang tidak mengirimnya di endpoint itu, cuma di
/// submitAttempt() — lihat era_quiz_result_response.dart) — jadi dibuat
/// kalimat fallback lokal di sini, disesuaikan lulus/tidak
/// (`score.isPassing`, BARU).
///
/// BARU: `response.passingGrade` (int, selalu 75 saat ini) +
/// `score.isPassing` dipakai untuk label "Lulus"/"Belum Lulus" di bawah
/// skor — sebelumnya halaman ini cuma menampilkan skor tanpa status
/// lulus/tidak sama sekali.
class EraQuizResultScreen extends ConsumerWidget {
  const EraQuizResultScreen({super.key, required this.eraId});

  final int eraId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final resultAsync = ref.watch(eraQuizResultProvider(eraId));
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

    void backToRoadmap() {
      if (era != null) {
        context.go('/history/${era.slug}');
      } else {
        context.go('/history');
      }
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: resultAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, _) => Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Text('Gagal memuat hasil: $error', textAlign: TextAlign.center),
            ),
          ),
          data: (response) {
            final score = response.result;
            final wrong = score.incorrect;
            final percent = score.percentage; // sudah int dari backend, tidak perlu .round() lagi
            final message = response.message ??
                (score.isPassing
                    ? 'Selamat! Kamu sudah menyelesaikan kuis sumatif era $eraName.'
                    : 'Kamu sudah menyelesaikan kuis sumatif era $eraName. Yuk coba lagi untuk hasil lebih baik!');

            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _EraBadge(eraName: eraName, accent: accent),
                      GestureDetector(
                        onTap: backToRoadmap,
                        child: const Icon(Icons.close, size: 22, color: AppColors.ink),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      children: [
                        const SizedBox(height: 24),
                        Container(
                          width: 96,
                          height: 96,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: accent.withOpacity(0.15),
                          ),
                          alignment: Alignment.center,
                          child: Container(
                            width: 72,
                            height: 72,
                            decoration: BoxDecoration(shape: BoxShape.circle, color: accent),
                            alignment: Alignment.center,
                            child: const Icon(Icons.military_tech, size: 32, color: Colors.white),
                          ),
                        ),
                        const SizedBox(height: 24),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(18),
                            boxShadow: [
                              BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 12, offset: const Offset(0, 4)),
                            ],
                          ),
                          child: Column(
                            children: [
                              const Text(
                                'SKOR EVALUASI ERA',
                                style: TextStyle(fontSize: 11, letterSpacing: 0.5, color: AppColors.textSecondary, fontWeight: FontWeight.w600),
                              ),
                              const SizedBox(height: 6),
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: '${score.correct}',
                                      style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: accent),
                                    ),
                                    TextSpan(
                                      text: ' / ${score.total}',
                                      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: AppColors.textSecondary),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 10),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: accent.withOpacity(0.12),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(Icons.check_circle, size: 14, color: accent),
                                    const SizedBox(width: 6),
                                    Text(
                                      '$percent% Terjawab Tepat',
                                      style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.bold, color: accent),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 8),
                              // BARU — label lulus/tidak lulus (ERAQUIZ-03
                              // revisi: dulu cuma skor, sekarang ada status
                              // lulus/tidak berdasarkan passing grade).
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: (score.isPassing ? AppColors.success : AppColors.coral)
                                      .withOpacity(0.12),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      score.isPassing ? Icons.emoji_events : Icons.refresh,
                                      size: 14,
                                      color: score.isPassing ? AppColors.success : AppColors.coral,
                                    ),
                                    const SizedBox(width: 6),
                                    Text(
                                      score.isPassing
                                          ? 'Lulus'
                                          : 'Belum Lulus · min. ${response.passingGrade}%',
                                      style: TextStyle(
                                        fontSize: 12.5,
                                        fontWeight: FontWeight.bold,
                                        color: score.isPassing ? AppColors.success : AppColors.coral,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),
                        Text(
                          message,
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: AppColors.ink, height: 1.35),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'Kamu bisa melihat detail jawabanmu dan pembahasan lengkap di halaman Rekap.',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 13, color: AppColors.textSecondary),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _StatPill(dotColor: AppColors.success, label: '${score.correct} Benar'),
                            const SizedBox(width: 10),
                            _StatPill(dotColor: AppColors.destructive, label: '$wrong Kurang Tepat'),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () => context.push('/era-quiz/$eraId/recap'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: accent,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Lihat Rekapan', style: TextStyle(fontWeight: FontWeight.bold)),
                              SizedBox(width: 6),
                              Icon(Icons.arrow_forward, size: 16),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton(
                          onPressed: () => context.pushReplacement('/era-quiz/$eraId'),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            side: const BorderSide(color: AppColors.border),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.refresh, size: 16, color: AppColors.ink),
                              SizedBox(width: 6),
                              Text('Kerjakan Ulang', style: TextStyle(color: AppColors.ink, fontWeight: FontWeight.w600)),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      GestureDetector(
                        onTap: backToRoadmap,
                        child: const Text(
                          'Kembali ke Roadmap',
                          style: TextStyle(fontSize: 13, color: AppColors.textSecondary),
                        ),
                      ),
                    ],
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

class _EraBadge extends StatelessWidget {
  const _EraBadge({required this.eraName, required this.accent});

  final String eraName;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(color: accent.withOpacity(0.14), borderRadius: BorderRadius.circular(20)),
      child: Text(
        eraName.toUpperCase(),
        style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: accent),
      ),
    );
  }
}

class _StatPill extends StatelessWidget {
  const _StatPill({required this.dotColor, required this.label});

  final Color dotColor;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(width: 8, height: 8, decoration: BoxDecoration(shape: BoxShape.circle, color: dotColor)),
          const SizedBox(width: 6),
          Text(label, style: const TextStyle(fontSize: 12.5, color: AppColors.ink)),
        ],
      ),
    );
  }
}