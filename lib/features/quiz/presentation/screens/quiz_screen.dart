import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../shared/models/quiz.dart';
import '../../../../shared/models/quiz_answer_check_result.dart';
import '../../../../shared/models/quiz_question.dart';
import '../../../card/presentation/providers/card_providers.dart';
import '../providers/quiz_providers.dart';

/// Halaman Kuis in-app (Design.md §3.3 poin 5, mockup referensi Image 3).
///
/// SKEMA BARU — "instan per soal" (menggantikan pola submit-di-akhir +
/// replay yang lama):
/// 1. User tap 1 opsi -> LANGSUNG panggil
///    `POST /quiz/questions/{id}/answer` (QuizAnswerController.answer()).
/// 2. Begitu response balik: opsi yang dipilih diwarnai hijau/coral sesuai
///    benar/salah; kalau salah, opsi yang BENAR (dari `correctOptionId`)
///    ikut di-highlight hijau juga (PRD.md QUIZ-03 / Rules.md R-QUIZ-04 —
///    beda dari model `QuizAnswerFeedback` lama yang sengaja tidak
///    membawa opsi benar). Teks `explanation` tampil di BOX TERPISAH di
///    atas tombol "Lanjut" (bukan menyatu di dalam opsi seperti versi
///    lama) supaya tidak terasa "aneh" saat digabung ke tile opsi.
/// 3. Tombol berubah jadi "Lanjut" (atau "Selesai" kalau ini soal
///    terakhir & `quizCompleted == true` dari response) -> pindah ke
///    soal berikutnya, reset state jawaban lokal.
/// 4. TIDAK ADA lagi fase replay/submit terpisah di akhir — backend
///    sudah progresif menyimpan tiap jawaban & otomatis menandai attempt
///    selesai begitu soal terakhir dijawab (lihat quiz_providers.dart).
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
    _questions = [...widget.quiz.questions]..sort((a, b) => a.order.compareTo(b.order));
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
      _finish();
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
    // R-QUIZ-04: tanpa skor/status lulus — cuma konfirmasi selesai.
    // Kalau ada vaksin baru terbuka, tampilkan banner kecil di atas
    // (Design.md §3.3 poin 6) via root Overlay — dipasang SEBELUM
    // navigate supaya tetap hidup lintas halaman (QuizScreen sendiri
    // bakal di-dispose begitu context.go() dipanggil). Detail animasi
    // reveal per-vaksin (locked->unlocked) baru terjadi nanti di halaman
    // Koleksi Vaksin (vaccine_list_screen.dart), bukan di sini.
    if (_newlyUnlockedVaccineIds.isNotEmpty) {
      ref.invalidate(cardListProvider);
      _showVaccineUnlockBanner(context, _newlyUnlockedVaccineIds.length);
      context.go('/history/${widget.eraSlug}');
      return;
    }

    context.go('/history/${widget.eraSlug}');
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Kuis selesai dikerjakan!')),
    );
  }

  void _confirmExit() {
    if (_selectedOptionId == null && _index == 0) {
      context.pop();
      return;
    }
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Keluar dari kuis?'),
        content: const Text(
          'Jawaban yang sudah kamu isi tersimpan, tapi kuis belum ditandai selesai sampai seluruh soal dijawab.',
        ),
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
          child: SizedBox(
            width: double.infinity,
            child: FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.ink,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
              ),
              onPressed: (!_isAnswered || _isChecking) ? null : _onPrimaryButtonTap,
              child: _isChecking
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                    )
                  : Text(
                      isLastAndCompleted ? 'Selesai' : 'Lanjut',
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
            ),
          ),
        ),
      ],
    );
  }
}

/// Box keterangan (`explanation_correct`/`explanation_incorrect`,
/// dipilih server) — SENGAJA dipisah dari `_OptionTile` (bukan menyatu di
/// dalam opsi seperti versi lama), muncul di atas tombol "Lanjut"/
/// "Selesai".
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
            isCorrect ? Icons.check_circle : Icons.info_outline,
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
                        ? Icons.check_circle
                        : (isWrongSelectedOption
                            ? Icons.cancel
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
                      const Icon(Icons.vaccines_outlined, color: Colors.white),
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