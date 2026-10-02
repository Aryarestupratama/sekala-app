import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../case_study_texts.dart';
import 'case_study_common.dart';

/// Isi 1 slot yang sudah terisi (label huruf + judul singkat opsi).
class CaseStudyTraySlot {
  const CaseStudyTraySlot({required this.letter, required this.title});

  final String letter;
  final String title;
}

/// Tray 3 slot prioritas — di layar langkah 1 tray ini di-pin (sticky) di
/// atas daftar opsi, supaya susunan user selalu terlihat saat scroll.
///
/// - [slots]: panjang 3, null = slot kosong.
/// - [onReleaseSlot]: tap slot yang terisi untuk melepasnya.
/// - [onReset]: tombol "Susun ulang" (nonaktif kalau semua slot kosong).
///
/// Tinggi total ~154px (dipakai `CaseStudyDecisionView` untuk extent
/// header yang di-pin) — ubah keduanya bersamaan kalau tinggi slot berubah.
class CaseStudyPriorityTray extends StatelessWidget {
  const CaseStudyPriorityTray({
    super.key,
    required this.slots,
    required this.onReleaseSlot,
    required this.onReset,
    required this.accent,
  });

  final List<CaseStudyTraySlot?> slots;
  final ValueChanged<int> onReleaseSlot;
  final VoidCallback onReset;

  /// Warna era — dipakai titik nomor pada slot yang sudah terisi.
  final Color accent;

  @override
  Widget build(BuildContext context) {
    final hasAny = slots.any((s) => s != null);

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 44,
            child: Row(
              children: [
                Text(
                  CaseStudyTexts.priorityHeading,
                  style: AppTextStyles.body.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    height: 1.2,
                  ),
                ),
                const Spacer(),
                TextButton.icon(
                  onPressed: hasAny ? onReset : null,
                  icon: const Icon(Icons.refresh_rounded, size: 18),
                  label: const Text(CaseStudyTexts.resetCta),
                  style: TextButton.styleFrom(
                    foregroundColor: AppColors.ink,
                    disabledForegroundColor: AppColors.textDisabled,
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    minimumSize: const Size(0, 44),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    textStyle: AppTextStyles.caption.copyWith(
                      fontSize: 13.5,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 76,
            child: Row(
              children: [
                for (var i = 0; i < slots.length; i++) ...[
                  if (i > 0) const SizedBox(width: 8),
                  Expanded(
                    child: _Slot(
                      number: i + 1,
                      slot: slots[i],
                      accent: accent,
                      onTap: slots[i] == null ? null : () => onReleaseSlot(i),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Slot extends StatelessWidget {
  const _Slot({
    required this.number,
    required this.slot,
    required this.onTap,
    required this.accent,
  });

  final int number;
  final CaseStudyTraySlot? slot;
  final VoidCallback? onTap;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    final filled = slot != null;

    return Semantics(
      button: filled,
      excludeSemantics: true,
      onTap: onTap,
      label: filled
          ? 'Prioritas $number: opsi ${slot!.letter}, ${slot!.title}. '
              'Ketuk untuk melepas'
          : 'Prioritas $number: belum dipilih',
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 180),
        layoutBuilder: (current, previous) => Stack(
          fit: StackFit.expand,
          children: [...previous, if (current != null) current],
        ),
        child: filled
            ? _FilledSlot(
                key: ValueKey('filled-$number-${slot!.letter}'),
                number: number,
                slot: slot!,
                accent: accent,
                onTap: onTap,
              )
            : _EmptySlot(key: ValueKey('empty-$number'), number: number),
      ),
    );
  }
}

class _FilledSlot extends StatelessWidget {
  const _FilledSlot({
    super.key,
    required this.number,
    required this.slot,
    required this.onTap,
    required this.accent,
  });

  final int number;
  final CaseStudyTraySlot slot;
  final VoidCallback? onTap;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surface,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: AppColors.ink, width: 1.5),
      ),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  _NumberDot(number: number, filled: true, accent: accent),
                  const SizedBox(width: 6),
                  Text(
                    slot.letter,
                    style: AppTextStyles.button.copyWith(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Text(
                slot.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.body.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  height: 1.2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _EmptySlot extends StatelessWidget {
  const _EmptySlot({super.key, required this.number});

  final int number;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: const _DashedRRectPainter(
        color: AppColors.textDisabled,
        radius: 12,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _NumberDot(number: number, filled: false),
            const Spacer(),
            Text(
              CaseStudyTexts.slotEmpty,
              style: AppTextStyles.body.copyWith(
                fontSize: 12,
                height: 1.2,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NumberDot extends StatelessWidget {
  const _NumberDot({required this.number, required this.filled, this.accent = AppColors.warning});

  final int number;
  final bool filled;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    final onAccent = caseStudyOnColor(accent);
    return Container(
      width: 24,
      height: 24,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: filled ? accent : Colors.transparent,
        border: filled ? null : Border.all(color: AppColors.border),
      ),
      child: Text(
        '$number',
        style: AppTextStyles.caption.copyWith(
          fontSize: 12,
          fontWeight: FontWeight.w700,
          color: filled ? onAccent : AppColors.textSecondary,
        ),
      ),
    );
  }
}

/// Border putus-putus rounded (Flutter tidak punya bawaan).
class _DashedRRectPainter extends CustomPainter {
  const _DashedRRectPainter({
    required this.color,
    required this.radius,
    this.strokeWidth = 1.5,
    this.dashLength = 5,
    this.gapLength = 4,
  });

  final Color color;
  final double radius;
  final double strokeWidth;
  final double dashLength;
  final double gapLength;

  @override
  void paint(Canvas canvas, Size size) {
    final rrect = RRect.fromRectAndRadius(
      Offset.zero & size,
      Radius.circular(radius),
    ).deflate(strokeWidth / 2);

    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    final path = Path()..addRRect(rrect);
    for (final metric in path.computeMetrics()) {
      var distance = 0.0;
      while (distance < metric.length) {
        final end = math.min(distance + dashLength, metric.length);
        canvas.drawPath(metric.extractPath(distance, end), paint);
        distance += dashLength + gapLength;
      }
    }
  }

  @override
  bool shouldRepaint(covariant _DashedRRectPainter old) =>
      old.color != color ||
      old.radius != radius ||
      old.strokeWidth != strokeWidth ||
      old.dashLength != dashLength ||
      old.gapLength != gapLength;
}