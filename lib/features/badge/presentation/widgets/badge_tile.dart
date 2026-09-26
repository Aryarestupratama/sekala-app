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
/// pojok. Ini keputusan produk yang jauh lebih sederhana dari animasi
/// reveal/confetti Koleksi Vaksin — badge TIDAK punya alur "sudah
/// dilihat"/reveal sama sekali.
class BadgeTile extends StatelessWidget {
  const BadgeTile({super.key, required this.badge, this.onTap});

  final BadgeCard badge;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final locked = !badge.unlocked;

    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.border),
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