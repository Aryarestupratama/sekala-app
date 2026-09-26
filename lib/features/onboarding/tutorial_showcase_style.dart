import 'package:flutter/material.dart';
import 'package:showcaseview/showcaseview.dart';

import '../../core/theme/app_colors.dart';

/// Gaya tooltip tutorial terpusat — dipakai SEMUA titik `Showcase(...)` di
/// app (Home, Informasi, Roadmap, Koleksi, Profil) lewat [tutorialShowcase]
/// alih-alih memanggil `Showcase(...)` polos di tiap layar.
///
/// KENAPA DIPUSATKAN DI SINI (bukan per-layar): sebelumnya tiap
/// `Showcase(...)` cuma diisi `title`/`description`/`child`, jadi
/// tampilannya 100% default bawaan package `showcaseview` — polos dan
/// tidak match dengan tema app (kartu putih, aksen ink). Kalau mau ganti
/// gaya tooltip lagi nanti (warna, radius, dst), cukup ubah SATU fungsi
/// ini, bukan 5 file (home_screen, era_list_screen, era_roadmap_screen x2,
/// vaccine_list_screen, profile_screen).
///
/// CATATAN VERSI: parameter di bawah ditulis untuk `showcaseview` v5.1.0
/// (versi yang sama disebut di `tutorial_keys.dart`). Kalau `flutter
/// analyze` menolak salah satu parameter (nama berubah antar versi minor),
/// hapus/ganti parameter itu saja — jangan buang seluruh fungsi ini.
Widget tutorialShowcase({
  required GlobalKey key,
  required String title,
  required String description,
  required Widget child,
}) {
  return Showcase(
    key: key,
    title: title,
    description: description,
    titleTextStyle: const TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w800,
      fontSize: 15,
    ),
    descTextStyle: const TextStyle(
      color: Color(0xE6FFFFFF), // putih ~90% opacity, lebih lembut dari judul
      fontSize: 13,
      height: 1.4,
    ),
    tooltipBackgroundColor: AppColors.ink,
    tooltipPadding: const EdgeInsets.all(16),
    tooltipBorderRadius: BorderRadius.circular(18),
    targetBorderRadius: BorderRadius.circular(16),
    overlayColor: Colors.black,
    overlayOpacity: 0.75,
    child: child,
  );
}