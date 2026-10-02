import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/models/era.dart';
import '../../../../shared/widgets/pressable_scale.dart';
import '../../../history/presentation/providers/history_providers.dart';
import '../providers/era_quiz_providers.dart';
import '../widgets/era_quiz_colors.dart';

/// GET /api/eras/{era}/quiz/result — ERAQUIZ-03.
///
/// Dipakai di DUA momen: (1) setelah submit sukses dari `EraQuizScreen`
/// (`pushReplacement`), dan (2) saat user tap node final-boss yang
/// berstatus "sudah dikerjakan" dari roadmap. Keduanya cukup lewat
/// `eraQuizResultProvider` (GET result) — TIDAK memakai response
/// `submitAttempt()` secara langsung sekalipun screen ini dibuka barusan
/// setelah submit, supaya satu-satunya sumber data konsisten.
///
/// `EraQuizResultResponse.message` SELALU null lewat jalur GET result()
/// ini — jadi dibuat kalimat fallback lokal di sini, disesuaikan
/// lulus/tidak (`score.isPassing`).
///
/// REDESIGN (rapikan tampilan yang sebelumnya bertumpuk): medali jadi
/// satu lingkaran glow (bukan dua lingkaran konsentris), status
/// "Lulus/Belum Lulus" DIGABUNG jadi satu banner dengan persentase
/// (sebelumnya 2 pill terpisah bertumpuk di bawah skor), dan 2 stat
/// "Benar/Kurang Tepat" jadi baris inline polos (bukan 2 pill
/// berbingkai) — total blok visual di kartu skor berkurang dari 5 jadi 3.
/// `withOpacity` -> `withValues`, tombol jadi [PressableScale], dan
/// seluruh ukuran font disamakan dengan `era_quiz_screen.dart`/
/// `era_quiz_recap_screen.dart`.
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
          loading: () => _ResultStatus(onBack: backToRoadmap),
          error: (error, _) => _ResultStatus(
            onBack: backToRoadmap,
            onRetry: () => ref.invalidate(eraQuizResultProvider(eraId)),
          ),
          data: (response) {
            final score = response.result;
            final wrong = score.incorrect;
            final eraLabel = eraName.isEmpty ? 'ini' : eraName;
            final message = response.message ??
                (score.isPassing
                    ? 'Selamat! Kamu sudah menyelesaikan kuis sumatif era $eraLabel.'
                    : 'Kamu sudah menyelesaikan kuis sumatif era $eraLabel. Yuk coba lagi untuk hasil lebih baik!');
            final statusColor = score.isPassing ? AppColors.success : AppColors.coral;

            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _EraBadge(eraName: eraName, accent: accent),
                      Semantics(button: true, label: 'Tutup', child: PressableScale(
                        onTap: backToRoadmap,
                        child: Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(color: AppColors.ink.withValues(alpha: 0.06), shape: BoxShape.circle),
                          child: const Icon(Icons.close_rounded, size: 22, color: AppColors.ink),
                        ),
                      )),
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      children: [
                        const SizedBox(height: 12),
                        Container(
                          width: 92,
                          height: 92,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: accent,
                            boxShadow: [
                              BoxShadow(color: accent.withValues(alpha: 0.28), blurRadius: 24, spreadRadius: 2),
                            ],
                          ),
                          alignment: Alignment.center,
                          child: Icon(Icons.military_tech_rounded, size: 40, color: eraQuizOnColor(accent)),
                        ),
                        const SizedBox(height: 24),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(color: AppColors.ink.withValues(alpha: 0.04), blurRadius: 14, offset: const Offset(0, 6)),
                            ],
                          ),
                          child: Column(
                            children: [
                              const Text(
                                'SKOR EVALUASI ERA',
                                style: TextStyle(fontSize: 12.5, letterSpacing: 0.6, color: AppColors.textSecondary, fontWeight: FontWeight.w700),
                              ),
                              const SizedBox(height: 8),
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: '${score.correct}',
                                      style: const TextStyle(fontSize: 42, fontWeight: FontWeight.w800, color: AppColors.ink),
                                    ),
                                    TextSpan(
                                      text: ' / ${score.total}',
                                      style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600, color: AppColors.textSecondary),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 14),
                              // Status lulus + persentase digabung jadi satu
                              // banner (sebelumnya 2 pill terpisah).
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                                decoration: BoxDecoration(
                                  color: statusColor.withValues(alpha: 0.10),
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      score.isPassing ? Icons.emoji_events_rounded : Icons.refresh_rounded,
                                      size: 18,
                                      color: AppColors.ink,
                                    ),
                                    const SizedBox(width: 7),
                                    Text(
                                      score.isPassing
                                          ? 'Lulus · ${score.percentage}% terjawab tepat'
                                          : 'Belum Lulus · min. ${response.passingGrade}%',
                                      // Teks Ink: hijau/coral di atas tint hanya ~2.9:1 / ~2.3:1.
                                      style: const TextStyle(fontSize: 14.5, fontWeight: FontWeight.w800, color: AppColors.ink),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 14),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(width: 7, height: 7, decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColors.success)),
                                  const SizedBox(width: 6),
                                  Text('${score.correct} Benar', style: const TextStyle(fontSize: 14, color: AppColors.textSecondary, fontWeight: FontWeight.w600)),
                                  const SizedBox(width: 16),
                                  Container(width: 7, height: 7, decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColors.destructive)),
                                  const SizedBox(width: 6),
                                  Text('$wrong Kurang Tepat', style: const TextStyle(fontSize: 14, color: AppColors.textSecondary, fontWeight: FontWeight.w600)),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),
                        Text(
                          message,
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 16.5, fontWeight: FontWeight.w800, color: AppColors.ink, height: 1.4),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Kamu bisa melihat detail jawabanmu dan pembahasan lengkap di halaman Rekap.',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 14.5, color: AppColors.textSecondary, height: 1.4),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: Column(
                    children: [
                      Semantics(button: true, child: PressableScale(
                        onTap: () => context.push('/era-quiz/$eraId/recap'),
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          decoration: BoxDecoration(color: accent, borderRadius: BorderRadius.circular(30)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Lihat Rekapan',
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 15,
                                  color: eraQuizOnColor(accent),
                                ),
                              ),
                              const SizedBox(width: 6),
                              Icon(
                                Icons.arrow_forward_rounded,
                                size: 16,
                                color: eraQuizOnColor(accent),
                              ),
                            ],
                          ),
                        ),
                      )),
                      const SizedBox(height: 10),
                      Semantics(button: true, child: PressableScale(
                        onTap: () => context.pushReplacement('/era-quiz/$eraId'),
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(color: AppColors.border, width: 1.4),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.refresh_rounded, size: 16, color: AppColors.ink),
                              SizedBox(width: 6),
                              Text('Kerjakan Ulang', style: TextStyle(color: AppColors.ink, fontWeight: FontWeight.w700, fontSize: 15)),
                            ],
                          ),
                        ),
                      )),
                      const SizedBox(height: 14),
                      // Dulu: GestureDetector pada teks 12.5sp (~16dp tinggi, tanpa
                      // semantik). Sekarang tombol 48dp.
                      TextButton(
                        onPressed: backToRoadmap,
                        style: TextButton.styleFrom(
                          foregroundColor: AppColors.ink,
                          minimumSize: const Size(48, 48),
                        ),
                        child: const Text(
                          'Kembali ke Roadmap',
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
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
    if (eraName.isEmpty) return const SizedBox.shrink();
    // Chip solid aksen era + teks kontras (dulu teks aksen di atas tint
    // aksen: Sky ~1.3:1).
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(color: accent, borderRadius: BorderRadius.circular(20)),
      child: Text(
        eraName.toUpperCase(),
        style: TextStyle(fontSize: 12, fontWeight: FontWeight.w800, color: eraQuizOnColor(accent)),
      ),
    );
  }
}

/// Loading / gagal memuat hasil. Dulu: spinner tanpa jalan keluar atau teks
/// exception mentah tanpa tombol apa pun.
class _ResultStatus extends StatelessWidget {
  const _ResultStatus({required this.onBack, this.onRetry});

  final VoidCallback onBack;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
          child: Semantics(
            button: true,
            label: 'Kembali ke roadmap',
            child: PressableScale(
              onTap: onBack,
              child: Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(color: AppColors.ink.withValues(alpha: 0.06), shape: BoxShape.circle),
                child: const Icon(Icons.close_rounded, size: 22, color: AppColors.ink),
              ),
            ),
          ),
        ),
        Expanded(
          child: Center(
            child: onRetry == null
                ? const CircularProgressIndicator(color: AppColors.ink)
                : Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.cloud_off_rounded, size: 40, color: AppColors.textSecondary),
                        const SizedBox(height: 12),
                        const Text(
                          'Hasil kuis belum bisa dimuat',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(height: 6),
                        const Text(
                          'Periksa koneksi internetmu, lalu coba lagi.',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 15, height: 1.4, color: AppColors.textSecondary),
                        ),
                        const SizedBox(height: 16),
                        FilledButton(
                          onPressed: onRetry,
                          style: FilledButton.styleFrom(
                            backgroundColor: AppColors.ink,
                            minimumSize: const Size(140, 48),
                            shape: const StadiumBorder(),
                          ),
                          child: const Text('Coba lagi', style: TextStyle(fontWeight: FontWeight.w700)),
                        ),
                      ],
                    ),
                  ),
          ),
        ),
      ],
    );
  }
}