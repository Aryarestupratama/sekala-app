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
/// BELUM ditambahkan (sengaja): tombol "Lewati Tutorial". `dismiss()`
/// menutup overlay tapi TIDAK memicu `onFinish`, jadi kalau dipasang
/// naif, status "sudah pernah lihat tutorial" (`_markSeen()` di
/// `TutorialTourController`) tidak akan pernah tersimpan — tutorial akan
/// auto-start lagi di login berikutnya walau user sudah skip. Menambah
/// tombol itu dengan benar perlu perubahan di `tutorial_tour_controller
/// .dart` juga (skip harus ikut memanggil `_markSeen()`), bukan cuma di
/// file ini — beri tahu saya kalau kamu mau itu, saya kerjakan sekalian.
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
    tooltipActionConfig: const TooltipActionConfig(
      position: TooltipActionPosition.inside,
      alignment: MainAxisAlignment.end,
      gapBetweenContentAndAction: 14,
    ),
    tooltipActions: [
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