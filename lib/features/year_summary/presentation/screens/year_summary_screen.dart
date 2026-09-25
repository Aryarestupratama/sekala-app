import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../shared/models/year.dart';
import '../../../../shared/models/year_summary_attempt.dart';
import '../../../../shared/models/year_summary_point.dart';
import '../../../../shared/widgets/pressable_scale.dart';
import '../../../history/presentation/providers/history_providers.dart';
import '../providers/year_summary_providers.dart';

/// Halaman Rangkuman Wabah — muncul setelah SELURUH section dalam satu
/// `year` completed (Design.md §3.3 poin 4, INFO-04).
///
/// REVISI TOTAL (Rangkuman Interaktif, pola "correct statement" mirip H5P
/// Single Choice Set — menggantikan revisi infografis sebelumnya):
/// - `Year.summaryImageUrl` (gambar statis) SUDAH DIHAPUS dari model,
///   digantikan endpoint terpisah `GET /years/{year}/summary`
///   (`yearSummaryAttemptProvider`) — 7 poin correct-statement, opsi
///   diacak backend tiap request.
/// - Kalau `year.yearSummaryCompleted == false`: langsung mulai widget 7
///   poin (`_SummaryAttemptFlow`) — satu per satu, progress bar + tombol
///   "Lanjut" manual (SUM-01/02).
/// - Kalau `year.yearSummaryCompleted == true`: tampilkan pilihan
///   "Lihat Rangkuman" (`_ChoiceView`, langsung ke Rangkuman Lengkap
///   tersimpan) atau "Kerjakan Ulang" (mulai `_SummaryAttemptFlow` dari
///   poin 1, hasil lama ditimpa — SUM-05/R-SUM-11).
/// - Setelah 7 poin selesai (baik pengerjaan pertama maupun ulang),
///   tampil "Rangkuman Lengkap" (`_FullSummaryView`, SUM-03) + badge
///   "Sempurna!" kalau benar semua di percobaan pertama (SUM-04, murni
///   kosmetik) — DIIKUTI quote -> referensi -> vaksin -> tombol Kuis,
///   urutan sama persis dengan sebelumnya (Design.md §3.3.4).
class YearSummaryScreen extends ConsumerWidget {
  const YearSummaryScreen({
    super.key,
    required this.yearId,
    required this.eraSlug,
  });

  final int yearId;
  final String eraSlug;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final yearAsync =
        ref.watch(yearInEraProvider((eraSlug: eraSlug, yearId: yearId)));
    final attemptAsync = ref.watch(yearSummaryAttemptProvider(yearId));
    final accent = EraAccents.ofSlug(eraSlug);

    // PENTING (fix bug "klik Lihat Rangkuman Lengkap malah ngulang dari
    // awal"): dulu pakai `yearAsync.when(loading: ...)` — begitu
    // `YearSummaryController.submit()` sukses dan invalidate
    // `yearsProvider(eraSlug)`, provider ini (turunannya) sempat balik ke
    // state loading sesaat sambil re-fetch di background. `.when()` dengan
    // cabang `loading` MENGGANTI SELURUH widget tree jadi spinner, yang
    // artinya `_SummaryScreenBody` (dan State lokalnya, termasuk
    // `_justSubmitted` yang baru saja diisi hasil submit) ikut DI-DISPOSE.
    // Begitu fetch baru selesai, `_SummaryScreenBody` dibangun ulang dari
    // nol (State baru, `_justSubmitted` balik null) — karena
    // `attemptAsync` sendiri TIDAK ikut ke-invalidate, `attempt.completion`
    // yang dibaca masih cache lama (null), jadi jatuhnya balik ke
    // `_SummaryAttemptFlow` alias mulai dari poin 1 lagi.
    //
    // Fix: cek `.hasValue` dulu (bukan `.when(loading:...)`) supaya data
    // LAMA tetap dipakai selama refresh di background berlangsung — layar
    // tidak pernah di-teardown ke spinner selama sudah pernah punya data,
    // jadi State lokal (`_justSubmitted`) tetap hidup.
    Widget body;
    if (yearAsync.hasValue && yearAsync.value == null) {
      body = const Center(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Text('Data tahun tidak ditemukan.', style: TextStyle(color: AppColors.textSecondary)),
        ),
      );
    } else if (yearAsync.hasValue && attemptAsync.hasValue) {
      body = _SummaryScreenBody(
        year: yearAsync.value!,
        attempt: attemptAsync.value!,
        eraSlug: eraSlug,
        accent: accent,
      );
    } else if (yearAsync.hasError && !yearAsync.hasValue) {
      body = Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.error_outline_rounded, size: 40, color: AppColors.textSecondary.withValues(alpha: 0.6)),
              const SizedBox(height: 12),
              Text(
                'Gagal memuat data tahun: ${yearAsync.error}',
                textAlign: TextAlign.center,
                style: const TextStyle(color: AppColors.textSecondary),
              ),
            ],
          ),
        ),
      );
    } else if (attemptAsync.hasError && !attemptAsync.hasValue) {
      // Termasuk kasus 403 (section belum semua completed) atau 404
      // (rangkuman belum published admin) — pesan generik dari
      // ApiException, sama pola dengan QuizScreen.
      body = Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.lock_outline_rounded, size: 40, color: AppColors.textSecondary.withValues(alpha: 0.6)),
              const SizedBox(height: 12),
              Text(
                'Rangkuman belum bisa diakses: ${attemptAsync.error}',
                textAlign: TextAlign.center,
                style: const TextStyle(color: AppColors.textSecondary),
              ),
            ],
          ),
        ),
      );
    } else {
      // Belum pernah punya data sama sekali (initial load) -> baru di sini
      // spinner boleh menggantikan seluruh body, karena belum ada State
      // penting yang bisa hilang.
      body = Center(child: CircularProgressIndicator(color: accent));
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        title: const Text('Rangkuman', style: TextStyle(fontWeight: FontWeight.w800)),
      ),
      body: body,
    );
  }
}

/// Router 3 kondisi berdasarkan `attempt.completion` DAN state lokal
/// "user sedang mengerjakan ulang" (`_forceAttempt`) — dipisah dari
/// provider karena "Kerjakan Ulang" itu keputusan UI sementara, bukan
/// state server (server baru tahu attempt baru selesai setelah submit).
class _SummaryScreenBody extends StatefulWidget {
  const _SummaryScreenBody({
    required this.year,
    required this.attempt,
    required this.eraSlug,
    required this.accent,
  });

  final Year year;
  final YearSummaryAttempt attempt;
  final String eraSlug;
  final Color accent;

  @override
  State<_SummaryScreenBody> createState() => _SummaryScreenBodyState();
}

class _SummaryScreenBodyState extends State<_SummaryScreenBody> {
  bool _forceAttempt = false;

  /// Diisi begitu attempt (baru atau ulang) selesai submit — dipakai
  /// supaya Rangkuman Lengkap yang tampil adalah hasil attempt BARU SAJA
  /// (termasuk badge Sempurna-nya), tanpa nunggu refetch provider (yang
  /// tetap terjadi di background lewat invalidate di controller).
  YearSummarySubmitResultLocal? _justSubmitted;

  @override
  Widget build(BuildContext context) {
    final hasSavedCompletion = widget.attempt.completion != null;

    if (_justSubmitted != null) {
      return _FullSummaryView(
        year: widget.year,
        eraSlug: widget.eraSlug,
        accent: widget.accent,
        fullSummary: _justSubmitted!.fullSummary,
        isPerfect: _justSubmitted!.isPerfect,
        quizUnlocked: _justSubmitted!.quizUnlocked,
      );
    }

    if (hasSavedCompletion && !_forceAttempt) {
      return _ChoiceView(
        year: widget.year,
        eraSlug: widget.eraSlug,
        accent: widget.accent,
        fullSummary: widget.attempt.fullSummary ?? const [],
        isPerfect: widget.attempt.completion!.isPerfect,
        onRetake: () => setState(() => _forceAttempt = true),
      );
    }

    return _SummaryAttemptFlow(
      yearId: widget.year.id,
      points: widget.attempt.points,
      accent: widget.accent,
      onCompleted: (result) => setState(() => _justSubmitted = YearSummarySubmitResultLocal(
            fullSummary: result.fullSummary,
            isPerfect: result.isPerfect,
            quizUnlocked: result.quizUnlocked,
          )),
      eraSlug: widget.eraSlug,
    );
  }
}

/// Kelas kecil lokal (bukan model API) — cuma wadah 3 field yang dipakai
/// `_FullSummaryView` setelah submit, biar `_SummaryScreenBodyState` tidak
/// perlu import `YearSummarySubmitResult` penuh cuma untuk 3 field ini.
class YearSummarySubmitResultLocal {
  const YearSummarySubmitResultLocal({
    required this.fullSummary,
    required this.isPerfect,
    required this.quizUnlocked,
  });

  final List<String> fullSummary;
  final bool isPerfect;
  final bool quizUnlocked;
}

/// Tampilan pilihan "Lihat Rangkuman" / "Kerjakan Ulang" (SUM-05) — muncul
/// kalau `year.yearSummaryCompleted == true` dan user belum menekan
/// "Kerjakan Ulang" di sesi ini.
class _ChoiceView extends StatelessWidget {
  const _ChoiceView({
    required this.year,
    required this.eraSlug,
    required this.accent,
    required this.fullSummary,
    required this.isPerfect,
    required this.onRetake,
  });

  final Year year;
  final String eraSlug;
  final Color accent;
  final List<String> fullSummary;
  final bool isPerfect;
  final VoidCallback onRetake;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 32, 20, 32),
      children: [
        Container(
          width: 88,
          height: 88,
          margin: const EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(color: accent.withValues(alpha: 0.12), shape: BoxShape.circle),
          alignment: Alignment.center,
          child: Icon(Icons.fact_check_rounded, size: 40, color: accent),
        ),
        const Text(
          'Kamu sudah menyelesaikan rangkuman wabah ini.',
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.w800, fontSize: 17),
        ),
        const SizedBox(height: 8),
        const Text(
          'Mau lihat rangkumannya lagi, atau kerjakan ulang dari awal?',
          textAlign: TextAlign.center,
          style: TextStyle(color: AppColors.textSecondary),
        ),
        const SizedBox(height: 28),
        PressableScale(
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute<void>(
              builder: (_) => Scaffold(
                backgroundColor: AppColors.background,
                appBar: AppBar(
                  backgroundColor: AppColors.surface,
                  elevation: 0,
                  surfaceTintColor: Colors.transparent,
                  title: const Text('Rangkuman', style: TextStyle(fontWeight: FontWeight.w800)),
                ),
                body: _FullSummaryView(
                  year: year,
                  eraSlug: eraSlug,
                  accent: accent,
                  fullSummary: fullSummary,
                  isPerfect: isPerfect,
                  // Tombol Kuis di sini pasti aktif — kalau
                  // completion tersimpan sudah ada, section pasti
                  // sudah completed & rangkuman pasti sudah selesai.
                  quizUnlocked: true,
                ),
              ),
            ),
          ),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 16),
            decoration: BoxDecoration(color: AppColors.ink, borderRadius: BorderRadius.circular(28)),
            alignment: Alignment.center,
            child: const Text(
              'Lihat Rangkuman',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        const SizedBox(height: 12),
        PressableScale(
          onTap: onRetake,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(28),
              border: Border.all(color: AppColors.border, width: 1.5),
            ),
            alignment: Alignment.center,
            child: const Text('Kerjakan Ulang', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ),
      ],
    );
  }
}

/// Alur mengerjakan 7 poin (SUM-01/02) — dipakai baik pengerjaan pertama
/// maupun "Kerjakan Ulang" (props sama, poin selalu opsi teracak baru
/// dari `attempt.points` yang sama).
class _SummaryAttemptFlow extends ConsumerStatefulWidget {
  const _SummaryAttemptFlow({
    required this.yearId,
    required this.points,
    required this.accent,
    required this.onCompleted,
    required this.eraSlug,
  });

  final int yearId;
  final List<YearSummaryPoint> points;
  final Color accent;
  final String eraSlug;
  final void Function(YearSummarySubmitResultForFlow result) onCompleted;

  @override
  ConsumerState<_SummaryAttemptFlow> createState() => _SummaryAttemptFlowState();
}

/// Sama alasan dengan YearSummarySubmitResultLocal — potongan minimal dari
/// `YearSummarySubmitResult` yang dibutuhkan callback `onCompleted`.
class YearSummarySubmitResultForFlow {
  const YearSummarySubmitResultForFlow({
    required this.fullSummary,
    required this.isPerfect,
    required this.quizUnlocked,
  });

  final List<String> fullSummary;
  final bool isPerfect;
  final bool quizUnlocked;
}

class _SummaryAttemptFlowState extends ConsumerState<_SummaryAttemptFlow> {
  late final List<YearSummaryPoint> _points;
  int _index = 0;

  /// optionId yang dipilih untuk poin AKTIF, null sebelum dijawab.
  int? _selectedOptionId;

  /// Hasil cek poin aktif dari backend, null sebelum dijawab.
  bool? _isCorrect;
  int? _correctOptionId;
  String? _correctOptionText;

  bool _isChecking = false;
  bool _isSubmitting = false;

  /// Kumpulan jawaban {pointId: optionId} — dikirim SEKALIGUS ke
  /// `submit()` setelah poin ke-7 dijawab (bukan progresif per-poin ke
  /// backend seperti checkAnswer, karena checkAnswer TIDAK disimpan).
  final Map<int, int> _answers = {};

  /// Berapa poin yang benar di PERCOBAAN PERTAMA — dipakai hitung badge
  /// "Sempurna!" di client SEBELUM submit (server tetap hitung ulang
  /// sendiri untuk field `is_perfect` yang sesungguhnya dipakai/disimpan,
  /// lihat YearSummaryService::submitAttempt() — nilai lokal ini murni
  /// buat referensi, TIDAK dikirim ke backend).
  int _correctCount = 0;

  @override
  void initState() {
    super.initState();
    _points = [...widget.points]..sort((a, b) => a.order.compareTo(b.order));
  }

  YearSummaryPoint get _currentPoint => _points[_index];
  bool get _isLastPoint => _index == _points.length - 1;
  bool get _isAnswered => _isCorrect != null;

  Future<void> _selectOption(int optionId) async {
    if (_isAnswered || _isChecking) return;

    setState(() {
      _selectedOptionId = optionId;
      _isChecking = true;
    });

    final result = await ref.read(yearSummaryControllerProvider.notifier).checkAnswer(
          yearId: widget.yearId,
          pointId: _currentPoint.id,
          optionId: optionId,
        );

    if (!mounted) return;

    if (result == null) {
      setState(() {
        _selectedOptionId = null;
        _isChecking = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Gagal memeriksa jawaban, coba lagi.')),
      );
      return;
    }

    _answers[_currentPoint.id] = optionId;
    if (result.isCorrect) _correctCount++;

    setState(() {
      _isCorrect = result.isCorrect;
      _correctOptionId = result.correctOption.id;
      _correctOptionText = result.correctOption.optionText;
      _isChecking = false;
    });
  }

  Future<void> _onPrimaryButtonTap() async {
    if (!_isAnswered || _isSubmitting) return;

    if (!_isLastPoint) {
      setState(() {
        _index += 1;
        _selectedOptionId = null;
        _isCorrect = null;
        _correctOptionId = null;
        _correctOptionText = null;
      });
      return;
    }

    // Poin ke-7 sudah dijawab -> submit sekaligus (SUM-05).
    setState(() => _isSubmitting = true);
    final result = await ref.read(yearSummaryControllerProvider.notifier).submit(
          yearId: widget.yearId,
          answers: _answers,
          eraSlug: widget.eraSlug,
        );
    if (!mounted) return;

    if (result == null) {
      setState(() => _isSubmitting = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Gagal menyimpan rangkuman, coba lagi.')),
      );
      return;
    }

    widget.onCompleted(YearSummarySubmitResultForFlow(
      fullSummary: result.fullSummary,
      isPerfect: result.isPerfect,
      quizUnlocked: result.quizUnlocked,
    ));
  }

  @override
  Widget build(BuildContext context) {
    // Sama alasan dengan QuizScreen: pastikan controller (.autoDispose)
    // tidak di-dispose Riverpod di tengah await checkAnswer()/submit().
    ref.watch(yearSummaryControllerProvider);

    final total = _points.length;

    return Column(
      children: [
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
              'Poin ${_index + 1} dari $total',
              style: const TextStyle(color: AppColors.textSecondary, fontSize: 13),
            ),
          ),
        ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
            children: [
              const Text(
                'Pilih kalimat yang paling sesuai dengan materi yang sudah kamu baca:',
                style: TextStyle(color: AppColors.textSecondary, fontSize: 13),
              ),
              const SizedBox(height: 12),
              // R-SUM-02: opsi yang MASIH tampil tergantung status jawab —
              // belum dijawab -> 3 opsi; benar -> cuma kalimat benar;
              // salah -> pilihan user + kalimat benar (pengecoh lain
              // disembunyikan), BEDA dari QuizScreen yang selalu tampilkan
              // semua opsi.
              if (!_isAnswered)
                for (final option in _currentPoint.options)
                  _SummaryOptionTile(
                    label: option.optionText,
                    isSelected: _selectedOptionId == option.id,
                    state: _OptionVisualState.neutral,
                    onTap: () => _selectOption(option.id),
                  )
              else ...[
                if (_isCorrect == false)
                  _SummaryOptionTile(
                    label: _currentPoint.options
                        .firstWhere((o) => o.id == _selectedOptionId)
                        .optionText,
                    isSelected: true,
                    state: _OptionVisualState.wrongSelected,
                    onTap: () {},
                  ),
                if (_isCorrect == false) const SizedBox(height: 4),
                _SummaryOptionTile(
                  label: _correctOptionText ?? '',
                  isSelected: _isCorrect == true,
                  state: _OptionVisualState.correct,
                  onTap: () {},
                ),
              ],
              if (_isAnswered) ...[
                const SizedBox(height: 8),
                _ExplanationBox(isCorrect: _isCorrect!).animate().fadeIn(duration: 200.ms).slideY(begin: 0.08, end: 0),
              ],
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
          child: Builder(
            builder: (context) {
              final disabled = !_isAnswered || _isChecking || _isSubmitting;
              final busy = _isChecking || _isSubmitting;
              return Opacity(
                opacity: disabled && !busy ? 0.5 : 1.0,
                child: PressableScale(
                  onTap: disabled ? null : _onPrimaryButtonTap,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(color: widget.accent, borderRadius: BorderRadius.circular(28)),
                    alignment: Alignment.center,
                    child: busy
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                          )
                        : Text(
                            _isLastPoint ? 'Lihat Rangkuman Lengkap' : 'Lanjut',
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.white),
                          ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

enum _OptionVisualState { neutral, correct, wrongSelected }

class _SummaryOptionTile extends StatelessWidget {
  const _SummaryOptionTile({
    required this.label,
    required this.isSelected,
    required this.state,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final _OptionVisualState state;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    Color borderColor = isSelected ? AppColors.ink : AppColors.border;
    Color? bgColor;
    IconData icon = isSelected ? Icons.radio_button_checked : Icons.radio_button_off;
    Color iconColor = isSelected ? AppColors.ink : AppColors.textDisabled;

    if (state == _OptionVisualState.correct) {
      borderColor = AppColors.success;
      bgColor = AppColors.success.withValues(alpha: 0.08);
      icon = Icons.check_circle_rounded;
      iconColor = AppColors.success;
    } else if (state == _OptionVisualState.wrongSelected) {
      borderColor = AppColors.coral;
      bgColor = AppColors.coral.withValues(alpha: 0.08);
      icon = Icons.cancel_rounded;
      iconColor = AppColors.coral;
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: state == _OptionVisualState.neutral ? onTap : null,
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
              Icon(icon, size: 20, color: iconColor),
              const SizedBox(width: 12),
              Expanded(child: Text(label, style: const TextStyle(fontSize: 15, height: 1.3))),
            ],
          ),
        ),
      ),
    );
  }
}

class _ExplanationBox extends StatelessWidget {
  const _ExplanationBox({required this.isCorrect});

  final bool isCorrect;

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
        children: [
          Icon(isCorrect ? Icons.check_circle : Icons.info_outline, size: 20, color: color),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              isCorrect ? 'Tepat sekali!' : 'Kurang tepat — ini kalimat yang benar.',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: color),
            ),
          ),
        ],
      ),
    );
  }
}

/// "Rangkuman Lengkap" (SUM-03) — 7 kalimat benar dirangkai jadi 1
/// bacaan utuh, diikuti quote -> referensi -> vaksin -> tombol Kuis,
/// urutan SAMA PERSIS dengan tampilan lama (Design.md §3.3.4).
class _FullSummaryView extends StatelessWidget {
  const _FullSummaryView({
    required this.year,
    required this.eraSlug,
    required this.accent,
    required this.fullSummary,
    required this.isPerfect,
    required this.quizUnlocked,
  });

  final Year year;
  final String eraSlug;
  final Color accent;
  final List<String> fullSummary;
  final bool isPerfect;
  final bool quizUnlocked;

  bool get _hasQuote => year.quoteText != null && year.quoteText!.trim().isNotEmpty;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
      children: [
        Row(
          children: [
            Text(
              '${eraSlug[0].toUpperCase()}${eraSlug.substring(1)} · ${year.year}',
              style: TextStyle(color: accent, fontWeight: FontWeight.bold, fontSize: 13),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(year.title, style: Theme.of(context).textTheme.headlineMedium),
        const SizedBox(height: 20),

        // SUM-04: badge kosmetik — TIDAK ada makna sistem apa pun selain
        // tampilan, tidak memengaruhi unlock vaksin/kuis.
        if (isPerfect) ...[
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: AppColors.gamify.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Row(
              children: [
                Icon(Icons.stars_rounded, color: AppColors.gamify, size: 22),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Sempurna! Kamu benar di semua poin percobaan pertama.',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ).animate().fadeIn(duration: 250.ms).scale(begin: const Offset(0.96, 0.96)),
          const SizedBox(height: 16),
        ],

        const Text(
          'RANGKUMAN',
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.bold,
            color: AppColors.textSecondary,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 8),
        if (fullSummary.isEmpty)
          const Text(
            'Rangkuman untuk wabah ini belum tersedia.',
            style: TextStyle(color: AppColors.textSecondary),
          )
        else
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: AppColors.border),
              boxShadow: [
                BoxShadow(color: AppColors.ink.withValues(alpha: 0.04), blurRadius: 14, offset: const Offset(0, 6)),
              ],
            ),
            child: Text(
              fullSummary.join(' '),
              style: const TextStyle(fontSize: 15, height: 1.6),
            ),
          ),

        if (_hasQuote) ...[
          const SizedBox(height: 24),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: accent.withValues(alpha: 0.06),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: accent.withValues(alpha: 0.2)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.format_quote_rounded, color: accent, size: 20),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    year.quoteText!,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontStyle: FontStyle.italic,
                          height: 1.5,
                        ),
                  ),
                ),
              ],
            ),
          ),
        ],

        if (year.references.isNotEmpty) ...[
          const SizedBox(height: 24),
          const Text(
            'REFERENSI',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: AppColors.textSecondary,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 8),
          for (var i = 0; i < year.references.length; i++)
            Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${i + 1}. ', style: const TextStyle(color: AppColors.textSecondary, fontSize: 12)),
                  Expanded(
                    child: Text(
                      year.references[i],
                      style: const TextStyle(color: AppColors.textSecondary, fontSize: 12, height: 1.4),
                    ),
                  ),
                ],
              ),
            ),
        ],

        if (year.vaccines.isNotEmpty) ...[
          const SizedBox(height: 24),
          const Text(
            'VAKSIN TERKAIT',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: AppColors.textSecondary,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final v in year.vaccines)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(999),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.vaccines_rounded, size: 14, color: AppColors.gamify),
                      const SizedBox(width: 6),
                      Text(v.name, style: const TextStyle(fontSize: 12.5, fontWeight: FontWeight.w600)),
                    ],
                  ),
                ),
            ],
          ),
        ],

        const SizedBox(height: 40),
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.border),
            boxShadow: [
              BoxShadow(color: AppColors.ink.withValues(alpha: 0.04), blurRadius: 14, offset: const Offset(0, 6)),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'LANGKAH TERAKHIR',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textSecondary,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                'Kerjakan kuis singkat untuk menyelesaikan wabah ini.',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
              ),
              const SizedBox(height: 4),
              const Text(
                'Kuis berskor — nilai minimum kelulusan 75%. Boleh dikerjakan ulang kalau belum lulus.',
                style: TextStyle(fontSize: 12, color: AppColors.textSecondary, fontStyle: FontStyle.italic),
              ),
              const SizedBox(height: 16),
              Builder(
                builder: (context) {
                  // SUM-06: quizUnlocked seharusnya SELALU true di titik
                  // ini (rangkuman baru selesai = section pasti sudah
                  // completed juga) — tetap dibuat non-tappable kalau
                  // somehow false, biar tidak menyesatkan user tap tombol
                  // mati.
                  return Opacity(
                    opacity: quizUnlocked ? 1.0 : 0.5,
                    child: PressableScale(
                      onTap: !quizUnlocked
                          ? null
                          : () => context.go(
                                '/year/${year.id}/quiz?era=$eraSlug&title=${Uri.encodeComponent(year.title)}',
                              ),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        decoration: BoxDecoration(color: AppColors.ink, borderRadius: BorderRadius.circular(28)),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.edit_note_rounded, size: 20, color: Colors.white),
                            SizedBox(width: 8),
                            Text('Kerjakan Kuis', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}