import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

/// Padding horizontal standar semua layar Studi Kasus.
const double kCaseStudyHPad = 24;

/// Fade + geser tipis berurutan per [index] (delay 70ms/urutan). Dilewati
/// kalau user mematikan animasi di pengaturan aksesibilitas OS.
Widget caseStudyReveal(BuildContext context, int index, Widget child) {
  if (MediaQuery.disableAnimationsOf(context)) return child;
  return child
      .animate(delay: (70 * index).ms)
      .fadeIn(duration: 350.ms, curve: Curves.easeOut)
      .slideY(begin: 0.06, end: 0, duration: 350.ms, curve: Curves.easeOut);
}

/// Tombol kembali bundar (kiri atas) — putih + border tipis.
class CaseStudyBackButton extends StatelessWidget {
  const CaseStudyBackButton({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: 'Kembali',
      child: Material(
        color: AppColors.surface,
        shape: const CircleBorder(side: BorderSide(color: AppColors.border)),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: const SizedBox(
            width: 40,
            height: 40,
            child: Icon(Icons.arrow_back_rounded, size: 20, color: AppColors.ink),
          ),
        ),
      ),
    );
  }
}

/// Batang aksen kecil di atas eyebrow. Warnanya mengikuti era (dioper
/// pemanggil) — default oren (`AppColors.warning`) HANYA sebagai jaring
/// pengaman kalau suatu saat dipakai di tempat yang belum sempat dioper
/// warna era-nya.
class CaseStudyAccentBar extends StatelessWidget {
  const CaseStudyAccentBar({super.key, this.color = AppColors.warning});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 3,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }
}

/// Label kecil uppercase ber-letter-spacing (eyebrow / heading kartu).
class CaseStudyEyebrow extends StatelessWidget {
  const CaseStudyEyebrow(this.text, {super.key, this.letterSpacing = 1.4});

  final String text;
  final double letterSpacing;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: AppTextStyles.caption.copyWith(
        color: AppColors.ink,
        fontSize: 11.5,
        fontWeight: FontWeight.w700,
        letterSpacing: letterSpacing,
      ),
    );
  }
}

/// Tombol CTA utama pill berwarna (teks kontras otomatis + ikon opsional)
/// — dipakai di bawah layar Opening/Briefing/Ruang Keputusan.
///
/// - [color]: warna latar saat aktif — dioper era, default oren
///   (`AppColors.warning`) sebagai jaring pengaman.
/// - [onTap] null -> tampilan disabled (abu-abu, sesuai mockup).
/// - [loading] true -> tetap berwarna [color] dengan spinner, tap
///   diabaikan (mencegah double submit tanpa "berkedip" jadi abu-abu).
/// - [icon] null -> tanpa ikon (mis. "Submit analisis").
class CaseStudyPrimaryButton extends StatelessWidget {
  const CaseStudyPrimaryButton({
    super.key,
    required this.label,
    required this.onTap,
    this.color = AppColors.warning,
    this.icon = Icons.arrow_forward_rounded,
    this.loading = false,
  });

  final String label;
  final VoidCallback? onTap;
  final Color color;
  final IconData? icon;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    final active = loading || onTap != null;
    // Kontras teks/ikon dihitung dari kecerahan [color], bukan
    // di-hardcode ink — warna era ada yang gelap (mis. Kemerdekaan),
    // teks hitam di atasnya tidak akan kebaca.
    final onColor = ThemeData.estimateBrightnessForColor(color) == Brightness.dark
        ? Colors.white
        : AppColors.ink;
    final fg = active ? onColor : AppColors.textDisabled;

    return SizedBox(
      width: double.infinity,
      height: 52,
      child: FilledButton(
        onPressed: loading ? () {} : onTap,
        style: FilledButton.styleFrom(
          backgroundColor: color,
          foregroundColor: onColor,
          disabledBackgroundColor: AppColors.border,
          disabledForegroundColor: AppColors.textDisabled,
          shape: const StadiumBorder(),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(label, style: AppTextStyles.button.copyWith(color: fg)),
            if (loading) ...[
              const SizedBox(width: 10),
              SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: onColor,
                ),
              ),
            ] else if (icon != null) ...[
              const SizedBox(width: 8),
              Icon(icon, size: 18, color: fg),
            ],
          ],
        ),
      ),
    );
  }
}