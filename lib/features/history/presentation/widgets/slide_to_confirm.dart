import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/theme/app_colors.dart';

/// Tombol "geser untuk lanjut" (slide-to-confirm) — dipakai sebagai CTA
/// bawah di section_detail_screen.dart menggantikan tombol ketuk biasa,
/// supaya tidak terpencet saat user sedang scroll materi.
///
/// CARA KERJA
/// - Hanya THUMB (lingkaran putih) yang bisa diseret; area track kosong
///   tidak bereaksi, jadi jempol yang menyapu layar tidak memicu apa pun.
/// - Lepas sebelum [_threshold] (80% jarak) -> thumb membal kembali ke awal.
/// - Lewat ambang -> getar (haptic), thumb mengunci di ujung kanan, lalu
///   [onConfirm] dipanggil. Selama [loading] tampil spinner + "Memproses…".
/// - Ketuk thumb tanpa menggeser -> thumb "mengintip" maju sedikit lalu
///   kembali (petunjuk cara pakai), TIDAK mengonfirmasi.
///
/// AKSESIBILITAS (WCAG 2.5.1/2.5.7 — gerakan menyeret butuh alternatif)
/// - Screen reader (TalkBack/VoiceOver) & Switch Access: aksi semantik
///   "ketuk dua kali" langsung mengonfirmasi tanpa menyeret.
/// - Thumb 60x60dp area sentuh (>= 48dp). Teks 16sp, kontras putih di atas
///   Ink ~19:1.
/// - "Reduce motion": tanpa animasi chevron & tanpa animasi membal.
///
/// [onConfirm] null = nonaktif (mis. data belum siap); tampilan meredup dan
/// label berganti [loadingLabel] bila [loading] true.
class SlideToConfirm extends StatefulWidget {
  const SlideToConfirm({
    super.key,
    required this.label,
    required this.onConfirm,
    this.loading = false,
    this.loadingLabel = 'Memuat…',
    this.confirmedLabel = 'Memproses…',
    this.accent,
  });

  /// Teks ajakan saat siap, mis. "Geser untuk lanjut baca".
  final String label;

  /// Dipanggil sekali setelah thumb sampai ujung. Null = nonaktif.
  final VoidCallback? onConfirm;

  /// True saat aksi sedang berjalan (atau data pendukung belum siap).
  final bool loading;

  final String loadingLabel;
  final String confirmedLabel;

  /// Warna isian di belakang thumb (mis. warna era). Null = putih transparan.
  final Color? accent;

  @override
  State<SlideToConfirm> createState() => _SlideToConfirmState();
}

class _SlideToConfirmState extends State<SlideToConfirm> with TickerProviderStateMixin {
  static const double _height = 60;
  static const double _box = 60; // area sentuh thumb
  static const double _thumb = 52; // diameter visual thumb
  static const double _threshold = 0.8;

  late final AnimationController _snap = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 220),
  );
  late final AnimationController _hint = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1500),
  );

  Animation<double>? _active;
  double _dx = 0;
  double _maxDx = 0;
  bool _confirmed = false;
  bool _passedThreshold = false;
  bool _hintStarted = false;

  bool get _reduceMotion => MediaQuery.disableAnimationsOf(context);
  bool get _enabled => widget.onConfirm != null && !widget.loading && !_confirmed;
  bool get _busy => _confirmed || widget.loading;

  String get _shownLabel {
    if (_confirmed) return widget.confirmedLabel;
    if (widget.loading) return widget.loadingLabel;
    return widget.label;
  }

  @override
  void initState() {
    super.initState();
    _snap.addListener(_onSnapTick);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_hintStarted) return;
    _hintStarted = true;
    if (!_reduceMotion) _hint.repeat();
  }

  @override
  void didUpdateWidget(SlideToConfirm oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Aksi selesai tapi layar ini masih tampil -> kembalikan thumb supaya
    // tombol bisa dipakai lagi.
    if (oldWidget.loading && !widget.loading && _confirmed) {
      _resetAfterConfirm();
    }
  }

  @override
  void dispose() {
    _snap.dispose();
    _hint.dispose();
    super.dispose();
  }

  void _onSnapTick() {
    final a = _active;
    if (a == null || !mounted) return;
    setState(() => _dx = a.value);
  }

  /// Animasikan posisi thumb. Return false kalau dibatalkan (drag dimulai /
  /// widget di-dispose).
  Future<bool> _animateTo(
    double target, {
    int ms = 220,
    Curve curve = Curves.easeOutCubic,
  }) async {
    if (!mounted) return false;
    if (_reduceMotion || (_dx - target).abs() < 0.5) {
      setState(() => _dx = target);
      return true;
    }
    _snap.duration = Duration(milliseconds: ms);
    _active = _snap.drive(Tween<double>(begin: _dx, end: target).chain(CurveTween(curve: curve)));
    try {
      await _snap.forward(from: 0).orCancel;
      return true;
    } on TickerCanceled {
      return false;
    }
  }

  Future<void> _resetAfterConfirm() async {
    await Future<void>.delayed(const Duration(milliseconds: 500));
    if (!mounted) return;
    setState(() {
      _confirmed = false;
      _passedThreshold = false;
    });
    await _animateTo(0, ms: 260);
  }

  Future<void> _confirm() async {
    if (!_enabled) return;
    setState(() => _confirmed = true);
    HapticFeedback.mediumImpact();
    await _animateTo(_maxDx, ms: 120);
    if (!mounted) return;
    widget.onConfirm?.call();
  }

  /// Ketuk tanpa geser: beri petunjuk, jangan konfirmasi.
  Future<void> _nudge() async {
    if (!_enabled) return;
    HapticFeedback.lightImpact();
    if (_reduceMotion) return;
    if (!await _animateTo(32, ms: 160)) return;
    if (!mounted || _confirmed) return;
    await _animateTo(0, ms: 240);
  }

  void _onDragStart(DragStartDetails details) {
    _snap.stop();
    _passedThreshold = _maxDx > 0 && _dx / _maxDx >= _threshold;
  }

  void _onDragUpdate(DragUpdateDetails details) {
    final next = (_dx + details.delta.dx).clamp(0.0, _maxDx);
    final passed = _maxDx > 0 && next / _maxDx >= _threshold;
    if (passed && !_passedThreshold) HapticFeedback.selectionClick();
    _passedThreshold = passed;
    setState(() => _dx = next);
  }

  void _onDragEnd(DragEndDetails details) {
    if (_maxDx > 0 && _dx / _maxDx >= _threshold) {
      _confirm();
    } else {
      _animateTo(0);
    }
  }

  void _onDragCancel() {
    if (!_confirmed) _animateTo(0);
  }

  @override
  Widget build(BuildContext context) {
    final reduce = _reduceMotion;
    final enabled = _enabled;

    return Semantics(
      button: true,
      enabled: enabled,
      label: _busy
          ? _shownLabel
          : '${widget.label}. Geser ke kanan, atau ketuk dua kali untuk melanjutkan.',
      onTap: enabled ? _confirm : null,
      excludeSemantics: true,
      child: LayoutBuilder(
        builder: (context, constraints) {
          _maxDx = (constraints.maxWidth - _box).clamp(0.0, double.infinity);
          final progress = _maxDx <= 0 ? 0.0 : (_dx / _maxDx).clamp(0.0, 1.0);

          final dimmed = !enabled && !_confirmed;
          final trackColor = dimmed ? AppColors.ink.withValues(alpha: 0.6) : AppColors.ink;
          final accent = widget.accent;
          final fillColor = accent == null
              ? Colors.white.withValues(alpha: 0.16)
              : accent.withValues(alpha: 0.55);
          final labelOpacity = _busy ? 1.0 : (1 - progress * 1.6).clamp(0.0, 1.0);

          final showSpinner = widget.loading && (_confirmed || !enabled);
          final showCheck = !showSpinner && (_confirmed || progress >= _threshold);

          return SizedBox(
            height: _height,
            child: Stack(
              children: [
                Positioned.fill(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: trackColor,
                      borderRadius: BorderRadius.circular(_height / 2),
                    ),
                  ),
                ),
                // Isian yang mengikuti thumb.
                Positioned(
                  left: 0,
                  top: 0,
                  bottom: 0,
                  width: _dx + _box,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: fillColor,
                      borderRadius: BorderRadius.circular(_height / 2),
                    ),
                  ),
                ),
                // Label, dipusatkan di ruang yang tidak tertutup thumb.
                Positioned.fill(
                  child: Padding(
                    padding: _confirmed
                        ? const EdgeInsets.only(left: 20, right: _box + 4)
                        : const EdgeInsets.only(left: _box + 4, right: 20),
                    child: Center(
                      child: Opacity(
                        opacity: labelOpacity,
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                _shownLabel,
                                maxLines: 1,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              if (!_busy && enabled) ...[
                                const SizedBox(width: 6),
                                _Chevrons(animation: _hint, animate: !reduce),
                              ],
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                // Thumb — satu-satunya area yang bisa diseret.
                Positioned(
                  left: _dx,
                  top: 0,
                  bottom: 0,
                  width: _box,
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: enabled ? _nudge : null,
                    onHorizontalDragStart: enabled ? _onDragStart : null,
                    onHorizontalDragUpdate: enabled ? _onDragUpdate : null,
                    onHorizontalDragEnd: enabled ? _onDragEnd : null,
                    onHorizontalDragCancel: enabled ? _onDragCancel : null,
                    child: Center(
                      child: Container(
                        width: _thumb,
                        height: _thumb,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: dimmed ? Colors.white.withValues(alpha: 0.75) : Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.22),
                              blurRadius: 6,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        alignment: Alignment.center,
                        child: showSpinner
                            ? const SizedBox(
                                width: 22,
                                height: 22,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2.5,
                                  color: AppColors.ink,
                                ),
                              )
                            : Icon(
                                showCheck ? Icons.check_rounded : Icons.arrow_forward_rounded,
                                size: 26,
                                color: AppColors.ink,
                              ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

/// Tiga chevron yang berkedip berurutan kiri -> kanan sebagai petunjuk arah.
class _Chevrons extends StatelessWidget {
  const _Chevrons({required this.animation, required this.animate});

  final Animation<double> animation;
  final bool animate;

  static double _wave(double t) => 0.25 + 0.75 * (1 - (t - 0.5).abs() * 2);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, _) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (var i = 0; i < 3; i++)
              Opacity(
                opacity: animate ? _wave((animation.value + i * 0.18) % 1.0) : 0.7,
                child: const Icon(Icons.chevron_right_rounded, size: 16, color: Colors.white),
              ),
          ],
        );
      },
    );
  }
}