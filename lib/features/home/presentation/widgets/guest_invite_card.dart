import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/pressable_scale.dart';

/// Design.md §3.2: untuk guest, ajakan masuk/daftar.
///
/// REVISI (design review):
/// - COPY SALAH: "collectible card tokoh sejarah" sudah usang — koleksinya
///   sekarang kartu VAKSIN (PRD §4.6), plus ada badge.
/// - KONTRAS: teks putih di atas ungu `AppColors.gamify` (#9985FB) ~3.0:1
///   (dan lebih rendah di ujung gradasi) — gagal AA 4.5:1. Sekarang teks
///   Ink (~6.6:1) dan tombol pill Ink dengan teks putih.
/// - Teks bodySmall 12sp -> bodyMedium 14sp.
/// - Label tombol "Masuk atau daftar": tombol ini membuka layar Masuk/Daftar,
///   bukan hanya Masuk (mayoritas guest adalah user baru).
/// - Semantics: satu tombol; ikon dekoratif disembunyikan dari screen reader.
class GuestInviteCard extends StatelessWidget {
  const GuestInviteCard({super.key, required this.onTap});

  final VoidCallback onTap;

  static const _title = 'Simpan progres belajarmu';
  static const _body =
      'Masuk atau daftar untuk melacak bacaan, mengerjakan kuis, '
      'dan mengoleksi kartu vaksin serta badge.';

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Semantics(
      button: true,
      onTap: onTap,
      label: '$_title. $_body',
      excludeSemantics: true,
      child: PressableScale(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppColors.gamify,
                Color.lerp(AppColors.gamify, Colors.white, 0.25)!,
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
                      _title,
                      style: textTheme.titleMedium?.copyWith(
                        color: AppColors.ink,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _body,
                      style: textTheme.bodyMedium?.copyWith(
                        color: AppColors.ink.withValues(alpha: 0.85),
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 14),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.ink,
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: const Text(
                          'Masuk atau daftar',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
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
                color: AppColors.ink.withValues(alpha: 0.18),
                size: 56,
              ),
            ],
          ),
        ),
      ),
    );
  }
}