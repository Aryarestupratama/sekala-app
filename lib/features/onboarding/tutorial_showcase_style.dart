import 'package:flutter/material.dart';
import 'package:showcaseview/showcaseview.dart';

import '../../core/theme/app_colors.dart';

/// Gaya tooltip tutorial terpusat — dipakai SEMUA titik `Showcase(...)` di
/// app (Home, Informasi, Roadmap, Koleksi, Profil) lewat [tutorialShowcase]
/// alih-alih memanggil `Showcase(...)` polos di tiap layar.
///
/// KENAPA DIPUSATKAN DI SINI (bukan per-layar): kalau mau ganti gaya
/// tooltip lagi nanti (warna, radius, tombol, dst), cukup ubah SATU fungsi
/// ini, bukan 6 titik di 5 file berbeda (home_screen, era_list_screen,
/// era_roadmap_screen x2, vaccine_list_screen, profile_screen).
///
/// REVISI: tambah tombol "Lanjutkan" eksplisit di tooltip (sebelumnya
/// mengandalkan tap-di-mana-saja bawaan package, yang tidak kelihatan
/// sebagai aksi oleh user). Tombol memanggil `ShowcaseView.get().next()`
/// — method ini SAMA untuk showcase tunggal maupun grup (kalau ini key
/// terakhir dalam satu `startShowCase([...])`, `next()` otomatis memicu
/// `onFinish` yang sudah didaftarkan `TutorialTourController` di
/// main.dart, lanjut ke `onStepFinished()`). Karena itu, tombol ini TIDAK
/// perlu tahu apakah dirinya "terakhir" atau bukan — cukup satu label
/// "Lanjutkan" untuk semua kasus, `next()` yang menentukan sendiri jalan
/// mana yang benar.
///
/// SENGAJA pakai `TooltipActionButton.custom` (bukan
/// `TooltipActionButton(type: ...)` dengan enum built-in) supaya tombol
/// bisa di-styling penuh sesuai tema app, dan supaya tidak bergantung pada
/// nama enum tombol built-in yang berbeda-beda antar versi package
/// (`TooltipActionButtonType` di sebagian dokumentasi/fork,
/// `TooltipDefaultActionType` di contoh resmi Simform lainnya) — dengan
/// `.custom`, kita cuma perlu widget + callback, jauh lebih tahan
/// terhadap perbedaan versi.
///
/// CATATAN VERSI: parameter di bawah (`tooltipActions`,
/// `tooltipActionConfig`, `TooltipActionButton.custom`,
/// `ShowcaseView.get().next()`) dikonfirmasi ada di dokumentasi package
/// `showcaseview` v5.x — TAPI belum dites langsung terhadap versi persis
/// yang terkunci di `pubspec.lock` proyek ini. Kalau `flutter analyze`
/// menolak salah satu nama parameter, sesuaikan/hapus parameter itu saja
/// — jangan buang seluruh fungsi ini.
///
/// REVISI 2 — Indikator progres & tombol "Lewati Tutorial":
///
/// 1) Indikator progres ("2/5"): opsional lewat [currentStep]+[totalSteps].
///    Dirender sebagai teks kecil di atas judul. Kalau salah satu null,
///    indikator tidak dirender sama sekali (dipakai di titik showcase yang
///    berdiri sendiri, bukan bagian dari satu tur berurutan).
///
/// 2) Tombol "Lewati": [onSkip] adalah callback OPSIONAL. Fungsi ini SENGAJA
///    tidak memanggil `dismiss()`/`_markSeen()` sendiri — file ini cuma
///    urusan tampilan tooltip, bukan pemilik state tur. Pemanggil (nanti
///    `TutorialTourController` lewat wrapper di tiap layar) yang wajib
///    menyediakan callback konkret berisi `ShowcaseView.get().dismiss()`
///    DIIKUTI `_markSeen()`, supaya status "sudah lihat" ikut tersimpan —
///    ini alasan kenapa dulu tombol ini belum dipasang (lihat riwayat di
///    atas). Kalau [onSkip] tidak diisi, tombol "Lewati" tidak dirender —
///    jadi menambahkan fitur ini ke satu titik showcase tertentu murni
///    soal mengisi parameter ini di titik itu, tanpa menyentuh file ini
///    lagi maupun titik showcase lain yang belum siap.
Widget tutorialShowcase({
  required GlobalKey key,
  required String title,
  required String description,
  required Widget child,
  int? currentStep,
  int? totalSteps,
  VoidCallback? onSkip,
}) {
  final showProgress = currentStep != null && totalSteps != null;

  return Showcase(
    key: key,
    // Progres ditempel di depan judul (bukan widget/baris terpisah) karena
    // `Showcase` merender `title` lewat `titleTextStyle` tunggal — menaruh
    // widget kustom di atasnya butuh override `titleWidget` yang lebih
    // invasif untuk manfaat kecil. "2/5  Judul Section" cukup jelas dan
    // tetap satu baris style.
    title: showProgress ? '$currentStep/$totalSteps  $title' : title,
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
    tooltipActionConfig: const TooltipActionConfig(
      position: TooltipActionPosition.inside,
      alignment: MainAxisAlignment.end,
      gapBetweenContentAndAction: 14,
    ),
    tooltipActions: [
      if (onSkip != null)
        TooltipActionButton.custom(
          button: GestureDetector(
            onTap: onSkip,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              child: const Text(
                'Lewati',
                style: TextStyle(
                  color: Color(0xB3FFFFFF), // putih ~70%, sengaja lebih redup
                  // dari "Lanjutkan" — ini aksi sekunder/keluar, bukan aksi
                  // utama yang ingin didorong.
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
            ),
          ),
        ),
      TooltipActionButton.custom(
        // CATATAN: `TooltipActionButton.custom` cuma punya parameter
        // `button` + `hideActionWidgetForShowcase` — TIDAK punya `onTap`
        // (itu cuma ada di constructor default `TooltipActionButton()`
        // yang pakai enum `type`). Makanya tap handler dipasang langsung
        // di widget `button` lewat GestureDetector, bukan lewat parameter
        // `onTap` di factory ini.
        button: GestureDetector(
          onTap: () => ShowcaseView.get().next(),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Lanjutkan',
                  style: TextStyle(
                    color: AppColors.ink,
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
                  ),
                ),
                SizedBox(width: 6),
                Icon(Icons.arrow_forward_rounded, size: 15, color: AppColors.ink),
              ],
            ),
          ),
        ),
      ),
    ],
    child: child,
  );
}