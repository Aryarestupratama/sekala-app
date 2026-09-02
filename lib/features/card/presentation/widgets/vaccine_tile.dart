import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/models/vaccine_card.dart';

/// Design.md §3.4 poin 1, disesuaikan ke domain vaksin.
///
/// PENTING (beda dari mockup tokoh lama): nama vaksin TIDAK disamarkan jadi
/// "???" saat terkunci — R-VAC-04 cuma menyembunyikan FOTO, bukan nama.
/// Yang disembunyikan hanya `photoUrl` (backend kirim null saat locked,
/// diganti `photoLockedUrl` versi siluet — lihat VaccineCardResource).
class VaccineTile extends StatelessWidget {
  const VaccineTile({super.key, required this.vaccine, required this.onTap});

  final VaccineCard vaccine;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final accent = vaccine.unlocked ? AppColors.gamify : AppColors.border;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: accent.withValues(alpha: vaccine.unlocked ? 0.6 : 1)),
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
                          Icons.lock_outline,
                          size: 14,
                          color: AppColors.textSecondary,
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
  }

  Widget _buildImage() {
    // Unlocked: pakai foto asli. Locked: pakai foto siluet kalau admin sudah
    // isi `photo_locked_url`; kalau belum, fallback ke ikon generik vaksin.
    final url = vaccine.unlocked ? vaccine.photoUrl : vaccine.photoLockedUrl;
    if (url == null) {
      return Icon(
        vaccine.unlocked ? Icons.vaccines_outlined : Icons.lock_outline,
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