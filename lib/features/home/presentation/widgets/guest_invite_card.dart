import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/pressable_scale.dart';

/// Design.md §3.2: untuk guest, kartu progress diganti ajakan
/// "Masuk untuk melacak progress bacaanmu".
///
/// REDESIGN: dari `Card` tint tipis jadi kartu gradasi warna gamify yang
/// lebih tegas, dengan ikon besar di kanan sebagai aksen visual dan
/// tombol pill putih (bukan FilledButton default) supaya kontras di atas
/// warna. Seluruh kartu bisa ditekan (bukan cuma tombolnya).
class GuestInviteCard extends StatelessWidget {
  const GuestInviteCard({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return PressableScale(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.gamify,
              AppColors.gamify.withValues(alpha: 0.78),
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.gamify.withValues(alpha: 0.28),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        padding: const EdgeInsets.fromLTRB(18, 18, 8, 18),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Buka semua fitur',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Masuk untuk melacak progress bacaan, ikut kuis, '
                    'dan kumpulkan collectible card tokoh sejarah.',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.white.withValues(alpha: 0.92),
                          height: 1.35,
                        ),
                  ),
                  const SizedBox(height: 14),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'Masuk sekarang',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: AppColors.gamify,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 4),
            Icon(
              Icons.lock_open_rounded,
              color: Colors.white.withValues(alpha: 0.35),
              size: 56,
            ),
          ],
        ),
      ),
    );
  }
}