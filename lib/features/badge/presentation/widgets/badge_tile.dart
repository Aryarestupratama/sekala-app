import 'dart:math' as math;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/models/badge_card.dart';

/// Kartu 1 badge di grid Koleksi Badge.
///
/// BEDA dari VaccineTile: badge locked TIDAK memakai foto siluet terpisah
/// ataupun nama "???" (backend memang tidak mengirim itu, lihat catatan
/// BadgeCard) — locked cukup diredupkan (`Opacity` + `ColorFiltered`
/// greyscale) dari ikon & nama aslinya, ditambah lencana gembok kecil di
/// pojok. Badge TIDAK punya alur reveal/confetti seperti Koleksi Vaksin —
/// SATU-SATUNYA kemiripan dengan vaksin adalah tag "Baru" + glow untuk
/// badge yang `unlocked && unseen` (baru didapat, belum pernah dibuka
/// detailnya), persis pola `_needsGlow` di VaccineTile, cuma tanpa
/// dialog/antrean reveal terpisah — mark-seen terjadi saat detail sheet
/// dibuka (lihat `_showBadgeDetail` di badge_list_screen.dart).
class BadgeTile extends StatelessWidget {
  const BadgeTile({super.key, required this.badge, this.onTap});

  final BadgeCard badge;
  final VoidCallback? onTap;

  bool get _needsGlow => badge.unlocked && badge.unseen;

  @override
  Widget build(BuildContext context) {
    final locked = !badge.unlocked;

    final card = InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: _needsGlow ? AppColors.gamify : AppColors.border,
            width: _needsGlow ? 1.5 : 1,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Opacity(
                    opacity: locked ? 0.35 : 1.0,
                    child: locked
                        ? ColorFiltered(
                            colorFilter: const ColorFilter.matrix(<double>[
                              0.2126, 0.7152, 0.0722, 0, 0,
                              0.2126, 0.7152, 0.0722, 0, 0,
                              0.2126, 0.7152, 0.0722, 0, 0,
                              0, 0, 0, 1, 0,
                            ]),
                            child: _BadgeIcon(url: badge.iconUrl),
                          )
                        : _BadgeIcon(url: badge.iconUrl),
                  ),
                  if (locked)
                    Positioned(
                      right: 4,
                      bottom: 4,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: Colors.black54,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.lock_outline_rounded,
                          size: 12,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  if (_needsGlow)
                    Positioned(
                      top: 0,
                      left: 0,
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
            const SizedBox(height: 8),
            Text(
              badge.name,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 12.5,
                color: locked ? AppColors.textSecondary : AppColors.ink,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              badge.year.title,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 10.5, color: AppColors.textDisabled),
            ),
          ],
        ),
      ),
    );

    // Glow cuma dipasang kalau perlu — badge locked/sudah-dilihat nggak
    // ke-overhead animasi looping sama sekali. Sama pola dengan
    // `_PulsingGlow` di vaccine_tile.dart (disalin, bukan diimpor, supaya
    // widget badge tetap berdiri sendiri tanpa dependensi silang ke fitur
    // Vaksin).
    return _needsGlow ? _PulsingGlow(child: card) : card;
  }
}

class _BadgeIcon extends StatelessWidget {
  const _BadgeIcon({required this.url});

  final String? url;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: ClipOval(
        child: Container(
          color: AppColors.ink.withValues(alpha: 0.06),
          child: url == null
              ? const Icon(Icons.emoji_events_outlined, color: AppColors.textSecondary)
              : CachedNetworkImage(
                  imageUrl: url!,
                  fit: BoxFit.cover,
                  errorWidget: (_, __, ___) =>
                      const Icon(Icons.emoji_events_outlined, color: AppColors.textSecondary),
                ),
        ),
      ),
    );
  }
}

/// Border-glow yang "berdenyut" pelan tanpa henti — disalin persis dari
/// `_PulsingGlow` milik vaccine_tile.dart (lihat catatan di pemakaiannya
/// di atas soal kenapa disalin, bukan diimpor).
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