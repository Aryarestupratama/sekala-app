import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/models/year.dart';
import '../../../../shared/widgets/pressable_scale.dart';

enum YearNodeState { completed, current, locked }

/// Satu node tahun di roadmap era (Design.md §3.3 poin 1) — tampilan beda
/// tergantung status:
/// - completed: sudah "year completed" (R-PROG-07) — lingkaran warna era,
///   checkmark hijau, label putih.
/// - current: unlocked tapi belum completed — lingkaran putih dgn border
///   warna era, plus kartu tooltip gelap "Mulai/Lanjutkan membaca →".
/// - locked: belum terbuka (R-YEAR-02/03) — lingkaran abu, ikon gembok,
///   label "Belum Terbuka".
///
/// REDESIGN: `withOpacity` (deprecated) -> `withValues(alpha:)`, dan
/// seluruh node kini dibungkus [PressableScale] supaya terasa "empuk"
/// saat ditekan (bounce animasi node current tetap ada, tidak dihapus).
class YearNode extends StatelessWidget {
  const YearNode({
    super.key,
    required this.year,
    required this.state,
    required this.accent,
    required this.onTap,
    this.nodeX,
    this.screenWidth,
  });

  final Year year;
  final YearNodeState state;
  final Color accent;
  final VoidCallback onTap;

  /// Posisi horizontal node (px, relatif ke `screenWidth`) dan lebar layar
  /// yang tersedia — dipakai tiap sub-widget state untuk menghitung
  /// pergeseran kotak label/tooltip-nya sendiri.
  final double? nodeX;
  final double? screenWidth;

  @override
  Widget build(BuildContext context) {
    switch (state) {
      case YearNodeState.completed:
        return _CompletedNode(year: year, accent: accent, onTap: onTap, nodeX: nodeX, screenWidth: screenWidth);
      case YearNodeState.current:
        return _CurrentNode(year: year, accent: accent, onTap: onTap, nodeX: nodeX, screenWidth: screenWidth);
      case YearNodeState.locked:
        return _LockedNode(year: year, onTap: onTap, nodeX: nodeX, screenWidth: screenWidth);
    }
  }
}

/// Hitung pergeseran horizontal (px) untuk sebuah kotak selebar
/// `2 * boxHalfWidth` yang idealnya center di `nodeX`, supaya kotak
/// tersebut tetap muat penuh di dalam `screenWidth`.
double _shiftForBox({
  required double? nodeX,
  required double? screenWidth,
  required double boxHalfWidth,
}) {
  if (nodeX == null || screenWidth == null) return 0;

  const edgePadding = 16.0;
  final idealLeft = nodeX - boxHalfWidth;
  final minLeft = edgePadding;
  final maxLeft = (screenWidth - boxHalfWidth * 2 - edgePadding).clamp(minLeft, double.infinity);
  final clampedLeft = idealLeft.clamp(minLeft, maxLeft);

  return clampedLeft - idealLeft;
}

class _CompletedNode extends StatelessWidget {
  const _CompletedNode({
    required this.year,
    required this.accent,
    required this.onTap,
    this.nodeX,
    this.screenWidth,
  });

  final Year year;
  final Color accent;
  final VoidCallback onTap;
  final double? nodeX;
  final double? screenWidth;

  @override
  Widget build(BuildContext context) {
    return PressableScale(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: accent,
                  boxShadow: [
                    BoxShadow(
                      color: accent.withValues(alpha: 0.35),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                alignment: Alignment.center,
                child: Text(
                  '${year.year}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              Positioned(
                top: -4,
                right: -4,
                child: Container(
                  width: 22,
                  height: 22,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.success,
                    border: Border.fromBorderSide(
                      BorderSide(color: Colors.white, width: 2),
                    ),
                  ),
                  child: const Icon(Icons.check_rounded, size: 13, color: Colors.white),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Transform.translate(
            offset: Offset(
              _shiftForBox(nodeX: nodeX, screenWidth: screenWidth, boxHalfWidth: 65),
              0,
            ),
            child: _YearLabel(text: year.title, dimmed: false),
          ),
        ],
      ),
    );
  }
}

/// Node untuk tahun yang sedang aktif (unlocked, belum completed).
///
/// Lingkarannya diberi animasi "bounce" halus & terus berulang, kotak
/// tooltip hitam di bawahnya sengaja TIDAK ikut bounce, supaya teksnya
/// tetap stabil/gampang dibaca. Efek tekan (PressableScale) dibungkus di
/// LUAR bounce supaya dua animasi tidak saling mengganggu.
class _CurrentNode extends StatefulWidget {
  const _CurrentNode({
    required this.year,
    required this.accent,
    required this.onTap,
    this.nodeX,
    this.screenWidth,
  });

  final Year year;
  final Color accent;
  final VoidCallback onTap;
  final double? nodeX;
  final double? screenWidth;

  @override
  State<_CurrentNode> createState() => _CurrentNodeState();
}

class _CurrentNodeState extends State<_CurrentNode> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _bounce;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat(reverse: true);

    _bounce = CurvedAnimation(parent: _controller, curve: Curves.easeInOutSine);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final completedSections = widget.year.sections.where((s) => s.completed).length;
    final ctaLabel = completedSections == 0 ? 'Mulai membaca' : 'Lanjutkan membaca';

    return PressableScale(
      onTap: widget.onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedBuilder(
            animation: _bounce,
            builder: (context, child) {
              final liftY = -8 * _bounce.value;
              final scale = 1.0 + (0.06 * _bounce.value);
              return Transform.translate(
                offset: Offset(0, liftY),
                child: Transform.scale(scale: scale, child: child),
              );
            },
            child: Container(
              width: 88,
              height: 88,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                border: Border.all(color: widget.accent, width: 4),
                boxShadow: [
                  BoxShadow(
                    color: widget.accent.withValues(alpha: 0.3),
                    blurRadius: 16,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              alignment: Alignment.center,
              child: Text(
                '${widget.year.year}',
                style: TextStyle(
                  color: widget.accent,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
          ),
          const SizedBox(height: 6),
          Transform.translate(
            offset: Offset(
              _shiftForBox(nodeX: widget.nodeX, screenWidth: widget.screenWidth, boxHalfWidth: 75),
              0,
            ),
            child: Container(
              constraints: const BoxConstraints(maxWidth: 150),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.ink,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    widget.year.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 11,
                    ),
                  ),
                  const SizedBox(height: 1),
                  Text(
                    '$ctaLabel →',
                    style: const TextStyle(color: Colors.white70, fontSize: 9.5),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _LockedNode extends StatelessWidget {
  const _LockedNode({required this.year, required this.onTap, this.nodeX, this.screenWidth});

  final Year year;
  final VoidCallback onTap;
  final double? nodeX;
  final double? screenWidth;

  @override
  Widget build(BuildContext context) {
    return PressableScale(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 68,
            height: 68,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.border,
            ),
            alignment: Alignment.center,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '${year.year}',
                  style: const TextStyle(
                    color: AppColors.textDisabled,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const Icon(Icons.lock_rounded, size: 14, color: AppColors.textDisabled),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Transform.translate(
            offset: Offset(
              _shiftForBox(nodeX: nodeX, screenWidth: screenWidth, boxHalfWidth: 65),
              0,
            ),
            child: const _YearLabel(text: 'Belum Terbuka', dimmed: true),
          ),
        ],
      ),
    );
  }
}

class _YearLabel extends StatelessWidget {
  const _YearLabel({required this.text, required this.dimmed});

  final String text;
  final bool dimmed;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 130),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border),
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: dimmed ? AppColors.textDisabled : AppColors.ink,
        ),
      ),
    );
  }
}