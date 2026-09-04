import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Index tab "Koleksi" di bottom nav — dipusatkan di sini (bukan angka
/// mentah `2` ditulis ulang di beberapa file) supaya `MainShell` dan
/// `VaccineListScreen` selalu merujuk konstanta yang sama.
const int koleksiTabIndex = 2;

/// Index tab bottom-nav yang SEDANG benar-benar aktif dilihat user.
///
/// PENTING kenapa provider ini perlu ada: go_router's
/// `StatefulShellRoute.indexedStack` (dipakai `MainShell`, lihat
/// `navigationShell`) menjaga SEMUA branch tab tetap ter-build di
/// `IndexedStack`, termasuk yang sedang tidak aktif/tidak kelihatan —
/// ini sengaja demi transisi tab instan tanpa rebuild penuh. Efek
/// sampingnya: widget seperti `VaccineListScreen` tetap "hidup" & ikut
/// rebuild (mis. gara-gara `cardListProvider` di-invalidate dari layar
/// lain) walau tab-nya tidak sedang dilihat user.
///
/// Tanpa provider ini, `VaccineListScreen` tidak punya cara membedakan
/// "aku baru dapat data baru karena user beneran buka tab ini" vs
/// "aku baru dapat data baru karena rebuild dari background" — akibatnya
/// animasi reveal vaksin bisa salah trigger duluan di layar lain (mis.
/// muncul menimpa halaman Kuis) sebelum user sempat pindah ke tab
/// Koleksi.
///
/// `MainShell` yang bertanggung jawab meng-update value ini (lihat
/// `main_shell.dart`) setiap kali `navigationShell.currentIndex` berubah.
final activeTabIndexProvider = StateProvider<int>((ref) => 0);