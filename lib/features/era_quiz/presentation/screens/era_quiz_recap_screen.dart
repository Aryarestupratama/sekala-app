import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/models/era.dart';
import '../../../../shared/models/era_quiz_recap_item.dart';
import '../../../../shared/widgets/pressable_scale.dart';
import '../../../history/presentation/providers/history_providers.dart';
import '../providers/era_quiz_providers.dart';
import '../widgets/era_quiz_colors.dart';
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

    // Tumpukan navigasi bisa kosong kalau layar ini dibuka lewat `go`.
    void back() {
      if (context.canPop()) {
        context.pop();
      } else {
        context.go('/era-quiz/$eraId/result');
      }
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: recapAsync.when(
          loading: () => _RecapStatus(onBack: back),
          error: (error, _) => _RecapStatus(
            onBack: back,
            onRetry: () => ref.invalidate(eraQuizRecapProvider(eraId)),
          ),
          data: (recap) => _RecapBody(
            questions: recap.questions,
            eraName: eraName,
            accent: accent,
            onBack: back,
          ),
        ),
      ),
    );
  }
}

/// Isi rekap + filter "Kurang tepat". Tujuan layar ini adalah belajar dari
/// jawaban yang salah; dengan 20 kartu panjang, user perlu bisa langsung
/// melihat yang salah saja.
class _RecapBody extends StatefulWidget {
  const _RecapBody({
    required this.questions,
    required this.eraName,
    required this.accent,
    required this.onBack,
  });

  final List<EraQuizRecapItem> questions;
  final String eraName;
  final Color accent;
  final VoidCallback onBack;

  @override
  State<_RecapBody> createState() => _RecapBodyState();
}

class _RecapBodyState extends State<_RecapBody> {
  bool _onlyWrong = false;

  @override
  Widget build(BuildContext context) {
    final all = widget.questions;
    final total = all.length;
    final correct = all.where((q) => q.isCorrect).length;
    final wrong = total - correct;
    final percent = total == 0 ? 0 : ((correct / total) * 100).round();
    final visible = [
      for (var i = 0; i < all.length; i++)
        if (!_onlyWrong || !all[i].isCorrect) (i, all[i]),
    ];

    return Column(
      children: [
        _Header(
          eraName: widget.eraName,
          accent: widget.accent,
          correct: correct,
          total: total,
          onBack: widget.onBack,
        ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 12),
            children: [
              _SummaryCard(accent: widget.accent, correct: correct, wrong: wrong, percent: percent),
              const SizedBox(height: 18),
              if (wrong > 0) ...[
                Row(
                  children: [
                    Expanded(
                      child: _FilterChip(
                        label: 'Semua ($total)',
                        selected: !_onlyWrong,
                        onTap: () => setState(() => _onlyWrong = false),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: _FilterChip(
                        label: 'Kurang tepat ($wrong)',
                        selected: _onlyWrong,
                        onTap: () => setState(() => _onlyWrong = true),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
              ],
              const Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.info_outline_rounded, size: 16, color: AppColors.textSecondary),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Review jawaban dan pelajari kembali pembahasan di bawah untuk memperkuat pemahamanmu.',
                      style: TextStyle(fontSize: 14, color: AppColors.textSecondary, height: 1.4),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              for (final (i, item) in visible) EraQuizRecapCard(index: i, item: item),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: Semantics(
            button: true,
            child: PressableScale(
              onTap: widget.onBack,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 15),
                decoration: BoxDecoration(color: AppColors.ink, borderRadius: BorderRadius.circular(30)),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.arrow_back_rounded, size: 18, color: Colors.white),
                    SizedBox(width: 8),
                    Text(
                      'Kembali ke Ringkasan Hasil',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 15),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _FilterChip extends StatelessWidget {
  const _FilterChip({required this.label, required this.selected, required this.onTap});

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      selected: selected,
      child: PressableScale(
        onTap: onTap,
        child: Container(
          height: 48,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: selected ? AppColors.ink : Colors.white,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: selected ? AppColors.ink : AppColors.border, width: 1.4),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: selected ? Colors.white : AppColors.ink,
            ),
          ),
        ),
      ),
    );
  }
}

/// Loading / gagal memuat rekap (dulu: teks exception mentah tanpa tombol).
class _RecapStatus extends StatelessWidget {
  const _RecapStatus({required this.onBack, this.onRetry});

  final VoidCallback onBack;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 8, 16, 0),
          child: Semantics(
            button: true,
            label: 'Kembali',
            child: PressableScale(
              onTap: onBack,
              child: Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(color: AppColors.ink.withValues(alpha: 0.06), shape: BoxShape.circle),
                child: const Icon(Icons.arrow_back_rounded, size: 22, color: AppColors.ink),
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
                          'Rekap jawaban belum bisa dimuat',
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

class _Header extends StatelessWidget {
  const _Header({
    required this.eraName,
    required this.accent,
    required this.correct,
    required this.total,
    required this.onBack,
  });

  final String eraName;
  final Color accent;
  final int correct;
  final int total;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(8, 8, 16, 12),
      child: Row(
        children: [
          Semantics(
            button: true,
            label: 'Kembali',
            child: PressableScale(
              onTap: onBack,
              child: Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(color: AppColors.ink.withValues(alpha: 0.06), shape: BoxShape.circle),
                child: const Icon(Icons.arrow_back_rounded, size: 22, color: AppColors.ink),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  spacing: 8,
                  runSpacing: 4,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    const Text(
                      'Rekap Jawaban',
                      style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800, color: AppColors.ink),
                    ),
                    if (eraName.isNotEmpty)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 3),
                        decoration: BoxDecoration(color: accent, borderRadius: BorderRadius.circular(20)),
                        child: Text(
                          eraName.toUpperCase(),
                          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w800, color: eraQuizOnColor(accent)),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 3),
                Text(
                  '$correct dari $total soal terjawab tepat',
                  style: const TextStyle(fontSize: 14, color: AppColors.textSecondary),
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
            child: Icon(Icons.military_tech_rounded, size: 22, color: eraQuizAccentStrong(accent)),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Ringkasan Evaluasi', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: AppColors.ink)),
                const SizedBox(height: 6),
                Wrap(
                  spacing: 12,
                  runSpacing: 4,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(width: 7, height: 7, decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColors.success)),
                        const SizedBox(width: 5),
                        Text('$correct Benar', style: const TextStyle(fontSize: 13.5, color: AppColors.textSecondary, fontWeight: FontWeight.w600)),
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(width: 7, height: 7, decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColors.destructive)),
                        const SizedBox(width: 5),
                        Text('$wrong Kurang Tepat', style: const TextStyle(fontSize: 13.5, color: AppColors.textSecondary, fontWeight: FontWeight.w600)),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          Text('$percent%', style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w800, color: AppColors.ink)),
        ],
      ),
    );
  }
}