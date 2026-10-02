import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/pressable_scale.dart';
import '../../../era_quiz/presentation/providers/era_quiz_providers.dart';

/// Node "final boss" (ERAQUIZ-01) — dirender sebagai node TERAKHIR di
/// roadmap era, setelah seluruh node tahun. 3 kemungkinan visual:
///
/// - `locked`: lingkaran abu + gembok.
/// - unlocked + belum attempted: lingkaran MERAH besar mencolok, dengan
///   cincin glow yang berdenyut di belakangnya (ERAQUIZ-01 minta ikon ini
///   tampil "besar/mencolok" beda dari node tahun biasa — denyut ini
///   memperkuat itu tanpa perlu warna baru).
/// - unlocked + sudah attempted: lingkaran warna era + checkmark, tap
///   membuka halaman Hasil dari attempt tersimpan.
///
/// CATATAN GAP (belum berubah dari versi sebelumnya — masih relevan):
/// `eraQuizAttemptStatusProvider` 404 untuk DUA kondisi tak terbedakan:
/// "belum pernah attempt" ATAU "era ini tidak punya kuis published".
/// Widget ini menutup gap itu dengan cek `eraQuizExistsProvider` LEBIH
/// DULU — kalau itu sendiri 404, node disembunyikan total
/// (`SizedBox.shrink()`). Error lain (bukan 404) TIDAK menyembunyikan
/// node — ditampilkan sebagai versi unattempted apa adanya.
///
/// REDESIGN: `withOpacity` -> `withValues(alpha:)`, seluruh tap target
/// dibungkus [PressableScale], dan versi unattempted mendapat cincin
/// glow berdenyut (lihat `_PulsingGlow`).
class FinalBossNode extends ConsumerWidget {
  const FinalBossNode({
    super.key,
    required this.eraId,
    required this.unlocked,
    required this.accent,
    required this.onTapLocked,
    required this.onTapUnattempted,
    required this.onTapAttempted,
    this.nodeX,
    this.screenWidth,
  });

  final int eraId;
  final bool unlocked;
  final Color accent;
  final VoidCallback onTapLocked;
  final VoidCallback onTapUnattempted;
  final VoidCallback onTapAttempted;
  final double? nodeX;
  final double? screenWidth;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (!unlocked) {
      return _LockedFinalBoss(onTap: onTapLocked, nodeX: nodeX, screenWidth: screenWidth);
    }

    final quizExistsAsync = ref.watch(eraQuizExistsProvider(eraId));

    return quizExistsAsync.when(
      data: (exists) {
        if (!exists) {
          return const SizedBox.shrink();
        }

        final attemptedAsync = ref.watch(eraQuizAttemptStatusProvider(eraId));
        return attemptedAsync.when(
          data: (attempted) => attempted
              ? _AttemptedFinalBoss(
                  accent: accent,
                  onTap: onTapAttempted,
                  nodeX: nodeX,
                  screenWidth: screenWidth,
                )
              : _UnattemptedFinalBoss(
                  onTap: onTapUnattempted,
                  nodeX: nodeX,
                  screenWidth: screenWidth,
                ),
          loading: () => const _LoadingFinalBoss(),
          error: (_, __) => _UnattemptedFinalBoss(
            onTap: onTapUnattempted,
            nodeX: nodeX,
            screenWidth: screenWidth,
          ),
        );
      },
      loading: () => const _LoadingFinalBoss(),
      error: (_, __) => _UnattemptedFinalBoss(
        onTap: onTapUnattempted,
        nodeX: nodeX,
        screenWidth: screenWidth,
      ),
    );
  }
}

class _LoadingFinalBoss extends StatelessWidget {
  const _LoadingFinalBoss();

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 88,
      height: 88,
      child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
    );
  }
}

class _LockedFinalBoss extends StatelessWidget {
  const _LockedFinalBoss({required this.onTap, this.nodeX, this.screenWidth});

  final VoidCallback onTap;
  final double? nodeX;
  final double? screenWidth;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      onTap: onTap,
      label: 'Kuis sumatif era. Terkunci, selesaikan semua tahun dulu.',
      excludeSemantics: true,
      child: PressableScale(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 84,
            height: 84,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.border,
            ),
            alignment: Alignment.center,
            child: const Icon(Icons.lock_rounded, size: 28, color: AppColors.textDisabled),
          ),
          const SizedBox(height: 8),
          Transform.translate(
            offset: Offset(_shiftFor(nodeX: nodeX, screenWidth: screenWidth, boxHalfWidth: 80), 0),
            child: Container(
            constraints: const BoxConstraints(maxWidth: 160),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColors.border),
            ),
            child: const Text(
              'Kuis Sumatif — Selesaikan semua tahun',
              textAlign: TextAlign.center,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: AppColors.textSecondary,
              ),
            ),
          )),
        ],
      ),
    ));
  }
}

/// Belum dikerjakan sama sekali — SENGAJA dibuat paling mencolok (merah +
/// ikon besar + shadow tebal + cincin glow berdenyut) karena ERAQUIZ-01
/// minta node ini tampil beda dari node tahun biasa.
class _UnattemptedFinalBoss extends StatefulWidget {
  const _UnattemptedFinalBoss({required this.onTap, this.nodeX, this.screenWidth});

  final VoidCallback onTap;
  final double? nodeX;
  final double? screenWidth;

  static const _red = Color(0xFFE53935);

  @override
  State<_UnattemptedFinalBoss> createState() => _UnattemptedFinalBossState();
}

class _UnattemptedFinalBossState extends State<_UnattemptedFinalBoss>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1700),
  );
  bool _pulseStarted = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_pulseStarted) return;
    _pulseStarted = true;
    // Hormati "reduce motion": cincin glow tidak berdenyut.
    if (!MediaQuery.disableAnimationsOf(context)) _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const red = _UnattemptedFinalBoss._red;

    return Semantics(
      button: true,
      onTap: widget.onTap,
      label: 'Kuis sumatif era. Belum dikerjakan, ketuk untuk mulai.',
      excludeSemantics: true,
      child: PressableScale(
      onTap: widget.onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 130,
            height: 130,
            child: Stack(
              alignment: Alignment.center,
              children: [
                AnimatedBuilder(
                  animation: _controller,
                  builder: (context, _) {
                    final t = Curves.easeOut.transform(_controller.value);
                    return Opacity(
                      opacity: (1 - t) * 0.45,
                      child: Container(
                        width: 96 + 34 * t,
                        height: 96 + 34 * t,
                        decoration: const BoxDecoration(shape: BoxShape.circle, color: red),
                      ),
                    );
                  },
                ),
                Container(
                  width: 96,
                  height: 96,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: red,
                    boxShadow: [
                      BoxShadow(color: red.withValues(alpha: 0.45), blurRadius: 20, offset: const Offset(0, 6)),
                    ],
                    border: Border.all(color: Colors.white, width: 3),
                  ),
                  alignment: Alignment.center,
                  // TODO: ganti ikon kalau Design.md menetapkan ikon final-boss
                  // yang spesifik — ini placeholder sementara.
                  child: const Icon(Icons.local_fire_department_rounded, size: 40, color: Colors.white),
                ),
              ],
            ),
          ),
          const SizedBox(height: 4),
          Transform.translate(
            offset: Offset(_shiftFor(nodeX: widget.nodeX, screenWidth: widget.screenWidth, boxHalfWidth: 85), 0),
            child: Container(
            constraints: const BoxConstraints(maxWidth: 170),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.ink,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Kuis Sumatif Era',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
                ),
                SizedBox(height: 2),
                Text(
                  'Uji semua yang sudah kamu pelajari →',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
              ],
            ),
          )),
        ],
      ),
    ));
  }
}

/// Sudah pernah dikerjakan (permanen, R-ERAQUIZ-09). Tap membuka halaman
/// Hasil dari attempt tersimpan terakhir (bukan mengerjakan ulang).
class _AttemptedFinalBoss extends StatelessWidget {
  const _AttemptedFinalBoss({
    required this.accent,
    required this.onTap,
    this.nodeX,
    this.screenWidth,
  });

  final Color accent;
  final VoidCallback onTap;
  final double? nodeX;
  final double? screenWidth;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      onTap: onTap,
      label: 'Kuis sumatif era. Sudah dikerjakan, ketuk untuk melihat hasil.',
      excludeSemantics: true,
      child: PressableScale(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: 84,
                height: 84,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: accent,
                  boxShadow: [
                    BoxShadow(color: accent.withValues(alpha: 0.35), blurRadius: 12, offset: const Offset(0, 4)),
                  ],
                ),
                alignment: Alignment.center,
                child: const Icon(Icons.emoji_events_rounded, size: 34, color: AppColors.ink),
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
                    border: Border.fromBorderSide(BorderSide(color: Colors.white, width: 2)),
                  ),
                  child: const Icon(Icons.check_rounded, size: 13, color: Colors.white),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Transform.translate(
            offset: Offset(_shiftFor(nodeX: nodeX, screenWidth: screenWidth, boxHalfWidth: 75), 0),
            child: Container(
            constraints: const BoxConstraints(maxWidth: 150),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColors.border),
            ),
            child: const Text(
              'Kuis Sumatif — Lihat Hasil',
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.ink),
            ),
          )),
        ],
      ),
    ));
  }
}

/// Geser horizontal (px) supaya kotak label selebar `2 * boxHalfWidth`
/// yang idealnya center di `nodeX` tetap muat di dalam `screenWidth`
/// (sama dengan `_shiftForBox` di year_node.dart).
double _shiftFor({
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