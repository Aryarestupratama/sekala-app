import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:showcaseview/showcaseview.dart';

import '../auth/presentation/providers/auth_providers.dart';
import '../../core/router/auth_state.dart';
import '../../core/theme/app_colors.dart';
import 'tutorial_keys.dart';

/// Satu "langkah" tur = 1 screen/tab, berisi showcase key apa saja yang
/// mau disorot berurutan di screen tsb sebelum lanjut ke langkah berikutnya.
///
/// - [branchIndex] : index tab bottom-nav yang harus aktif untuk step ini
///   (lihat `MainShell._items` -- 0 Home, 1 Informasi, 2 Koleksi, 3 Profil).
///   Null kalau step ini tidak butuh pindah tab (misal masih di dalam tab
///   yang sama, cuma beda route hasil push).
/// - [pushRoute] : route tambahan yang perlu di-push SETELAH pindah tab,
///   dipakai untuk masuk ke Roadmap Era (bukan tab, tapi push di dalam
///   branch "Informasi"). Null kalau step ini ada di root tab saja.
class TutorialStep {
  const TutorialStep({
    this.branchIndex,
    this.pushRoute,
    this.readyKey,
    required this.keys,
  });

  final int? branchIndex;
  final String? pushRoute;

  /// GlobalKey PENANDA SIAP (bukan Showcase) -- dicek via `.currentContext`
  /// buat mastiin widget target beneran udah ke-render (misal nunggu fetch
  /// API selesai) SEBELUM manggil startShowCase(). Null kalau screen-nya
  /// statis/tidak nunggu API (Home, Profil) -- delay singkat aja cukup.
  final GlobalKey? readyKey;
  final List<GlobalKey> keys;
}

/// Kunci SharedPreferences untuk status "sudah pernah lihat tutorial" —
/// SEKARANG cuma dipakai untuk GUEST (session lokal, tidak punya row
/// `users`). Untuk user login, status "sudah lihat" disimpan di backend
/// (`users.has_seen_onboarding_tutorial`, via `authRepositoryProvider`)
/// SUPAYA per-akun, bukan per-device — flag lokal murni terbukti salah
/// asumsi: logout lalu daftar/login akun LAIN di device yang sama membuat
/// tur tidak pernah muncul untuk akun baru itu (ketuker sama akun
/// sebelumnya yang sudah pernah lihat, karena SharedPreferences memang
/// per-device/per-install).
const _prefsKeyHasSeenTutorial = 'has_seen_onboarding_tutorial';

/// Konstanta timing tur — SEMUA nilai di bawah ini hasil trial-error
/// empiris terhadap perilaku package `showcaseview`/kondisi device tim
/// saat pengembangan, BUKAN dihitung dari SLA API sebenarnya (misal p99
/// latency endpoint era/roadmap/vaccine-list). Kalau di masa depan ada
/// laporan tur "kepotong"/timeout di jaringan lambat, yang perlu dinaikkan
/// LEBIH DULU adalah *MaxAttempts (memperpanjang total waktu tunggu),
/// bukan intervalnya (interval yang lebih besar cuma bikin tur terasa
/// lebih lambat responsnya tanpa menambah toleransi nyata).
///
/// - [_readyKeyPollInterval]/[_readyKeyMaxAttempts]: polling
///   `readyKey.currentContext` (nunggu layar selesai fetch API). ~8 detik
///   total.
/// - [_showCaseRetryInterval]/[_showCaseRetryMaxAttempts]: retry
///   `ShowcaseView.get().startShowCase()` (lihat catatan panjang di
///   `_tryStartShowCaseWithRetry`). ~8 detik total.
/// - [_branchSettleDelay]: jeda setelah `goBranch()` sebelum `push()`
///   berikutnya, supaya branch baru sempat settle dulu.
/// - [_transitionFadeDuration]: durasi fade scrim saat pindah tab/route
///   di dalam tur (lihat `_withFadeTransition`).
const _readyKeyPollInterval = Duration(milliseconds: 100);
const _readyKeyMaxAttempts = 80;
const _showCaseRetryInterval = Duration(milliseconds: 200);
const _showCaseRetryMaxAttempts = 40;
const _branchSettleDelay = Duration(milliseconds: 50);
const _transitionFadeDuration = Duration(milliseconds: 160);

class TutorialTourController {
  TutorialTourController._();

  /// Urutan tur -- SEPAKAT: Home (CTA) -> Informasi Sejarah (kartu era)
  /// -> Roadmap (node tahun + ikon info) -> Koleksi Vaksin (tile pertama)
  /// -> Profil (menu Bantuan).
  ///
  /// CATATAN implementasi Roadmap: dari tab "Informasi" (branchIndex 1),
  /// kita push ke roadmap era yang SUDAH ADA datanya (year > 0) supaya ada
  /// konten nyata untuk disorot -- kalau push ke era yang year-nya masih
  /// kosong, layar cuma nampilin "Belum ada konten di masa ini." dan node
  /// tahun yang mau disorot tidak akan pernah muncul (GlobalKey tidak
  /// pernah attach), bikin tur macet diam-diam tanpa error apapun.
  ///
  /// Push ke era 'kolonial' -- era PERTAMA (paling atas di roadmap Informasi
  /// Sejarah), sesuai urutan tur yang seharusnya dari awal. Sebelumnya
  /// sempat diarahkan sementara ke 'modern' karena cuma era itu yang punya
  /// data tahun (kolonial & kemerdekaan masih total: 0) -- sekarang
  /// ketiga era sudah punya data (lihat KolonialSeeder.php/
  /// KemerdekaanSeeder.php), jadi dikembalikan ke 'kolonial'.
  static final List<TutorialStep> _steps = [
    TutorialStep(branchIndex: 0, keys: [TutorialKeys.homeCtaButton]),
    TutorialStep(
      branchIndex: 1,
      readyKey: TutorialKeys.eraExploreCardReady,
      keys: [TutorialKeys.eraExploreCard],
    ),
    TutorialStep(
      branchIndex: 1,
      pushRoute: '/history/kolonial',
      readyKey: TutorialKeys.roadmapReady,
      keys: [TutorialKeys.roadmapYearNode, TutorialKeys.roadmapInfoIcon],
    ),
    TutorialStep(
      branchIndex: 2,
      readyKey: TutorialKeys.vaccineListReady,
      keys: [TutorialKeys.vaccineTileFirst],
    ),
    TutorialStep(branchIndex: 3, keys: [TutorialKeys.profileHelpMenuTile]),
  ];

  static int _currentStepIndex = 0;

  /// Nomor step tur SAAT INI (1-based) & total step -- dipakai UI tooltip
  /// buat indikator progres ("2/5", lihat `tutorialShowcase()`). Kalau
  /// tidak ada tur berjalan, `currentStepNumber` tetap balikin nilai step
  /// terakhir yang aktif (aman dipanggil kapan saja, tinggal pemanggil
  /// yang memutuskan mau ditampilkan atau tidak).
  static int get currentStepNumber => _currentStepIndex + 1;
  static int get totalStepCount => _steps.length;

  // "Nomor tiket" tur yang sedang aktif. Tiap `start()` menaikkan angka ini
  // -- kalau ada tur LAMA yang masih jalan (mis. auto-start yang masih
  // nunggu widget mounted) terus user memicu tur BARU (misal manual dari
  // Bantuan & Dukungan) SEBELUM yang lama selesai, tur lama harus langsung
  // membatalkan diri begitu sadar `_runId` sudah berubah -- supaya tidak
  // ada 2 tur jalan bersamaan berebut `_activeContext`/`_currentStepIndex`
  // yang sama (race condition ini yang bikin app hang/crash sebelumnya).
  static int _runId = 0;

  // Context layar yang valid (descendant dari navigationShell -- misal
  // context dari HomeScreen atau HelpSupportScreen) untuk dipakai SELURUH
  // rangkaian tur, termasuk dari callback onFinish di MainShell yang TIDAK
  // bisa dipakai langsung (context MainShell sendiri ada DI LUAR
  // navigationShell, bukan di dalamnya -- StatefulNavigationShell.of()
  // akan gagal kalau dipanggil pakai context itu). Karena branch
  // IndexedStack di StatefulNavigationShell tidak pernah di-dispose
  // selagi tab lain aktif, context ini tetap valid sepanjang aplikasi
  // berjalan, tidak perlu di-refresh tiap step.
  static BuildContext? _activeContext;

  /// WidgetRef dari pemanggil `start()`/`maybeAutoStart()` — disimpan
  /// bareng `_activeContext` (siklus hidup sama, lihat catatan di atas)
  /// supaya `onStepFinished()`/`_markSeen()` bisa baca status auth &
  /// panggil `authRepositoryProvider.markTutorialSeen()` tanpa perlu
  /// context BuildContext punya akses Provider secara langsung.
  static WidgetRef? _activeRef;

  /// Dipanggil dari HomeScreen (BUKAN MainShell -- lihat catatan
  /// `_activeContext` di atas) setelah frame pertama, cuma jalan kalau
  /// user belum pernah lihat tutorial sama sekali.
  ///
  /// [ref] WAJIB `WidgetRef` dari `ConsumerState` HomeScreen — dipakai
  /// untuk 2 hal: (1) cek status "sudah lihat" yang SUMBERNYA beda
  /// tergantung status auth (guest -> SharedPreferences lokal, user login
  /// -> `User.hasSeenOnboardingTutorial` dari backend), dan (2) disimpan
  /// ke `_activeRef` untuk dipakai lagi nanti di `onStepFinished()`.
  static Future<void> maybeAutoStart(BuildContext context, WidgetRef ref) async {
    final authStatus = ref.read(authNotifierProvider).status;

    final bool hasSeen;
    if (authStatus == AuthStatus.authenticated) {
      // User login -- sumber kebenaran backend, BUKAN SharedPreferences
      // (lihat catatan panjang di `_prefsKeyHasSeenTutorial`). Pakai
      // `.future` supaya dapat data FRESH (bukan cache stale dari
      // sebelum login ini, misal sisa akun sebelumnya di device yang
      // sama) -- currentUserProvider sendiri sudah auto-invalidate tiap
      // authNotifierProvider berubah (lihat auth_providers.dart), tapi di
      // titik postFrameCallback ini kita perlu NILAINYA, bukan cuma
      // trigger refetch.
      final user = await ref.read(currentUserProvider.future);
      hasSeen = user?.hasSeenOnboardingTutorial ?? false;
    } else {
      // Guest -- tidak punya row `users`, tetap pakai flag lokal.
      final prefs = await SharedPreferences.getInstance();
      hasSeen = prefs.getBool(_prefsKeyHasSeenTutorial) ?? false;
    }

    if (hasSeen) return;
    if (!context.mounted) return;
    start(context, ref);
  }

  /// Dipanggil manual dari Bantuan & Dukungan ("Lihat Tutorial Aplikasi")
  /// maupun oleh [maybeAutoStart]. [context] WAJIB context dari dalam salah
  /// satu layar tab (Home/Informasi/Koleksi/Profil atau layar yang di-push
  /// di dalamnya) -- context dari MainShell sendiri TIDAK valid. [ref]
  /// WAJIB `WidgetRef` dari screen yang sama (lihat catatan `_activeRef`).
  ///
  /// Memanggil ini SELALU membatalkan tur lain yang mungkin masih berjalan
  /// (lihat catatan `_runId`).
  static void start(BuildContext context, WidgetRef ref) {
    _runId++;
    final myRunId = _runId;
    debugPrint('[Tutorial] start() dipanggil (runId=$myRunId) dengan context=$context');
    _activeContext = context;
    _activeRef = ref;
    _currentStepIndex = 0;
    _goToStep(myRunId, _steps[_currentStepIndex]);
  }

  static Future<void> _goToStep(int runId, TutorialStep step) async {
    if (runId != _runId) {
      debugPrint('[Tutorial] (runId=$runId) BERHENTI: sudah digantikan tur baru (runId=$_runId)');
      return;
    }

    final context = _activeContext;
    debugPrint('[Tutorial] (runId=$runId) _goToStep dipanggil, stepIndex=$_currentStepIndex, '
        'context=$context, mounted=${context?.mounted}');
    if (context == null || !context.mounted) {
      debugPrint('[Tutorial] (runId=$runId) BERHENTI: context null/tidak mounted');
      return;
    }

    if (step.branchIndex != null) {
      final shell = StatefulNavigationShell.of(context);
      debugPrint('[Tutorial] (runId=$runId) currentIndex=${shell.currentIndex}, target=${step.branchIndex}');
      // SELALU pakai initialLocation:true -- bukan cuma kalau currentIndex
      // beda. Ini reset branch tujuan balik ke ROOT screen-nya (misal
      // ProfileScreen), bukan cuma pindah tab sambil tetap nyangkut di
      // route yang di-push sebelumnya (misal HelpSupportScreen kalau tur
      // dimulai dari situ). Tanpa ini, step Profil di akhir tur bisa
      // nampilin HelpSupportScreen yang masih ketumpuk di atas, bukan
      // ProfileScreen yang jadi target Showcase.
      final didRun = await _withFadeTransition(runId, context, () {
        shell.goBranch(step.branchIndex!, initialLocation: true);
      });
      if (!didRun) {
        debugPrint('[Tutorial] (runId=$runId) BERHENTI: dibatalkan/unmount selagi fade goBranch');
        return;
      }
      debugPrint('[Tutorial] (runId=$runId) goBranch(${step.branchIndex}, initialLocation: true) dipanggil');
    }

    if (step.pushRoute != null) {
      // Tunggu 1 frame supaya goBranch di atas selesai settle dulu sebelum
      // push route baru di branch yang baru aktif.
      await Future<void>.delayed(_branchSettleDelay);
      if (runId != _runId || !context.mounted) {
        debugPrint('[Tutorial] (runId=$runId) BERHENTI: dibatalkan/unmount setelah delay push');
        return;
      }
      final didRun = await _withFadeTransition(runId, context, () {
        context.push(step.pushRoute!);
      });
      if (!didRun) {
        debugPrint('[Tutorial] (runId=$runId) BERHENTI: dibatalkan/unmount selagi fade push');
        return;
      }
      debugPrint('[Tutorial] (runId=$runId) push(${step.pushRoute}) dipanggil');
    }

    // Kalau step ini punya readyKey (layar yang nunggu fetch API dulu),
    // tunggu SAMPAI BENERAN siap (polling `.currentContext`, reliable
    // karena readyKey pakai KeyedSubtree biasa, BUKAN Showcase -- lihat
    // catatan panjang di tutorial_keys.dart & bawah). Kalau tidak ada
    // readyKey (Home/Profil, statis/tidak nunggu API), langsung lanjut.
    if (step.readyKey != null) {
      debugPrint('[Tutorial] (runId=$runId) nunggu readyKey: ${step.readyKey}');
      final ready = await _waitForKeyMounted(runId, step.readyKey!);
      debugPrint('[Tutorial] (runId=$runId) hasil nunggu readyKey: $ready');
      if (runId != _runId || !context.mounted) return;
      if (!ready) {
        debugPrint('[Tutorial] (runId=$runId) BERHENTI: timeout nunggu readyKey, '
            'BUKAN ditandai selesai -- auto-start bisa dicoba lagi login berikutnya.');
        return;
      }
    }

    // PENTING (revisi setelah investigasi panjang): SEBELUMNYA di sini kita
    // polling `key.currentContext != null` LANGSUNG di key Showcase-nya.
    // Ternyata itu salah asumsi -- terbukti dari test isolasi, GlobalKey
    // yang dibungkus `Showcase` (package showcaseview v5.1.0) TIDAK PERNAH
    // expose `.currentContext` lewat mekanisme Key Flutter standar (beda
    // dari widget biasa seperti KeyedSubtree yang normal nempel). Makanya
    // sekarang kesiapan dicek lewat `readyKey` terpisah (di atas), baru di
    // sini kita COBA PANGGIL startShowCase() beberapa kali (jaga-jaga) buat
    // Showcase key yang sebenarnya.
    debugPrint('[Tutorial] (runId=$runId) mulai coba startShowCase (retry): ${step.keys}');
    final success = await _tryStartShowCaseWithRetry(runId, step.keys);
    if (runId != _runId) {
      debugPrint('[Tutorial] (runId=$runId) BERHENTI: dibatalkan tur baru selagi retry');
      return;
    }
    if (!context.mounted) {
      debugPrint('[Tutorial] (runId=$runId) BERHENTI: context unmount setelah retry');
      return;
    }
    if (!success) {
      // Timeout -- data API kemungkinan gagal/lama sekali, atau target
      // memang tidak pernah muncul. Batalkan tanpa menandai `_markSeen()`
      // -- kalau ini timeout karena API lambat (rawan terjadi persis di
      // login/registrasi pertama, koneksi masih "dingin"), auto-start
      // WAJIB bisa dicoba lagi di login berikutnya, bukan langsung
      // dianggap "user sudah pernah lihat tutorial" padahal belum kelar.
      debugPrint('[Tutorial] (runId=$runId) BERHENTI: timeout retry startShowCase, '
          'BUKAN ditandai selesai -- auto-start bisa dicoba lagi login berikutnya.');
      return;
    }
    debugPrint('[Tutorial] (runId=$runId) startShowCase() sukses untuk step $_currentStepIndex');
  }

  /// Polling tiap 100ms sampai [key] (KeyedSubtree biasa, BUKAN Showcase)
  /// punya `.currentContext` (artinya widget target beneran udah selesai
  /// di-build -- misal setelah fetch API selesai), maksimal ~8 detik
  /// sebelum dianggap timeout.
  /// Bungkus 1 aksi navigasi instan ([action] -- pemanggilan `goBranch()`
  /// atau `push()`) dengan scrim fade-in -> aksi -> fade-out, supaya
  /// pindah tab/route di tengah tur tidak terasa "kepotong" mendadak.
  ///
  /// SENGAJA scrim polos (bukan animasi halaman sungguhan) -- `goBranch()`
  /// pindah `IndexedStack` (instan by design, tidak ada hook animasi resmi
  /// dari `StatefulNavigationShell`) dan `push()` sudah dapat transisi
  /// bawaan go_router/Material sendiri; scrim ini cuma menutupi momen
  /// potong itu dengan fade pendek supaya terasa disengaja, bukan glitch.
  ///
  /// Return `false` kalau tur dibatalkan/context unmount di tengah proses
  /// (pemanggil WAJIB berhenti, jangan lanjut ke langkah berikutnya).
  static Future<bool> _withFadeTransition(
    int runId,
    BuildContext context,
    VoidCallback action,
  ) async {
    final opacity = ValueNotifier<double>(0);
    final overlay = Overlay.of(context);
    late final OverlayEntry entry;
    entry = OverlayEntry(
      builder: (_) => IgnorePointer(
        child: ValueListenableBuilder<double>(
          valueListenable: opacity,
          builder: (_, value, __) => AnimatedOpacity(
            opacity: value,
            duration: _transitionFadeDuration,
            curve: Curves.easeInOut,
            child: Container(color: AppColors.background),
          ),
        ),
      ),
    );

    void cleanUp() {
      entry.remove();
      opacity.dispose();
    }

    overlay.insert(entry);
    opacity.value = 1;
    await Future<void>.delayed(_transitionFadeDuration);

    if (runId != _runId || !context.mounted) {
      cleanUp();
      return false;
    }

    action();

    // 1 frame supaya widget hasil `action()` sempat ke-build dulu sebelum
    // scrim memudar -- tanpa ini user bisa sempat lihat sekilas frame
    // lama/kosong sebelum konten baru selesai di-render.
    await Future<void>.delayed(const Duration(milliseconds: 16));

    if (runId != _runId || !context.mounted) {
      cleanUp();
      return false;
    }

    opacity.value = 0;
    await Future<void>.delayed(_transitionFadeDuration);
    cleanUp();
    return true;
  }

  static Future<bool> _waitForKeyMounted(
    int runId,
    GlobalKey key, {
    int maxAttempts = _readyKeyMaxAttempts,
  }) async {
    var attempts = 0;
    while (attempts < maxAttempts) {
      if (runId != _runId) return false;
      if (key.currentContext != null) return true;
      await Future<void>.delayed(_readyKeyPollInterval);
      attempts++;
    }
    return false;
  }

  /// Coba panggil `ShowcaseView.get().startShowCase(keys)` berulang tiap
  /// 200ms sampai TIDAK error, maksimal ~8 detik sebelum dianggap timeout.
  /// Ini lapisan jaga-jaga TAMBAHAN di atas `readyKey` (kalau step-nya
  /// punya readyKey, widget target seharusnya sudah pasti siap di titik
  /// ini; retry di sini cuma buffer ekstra buat step tanpa readyKey).
  static Future<bool> _tryStartShowCaseWithRetry(
    int runId,
    List<GlobalKey> keys, {
    int maxAttempts = _showCaseRetryMaxAttempts,
  }) async {
    var attempts = 0;
    while (attempts < maxAttempts) {
      if (runId != _runId) return false;
      // PENTING: delay DULU sebelum nyoba, baru attempt -- bukan attempt
      // dulu baru delay kalau gagal. ShowcaseView.get().startShowCase()
      // ternyata TIDAK melempar error walau key targetnya belum ke-render
      // (cuma diam-diam nggak nampilin apa-apa), jadi kalau attempt
      // pertama dilakukan instan (0ms) tanpa delay, hasilnya selalu
      // "sukses" palsu padahal widgetnya (apalagi yang nunggu data API
      // kayak era list/roadmap) belum tentu udah kebentuk.
      await Future<void>.delayed(_showCaseRetryInterval);
      attempts++;
      try {
        ShowcaseView.get().startShowCase(keys);
        return true;
      } catch (_) {
        // Target belum siap -- coba lagi setelah delay berikutnya.
      }
    }
    return false;
  }

  /// Dipasang sebagai `onFinish` callback di `ShowcaseView.register()`
  /// (main.dart) -- terpanggil otomatis tiap kali seluruh key dalam 1 step
  /// selesai ditampilkan (tooltip terakhir ditutup). Pakai `_activeContext`
  /// yang tersimpan untuk navigasi (goBranch/push) ke step berikutnya.
  static void onStepFinished() {
    final runId = _runId;
    final context = _activeContext;
    if (context == null || !context.mounted) return;

    // Kalau step yang barusan selesai sempat push route (Roadmap), balik
    // dulu sebelum lanjut ke step berikutnya supaya tidak menumpuk history.
    final finishedStep = _steps[_currentStepIndex];
    if (finishedStep.pushRoute != null && context.canPop()) {
      context.pop();
    }

    _currentStepIndex++;
    if (_currentStepIndex >= _steps.length) {
      _markSeen();
      return;
    }
    _goToStep(runId, _steps[_currentStepIndex]);
  }

  /// Dipanggil dari tombol "Lewati" di tooltip (parameter `onSkip` di
  /// `tutorialShowcase()`, lihat `tutorial_showcase_style.dart`).
  ///
  /// `ShowcaseView.get().dismiss()` menutup overlay TAPI TIDAK memicu
  /// `onFinish` bawaan package (`onStepFinished()` di atas tidak akan
  /// terpanggil) -- makanya `_markSeen()` dipanggil manual di sini, bukan
  /// mengandalkan alur finish normal. `_runId` dinaikkan lebih dulu supaya
  /// retry/delay (`_waitForKeyMounted`/`_tryStartShowCaseWithRetry`/
  /// `_withFadeTransition`) milik step yang sedang berjalan langsung sadar
  /// dirinya sudah dibatalkan, sama seperti pola pembatalan tur baru di
  /// `start()`.
  static void skip() {
    debugPrint('[Tutorial] skip() dipanggil di step $_currentStepIndex');
    _runId++;
    ShowcaseView.get().dismiss();
    _markSeen();
  }

  /// Guest -> tetap tulis flag lokal (tidak punya row `users`).
  /// User login -> kirim ke backend (`PATCH auth/profile/tutorial-seen`)
  /// SEBAGAI SATU-SATUNYA sumber kebenaran -- SENGAJA TIDAK ikut menulis
  /// flag lokal juga untuk kasus ini, supaya tidak mengulang bug lama:
  /// kalau ditulis lokal juga, device yang sama dipakai akun LAIN
  /// setelahnya akan salah baca flag ini lagi (lihat catatan
  /// `_prefsKeyHasSeenTutorial`). Kalau request backend gagal (offline),
  /// sengaja dibiarkan gagal diam-diam (bukan fitur kritikal) -- auto-start
  /// akan otomatis dicoba lagi di sesi berikutnya karena backend masih
  /// `false`.
  static Future<void> _markSeen() async {
    final ref = _activeRef;
    final authStatus = ref?.read(authNotifierProvider).status;

    if (authStatus == AuthStatus.authenticated && ref != null) {
      try {
        await ref.read(authRepositoryProvider).markTutorialSeen();
      } catch (_) {
        // Best-effort -- lihat dokumentasi method di atas.
      }
      return;
    }

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_prefsKeyHasSeenTutorial, true);
  }
}