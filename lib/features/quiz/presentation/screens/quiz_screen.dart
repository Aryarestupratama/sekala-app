import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../shared/models/era.dart';
import '../../../../shared/models/quiz.dart';
import '../../../../shared/models/quiz_answer_check_result.dart';
import '../../../../shared/models/quiz_question.dart';
import '../../../../shared/models/quiz_question_option.dart';
import '../../../../shared/models/quiz_show_response.dart';
import '../../../../shared/widgets/pressable_scale.dart';
import '../../../card/presentation/providers/card_providers.dart';
import '../providers/quiz_providers.dart';

/// Halaman Kuis in-app (Design.md §3.3 poin 5, mockup referensi Image 3).
///
/// REVISI BESAR (kuis formatif kini berskor + passing grade 75% + boleh
/// retake, menggantikan filosofi lama "tanpa skor"):
/// 1. Endpoint `GET .../quiz` sekarang membungkus quiz dalam
///    `QuizShowResponse` (passing_grade/question_count/attempt_status/
///    latest_score). Layar SEKARANG WAJIB menampilkan info passing grade
///    ke user SEBELUM masuk soal pertama (`_QuizIntro`) — tidak boleh
///    langsung lompat ke soal pertama seperti versi lama.
/// 2. Skema jawab per soal ("instan") TIDAK berubah: user tap 1 opsi ->
///    `POST /quiz/questions/{id}/answer`, feedback instan tampil.
/// 3. BARU: begitu soal TERAKHIR dijawab (`quizCompleted == true`),
///    response membawa `finalScore`/`isPassing`. Kalau `isPassing ==
///    false`, TIDAK langsung `_finish()` seperti versi lama — tampilkan
///    `_FailedResultView` dengan opsi "Kerjakan Ulang" (panggil
///    `POST .../quiz/retry` dulu) sebelum bisa menjawab lagi. Kalau
///    `isPassing == true`, alur `_finish()` (unlock vaksin dsb) SAMA
///    seperti sebelumnya.
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
    final accent = EraAccents.ofSlug(eraSlug);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: quizAsync.when(
          data: (response) {
            if (!response.quiz.isPublished || response.quiz.questions.isEmpty) {
              return _QuizUnavailable(eraSlug: eraSlug);
            }
            return _QuizFlow(
              response: response,
              yearId: yearId,
              eraSlug: eraSlug,
              yearTitle: yearTitle,
              accent: accent,
            );
          },
          loading: () => Center(child: CircularProgressIndicator(color: accent)),
          // Termasuk kasus 403 (R-QUIZ-02: belum semua section completed)
          // — tampil sebagai pesan error generik dari ApiException.
          error: (error, _) => Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.lock_outline_rounded, size: 40, color: AppColors.textSecondary.withValues(alpha: 0.6)),
                  const SizedBox(height: 12),
                  Text(
                    'Kuis belum bisa diakses: $error',
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: AppColors.textSecondary),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// BARU (fix bug: tombol "Kembali" tidak berbuat apa-apa) — halaman kuis
/// ini bisa dibuka dengan `context.push()` (ada history untuk di-pop) ATAU
/// `context.go()`/deep link (TIDAK ada history sama sekali). Pakai
/// `Navigator.maybePop()`/`context.pop()` polos di kasus kedua bikin
/// tombol "Kembali" kelihatan macet (tidak melakukan apa-apa). Helper ini
/// selalu punya fallback yang jelas: pop kalau bisa, kalau tidak baru
/// pindah ke roadmap era via `context.go()`.
void _safeBack(BuildContext context, String eraSlug) {
  if (context.canPop()) {
    context.pop();
  } else {
    context.go('/history/$eraSlug');
  }
}


class _QuizUnavailable extends StatelessWidget {
  const _QuizUnavailable({required this.eraSlug});

  final String eraSlug;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.quiz_rounded, size: 40, color: AppColors.textDisabled),
            const SizedBox(height: 12),
            const Text(
              'Kuis untuk wabah ini belum tersedia.',
              textAlign: TextAlign.center,
              style: TextStyle(color: AppColors.textSecondary),
            ),
            const SizedBox(height: 16),
            TextButton(onPressed: () => _safeBack(context, eraSlug), child: const Text('Kembali')),
          ],
        ),
      ),
    );
  }
}

/// BARU — pengatur transisi Intro (info passing grade) -> Body (soal-soal)
/// -> FailedResult (kalau gagal, sebelum retry). Dipisah dari `_QuizBody`
/// lama supaya `_QuizBody` tetap fokus di logic jawab-per-soal.
class _QuizFlow extends ConsumerStatefulWidget {
  const _QuizFlow({
    required this.response,
    required this.yearId,
    required this.eraSlug,
    required this.accent,
    this.yearTitle,
  });

  final QuizShowResponse response;
  final int yearId;
  final String eraSlug;
  final Color accent;
  final String? yearTitle;

  @override
  ConsumerState<_QuizFlow> createState() => _QuizFlowState();
}

class _QuizFlowState extends ConsumerState<_QuizFlow> {
  /// Kalau user sudah menekan "Mulai"/"Lanjutkan"/"Kerjakan Ulang" di
  /// layar intro, kita masuk ke `_QuizBody`. Kalau `attempt_status ==
  /// passed` (sudah lulus sebelumnya), TIDAK PERNAH masuk ke sini —
  /// intro-nya sendiri sudah final (lihat `_QuizIntro`).
  bool _entered = false;

  /// Diset true setelah soal terakhir dijawab TAPI gagal (isPassing ==
  /// false) — dipakai untuk render `_FailedResultView` alih-alih
  /// `_QuizBody`.
  bool _showFailedResult = false;
  double? _failedScore;

  Future<void> _startOrRetry() async {
    if (widget.response.failed) {
      // R-QUIZ-08: attempt yang gagal wajib di-retry dulu (reset ke
      // kosong) sebelum boleh menjawab lagi.
      final retried = await ref.read(quizRetryControllerProvider.notifier).retry(widget.yearId);
      if (retried == null || !mounted) return; // gagal retry (mis. 422 sudah lulus) — biarkan error tampil di intro
    }
    setState(() {
      _entered = true;
      _showFailedResult = false;
    });
  }

  void _onFailed(double score) {
    setState(() {
      _showFailedResult = true;
      _failedScore = score;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.response.passed) {
      // Sudah lulus sebelumnya — tampilkan ringkasan final, TIDAK ada
      // jalan untuk menjawab lagi (backend juga menolak retry kalau
      // sudah lulus).
      return _QuizIntro(
        response: widget.response,
        yearTitle: widget.yearTitle,
        eraSlug: widget.eraSlug,
        accent: widget.accent,
        onPrimaryPressed: null, // tidak ada aksi, sudah final
      );
    }

    if (_showFailedResult && _failedScore != null) {
      return _FailedResultView(
        score: _failedScore!,
        passingGrade: widget.response.passingGrade,
        isRetrying: ref.watch(quizRetryControllerProvider).isLoading,
        accent: widget.accent,
        onRetry: () async {
          final retried = await ref.read(quizRetryControllerProvider.notifier).retry(widget.yearId);
          if (retried != null && mounted) {
            setState(() {
              _entered = true;
              _showFailedResult = false;
              _failedScore = null;
            });
          }
        },
        onExit: () => _safeBack(context, widget.eraSlug),
      );
    }

    if (!_entered) {
      final retryState = ref.watch(quizRetryControllerProvider);
      return _QuizIntro(
        response: widget.response,
        yearTitle: widget.yearTitle,
        eraSlug: widget.eraSlug,
        accent: widget.accent,
        isLoading: retryState.isLoading,
        errorText: retryState.hasError
            ? 'Gagal memulai ulang kuis: ${retryState.error}'
            : null,
        onPrimaryPressed: _startOrRetry,
      );
    }

    return _QuizBody(
      quiz: widget.response.quiz,
      yearId: widget.yearId,
      eraSlug: widget.eraSlug,
      yearTitle: widget.yearTitle,
      accent: widget.accent,
      onFailed: _onFailed,
    );
  }
}

/// BARU — layar info SEBELUM soal pertama: nama kuis, jumlah soal,
/// passing grade 75%, dan status attempt terkini (belum pernah/lanjut/
/// gagal/lulus). Requirement baru: "minimum passing grade ditampilkan
/// sebelum masuk halaman quiz" — berlaku untuk kuis formatif MAUPUN
/// sumatif (lihat era_quiz_screen.dart untuk versi sumatif).
class _QuizIntro extends StatelessWidget {
  const _QuizIntro({
    required this.response,
    required this.yearTitle,
    required this.eraSlug,
    required this.accent,
    this.isLoading = false,
    this.errorText,
    required this.onPrimaryPressed,
  });

  final QuizShowResponse response;
  final String? yearTitle;
  final String eraSlug;
  final Color accent;
  final bool isLoading;
  final String? errorText;

  /// Null kalau tidak ada aksi (mis. sudah lulus, tinggal ditampilkan).
  final VoidCallback? onPrimaryPressed;

  @override
  Widget build(BuildContext context) {
    final String primaryLabel = switch (response.attemptStatus) {
      'failed' => 'Kerjakan Ulang',
      'in_progress' => 'Lanjutkan',
      _ => 'Mulai Kuis',
    };

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              response.passed ? Icons.emoji_events_rounded : Icons.quiz_rounded,
              size: 44,
              color: response.passed ? AppColors.success : accent,
            ),
            const SizedBox(height: 16),
            Text(
              yearTitle == null ? 'Kuis' : 'Kuis · $yearTitle',
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
            ),
            const SizedBox(height: 12),
            _InfoRow(label: 'Jumlah soal', value: '${response.questionCount} soal'),
            const SizedBox(height: 4),
            _InfoRow(label: 'Nilai minimum kelulusan', value: '${response.passingGrade}%'),
            if (response.latestScore != null) ...[
              const SizedBox(height: 4),
              _InfoRow(
                label: response.passed ? 'Skor kamu' : 'Skor terakhir',
                value: '${response.latestScore!.round()}%',
                valueColor: response.passed ? AppColors.success : AppColors.coral,
              ),
            ],
            const SizedBox(height: 20),
            if (errorText != null) ...[
              Text(errorText!, textAlign: TextAlign.center, style: const TextStyle(color: AppColors.coral, fontSize: 12.5)),
              const SizedBox(height: 12),
            ],
            if (onPrimaryPressed != null)
              _PrimaryCta(
                label: primaryLabel,
                color: accent,
                loading: isLoading,
                onTap: onPrimaryPressed,
              )
            else
              const Text(
                'Kamu sudah lulus kuis ini.',
                style: TextStyle(color: AppColors.textSecondary, fontSize: 13),
              ),
            const SizedBox(height: 12),
            // FIX (bug: tombol "Kembali" di layar sudah lulus tidak
            // bereaksi sama sekali) — dulu pakai _safeBack() yang coba
            // context.pop() dulu kalau canPop() true. Ternyata di layar
            // intro ini, canPop() bisa saja true tapi pop()-nya sendiri
            // jadi no-op (tidak melakukan apa-apa, tergantung struktur
            // router). Karena semantik "kembali" di sini cuma perlu balik
            // ke roadmap (bukan presisi pop ke layar sebelumnya), langsung
            // context.go() saja tanpa coba pop() dulu — selalu pasti jalan.
            TextButton(
              onPressed: () => context.go('/history/$eraSlug'),
              child: const Text('Kembali'),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.label, required this.value, this.valueColor});

  final String label;
  final String value;
  final Color? valueColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('$label: ', style: const TextStyle(color: AppColors.textSecondary, fontSize: 13)),
        Text(
          value,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: valueColor ?? AppColors.ink),
        ),
      ],
    );
  }
}

/// Tombol CTA utama pill, dipakai bersama oleh Intro/FailedResult/Body —
/// gaya sama dengan `PressableScale`+`Container` di layar lain (bukan
/// `FilledButton` bawaan). Kontras teks/spinner dihitung dari kecerahan
/// [color] karena warna era ada yang gelap.
///
/// - [onTap] null -> disabled (abu-abu, tap diabaikan).
/// - [loading] true -> tetap berwarna [color] dengan spinner, tap
///   diabaikan (mencegah double-submit tanpa "berkedip" abu-abu).
class _PrimaryCta extends StatelessWidget {
  const _PrimaryCta({
    required this.label,
    required this.color,
    required this.onTap,
    this.loading = false,
  });

  final String label;
  final Color color;
  final VoidCallback? onTap;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    final active = loading || onTap != null;
    final onColor = ThemeData.estimateBrightnessForColor(color) == Brightness.dark
        ? Colors.white
        : AppColors.ink;

    return Opacity(
      opacity: active ? 1.0 : 0.5,
      child: PressableScale(
        onTap: loading ? null : onTap,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: active ? color : AppColors.border,
            borderRadius: BorderRadius.circular(28),
          ),
          alignment: Alignment.center,
          child: loading
              ? SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(strokeWidth: 2, color: onColor),
                )
              : Text(
                  label,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: active ? onColor : AppColors.textDisabled,
                  ),
                ),
        ),
      ),
    );
  }
}

/// BARU — tampil begitu soal terakhir dijawab TAPI skor < passing grade.
/// Beda dari alur lama yang langsung `_finish()` tanpa syarat lulus.
class _FailedResultView extends StatelessWidget {
  const _FailedResultView({
    required this.score,
    required this.passingGrade,
    required this.isRetrying,
    required this.accent,
    required this.onRetry,
    required this.onExit,
  });

  final double score;
  final int passingGrade;
  final bool isRetrying;
  final Color accent;
  final VoidCallback onRetry;
  final VoidCallback onExit;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.refresh_rounded, size: 44, color: AppColors.coral),
            const SizedBox(height: 16),
            const Text(
              'Belum Lulus',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
            ),
            const SizedBox(height: 8),
            Text(
              'Skor kamu ${score.round()}%, minimal $passingGrade% untuk lulus. Yuk coba lagi!',
              textAlign: TextAlign.center,
              style: const TextStyle(color: AppColors.textSecondary, fontSize: 13.5),
            ),
            const SizedBox(height: 24),
            _PrimaryCta(
              label: 'Kerjakan Ulang',
              color: accent,
              loading: isRetrying,
              onTap: onRetry,
            ),
            const SizedBox(height: 12),
            TextButton(onPressed: onExit, child: const Text('Keluar dari kuis')),
          ],
        ),
      ),
    );
  }
}

class _QuizBody extends ConsumerStatefulWidget {
  const _QuizBody({
    required this.quiz,
    required this.yearId,
    required this.eraSlug,
    required this.onFailed,
    required this.accent,
    this.yearTitle,
  });

  final Quiz quiz;
  final int yearId;
  final String eraSlug;
  final Color accent;
  final String? yearTitle;

  /// BARU — dipanggil begitu soal terakhir dijawab TAPI isPassing ==
  /// false, membawa skor akhir. Parent (`_QuizFlow`) yang menampilkan
  /// `_FailedResultView`, `_QuizBody` sendiri tidak tahu apa-apa soal
  /// retry (separation of concerns, sama pola dengan `onFinished`
  /// implisit lewat context.go() untuk kasus lulus).
  final void Function(double score) onFailed;

  @override
  ConsumerState<_QuizBody> createState() => _QuizBodyState();
}

class _QuizBodyState extends ConsumerState<_QuizBody> {
  late final List<QuizQuestion> _questions;

  /// BARU — urutan opsi diacak SEKALI per soal (bukan tiap render, biar
  /// tidak "lompat-lompat" posisinya tiap kali user pilih jawaban/rebuild)
  /// dan di-cache per question.id supaya konsisten selama sesi mengerjakan
  /// berlangsung.
  late final Map<int, List<QuizQuestionOption>> _shuffledOptionsByQuestionId;

  int _index = 0;

  /// Jawaban yang dipilih untuk soal yang SEDANG AKTIF (bukan riwayat
  /// semua soal — beda dari skema lama yang simpan map lengkap
  /// questionId->optionId di client). Backend yang menyimpan progresif.
  int? _selectedOptionId;

  /// Hasil cek soal aktif, null sebelum dijawab / setelah pindah soal.
  QuizAnswerCheckResult? _result;

  bool _isChecking = false;
  List<int> _newlyUnlockedVaccineIds = const [];

  @override
  void initState() {
    super.initState();
    // BARU: urutan soal & opsi diacak — supaya tiap user dapat urutan
    // beda (bukan lagi urut `order` tetap 1-10). Diacak SEKALI di sini
    // (bukan di build()), supaya tidak berubah-ubah selama sesi
    // mengerjakan berlangsung.
    _questions = [...widget.quiz.questions]..shuffle();
    _shuffledOptionsByQuestionId = {
      for (final q in _questions) q.id: [...q.options]..shuffle(),
    };
  }

  QuizQuestion get _currentQuestion => _questions[_index];
  bool get _isLastQuestion => _index == _questions.length - 1;
  bool get _isAnswered => _result != null;

  Future<void> _selectOption(int optionId) async {
    if (_isAnswered || _isChecking) return; // sudah dijawab / lagi proses -> read-only

    setState(() {
      _selectedOptionId = optionId;
      _isChecking = true;
    });

    QuizAnswerCheckResult? result;
    try {
      result = await ref.read(quizAnswerControllerProvider.notifier).answer(
            yearId: widget.yearId,
            questionId: _currentQuestion.id,
            optionId: optionId,
            eraSlug: widget.eraSlug,
          );
    } catch (_) {
      // Jaring pengaman kedua — answer() sendiri sudah nangani exception
      // & return null, ini buat exception tak terduga lain.
      result = null;
    }
    if (!mounted) return;

    if (result == null) {
      // Gagal cek jawaban (network dsb.) — biarkan user coba pilih lagi,
      // jangan nyangkut di state "sudah pilih tapi belum ada hasil".
      setState(() {
        _selectedOptionId = null;
        _isChecking = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Gagal memeriksa jawaban, coba lagi.')),
      );
      return;
    }

    setState(() {
      _result = result;
      _isChecking = false;
      if (result!.newlyUnlockedVaccineIds.isNotEmpty) {
        _newlyUnlockedVaccineIds = result.newlyUnlockedVaccineIds;
      }
    });
  }

  void _onPrimaryButtonTap() {
    if (!_isAnswered) return; // guard, tombol harusnya disabled

    if (_result!.quizCompleted) {
      // BARU: cek lulus/tidak sebelum _finish(). isPassing null cuma
      // kalau quizCompleted false (tidak mungkin sampai sini), jadi aman
      // pakai `== true` sebagai guard eksplisit.
      if (_result!.isPassing == true) {
        _finish();
      } else {
        widget.onFailed(_result!.finalScore ?? 0);
      }
      return;
    }

    if (!_isLastQuestion) {
      // Reset provider state juga, supaya soal berikutnya tidak sempat
      // "mewarisi" hasil soal sebelumnya sepersekian detik sebelum
      // build ulang.
      ref.read(quizAnswerControllerProvider.notifier).reset();
      setState(() {
        _index += 1;
        _selectedOptionId = null;
        _result = null;
      });
    }
  }

  void _finish() {
    // R-QUIZ-09: LULUS (skor >= 75%) — year completed, vaksin (kalau ada)
    // otomatis ter-unlock. Kalau ada vaksin baru terbuka, tampilkan
    // banner kecil di atas (Design.md §3.3 poin 6) via root Overlay —
    // dipasang SEBELUM navigate supaya tetap hidup lintas halaman
    // (QuizScreen sendiri bakal di-dispose begitu context.go() dipanggil).
    if (_newlyUnlockedVaccineIds.isNotEmpty) {
      ref.invalidate(cardListProvider);
      _showVaccineUnlockBanner(context, _newlyUnlockedVaccineIds.length);
      context.go('/history/${widget.eraSlug}');
      return;
    }

    context.go('/history/${widget.eraSlug}');
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Selamat, kamu lulus kuis ini!')),
    );
  }

  void _confirmExit() {
    if (_selectedOptionId == null && _index == 0) {
      _safeBack(context, widget.eraSlug);
      return;
    }
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Keluar dari kuis?'),
        content: const Text(
          'Jawaban yang sudah kamu isi tersimpan, tapi kuis belum ditandai selesai sampai seluruh soal dijawab dan lulus.',
        ),
        actions: [
          // Ini menutup DIALOG (bukan keluar kuis) — showDialog() selalu
          // mendorong route baru, jadi context.pop() di sini aman tanpa
          // perlu _safeBack.
          TextButton(onPressed: () => context.pop(), child: const Text('Batal')),
          TextButton(
            onPressed: () {
              context.pop(); // tutup dialog
              _safeBack(context, widget.eraSlug); // keluar kuis, dengan fallback
            },
            child: const Text('Keluar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // FIX (dari kasus Bug 2 skema lama — kuis stuck loading di HP fisik):
    // quizAnswerControllerProvider pakai `.autoDispose`, jadi butuh ada
    // listener AKTIF (ref.watch, bukan cuma ref.read di event handler)
    // selama widget ini hidup, supaya provider tidak di-dispose Riverpod
    // di tengah `await` network call answer() masih berjalan (race yang
    // nyaris selalu menang di emulator karena latensi lokal super cepat,
    // tapi kalah di HP fisik).
    ref.watch(quizAnswerControllerProvider);

    final total = _questions.length;
    final isLastAndCompleted = _isAnswered && _result!.quizCompleted;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
          child: Row(
            children: [
              IconButton(icon: const Icon(Icons.close_rounded), onPressed: _confirmExit),
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
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 260),
                    curve: Curves.easeOut,
                    height: 6,
                    decoration: BoxDecoration(
                      color: i <= _index ? widget.accent : AppColors.border,
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
              for (final option in _shuffledOptionsByQuestionId[_currentQuestion.id]!)
                _OptionTile(
                  label: option.optionText,
                  isSelected: _selectedOptionId == option.id,
                  // Opsi yang dipilih user diwarnai sesuai benar/salah;
                  // opsi BENAR (dari correctOptionId) ikut diwarnai hijau
                  // walau bukan yang dipilih user (highlight jawaban
                  // benar saat user salah, PRD.md QUIZ-03).
                  isCorrectOption: _isAnswered && _result!.correctOptionId == option.id,
                  isWrongSelectedOption:
                      _isAnswered && !_result!.isCorrect && _selectedOptionId == option.id,
                  isAnswered: _isAnswered,
                  onTap: () => _selectOption(option.id),
                ),
              // BARU — box keterangan terpisah (bukan menyatu di opsi),
              // warna mengikuti benar/salah jawaban user untuk soal ini.
              if (_isAnswered) ...[
                const SizedBox(height: 8),
                _ExplanationBox(
                  isCorrect: _result!.isCorrect,
                  explanation: _result!.explanation,
                ).animate().fadeIn(duration: 200.ms).slideY(begin: 0.08, end: 0),
              ],
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
          child: _PrimaryCta(
            label: isLastAndCompleted ? 'Lihat Hasil' : 'Lanjut',
            color: widget.accent,
            loading: _isChecking,
            onTap: !_isAnswered ? null : _onPrimaryButtonTap,
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
    required this.isCorrectOption,
    required this.isWrongSelectedOption,
    required this.isAnswered,
    required this.onTap,
  });

  final String label;
  final bool isSelected;

  /// True kalau opsi ini adalah jawaban yang benar (dari
  /// `correctOptionId`) — bisa true meski BUKAN yang dipilih user, kalau
  /// user salah jawab (PRD.md QUIZ-03: opsi benar ikut di-highlight).
  final bool isCorrectOption;

  /// True kalau opsi ini yang DIPILIH user DAN jawabannya salah.
  final bool isWrongSelectedOption;

  final bool isAnswered;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    Color borderColor = isSelected ? AppColors.ink : AppColors.border;
    Color? bgColor;
    Widget? trailingBadge;

    if (isAnswered) {
      if (isCorrectOption) {
        borderColor = AppColors.success;
        bgColor = AppColors.success.withValues(alpha: 0.08);
        trailingBadge = _Badge(
          label: isSelected ? 'Benar!' : 'Jawaban benar',
          color: AppColors.success,
        );
      } else if (isWrongSelectedOption) {
        borderColor = AppColors.coral;
        bgColor = AppColors.coral.withValues(alpha: 0.08);
        trailingBadge = const _Badge(label: 'Kurang tepat', color: AppColors.coral);
      }
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: isAnswered ? null : onTap, // read-only begitu soal dijawab
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: bgColor ?? AppColors.surface,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: borderColor, width: isSelected ? 1.5 : 1),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                !isAnswered
                    ? (isSelected ? Icons.radio_button_checked : Icons.radio_button_off)
                    : (isCorrectOption
                        ? Icons.check_circle_rounded
                        : (isWrongSelectedOption
                            ? Icons.cancel_rounded
                            : Icons.radio_button_off)), // netral, bukan dipilih & bukan yang benar
                size: 20,
                color: !isAnswered
                    ? (isSelected ? AppColors.ink : AppColors.textDisabled)
                    : (isCorrectOption
                        ? AppColors.success
                        : (isWrongSelectedOption ? AppColors.coral : AppColors.textDisabled)),
              ),
              const SizedBox(width: 12),
              Expanded(child: Text(label, style: const TextStyle(fontSize: 15))),
              if (trailingBadge != null) trailingBadge,
            ],
          ),
        ),
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  const _Badge({required this.label, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: color),
      ),
    );
  }
}

/// Box keterangan (`explanation_correct`/`explanation_incorrect`,
/// dipilih server) — SENGAJA dipisah dari `_OptionTile` (bukan menyatu di
/// dalam opsi), muncul di atas tombol "Lanjut"/"Lihat Hasil". TIDAK
/// berubah dari versi sebelumnya (sempat tidak ikut tersalin saat
/// restrukturisasi Intro/FailedResult — sudah diperbaiki di sini).
class _ExplanationBox extends StatelessWidget {
  const _ExplanationBox({required this.isCorrect, required this.explanation});

  final bool isCorrect;
  final String explanation;

  @override
  Widget build(BuildContext context) {
    final color = isCorrect ? AppColors.success : AppColors.coral;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color, width: 1),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            isCorrect ? Icons.check_circle_rounded : Icons.info_outline_rounded,
            size: 20,
            color: color,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isCorrect ? 'Benar!' : 'Kurang tepat',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: color),
                ),
                const SizedBox(height: 4),
                Text(
                  explanation,
                  style: const TextStyle(fontSize: 13, height: 1.4, color: AppColors.ink),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Banner "Kamu telah membuka X koleksi vaksin baru!" — dipasang ke root
/// Overlay (bukan Scaffold/SnackBar biasa) supaya tetap tampil walau
/// halaman yang manggilnya (QuizScreen) sudah di-dispose begitu
/// `context.go()` pindah ke roadmap era. Auto-dismiss sendiri setelah
/// beberapa detik; tap banner langsung ke halaman Koleksi Vaksin.
void _showVaccineUnlockBanner(BuildContext context, int count) {
  final overlay = Overlay.of(context, rootOverlay: true);
  late OverlayEntry entry;
  entry = OverlayEntry(
    builder: (context) => _VaccineUnlockBanner(
      count: count,
      onDismissed: () => entry.remove(),
    ),
  );
  overlay.insert(entry);
}

class _VaccineUnlockBanner extends StatefulWidget {
  const _VaccineUnlockBanner({required this.count, required this.onDismissed});

  final int count;
  final VoidCallback onDismissed;

  @override
  State<_VaccineUnlockBanner> createState() => _VaccineUnlockBannerState();
}

class _VaccineUnlockBannerState extends State<_VaccineUnlockBanner> {
  bool _visible = false;

  @override
  void initState() {
    super.initState();
    // Tunda 1 frame biar transisi slide-in kepakai (bukan langsung
    // full-visible tanpa animasi).
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) setState(() => _visible = true);
    });
    Future.delayed(const Duration(milliseconds: 3200), () {
      if (mounted) setState(() => _visible = false);
    });
    Future.delayed(const Duration(milliseconds: 3700), widget.onDismissed);
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: SafeArea(
        child: AnimatedSlide(
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeOutCubic,
          offset: _visible ? Offset.zero : const Offset(0, -1.2),
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 250),
            opacity: _visible ? 1 : 0,
            // PENTING: banner ini dipasang ke root Overlay (bukan lewat
            // Scaffold/MaterialApp biasa), jadi TIDAK ada ancestor
            // `Material` yang biasanya nyediain DefaultTextStyle sesuai
            // Theme (bodyMedium dsb) — tanpa ini, Text di dalamnya jatuh
            // ke default mentah (font besar & rata tanpa styling), inilah
            // penyebab bug font gede tanpa style. `type: transparency`
            // biar nggak nambah background putih tak terduga, warnanya
            // tetap dari Container di bawah.
            child: Material(
              type: MaterialType.transparency,
              child: GestureDetector(
                // Dari mana pun quiz ini dipanggil, /cards selalu valid buat
                // user login terverifikasi (satu-satunya yang bisa sampai ke
                // layar ini, R-QUIZ-02/09) — jadi aman diarahkan langsung.
                onTap: () => context.go('/cards'),
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  decoration: BoxDecoration(
                    color: AppColors.gamify,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: const [
                      BoxShadow(color: Colors.black26, blurRadius: 12, offset: Offset(0, 4)),
                    ],
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.vaccines_rounded, color: Colors.white),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'Kamu telah membuka ${widget.count} koleksi vaksin baru!',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            height: 1.3,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ).animate().fadeIn(duration: 200.ms),
    );
  }
}