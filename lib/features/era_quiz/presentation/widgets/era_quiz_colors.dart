import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

/// Putih atau Ink di atas [bg], mana yang rasio kontras WCAG-nya lebih
/// tinggi. `ThemeData.estimateBrightnessForColor` keliru untuk Green era
/// Kemerdekaan (#4BA95F): menganggapnya "gelap" -> teks putih ~2.9:1,
/// padahal Ink ~6.6:1. Sky (~12:1) dan Orange (~10:1) otomatis memakai Ink.
Color eraQuizOnColor(Color bg) {
  final l = bg.computeLuminance();
  final white = 1.05 / (l + 0.05);
  final ink = (l + 0.05) / (AppColors.ink.computeLuminance() + 0.05);
  return white >= ink ? Colors.white : AppColors.ink;
}

/// Aksen era digelapkan ke arah Ink untuk teks kecil / grafis penting di
/// atas latar terang (Sky mentah hanya ~1.6:1 di atas putih).
Color eraQuizAccentStrong(Color accent) => Color.lerp(accent, AppColors.ink, 0.45)!;