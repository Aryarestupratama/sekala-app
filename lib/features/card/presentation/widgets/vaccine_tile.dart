import 'dart:math' as math;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/models/vaccine_card.dart';
import '../../../../shared/widgets/pressable_scale.dart';

/// Design.md §3.4 poin 1, disesuaikan ke domain vaksin.
///
/// PENTING (beda dari mockup tokoh lama): nama vaksin TIDAK disamarkan jadi
/// "???" saat terkunci — R-VAC-04 cuma menyembunyikan FOTO, bukan nama.
/// Yang disembunyikan hanya `photoUrl` (backend kirim null saat locked,
/// diganti `photoLockedUrl` versi siluet — lihat VaccineCardResource).
///
/// GLOW "BARU": vaksin yang `unlocked && unseen` (sudah lolos animasi
/// reveal di dialog, tapi belum pernah dibuka detailnya — lihat
/// `_openDetail` di vaccine_list_screen.dart yang baru menandai `seen`
/// pas detail dibuka, BUKAN pas dialog reveal ditutup) dikasih glow
/// pulsing + badge kecil "Baru!", supaya tetap menonjol di grid sampai
/// user benar-benar buka detailnya.
///
/// REDESIGN: `InkWell` (ripple Material) diganti [PressableScale] (scale
/// tekan) supaya konsisten dengan tap-feedback di kartu lain se-app;
/// `onTap`, kondisi glow, dan silhouette locked/unlocked sama persis.
class VaccineTile extends StatelessWidget {
  const VaccineTile({super.key, required this.vaccine, required this.onTap});

  final VaccineCard vaccine;
  final VoidCallback onTap;

  bool get _needsGlow => vaccine.unlocked && vaccine.unseen;

  @override
  Widget build(BuildContext context) {
    final accent = vaccine.unlocked ? AppColors.gamify : AppColors.border;

    final card = PressableScale(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: _needsGlow ? AppColors.gamify : accent.withValues(alpha: vaccine.unlocked ? 0.6 : 1),
            width: _needsGlow ? 1.5 : 1,
          ),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Container(
                    color: vaccine.unlocked
                        ? AppColors.gamify.withValues(alpha: 0.08)
                        : AppColors.border.withValues(alpha: 0.35),
                    child: _buildImage(),
                  ),
                  if (!vaccine.unlocked)
                    Positioned(
                      top: 6,
                      right: 6,
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.lock_outline_rounded,
                          size: 14,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ),
                  if (_needsGlow)
                    Positioned(
                      top: 6,
                      left: 6,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: AppColors.gamify,
                          borderRadius: BorderRadius.circular(999),
                          boxShadow: const [
                            BoxShadow(color: Colors.black26, blurRadius: 4, offset: Offset(0, 2)),
                          ],
                        ),
                        child: const Text(
                          'Baru!',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.2,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 8, 10, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    vaccine.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 6,
                        height: 6,
                        decoration: BoxDecoration(
                          color: vaccine.unlocked ? AppColors.success : AppColors.textDisabled,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        vaccine.unlocked ? 'TERBUKA' : 'TERKUNCI',
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              color: AppColors.textSecondary,
                              letterSpacing: 0.4,
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
    );

    // Glow cuma dipasang kalau perlu — item locked/sudah-dilihat nggak
    // ke-overhead animasi looping sama sekali.
    return _needsGlow ? _PulsingGlow(child: card) : card;
  }

  Widget _buildImage() {
    // Unlocked: pakai foto asli. Locked: pakai foto siluet kalau admin sudah
    // isi `photo_locked_url`; kalau belum, fallback ke ikon generik vaksin.
    final url = vaccine.unlocked ? vaccine.photoUrl : vaccine.photoLockedUrl;
    if (url == null) {
      return Icon(
        vaccine.unlocked ? Icons.vaccines_outlined : Icons.lock_outline_rounded,
        size: 32,
        color: vaccine.unlocked ? AppColors.gamify : AppColors.border,
      );
    }
    return CachedNetworkImage(
      imageUrl: url,
      fit: BoxFit.cover,
      errorWidget: (context, url, error) => const Icon(Icons.vaccines_outlined, size: 32),
    );
  }
}

/// Border-glow yang "berdenyut" pelan tanpa henti (dipasang di luar
/// [PressableScale] supaya efek shadow tidak ke-clip sama `Clip.antiAlias`
/// di Container dalamnya). Blur & spread naik-turun terus lewat kurva sin,
/// jadi transisinya mulus di kedua ujung (bukan "loncat" pas reverse).
class _PulsingGlow extends StatefulWidget {
  const _PulsingGlow({required this.child});

  final Widget child;

  @override
  State<_PulsingGlow> createState() => _PulsingGlowState();
}

class _PulsingGlowState extends State<_PulsingGlow> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        // sin -> 0..1..0 mulus, dipakai buat naik-turunin blur/spread/opacity.
        final t = (math.sin(_controller.value * 2 * math.pi) + 1) / 2;
        return DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: AppColors.gamify.withValues(alpha: 0.25 + 0.35 * t),
                blurRadius: 8 + 14 * t,
                spreadRadius: 1 + 2 * t,
              ),
            ],
          ),
          child: child,
        );
      },
      child: widget.child,
    );
  }
}