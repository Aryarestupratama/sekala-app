import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/models/era.dart';
import '../../../history/presentation/providers/history_providers.dart';
import '../providers/era_quiz_providers.dart';
import '../widgets/era_quiz_option_tile.dart';

/// GET /api/eras/{era}/quiz + POST .../attempt — ERAQUIZ-01–04.
///
/// Layout & warna mengikuti mockup "Kuis Sumatif" yang diberikan: 1 soal
/// per halaman, progress bar segmen + persentase, tombol Sebelumnya/
/// Selanjutnya di bawah (berubah jadi "Kirim Jawaban" di soal terakhir,
/// ERAQUIZ-02). Warna aksen ikut era (Kolonial = orange, Kemerdekaan =
/// green, Modern = sky) via `EraAccents`.
///
/// PENYEDERHANAAN dari mockup: widget "Navigasi Cepat" (nomor soal
/// lompat-lompat) DIHILANGKAN atas permintaan — navigasi murni linear
/// lewat Sebelumnya/Selanjutnya. `EraQuizQuickNav` (widget-nya) tetap
/// ada di folder widgets kalau suatu saat mau dipakai lagi, tapi TIDAK
/// diimpor/dipakai screen ini lagi.
///
/// PENYEDERHANAAN dari mockup (ditandai jelas di komentar masing-masing
/// widget anak): badge kategori soal ("🩺 Kesehatan Masyarakat...") di
/// mockup TIDAK didukung data — `EraQuizQuestion` (dikonfirmasi ke
/// source `UserEraQuizController::show()`) tidak punya field kategori
/// apapun, cuma `id`/`order`/`question`/`options`. Badge itu SENGAJA
/// dihilangkan di sini daripada mengarang data — kalau kategori memang
/// dibutuhkan, itu perubahan skema+admin dulu, bukan sesuatu yang bisa
/// ditambah dari Flutter saja.
///
/// Jawaban disimpan di STATE LOKAL (`_answers`) selama user mengerjakan
/// — TIDAK ada panggilan API per soal (beda dari kuis year yang
/// progresif) sampai user menekan "Kirim Jawaban" di soal terakhir
/// (R-ERAQUIZ-04, backend mewajibkan semua soal terjawab dalam SATU
/// request `submitAttempt()`).
class EraQuizScreen extends ConsumerStatefulWidget {
  const EraQuizScreen({super.key, required this.eraId});

  final int eraId;

  @override
  ConsumerState<EraQuizScreen> createState() => _EraQuizScreenState();
}

class _EraQuizScreenState extends ConsumerState<EraQuizScreen> {
  int _currentIndex = 0;
  final Map<int, int> _answers = {}; // questionId -> optionId

  void _selectOption(int questionId, int optionId) {
    setState(() => _answers[questionId] = optionId);
  }

  void _goTo(int index, int totalQuestions) {
    if (index < 0 || index >= totalQuestions) return;
    setState(() => _currentIndex = index);
  }

  Future<void> _handlePrimaryAction(List<int> questionIds) async {
    final isLast = _currentIndex == questionIds.length - 1;

    if (!isLast) {
      _goTo(_currentIndex + 1, questionIds.length);
      return;
    }

    // Soal terakhir -> cek semua soal sudah terjawab (jaga-jaga di sisi
    // client sebelum request; backend tetap validasi ulang lewat
    // StoreEraQuizAttemptRequest, R-ERAQUIZ-04). Kalau ada yang belum
    // terjawab, lompat ke soal pertama yang kosong supaya user tahu
    // persis apa yang kurang, alih-alih cuma pesan generik.
    final firstUnanswered = questionIds.indexWhere((id) => !_answers.containsKey(id));
    if (firstUnanswered != -1) {
      _goTo(firstUnanswered, questionIds.length);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Masih ada soal yang belum dijawab.')),
      );
      return;
    }

    final result = await ref
        .read(eraQuizSubmitControllerProvider.notifier)
        .submit(eraId: widget.eraId, answersByQuestionId: _answers);

    if (result != null && mounted) {
      // Ganti (bukan push) supaya user tidak bisa "back" ke layar
      // pengerjaan kuis yang sudah selesai disubmit.
      context.pushReplacement('/era-quiz/${widget.eraId}/result');
    }
  }

  @override
  Widget build(BuildContext context) {
    final quizAsync = ref.watch(eraQuizProvider(widget.eraId));
    final submitState = ref.watch(eraQuizSubmitControllerProvider);

    final erasAsync = ref.watch(erasProvider);
    Era? era;
    for (final candidate in erasAsync.valueOrNull ?? const <Era>[]) {
      if (candidate.id == widget.eraId) {
        era = candidate;
        break;
      }
    }
    final accent = era != null ? EraAccents.ofSlug(era.slug) : AppColors.primary;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: quizAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, _) => Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Text('Gagal memuat kuis sumatif: $error', textAlign: TextAlign.center),
            ),
          ),
          data: (quiz) {
            final questions = [...quiz.questions]..sort((a, b) => a.order.compareTo(b.order));

            if (questions.isEmpty) {
              return const Center(child: Text('Kuis sumatif ini belum punya soal.'));
            }

            final questionIds = questions.map((q) => q.id).toList();
            final total = questions.length;
            final current = questions[_currentIndex];
            final isLast = _currentIndex == total - 1;
            final answeredCount = _answers.length;
            final percent = (((_currentIndex + 1) / total) * 100).round();
            final isSubmitting = submitState.isLoading;

            return Column(
              children: [
                _Header(eraName: era?.name, accent: accent, onClose: () => context.pop()),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
                  child: _ProgressSegments(total: total, currentIndex: _currentIndex, accent: accent),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Soal ${_currentIndex + 1} dari $total',
                        style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
                      ),
                      Text(
                        '$percent% Selesai',
                        style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(18),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.04),
                                blurRadius: 12,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Align(
                                alignment: Alignment.centerRight,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: accent.withOpacity(0.12),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    'Pilihan Ganda',
                                    style: TextStyle(
                                      fontSize: 10.5,
                                      fontWeight: FontWeight.bold,
                                      color: accent,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                current.question,
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.ink,
                                  height: 1.35,
                                ),
                              ),
                              const SizedBox(height: 14),
                              for (final option in [...current.options]
                                ..sort((a, b) => a.order.compareTo(b.order)))
                                EraQuizOptionTile(
                                  label: option.optionText,
                                  selected: _answers[current.id] == option.id,
                                  accent: accent,
                                  onTap: () => _selectOption(current.id, option.id),
                                ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  const Icon(Icons.lock_outline, size: 13, color: AppColors.textDisabled),
                                  const SizedBox(width: 6),
                                  Expanded(
                                    child: Text(
                                      'Jawaban tersimpan sementara · Bisa diubah kembali sebelum submit',
                                      style: const TextStyle(fontSize: 10.5, color: AppColors.textDisabled),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                _BottomBar(
                  accent: accent,
                  isFirst: _currentIndex == 0,
                  isLast: isLast,
                  isSubmitting: isSubmitting,
                  answeredCount: answeredCount,
                  total: total,
                  onPrevious: () => _goTo(_currentIndex - 1, total),
                  onPrimary: () => _handlePrimaryAction(questionIds),
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
  const _Header({required this.eraName, required this.accent, required this.onClose});

  final String? eraName;
  final Color accent;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
      child: Row(
        children: [
          GestureDetector(
            onTap: onClose,
            child: const Icon(Icons.close, size: 22, color: AppColors.ink),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'Kuis Sumatif: ${eraName ?? '...'}',
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: AppColors.ink),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProgressSegments extends StatelessWidget {
  const _ProgressSegments({required this.total, required this.currentIndex, required this.accent});

  final int total;
  final int currentIndex;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (var i = 0; i < total; i++)
          Expanded(
            child: Container(
              height: 5,
              margin: EdgeInsets.only(right: i == total - 1 ? 0 : 4),
              decoration: BoxDecoration(
                color: i <= currentIndex ? accent : AppColors.border,
                borderRadius: BorderRadius.circular(3),
              ),
            ),
          ),
      ],
    );
  }
}

class _BottomBar extends StatelessWidget {
  const _BottomBar({
    required this.accent,
    required this.isFirst,
    required this.isLast,
    required this.isSubmitting,
    required this.answeredCount,
    required this.total,
    required this.onPrevious,
    required this.onPrimary,
  });

  final Color accent;
  final bool isFirst;
  final bool isLast;
  final bool isSubmitting;
  final int answeredCount;
  final int total;
  final VoidCallback onPrevious;
  final VoidCallback onPrimary;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: AppColors.border)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              if (!isFirst)
                TextButton.icon(
                  onPressed: isSubmitting ? null : onPrevious,
                  icon: const Icon(Icons.arrow_back, size: 16, color: AppColors.ink),
                  label: const Text('Sebelumnya', style: TextStyle(color: AppColors.ink)),
                )
              else
                const SizedBox(width: 1),
              const Spacer(),
              ElevatedButton(
                onPressed: isSubmitting ? null : onPrimary,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.ink,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                ),
                child: isSubmitting
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                      )
                    : Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(isLast ? 'Kirim Jawaban' : 'Selanjutnya'),
                          const SizedBox(width: 6),
                          Icon(isLast ? Icons.check : Icons.arrow_forward, size: 16),
                        ],
                      ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Hasil & pembahasan lengkap akan ditampilkan setelah seluruh $total soal dijawab.',
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 10.5, color: AppColors.textDisabled, fontStyle: FontStyle.italic),
          ),
        ],
      ),
    );
  }
}