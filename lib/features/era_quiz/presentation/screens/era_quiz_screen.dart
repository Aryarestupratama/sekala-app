import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/models/era.dart';
import '../../../../shared/models/era_quiz_start.dart';
import '../../../../shared/models/era_quiz_question_option.dart';
import '../../../../shared/widgets/pressable_scale.dart';
import '../../../../shared/widgets/rich_body_text.dart';
import '../../../history/presentation/providers/history_providers.dart';
import '../providers/era_quiz_providers.dart';
import '../widgets/era_quiz_colors.dart';
import '../widgets/era_quiz_option_tile.dart';

/// GET /api/eras/{era}/quiz + POST .../attempt — ERAQUIZ-01–04.
///
/// REVISI BESAR (soal kini ditarik dari bank formatif per year, random
/// ULANG tiap `GET .../quiz` dipanggil):
/// - `eraQuizProvider` (plain FutureProvider, versi lama) DIHAPUS TOTAL —
///   diganti `EraQuizSessionController`. Fetch HANYA terjadi 1x per sesi,
///   dipicu eksplisit lewat tombol "Mulai Kuis" di layar intro (BARU),
///   BUKAN otomatis saat screen dibuka. Ini mencegah soal berubah diam-
///   diam kalau widget sempat di-rebuild/dispose di tengah user
///   mengerjakan (lihat catatan panjang di era_quiz_providers.dart).
/// - Layar intro (BARU) menampilkan passing grade 75% & jumlah soal
///   SEBELUM user masuk ke soal pertama (requirement baru, sama seperti
///   kuis formatif).
///
/// Layout & warna soal-per-soal TIDAK berubah dari versi sebelumnya:
/// 1 soal per halaman, progress bar segmen + persentase, tombol
/// Sebelumnya/Selanjutnya (berubah jadi "Kirim Jawaban" di soal
/// terakhir, ERAQUIZ-02). Warna aksen ikut era via `EraAccents`.
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

  /// BARU — urutan opsi diacak SEKALI per soal (bukan tiap render) begitu
  /// data attempt pertama kali diterima, dan di-cache di sini supaya
  /// tidak berubah-ubah selama sesi mengerjakan berlangsung. Diisi lazy
  /// di build() (guard null-check), karena soalnya baru tersedia setelah
  /// `EraQuizSessionController.start()` selesai (async).
  Map<int, List<EraQuizQuestionOption>>? _shuffledOptionsByQuestionId;

  /// BARU — true begitu user menekan "Mulai Kuis" di layar intro dan
  /// `EraQuizSessionController.start()` dipanggil. Sebelum ini, TIDAK ADA
  /// request ke backend sama sekali.
  bool _started = false;

  void _selectOption(int questionId, int optionId) {
    setState(() => _answers[questionId] = optionId);
  }

  void _goTo(int index, int totalQuestions) {
    if (index < 0 || index >= totalQuestions) return;
    setState(() => _currentIndex = index);
  }

  /// Tombol X / back sistem sebelumnya langsung keluar: 20 soal berisi
  /// jawaban hanya hidup di State lokal ini, jadi keluar di soal ke-15
  /// membuang semuanya tanpa peringatan.
  Future<void> _confirmExit(Era? era) async {
    if (_answers.isEmpty) {
      _leave(era);
      return;
    }
    final leave = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Keluar dari kuis sumatif?'),
        content: const Text(
          'Jawabanmu belum dikirim dan akan hilang. Kamu bisa mengerjakan '
          'ulang kapan saja, tapi soalnya akan diacak lagi.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: const Text('Lanjut mengerjakan'),
          ),
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            style: TextButton.styleFrom(foregroundColor: AppColors.ink),
            child: const Text('Keluar'),
          ),
        ],
      ),
    );
    if (leave == true && mounted) _leave(era);
  }

  void _leave(Era? era) {
    if (context.canPop()) {
      context.pop();
    } else {
      context.go(era == null ? '/history' : '/history/${era.slug}');
    }
  }

  Future<void> _start() async {
    setState(() => _started = true);
    await ref.read(eraQuizSessionControllerProvider.notifier).start(widget.eraId);
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

    if (!mounted) return;

    if (result != null) {
      // Ganti (bukan push) supaya user tidak bisa "back" ke layar
      // pengerjaan kuis yang sudah selesai disubmit.
      context.pushReplacement('/era-quiz/${widget.eraId}/result');
      return;
    }

    // FIX (bug: submit gagal tapi diam saja, kelihatan "tidak terjadi
    // apa-apa") — result null berarti submit() di controller menangkap
    // exception (mis. 422 validasi "answers harus tepat 20", 403 belum
    // unlocked, dsb). Tampilkan pesan error asli ke user, jangan biarkan
    // tombol cuma balik ke kondisi semula tanpa penjelasan.
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Jawaban belum terkirim. Jawabanmu masih ada di layar ini, '
          'periksa koneksimu lalu tekan Kirim Jawaban lagi.',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // FIX (bug: "Tried to use EraQuizSessionController after dispose was
    // called") — provider ini `.autoDispose`. Kalau di-watch HANYA di
    // dalam cabang `_started == true`, maka pada saat `_start()` pertama
    // kali memanggil `notifier.start(...)`, BELUM ADA listener aktif sama
    // sekali (watch baru terjadi di rebuild berikutnya, satu frame
    // sesudahnya) — provider langsung di-dispose Riverpod sebelum
    // `start()` sempat selesai nyimpen `state`, karena `ref.read()` di
    // `_start()` tidak menghitung sebagai listener yang mempertahankan
    // provider tetap hidup. Watch di sini TANPA SYARAT (selalu, bahkan
    // saat `!_started`) supaya listener sudah terpasang sebelum tombol
    // "Mulai Kuis" ditekan sama sekali.
    final sessionState = ref.watch(eraQuizSessionControllerProvider);

    final erasAsync = ref.watch(erasProvider);
    Era? era;
    for (final candidate in erasAsync.valueOrNull ?? const <Era>[]) {
      if (candidate.id == widget.eraId) {
        era = candidate;
        break;
      }
    }
    final accent = era != null ? EraAccents.ofSlug(era.slug) : AppColors.primary;

    if (!_started) {
      return Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: _EraQuizIntro(eraName: era?.name, accent: accent, onStart: _start),
        ),
      );
    }

    final submitState = ref.watch(eraQuizSubmitControllerProvider);

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) _confirmExit(era);
      },
      child: Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: sessionState.when(
          loading: () => const Center(child: CircularProgressIndicator(color: AppColors.ink)),
          error: (error, _) => _EraQuizStatus(
            onRetry: () => ref.read(eraQuizSessionControllerProvider.notifier).start(widget.eraId),
            onBack: () => _leave(era),
          ),
          data: (EraQuizStart? quiz) {
            if (quiz == null) {
              // Belum sempat start() atau sudah di-clear() (mis. abis
              // submit) — seharusnya jarang kejadian karena _started
              // sudah true di titik ini, tapi jaring pengaman.
              return const Center(child: CircularProgressIndicator(color: AppColors.ink));
            }

            // FIX (bug): dulu di-sort ulang by `order` di sini — itu
            // DIAM-DIAM MEMBATALKAN hasil random dari backend
            // (EraQuiz::randomQuestions() sudah shuffle() urutannya
            // sebelum dikirim). `order` di tiap soal itu urutan ASLI-nya
            // di bank formatif per year (1-10), BUKAN urutan tampil yang
            // seharusnya dipakai di sini — pakai apa adanya dari response.
            final questions = quiz.questions;

            if (questions.isEmpty) {
              return const Center(
                child: Padding(
                  padding: EdgeInsets.all(24),
                  child: Text(
                    'Kuis sumatif ini belum punya soal.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: AppColors.textSecondary, fontSize: 15),
                  ),
                ),
              );
            }

            // BARU: acak urutan opsi SEKALI per soal, di-cache supaya
            // tidak berubah-ubah tiap render (mis. tiap kali user pilih
            // jawaban men-trigger setState di widget ini).
            _shuffledOptionsByQuestionId ??= {
              for (final q in questions) q.id: [...q.options]..shuffle(),
            };

            final questionIds = questions.map((q) => q.id).toList();
            final total = questions.length;
            final current = questions[_currentIndex];
            final isLast = _currentIndex == total - 1;
            final answeredCount = _answers.length;
            final isSubmitting = submitState.isLoading;

            return Column(
              children: [
                _Header(eraName: era?.name, accent: accent, onClose: () => _confirmExit(era)),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
                  child: _ProgressSegments(
                    answered: [for (final id in questionIds) _answers.containsKey(id)],
                    currentIndex: _currentIndex,
                    accent: accent,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 14, 16, 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Soal ${_currentIndex + 1} dari $total',
                        style: const TextStyle(fontSize: 14, color: AppColors.textSecondary, fontWeight: FontWeight.w600),
                      ),
                      // Yang penting bagi user: berapa soal yang sudah dijawab
                      // (bukan posisi halaman dalam persen).
                      Text(
                        'Terjawab $answeredCount dari $total',
                        style: const TextStyle(fontSize: 14, color: AppColors.textSecondary, fontWeight: FontWeight.w600),
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
                          padding: const EdgeInsets.all(18),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.ink.withValues(alpha: 0.04),
                                blurRadius: 14,
                                offset: const Offset(0, 6),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RichBodyText(
                                current.question,
                                style: const TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.ink,
                                  height: 1.4,
                                ),
                              ),
                              const SizedBox(height: 16),
                              for (final option in _shuffledOptionsByQuestionId![current.id]!)
                                EraQuizOptionTile(
                                  label: option.optionText,
                                  selected: _answers[current.id] == option.id,
                                  accent: accent,
                                  onTap: () => _selectOption(current.id, option.id),
                                ),
                              const SizedBox(height: 6),
                              Row(
                                children: [
                                  const Icon(Icons.info_outline_rounded, size: 16, color: AppColors.textSecondary),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      // Dulu: "Jawaban tersimpan sementara" + ikon gembok —
                                      // menyesatkan: jawaban hanya ada di layar ini.
                                      'Jawabanmu belum dikirim. Kamu masih bisa mengubahnya sebelum menekan Kirim Jawaban.',
                                      style: const TextStyle(fontSize: 13, height: 1.4, color: AppColors.textSecondary),
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
    ));
  }
}

/// BARU — layar info SEBELUM soal pertama: passing grade 75% & jumlah
/// soal. Konstanta 20/75 dipakai sebagai fallback tampilan awal (sebelum
/// `EraQuizStart` benar-benar di-fetch) — begitu fetch selesai, angka
/// sebenarnya (`EraQuizStart.passingGrade`/`questionCount`) sudah pasti
/// sama karena keduanya konstanta tetap di backend
/// (`EraQuiz::PASSING_GRADE_PERCENTAGE`/`ATTEMPT_QUESTION_COUNT`).
class _EraQuizIntro extends StatelessWidget {
  const _EraQuizIntro({required this.eraName, required this.accent, required this.onStart});

  final String? eraName;
  final Color accent;
  final VoidCallback onStart;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Center(
        child: SingleChildScrollView(child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 88,
              height: 88,
              decoration: BoxDecoration(color: accent.withValues(alpha: 0.12), shape: BoxShape.circle),
              alignment: Alignment.center,
              child: Icon(Icons.military_tech_rounded, size: 40, color: eraQuizAccentStrong(accent)),
            ),
            const SizedBox(height: 20),
            Text(
              'Kuis Sumatif${eraName != null ? ': $eraName' : ''}',
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
            ),
            const SizedBox(height: 14),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.border),
              ),
              child: Column(
                children: [
                  _InfoLine(label: 'Jumlah soal', value: '20 soal'),
                  const SizedBox(height: 8),
                  _InfoLine(label: 'Nilai minimum kelulusan', value: '75%', emphasize: true),
                ],
              ),
            ),
            const SizedBox(height: 14),
            const Text(
              'Soal diambil acak dari kuis-kuis tahun di era ini. Kamu boleh mengerjakan ulang kapan saja.',
              textAlign: TextAlign.center,
              style: TextStyle(color: AppColors.textSecondary, fontSize: 14.5, height: 1.4),
            ),
            const SizedBox(height: 28),
            Semantics(button: true, child: PressableScale(
              onTap: onStart,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(color: accent, borderRadius: BorderRadius.circular(28)),
                alignment: Alignment.center,
                child: Text(
                  'Mulai Kuis',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    color: eraQuizOnColor(accent),
                  ),
                ),
              ),
            )),
            const SizedBox(height: 12),
            TextButton(onPressed: () => Navigator.of(context).maybePop(), child: const Text('Kembali')),
          ],
        )),
      ),
    );
  }
}

class _InfoLine extends StatelessWidget {
  const _InfoLine({required this.label, required this.value, this.emphasize = false});

  final String label;
  final String value;
  final bool emphasize;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(label, style: const TextStyle(color: AppColors.textSecondary, fontSize: 15)),
        const SizedBox(width: 6),
        Text(
          value,
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 15,
            color: emphasize ? AppColors.ink : AppColors.textSecondary,
          ),
        ),
      ],
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
          Semantics(button: true, label: 'Tutup kuis', child: PressableScale(
            onTap: onClose,
            child: Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(color: AppColors.ink.withValues(alpha: 0.06), shape: BoxShape.circle),
              child: const Icon(Icons.close_rounded, size: 22, color: AppColors.ink),
            ),
          )),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'Kuis Sumatif: ${eraName ?? '...'}',
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w800, color: AppColors.ink),
            ),
          ),
        ],
      ),
    );
  }
}

/// Segmen per soal: terjawab = aksen era (digelapkan), soal yang sedang
/// dibuka = Ink, belum dijawab = abu. Dulu segmen hanya menandai posisi
/// halaman, jadi 20 segmen tidak memberi tahu soal mana yang masih kosong.
class _ProgressSegments extends StatelessWidget {
  const _ProgressSegments({required this.answered, required this.currentIndex, required this.accent});

  final List<bool> answered;
  final int currentIndex;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    final duration = MediaQuery.disableAnimationsOf(context)
        ? Duration.zero
        : const Duration(milliseconds: 220);
    final total = answered.length;
    final strong = eraQuizAccentStrong(accent);

    return ExcludeSemantics(
      child: Row(
        children: [
          for (var i = 0; i < total; i++)
            Expanded(
              child: AnimatedContainer(
                duration: duration,
                curve: Curves.easeOut,
                height: i == currentIndex ? 8 : 5,
                margin: EdgeInsets.only(right: i == total - 1 ? 0 : 4),
                decoration: BoxDecoration(
                  color: i == currentIndex
                      ? AppColors.ink
                      : (answered[i] ? strong : AppColors.border),
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
            ),
        ],
      ),
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
                  icon: const Icon(Icons.arrow_back_rounded, size: 18, color: AppColors.ink),
                  label: const Text('Sebelumnya', style: TextStyle(color: AppColors.ink, fontWeight: FontWeight.w600, fontSize: 15)),
                )
              else
                const SizedBox(width: 1),
              const Spacer(),
              Semantics(button: true, enabled: !isSubmitting, child: PressableScale(
                onTap: isSubmitting ? null : onPrimary,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                  decoration: BoxDecoration(color: AppColors.ink, borderRadius: BorderRadius.circular(30)),
                  child: isSubmitting
                      ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                        )
                      : Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              isLast ? 'Kirim Jawaban' : 'Selanjutnya',
                              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 15),
                            ),
                            const SizedBox(width: 6),
                            Icon(isLast ? Icons.check_rounded : Icons.arrow_forward_rounded, size: 18, color: Colors.white),
                          ],
                        ),
                ),
              )),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            'Hasil & pembahasan lengkap akan ditampilkan setelah seluruh $total soal dijawab.',
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 13, height: 1.35, color: AppColors.textSecondary),
          ),
        ],
      ),
    );
  }
}

/// Gagal memuat soal. Dulu: teks exception mentah tanpa tombol apa pun.
class _EraQuizStatus extends StatelessWidget {
  const _EraQuizStatus({required this.onRetry, required this.onBack});

  final VoidCallback onRetry;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.cloud_off_rounded, size: 40, color: AppColors.textSecondary),
              const SizedBox(height: 12),
              const Text(
                'Kuis sumatif belum bisa dimuat',
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
              TextButton(
                onPressed: onBack,
                style: TextButton.styleFrom(foregroundColor: AppColors.ink, minimumSize: const Size(140, 48)),
                child: const Text('Kembali', style: TextStyle(fontWeight: FontWeight.w700)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}