import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../shared/models/quiz.dart';
import '../../../../shared/models/quiz_answer_feedback.dart';
import '../../../../shared/models/quiz_question.dart';
import '../providers/quiz_providers.dart';

/// Halaman Kuis in-app (Design.md §3.3 poin 5, mockup referensi Image 3).
///
/// MEKANISME "feedback instan" (disepakati bukan submit per-soal, karena
/// backend cuma punya SATU endpoint submit untuk semua jawaban sekaligus,
/// lihat quiz_api.dart):
/// 1. Fase MENJAWAB — user isi soal 1..N berurutan, belum ada feedback
///    berwarna, cuma pilih opsi lalu "Lanjut".
/// 2. Begitu soal terakhir dijawab -> submit SEKALI ke backend
///    (POST /quiz/attempt) di background.
/// 3. Fase REVIEW — begitu submit sukses, kembali ke soal 1, sekarang
///    opsi yang DIPILIH user sudah bisa diberi warna (hijau/merah) dari
///    `feedback` yang sudah diterima -> terasa "instan per soal" walau
///    submit aslinya cuma sekali di akhir. Soal terakhir tombolnya jadi
///    "Selesai" (bukan skor — R-QUIZ-04, tanpa reveal opsi mana yang
///    benar kalau user salah, lihat catatan di quiz_answer_feedback.dart).
class QuizScreen extends ConsumerWidget {
  const QuizScreen({
    super.key,
    required this.yearId,
    required this.eraSlug,
    this.yearTitle,
  });

  final int yearId;
  final String eraSlug;

  /// Opsional — dioper dari YearSummaryScreen (`year.title`) buat header
  /// "Kuis · <judul wabah>" seperti mockup. Kalau null (mis. deep link
  /// langsung), header cukup "Kuis" polos.
  final String? yearTitle;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quizAsync = ref.watch(quizProvider(yearId));

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: quizAsync.when(
          data: (quiz) {
            if (!quiz.isPublished || quiz.questions.isEmpty) {
              return const _QuizUnavailable();
            }
            return _QuizBody(
              quiz: quiz,
              yearId: yearId,
              eraSlug: eraSlug,
              yearTitle: yearTitle,
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          // Termasuk kasus 403 (R-QUIZ-02: belum semua section completed)
          // — tampil sebagai pesan error generik dari ApiException.
          error: (error, _) => Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Text('Kuis belum bisa diakses: $error', textAlign: TextAlign.center),
            ),
          ),
        ),
      ),
    );
  }
}

class _QuizUnavailable extends StatelessWidget {
  const _QuizUnavailable();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.quiz_outlined, size: 40, color: AppColors.textDisabled),
            const SizedBox(height: 12),
            const Text(
              'Kuis untuk wabah ini belum tersedia.',
              textAlign: TextAlign.center,
              style: TextStyle(color: AppColors.textSecondary),
            ),
            const SizedBox(height: 16),
            TextButton(onPressed: () => context.pop(), child: const Text('Kembali')),
          ],
        ),
      ),
    );
  }
}

enum _QuizPhase { answering, submitting, reviewing }

class _QuizBody extends ConsumerStatefulWidget {
  const _QuizBody({
    required this.quiz,
    required this.yearId,
    required this.eraSlug,
    this.yearTitle,
  });

  final Quiz quiz;
  final int yearId;
  final String eraSlug;
  final String? yearTitle;

  @override
  ConsumerState<_QuizBody> createState() => _QuizBodyState();
}

class _QuizBodyState extends ConsumerState<_QuizBody> {
  late final List<QuizQuestion> _questions;
  late final Map<int, int?> _selectedByQuestionId; // questionId -> optionId
  _QuizPhase _phase = _QuizPhase.answering;
  int _index = 0;
  List<QuizAnswerFeedback> _feedback = const [];
  List<int> _newlyUnlockedVaccineIds = const [];

  @override
  void initState() {
    super.initState();
    _questions = [...widget.quiz.questions]..sort((a, b) => a.order.compareTo(b.order));
    _selectedByQuestionId = {for (final q in _questions) q.id: null};
  }

  QuizQuestion get _currentQuestion => _questions[_index];
  bool get _isLastQuestion => _index == _questions.length - 1;

  QuizAnswerFeedback? _feedbackFor(int questionId) {
    for (final f in _feedback) {
      if (f.questionId == questionId) return f;
    }
    return null;
  }

  void _selectOption(int optionId) {
    if (_phase != _QuizPhase.answering) return; // review = read-only
    setState(() => _selectedByQuestionId[_currentQuestion.id] = optionId);
  }

  Future<void> _onPrimaryButtonTap() async {
    if (_phase == _QuizPhase.answering) {
      if (_selectedByQuestionId[_currentQuestion.id] == null) return; // guard

      if (!_isLastQuestion) {
        setState(() => _index += 1);
        return;
      }

      // Soal terakhir dijawab -> submit sekali ke backend.
      setState(() => _phase = _QuizPhase.submitting);
      final response = await ref.read(quizSubmitControllerProvider.notifier).submit(
            yearId: widget.yearId,
            eraSlug: widget.eraSlug,
            answersByQuestionId: _selectedByQuestionId,
          );
      if (!mounted) return;

      if (response == null) {
        // Gagal submit (network dsb.) — biarkan user coba lagi dari soal
        // terakhir, jangan hilang progress jawabannya.
        setState(() => _phase = _QuizPhase.answering);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Gagal mengirim jawaban, coba lagi.')),
        );
        return;
      }

      setState(() {
        _feedback = response.feedback;
        _newlyUnlockedVaccineIds = response.newlyUnlockedVaccineIds;
        _phase = _QuizPhase.reviewing;
        _index = 0; // mulai review dari soal 1
      });
      return;
    }

    if (_phase == _QuizPhase.reviewing) {
      if (!_isLastQuestion) {
        setState(() => _index += 1);
        return;
      }
      _finish();
    }
  }

  void _finish() {
    // R-QUIZ-04: tanpa skor/status lulus — cuma konfirmasi selesai.
    // Halaman reveal khusus animasi "Vaksin baru terbuka!" belum dibuat
    // (lihat progress.md) — sementara info vaksin baru ditampilkan lewat
    // SnackBar sebagai placeholder, bukan hilang begitu saja.
    final message = _newlyUnlockedVaccineIds.isEmpty
        ? 'Kuis selesai dikerjakan!'
        : 'Kuis selesai dikerjakan! ${_newlyUnlockedVaccineIds.length} vaksin baru terbuka.';
    context.go('/history/${widget.eraSlug}');
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  void _confirmExit() {
    if (_phase != _QuizPhase.answering || _selectedByQuestionId.values.every((v) => v == null)) {
      context.pop();
      return;
    }
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Keluar dari kuis?'),
        content: const Text('Jawaban yang sudah kamu isi belum dikirim dan akan hilang.'),
        actions: [
          TextButton(onPressed: () => context.pop(), child: const Text('Batal')),
          TextButton(
            onPressed: () {
              context.pop(); // tutup dialog
              context.pop(); // keluar kuis
            },
            child: const Text('Keluar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final total = _questions.length;
    final selected = _selectedByQuestionId[_currentQuestion.id];
    final feedback = _phase == _QuizPhase.reviewing ? _feedbackFor(_currentQuestion.id) : null;
    final isSubmitting = _phase == _QuizPhase.submitting;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
          child: Row(
            children: [
              IconButton(icon: const Icon(Icons.close), onPressed: _confirmExit),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  widget.yearTitle == null ? 'Kuis' : 'Kuis · ${widget.yearTitle}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
          child: Row(
            children: [
              for (var i = 0; i < total; i++) ...[
                Expanded(
                  child: Container(
                    height: 6,
                    decoration: BoxDecoration(
                      color: i <= _index ? AppColors.ink : AppColors.border,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
                if (i != total - 1) const SizedBox(width: 6),
              ],
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Soal ${_index + 1} dari $total',
              style: const TextStyle(color: AppColors.textSecondary, fontSize: 13),
            ),
          ),
        ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.border),
                ),
                child: Text(
                  _currentQuestion.question,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, height: 1.3),
                ),
              ),
              const SizedBox(height: 20),
              for (final option in [...(_currentQuestion.options)]
                ..sort((a, b) => a.order.compareTo(b.order)))
                _OptionTile(
                  label: option.optionText,
                  isSelected: selected == option.id,
                  // Cuma opsi yang DIPILIH user yang bisa diwarnai
                  // (R-QUIZ-04 — tidak pernah reveal opsi benar yang lain).
                  feedback: (feedback != null && selected == option.id)
                      ? feedback
                      : null,
                  onTap: () => _selectOption(option.id),
                ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
          child: SizedBox(
            width: double.infinity,
            child: FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.ink,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
              ),
              onPressed: (selected == null || isSubmitting) ? null : _onPrimaryButtonTap,
              child: isSubmitting
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                    )
                  : Text(
                      _phase == _QuizPhase.reviewing && _isLastQuestion ? 'Selesai' : 'Lanjut',
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
            ),
          ),
        ),
      ],
    );
  }
}

class _OptionTile extends StatelessWidget {
  const _OptionTile({
    required this.label,
    required this.isSelected,
    required this.feedback,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final QuizAnswerFeedback? feedback;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    // feedback != null berarti tile ini yang dipilih user & sudah masuk
    // fase review — warnai hijau (benar)/coral (Design.md §5.2, bukan
    // merah destructive standar) sesuai R-QUIZ-04.
    Color borderColor = isSelected ? AppColors.ink : AppColors.border;
    Color? bgColor;
    Widget? trailingBadge;

    if (feedback != null) {
      if (feedback!.isCorrect) {
        borderColor = AppColors.success;
        bgColor = AppColors.success.withValues(alpha: 0.08);
      } else {
        borderColor = AppColors.coral;
        bgColor = AppColors.coral.withValues(alpha: 0.08);
      }
      trailingBadge = Container(
        margin: const EdgeInsets.only(top: 6),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
        decoration: BoxDecoration(
          color: (feedback!.isCorrect ? AppColors.success : AppColors.coral).withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          feedback!.isCorrect ? 'Benar!' : 'Kurang tepat',
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.bold,
            color: feedback!.isCorrect ? AppColors.success : AppColors.coral,
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: feedback == null ? onTap : null, // review = read-only
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: bgColor ?? AppColors.surface,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: borderColor, width: isSelected ? 1.5 : 1),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    feedback == null
                        ? (isSelected ? Icons.radio_button_checked : Icons.radio_button_off)
                        : (feedback!.isCorrect ? Icons.check_circle : Icons.cancel),
                    size: 20,
                    color: feedback == null
                        ? (isSelected ? AppColors.ink : AppColors.textDisabled)
                        : (feedback!.isCorrect ? AppColors.success : AppColors.coral),
                  ),
                  const SizedBox(width: 12),
                  Expanded(child: Text(label, style: const TextStyle(fontSize: 15))),
                ],
              ),
              if (trailingBadge != null) trailingBadge,
            ],
          ),
        ),
      ),
    );
  }
}