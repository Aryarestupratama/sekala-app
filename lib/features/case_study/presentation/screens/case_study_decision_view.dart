import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/models/case_study_option.dart';
import '../../../../shared/models/case_study_submit_result.dart';
import '../../domain/case_study_repository.dart';
import '../case_study_texts.dart';
import '../widgets/case_study_common.dart';
import '../widgets/case_study_incorrect_sheet.dart';
import '../widgets/case_study_option_card.dart';
import '../widgets/case_study_priority_tray.dart';

enum _DecisionStep { rank, reason }

/// Layar 3 Studi Kasus — Ruang Keputusan, dibagi 2 langkah di dalam SATU
/// widget (bukan 2 route) supaya susunan slot & teks alasan tetap ada saat
/// user bolak-balik antar langkah:
/// - Langkah 1: susun 3 prioritas dari 5 opsi (tray slot di-pin di atas).
/// - Langkah 2: tulis alasan (min. `CaseStudyRules.reasonMinLength`
///   karakter), lalu Submit — SATU kali submit di akhir.
///
/// Widget ini memegang state pengerjaan (slot, alasan, langkah) tapi TIDAK
/// tahu soal provider/router. Kontraknya:
/// - [onSubmit]: kirim ke server, kembalikan hasil (null = gagal jaringan/
///   validasi -> tampil SnackBar, user bisa coba lagi).
/// - Hasil SALAH ditangani DI SINI: bottom sheet feedback, lalu kembali ke
///   langkah 1 dengan susunan & alasan terakhir dipertahankan.
/// - Hasil BENAR diteruskan ke [onCorrect] (shell pindah ke layar Badge).
/// - [onBack]: keluar dari Ruang Keputusan (dari langkah 1). Kalau sudah
///   ada isian, ditanya konfirmasi dulu.
///
/// [options] wajib memakai 1 hasil fetch yang sama selama sesi (urutan
/// diacak server per request, huruf A–E diberikan di sini berdasarkan
/// index) — lihat catatan `caseStudyDetailProvider`.
class CaseStudyDecisionView extends StatefulWidget {
  const CaseStudyDecisionView({
    super.key,
    required this.wabahName,
    required this.options,
    required this.reasonDescription,
    required this.onSubmit,
    required this.onCorrect,
    required this.onBack,
    required this.accent,
  });

  /// `Year.title` — disisipkan ke instruksi langkah 1 (`CaseStudyTexts
  /// .rankInstruction`), teks resmi sesuai progress.md ("Alur 4 layar").
  final String wabahName;

  final List<CaseStudyOption> options;

  /// Pertanyaan di atas kolom alasan (`CaseStudy.reasonDescription`, admin).
  final String reasonDescription;

  /// Warna era (`EraAccents.ofSlug`), dioper dari shell — menggantikan
  /// oren hardcode di seluruh layar ini (accent bar, tombol, badge
  /// prioritas, sheet feedback salah).
  final Color accent;

  final Future<CaseStudySubmitResult?> Function(
    List<int> slotOptionIds,
    String reason,
  ) onSubmit;
  final ValueChanged<CaseStudySubmitResult> onCorrect;
  final VoidCallback onBack;

  @override
  State<CaseStudyDecisionView> createState() => _CaseStudyDecisionViewState();
}

class _CaseStudyDecisionViewState extends State<CaseStudyDecisionView> {
  /// Tinggi header yang di-pin = tray (~142) + padding vertikal (12) +
  /// cadangan. Sinkron dengan `CaseStudyPriorityTray`.
  static const double _trayExtent = 158;

  _DecisionStep _step = _DecisionStep.rank;
  final List<int?> _slots = List<int?>.filled(CaseStudyRules.slotCount, null);
  final TextEditingController _reason = TextEditingController();
  bool _submitting = false;

  @override
  void initState() {
    super.initState();
    _reason.addListener(_onReasonChanged);
  }

  @override
  void dispose() {
    _reason.removeListener(_onReasonChanged);
    _reason.dispose();
    super.dispose();
  }

  void _onReasonChanged() {
    if (mounted) setState(() {});
  }

  // ---------- helper state ----------

  CaseStudyOption? _optionById(int? id) {
    if (id == null) return null;
    for (final o in widget.options) {
      if (o.id == id) return o;
    }
    return null;
  }

  String _letterOf(int optionId) {
    final i = widget.options.indexWhere((o) => o.id == optionId);
    return i < 0 ? '?' : String.fromCharCode(65 + i);
  }

  bool get _allFilled => !_slots.contains(null);

  bool get _hasDraft =>
      _slots.any((s) => s != null) || _reason.text.trim().isNotEmpty;

  /// Dihitung per code point setelah trim — sama dengan `mb_strlen(trim())`
  /// di CaseStudyService::submit().
  int get _reasonLength => _reason.text.trim().runes.length;

  bool get _reasonReady => _reasonLength >= CaseStudyRules.reasonMinLength;

  // ---------- aksi ----------

  void _toggle(int optionId) {
    final current = _slots.indexOf(optionId);
    if (current != -1) {
      setState(() => _slots[current] = null);
      HapticFeedback.selectionClick();
      return;
    }
    final empty = _slots.indexOf(null);
    if (empty == -1) return; // semua slot penuh
    setState(() => _slots[empty] = optionId);
    HapticFeedback.selectionClick();
  }

  void _releaseSlot(int index) {
    if (_slots[index] == null) return;
    setState(() => _slots[index] = null);
  }

  void _reset() => setState(() => _slots.fillRange(0, _slots.length, null));

  void _goTo(_DecisionStep step) {
    FocusScope.of(context).unfocus();
    setState(() => _step = step);
  }

  Future<void> _handleBack() async {
    if (_submitting) return;

    if (_step == _DecisionStep.reason) {
      _goTo(_DecisionStep.rank);
      return;
    }

    if (!_hasDraft) {
      widget.onBack();
      return;
    }

    final leave = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text(CaseStudyTexts.leaveTitle),
        content: const Text(CaseStudyTexts.leaveBody),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: const Text(CaseStudyTexts.leaveStay),
          ),
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: const Text(CaseStudyTexts.leaveConfirm),
          ),
        ],
      ),
    );

    if (leave == true && mounted) widget.onBack();
  }

  Future<void> _submit() async {
    if (_submitting || !_allFilled || !_reasonReady) return;

    FocusScope.of(context).unfocus();
    setState(() => _submitting = true);

    CaseStudySubmitResult? result;
    try {
      result = await widget.onSubmit(
        _slots.map((id) => id!).toList(),
        _reason.text.trim(),
      );
    } catch (_) {
      result = null;
    } finally {
      if (mounted) setState(() => _submitting = false);
    }

    if (!mounted) return;

    if (result == null) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          const SnackBar(content: Text(CaseStudyTexts.submitError)),
        );
      return;
    }

    if (result.isCorrect) {
      widget.onCorrect(result);
      return;
    }

    await showCaseStudyIncorrectSheet(context, feedback: result.feedback, accent: widget.accent);
    if (!mounted) return;
    // "Coba lagi": balik ke langkah 1, susunan & alasan tetap utuh supaya
    // user tinggal menukar posisi.
    _goTo(_DecisionStep.rank);
  }

  // ---------- build ----------

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) _handleBack();
      },
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 220),
            layoutBuilder: (current, previous) => Stack(
              fit: StackFit.expand,
              children: [...previous, if (current != null) current],
            ),
            child: KeyedSubtree(
              key: ValueKey(_step),
              child: _step == _DecisionStep.rank
                  ? _buildRankStep(context)
                  : _buildReasonStep(context),
            ),
          ),
        ),
      ),
    );
  }

  // ---------- langkah 1 ----------

  Widget _buildRankStep(BuildContext context) {
    final options = widget.options;
    final slotViews = _slots.map((id) {
      final o = _optionById(id);
      return o == null
          ? null
          : CaseStudyTraySlot(letter: _letterOf(o.id), title: o.title);
    }).toList();

    return Column(
      children: [
        _StepTopBar(step: 1, onBack: _handleBack),
        Expanded(
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(
                      kCaseStudyHPad, 20, kCaseStudyHPad, 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CaseStudyAccentBar(color: widget.accent),
                      const SizedBox(height: 12),
                      const CaseStudyEyebrow(CaseStudyTexts.decisionEyebrow),
                      const SizedBox(height: 12),
                      Semantics(
                        header: true,
                        child: Text(
                          CaseStudyTexts.rankTitle,
                          style: AppTextStyles.h1.copyWith(fontSize: 24),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        CaseStudyTexts.rankInstruction(widget.wabahName),
                        style: AppTextStyles.bodySecondary
                            .copyWith(fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ),
              SliverPersistentHeader(
                pinned: true,
                delegate: _PinnedHeaderDelegate(
                  extent: _trayExtent,
                  child: CaseStudyPriorityTray(
                    slots: slotViews,
                    onReleaseSlot: _releaseSlot,
                    onReset: _reset,
                    accent: widget.accent,
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(
                      kCaseStudyHPad, 12, kCaseStudyHPad, 12),
                  child: Text(
                    CaseStudyTexts.pickHeading(options.length),
                    style: AppTextStyles.body.copyWith(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      height: 1.2,
                    ),
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(
                    kCaseStudyHPad, 0, kCaseStudyHPad, 24),
                sliver: SliverList.separated(
                  itemCount: options.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 10),
                  itemBuilder: (context, i) {
                    final o = options[i];
                    final slotIndex = _slots.indexOf(o.id);
                    final selected = slotIndex != -1;
                    final dimmed = !selected && _allFilled;
                    return CaseStudyOptionCard(
                      letter: String.fromCharCode(65 + i),
                      title: o.title,
                      description: o.description,
                      priority: selected ? slotIndex + 1 : null,
                      dimmed: dimmed,
                      accent: widget.accent,
                      onTap: dimmed ? null : () => _toggle(o.id),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding:
              const EdgeInsets.fromLTRB(kCaseStudyHPad, 8, kCaseStudyHPad, 20),
          child: CaseStudyPrimaryButton(
            label: CaseStudyTexts.continueCta,
            color: widget.accent,
            onTap: _allFilled ? () => _goTo(_DecisionStep.reason) : null,
          ),
        ),
      ],
    );
  }

  // ---------- langkah 2 ----------

  Widget _buildReasonStep(BuildContext context) {
    final ready = _reasonReady;

    return Column(
      children: [
        _StepTopBar(step: 2, onBack: _handleBack),
        Expanded(
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => FocusScope.of(context).unfocus(),
            child: SingleChildScrollView(
              keyboardDismissBehavior:
                  ScrollViewKeyboardDismissBehavior.onDrag,
              padding: const EdgeInsets.fromLTRB(
                  kCaseStudyHPad, 20, kCaseStudyHPad, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CaseStudyAccentBar(color: widget.accent),
                  const SizedBox(height: 12),
                  const CaseStudyEyebrow(CaseStudyTexts.decisionEyebrow),
                  const SizedBox(height: 12),
                  Semantics(
                    header: true,
                    child: Text(
                      CaseStudyTexts.reasonStepTitle,
                      style: AppTextStyles.h1.copyWith(fontSize: 24),
                    ),
                  ),
                  const SizedBox(height: 20),
                  _SummaryCard(
                    rows: [
                      for (final id in _slots)
                        if (_optionById(id) case final o?)
                          _SummaryRowData(
                            letter: _letterOf(o.id),
                            title: o.title,
                          ),
                    ],
                    accent: widget.accent,
                    onEdit: () => _goTo(_DecisionStep.rank),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: widget.accent,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        CaseStudyTexts.reasonLabel,
                        style: AppTextStyles.body.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          height: 1.2,
                        ),
                      ),
                    ],
                  ),
                  if (widget.reasonDescription.trim().isNotEmpty) ...[
                    const SizedBox(height: 8),
                    Text(
                      widget.reasonDescription,
                      style:
                          AppTextStyles.bodySecondary.copyWith(fontSize: 14),
                    ),
                  ],
                  const SizedBox(height: 12),
                  TextField(
                    controller: _reason,
                    enabled: !_submitting,
                    minLines: 6,
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    textCapitalization: TextCapitalization.sentences,
                    style: AppTextStyles.body.copyWith(fontSize: 14),
                    decoration: InputDecoration(
                      hintText: CaseStudyTexts.reasonPlaceholder,
                      hintStyle: AppTextStyles.body.copyWith(
                        fontSize: 14,
                        color: AppColors.textDisabled,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          ready
                              ? CaseStudyTexts.reasonHintReady
                              : CaseStudyTexts.reasonHintLocked,
                          style: AppTextStyles.caption,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        '$_reasonLength/${CaseStudyRules.reasonMinLength}',
                        style: AppTextStyles.caption.copyWith(
                          fontWeight: FontWeight.w600,
                          color: ready ? AppColors.ink : AppColors.textDisabled,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding:
              const EdgeInsets.fromLTRB(kCaseStudyHPad, 8, kCaseStudyHPad, 20),
          child: CaseStudyPrimaryButton(
            label: CaseStudyTexts.submitCta,
            icon: null,
            color: widget.accent,
            loading: _submitting,
            onTap: ready && _allFilled ? _submit : null,
          ),
        ),
      ],
    );
  }
}

/// Baris atas: tombol kembali + label "Langkah N dari 2".
class _StepTopBar extends StatelessWidget {
  const _StepTopBar({required this.step, required this.onBack});

  final int step;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
          kCaseStudyHPad - 4, 12, kCaseStudyHPad, 0),
      child: Row(
        children: [
          CaseStudyBackButton(onTap: onBack),
          const Spacer(),
          Text(
            CaseStudyTexts.stepLabel(step),
            style: AppTextStyles.caption.copyWith(fontSize: 12.5),
          ),
        ],
      ),
    );
  }
}

/// Header sliver ber-tinggi tetap yang menempel (pinned) di atas daftar
/// opsi. Diberi garis bawah tipis hanya saat konten sedang menyelip di
/// bawahnya, dan skala teks di-clamp supaya tray tidak melebihi extent
/// pada pengaturan font besar.
class _PinnedHeaderDelegate extends SliverPersistentHeaderDelegate {
  _PinnedHeaderDelegate({required this.extent, required this.child});

  final double extent;
  final Widget child;

  @override
  double get minExtent => extent;

  @override
  double get maxExtent => extent;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      padding: const EdgeInsets.fromLTRB(kCaseStudyHPad, 4, kCaseStudyHPad, 8),
      alignment: Alignment.topCenter,
      decoration: BoxDecoration(
        color: AppColors.background,
        border: overlapsContent
            ? const Border(bottom: BorderSide(color: AppColors.border))
            : null,
      ),
      child: MediaQuery.withClampedTextScaling(
        maxScaleFactor: 1.15,
        child: child,
      ),
    );
  }

  @override
  bool shouldRebuild(covariant _PinnedHeaderDelegate oldDelegate) => true;
}

class _SummaryRowData {
  const _SummaryRowData({required this.letter, required this.title});

  final String letter;
  final String title;
}

/// Kartu ringkasan 3 prioritas di langkah 2 (+ tombol "Ubah").
class _SummaryCard extends StatelessWidget {
  const _SummaryCard({required this.rows, required this.onEdit, required this.accent});

  final List<_SummaryRowData> rows;
  final VoidCallback onEdit;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  CaseStudyTexts.summaryHeading,
                  style: AppTextStyles.body.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    height: 1.2,
                  ),
                ),
              ),
              TextButton.icon(
                onPressed: onEdit,
                icon: const Icon(Icons.edit_outlined, size: 16),
                label: const Text(CaseStudyTexts.editCta),
                style: TextButton.styleFrom(
                  foregroundColor: AppColors.ink,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  minimumSize: const Size(0, 32),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  textStyle: AppTextStyles.caption.copyWith(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: AppColors.border),
            ),
            child: Column(
              children: [
                for (var i = 0; i < rows.length; i++) ...[
                  if (i > 0) const SizedBox(height: 6),
                  _SummaryRow(number: i + 1, data: rows[i], accent: accent),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({required this.number, required this.data, required this.accent});

  final int number;
  final _SummaryRowData data;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    final onAccent = ThemeData.estimateBrightnessForColor(accent) == Brightness.dark
        ? Colors.white
        : AppColors.ink;
    return Container(
      constraints: const BoxConstraints(minHeight: 44),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Container(
            width: 24,
            height: 24,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: accent,
              shape: BoxShape.circle,
            ),
            child: Text(
              '$number',
              style: AppTextStyles.caption.copyWith(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: onAccent,
              ),
            ),
          ),
          const SizedBox(width: 10),
          SizedBox(
            width: 16,
            child: Text(
              data.letter,
              style: AppTextStyles.button.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              data.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.body.copyWith(
                fontSize: 13.5,
                fontWeight: FontWeight.w500,
                height: 1.3,
              ),
            ),
          ),
        ],
      ),
    );
  }
}