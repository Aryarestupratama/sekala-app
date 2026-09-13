/// GlobalKeys terpusat untuk semua target coach mark tutorial aplikasi.
///
/// Dipisah jadi file sendiri (bukan didefinisikan langsung di masing-masing
/// screen) supaya `TutorialTourController` bisa merujuk key yang sama tanpa
/// import screen-nya secara langsung (hindari circular import), dan supaya
/// nambah/hapus 1 langkah tur cukup ubah di 2 tempat yang jelas: sini
/// (deklarasi key) + `tutorial_tour_controller.dart` (urutan step).
///
/// PENTING: GlobalKey harus persisten (bukan dibuat ulang tiap build), jadi
/// semuanya `static final` di sini -- BUKAN dibuat di dalam method build()
/// widget manapun.
library;

import 'package:flutter/widgets.dart';

class TutorialKeys {
  TutorialKeys._();

  // === Step 1: Home ===
  static final homeCtaButton = GlobalKey(debugLabel: 'tutorial_home_cta');

  // === Step 2: Informasi Sejarah (era_list_screen.dart) ===
  static final eraExploreCard = GlobalKey(debugLabel: 'tutorial_era_card');

  // === Step 3: Roadmap Era (era_roadmap_screen.dart) ===
  static final roadmapYearNode = GlobalKey(debugLabel: 'tutorial_year_node');
  static final roadmapInfoIcon = GlobalKey(debugLabel: 'tutorial_info_icon');

  // === Step 4: Koleksi Vaksin (vaccine_list_screen.dart) ===
  static final vaccineTileFirst = GlobalKey(debugLabel: 'tutorial_vaccine_tile');
  static final vaccineListReady = GlobalKey(debugLabel: 'tutorial_vaccine_tile_ready');

  // === Step 5: Profil (profile_screen.dart) ===
  static final profileHelpMenuTile = GlobalKey(debugLabel: 'tutorial_help_menu');

  // === Penanda "siap" (readiness marker) ===
  // GlobalKey biasa yang dibungkus KeyedSubtree (BUKAN Showcase) di layar
  // yang nunggu fetch API dulu sebelum konten kelihatan (EraList,
  // EraRoadmap). Dipakai TutorialTourController buat ngecek "widget target
  // udah beneran ke-render belum" via `.currentContext` -- terbukti dari
  // investigasi kalau `.currentContext` TIDAK reliable kalau dicek langsung
  // dari key yang dipasang di widget `Showcase` (kemungkinan besar
  // ShowcaseView v5.1.0 tidak forward key itu ke Flutter Element secara
  // normal). KeyedSubtree biasa terbukti reliable, jadi dipisah begini.
  static final eraExploreCardReady = GlobalKey(debugLabel: 'tutorial_era_card_ready');
  static final roadmapReady = GlobalKey(debugLabel: 'tutorial_roadmap_ready');
}