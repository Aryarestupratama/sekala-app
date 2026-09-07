import 'dart:async';
import 'dart:math' as math;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../shared/provider/active_tab_provider.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/models/vaccine_card.dart';
import '../providers/card_providers.dart';
import '../widgets/vaccine_tile.dart';

enum _VaccineFilter { all, unlocked, locked }

/// GET /api/cards — CARD-01. Rute ini hanya bisa dicapai user login
/// (guard router di app_router.dart nendang guest ke /auth — R-VAC-05).
///
/// CATATAN DESAIN (update): filter kini 2 lapis, digabung dengan logika
/// AND — status (Semua/Terbuka/Terkunci, baris pertama) DAN era (baris
/// kedua, dinamis dari `meta.eras`, bukan hardcode 3 era). Sebelumnya
/// filter era sempat ditunda karena `VaccineCard` belum bawa info era per
/// item — sudah ditambahkan di `VaccineCardResource`/`VaccineCard.eras`,
/// jadi filter era diaktifkan kembali di sini.
///
/// Era dipilih via slug (bukan id) karena slug juga dipakai buat referensi
/// di API/route lain (Schema.md §2.2) — `null` berarti "Semua Era".
class VaccineListScreen extends ConsumerStatefulWidget {
  const VaccineListScreen({super.key});

  @override
  ConsumerState<VaccineListScreen> createState() => _VaccineListScreenState();
}

class _VaccineListScreenState extends ConsumerState<VaccineListScreen> {
  _VaccineFilter _filter = _VaccineFilter.all;

  // null = "Semua Era". Disimpan sebagai slug, bukan index/id, supaya
  // tetap valid dipilih walau urutan/isi `meta.eras` berubah antar fetch.
  String? _eraSlug;

  // Vaksin yang sudah pernah masuk antrean reveal SELAMA widget ini hidup.
  // Sengaja per-ID (bukan flag boolean tunggal) karena `MainShell` mem-
  // pertahankan state tab ini lewat IndexedStack (tidak pernah dispose
  // saat pindah tab) — kalau pakai flag boolean sekali-jalan, batch
  // vaksin `unseen` yang datang dari kunjungan KEDUA dst. (mis. user
  // selesaikan year lain lalu balik ke tab ini) tidak akan pernah
  // di-reveal, karena flag-nya sudah kepakai di kunjungan pertama.
  bool _revealQueueRunning = false;
  final Set<int> _queuedVaccineIds = {};

  // true selama user sedang berada di halaman detail vaksin (dibuka dari
  // list ini) — lihat `_openDetail()` & catatan gating lapis 2 di
  // `build()`.
  bool _inDetail = false;

  // Status & era digabung dengan logika AND — mis. "Terbuka" + "Kolonial"
  // = vaksin terbuka yang eras-nya mengandung slug "kolonial".
  List<VaccineCard> _applyFilter(List<VaccineCard> data) {
    final byStatus = switch (_filter) {
      _VaccineFilter.all => data,
      _VaccineFilter.unlocked => data.where((v) => v.unlocked).toList(),
      _VaccineFilter.locked => data.where((v) => !v.unlocked).toList(),
    };

    if (_eraSlug == null) return byStatus;
    return byStatus
        .where((v) => v.eras.any((era) => era.slug == _eraSlug))
        .toList();
  }

  /// Diputar sekali tiap kali halaman ini pertama kali dapat data dengan
  /// vaksin `unlocked && unseen` — satu per satu, berurutan (dialog
  /// berikutnya baru muncul setelah dialog sebelumnya ditutup user).
  ///
  /// PENTING: "sudah dilihat" (mark-seen) SENGAJA TIDAK ditandai di sini
  /// begitu dialog ditutup — kalau langsung ditandai di titik ini, badge
  /// dot & glow "Baru!" di grid (lihat VaccineTile) bakal langsung hilang
  /// tanpa sempat kelihatan sama sekali begitu antrean reveal kelar.
  /// Mark-seen yang sebenarnya baru terjadi di `_openDetail()`, dipicu
  /// user beneran buka halaman detail vaksin — supaya ada jeda "glow
  /// menyala di grid" antara reveal selesai dan detail dibuka.
  Future<void> _maybeStartRevealQueue(List<VaccineCard> allData) async {
    // Guard ini cuma mencegah DUA antrean jalan bersamaan (mis. dipanggil
    // dua kali beruntun dari dua post-frame callback) — BUKAN mencegah
    // antrean berikutnya selamanya, karena widget ini bisa menerima batch
    // vaksin `unseen` baru berkali-kali sepanjang hidupnya (lihat catatan
    // di deklarasi field `_queuedVaccineIds`).
    if (_revealQueueRunning) return;

    final pending = allData
        .where((v) => v.unlocked && v.unseen && !_queuedVaccineIds.contains(v.id))
        .toList();
    if (pending.isEmpty) return;

    _revealQueueRunning = true;
    _queuedVaccineIds.addAll(pending.map((v) => v.id));

    try {
      for (var i = 0; i < pending.length; i++) {
        if (!mounted) return;
        await showGeneralDialog<void>(
          context: context,
          barrierDismissible: false,
          barrierColor: Colors.black87,
          transitionDuration: const Duration(milliseconds: 300),
          pageBuilder: (context, _, __) => _VaccineRevealDialog(
            vaccine: pending[i],
            index: i + 1,
            total: pending.length,
          ),
          transitionBuilder: (context, animation, _, child) =>
              FadeTransition(opacity: animation, child: child),
        );
      }
    } finally {
      // Reset di `finally` (bukan cuma di akhir loop) supaya kalau widget
      // ke-unmount di tengah antrean (return awal di atas), guard tetap
      // kebuka lagi untuk percobaan berikutnya alih-alih nyangkut true.
      if (mounted) _revealQueueRunning = false;
    }
  }

  /// Dipanggil pas user beneran ketuk kartu vaksin unlocked (mau yang
  /// baru maupun yang sudah lama dilihat). Kalau vaksin ini masih
  /// `unseen`, tandai "sudah dilihat" dulu (best-effort — kegagalan tidak
  /// menghalangi navigasi ke detail) sebelum pindah halaman, supaya glow
  /// & badge dot ikut hilang begitu user balik ke grid/bottom nav.
  ///
  /// PENTING: pakai `context.push()` (bukan `context.go()`) — `push()`
  /// mengembalikan `Future` yang baru selesai persis ketika halaman
  /// detail ini di-pop/kembali ke list. Ini dipakai sebagai sinyal pasti
  /// "user beneran sudah balik ke list" untuk membuka kembali gate
  /// `_inDetail` (lihat pemakaiannya di `build()`) — beda dari sekadar
  /// mengandalkan `activeTabIndexProvider`, yang TIDAK berubah selama
  /// user cuma buka/tutup detail di dalam tab Koleksi yang sama.
  Future<void> _openDetail(VaccineCard vaccine) async {
    if (vaccine.unseen) {
      unawaited(
        ref.read(cardRepositoryProvider).markVaccineSeen(vaccine.id).then((_) {
          if (mounted) ref.invalidate(cardListProvider);
        }),
      );
    }

    setState(() => _inDetail = true);
    await context.push('/cards/${vaccine.id}');
    if (!mounted) return;
    setState(() => _inDetail = false);

    // Begitu beneran balik ke list, cek ulang antrean reveal pakai data
    // terbaru — kalau ada vaksin `unseen` baru yang datang SELAMA user
    // di halaman detail (mis. dari year lain yang diselesaikan lewat
    // deep-link/notifikasi, kasus langka tapi mungkin), animasinya baru
    // muncul sekarang, bukan menimpa halaman detail tadi.
    final latest = ref.read(cardListProvider).valueOrNull?.data;
    if (latest != null) _maybeStartRevealQueue(latest);
  }

  @override
  Widget build(BuildContext context) {
    final cardsAsync = ref.watch(cardListProvider);

    // GATING PENTING (lapis 1): `MainShell` mempertahankan state SEMUA
    // tab lewat go_router `StatefulShellRoute.indexedStack` — widget ini
    // tetap ter-build & rebuild di background walau tab "Koleksi" TIDAK
    // sedang dilihat user (mis. `cardListProvider` di-invalidate dari
    // halaman Kuis di tab lain setelah submit). Tanpa gating ini, reveal
    // dialog bisa salah trigger duluan menimpa layar manapun yang sedang
    // aktif. `activeTabIndexProvider` di-watch supaya begitu user PINDAH
    // ke tab Koleksi, widget ini rebuild ulang dan reveal queue baru
    // diizinkan jalan dengan data yang sudah ter-fetch duluan.
    //
    // GATING PENTING (lapis 2): `_inDetail` menutup celah yang TIDAK bisa
    // dideteksi lapis 1 — index tab TIDAK berubah sama sekali selama user
    // cuma buka halaman detail vaksin dari list yang sama (masih di
    // branch "Koleksi" yang sama, cuma nested route beda). Tanpa lapis
    // ini, reveal animasi bisa nongol menimpa halaman detail yang sedang
    // dibuka user, alih-alih menunggu sampai user beneran balik ke list
    // (lihat `_openDetail()` — flag ini di-reset begitu `context.push()`
    // selesai/di-pop).
    final isActiveTab = ref.watch(activeTabIndexProvider) == koleksiTabIndex;
    final canRevealNow = isActiveTab && !_inDetail;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('Koleksi Vaksin')),
      body: cardsAsync.when(
        data: (response) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (canRevealNow) _maybeStartRevealQueue(response.data);
          });

          final filtered = _applyFilter(response.data);
          return RefreshIndicator(
            onRefresh: () async => ref.invalidate(cardListProvider),
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                    child: Text(
                      '${response.meta.unlocked} dari ${response.meta.total} vaksin terbuka',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 44,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      children: [
                        _FilterChip(
                          label: 'Semua',
                          selected: _filter == _VaccineFilter.all,
                          onTap: () => setState(() => _filter = _VaccineFilter.all),
                        ),
                        const SizedBox(width: 8),
                        _FilterChip(
                          label: 'Terbuka',
                          selected: _filter == _VaccineFilter.unlocked,
                          onTap: () => setState(() => _filter = _VaccineFilter.unlocked),
                        ),
                        const SizedBox(width: 8),
                        _FilterChip(
                          label: 'Terkunci',
                          selected: _filter == _VaccineFilter.locked,
                          onTap: () => setState(() => _filter = _VaccineFilter.locked),
                        ),
                      ],
                    ),
                  ),
                ),
                // Baris kedua: filter era, dinamis dari `meta.eras` (cuma
                // era yang benar-benar punya vaksin yang muncul sebagai
                // chip) — bukan hardcode Kolonial/Kemerdekaan/Modern, biar
                // tetap benar kalau daftar era di sistem berubah.
                if (response.meta.eras.isNotEmpty)
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: 44,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                        children: [
                          _FilterChip(
                            label: 'Semua Era',
                            selected: _eraSlug == null,
                            onTap: () => setState(() => _eraSlug = null),
                          ),
                          for (final era in response.meta.eras) ...[
                            const SizedBox(width: 8),
                            _FilterChip(
                              label: '${era.name} (${era.unlocked}/${era.total})',
                              selected: _eraSlug == era.slug,
                              onTap: () => setState(() => _eraSlug = era.slug),
                              color: EraAccents.ofSlug(era.slug),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                const SliverPadding(padding: EdgeInsets.only(top: 8)),
                if (filtered.isEmpty)
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(
                      child: Text(
                        'Belum ada vaksin di kategori ini.',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(color: AppColors.textSecondary),
                      ),
                    ),
                  )
                else
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    sliver: SliverGrid(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 12,
                        crossAxisSpacing: 12,
                        childAspectRatio: 0.75,
                      ),
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final vaccine = filtered[index];
                          return VaccineTile(
                            vaccine: vaccine,
                            // CARD-02: detail hanya untuk yang sudah unlock —
                            // yang masih siluet dikasih hint doang, bukan
                            // navigasi ke halaman yang bakal 404 (R-VAC-05).
                            onTap: vaccine.unlocked
                                ? () => _openDetail(vaccine)
                                : () => ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          'Belum terbuka — selesaikan wabah terkait dulu.',
                                        ),
                                      ),
                                    ),
                          );
                        },
                        childCount: filtered.length,
                      ),
                    ),
                  ),
                const SliverPadding(padding: EdgeInsets.only(bottom: 16)),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('Gagal memuat data: $error')),
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  const _FilterChip({
    required this.label,
    required this.selected,
    required this.onTap,
    this.color = AppColors.gamify,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  // Warna saat selected — default gamify (dipakai chip status Semua/
  // Terbuka/Terkunci, tidak berubah). Chip era mengoper warna per-era
  // (EraAccents.ofSlug) supaya visually konsisten dengan Design.md §5.4
  // (Kolonial=Orange, Kemerdekaan=Green, Modern=Sky).
  final Color color;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(999),
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: selected ? color : AppColors.surface,
          borderRadius: BorderRadius.circular(999),
          border: Border.all(color: selected ? color : AppColors.border),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: selected ? Colors.white : AppColors.textSecondary,
            fontWeight: FontWeight.w600,
            fontSize: 13,
          ),
        ),
      ),
    );
  }
}

/// Dialog full-screen: kartu vaksin mulai dari locked (siluet, sedikit
/// "berdenyut" mengundang ketukan), user ketuk -> crossfade+scale-pop ke
/// versi unlocked + confetti + shimmer, baru tombol "Lanjut"/"Selesai"
/// muncul. Satu instance = satu vaksin; pemanggilnya (`_maybeStartRevealQueue`)
/// yang menumpuk beberapa instance berurutan kalau ada >1 vaksin baru.
class _VaccineRevealDialog extends StatefulWidget {
  const _VaccineRevealDialog({
    required this.vaccine,
    required this.index,
    required this.total,
  });

  final VaccineCard vaccine;
  final int index;
  final int total;

  @override
  State<_VaccineRevealDialog> createState() => _VaccineRevealDialogState();
}

class _VaccineRevealDialogState extends State<_VaccineRevealDialog>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final ConfettiController _confettiController;

  bool _showingBack = false; // sisi mana yang lagi ditampilkan (locked/unlocked)
  bool _settled = false; // animasi sudah kelar total -> baru tampilkan nama+tombol
  bool _confettiPlayed = false;

  // Timeline dibagi 3 tahap dalam skala 0.0-1.0 (lihat _scaleFor/_angleFor):
  // 1. ANTICIPATION (0 - 0.12): kartu "mengecil" sesaat SEBELUM flip, biar
  //    reveal-nya kerasa "meletus" bukan langsung ganti gambar begitu saja.
  // 2. IMPACT (0.12 - 0.62): flip 3D beneran (rotasi sumbu Y), gambar
  //    ditukar TEPAT di titik 90 derajat (bukan crossfade/fade).
  // 3. AFTERMATH (0.62 - 0.85): overshoot scale (bounce-in) + confetti
  //    didelay dikit dari titik flip kelar, biar kerasa ada "ekor"-nya.
  static const _anticipationEnd = 0.12;
  static const _flipEnd = 0.62;
  static const _settleEnd = 0.85;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 950),
    );
    _confettiController = ConfettiController(duration: const Duration(milliseconds: 900));

    _controller.addListener(() {
      final t = _controller.value;

      final showBack = t >= (_anticipationEnd + _flipEnd) / 2;
      if (showBack != _showingBack) {
        setState(() => _showingBack = showBack);
      }

      if (t >= _flipEnd && !_confettiPlayed) {
        _confettiPlayed = true;
        // Delay dikit dari titik flip kelar (bukan bareng persis) biar
        // confetti kerasa sebagai "ekor" dari impact, bukan numpuk.
        Future.delayed(const Duration(milliseconds: 100), () {
          if (mounted) _confettiController.play();
        });
      }

      if (t >= _settleEnd && !_settled) {
        setState(() => _settled = true);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _confettiController.dispose();
    super.dispose();
  }

  void _reveal() {
    if (_controller.value != 0) return; // lagi/udah jalan, cegah re-trigger
    _controller.forward();
  }

  /// Rotasi sumbu Y (radian) buat efek flip. 0 di awal (locked, hadap
  /// depan) -> pi di akhir tahap IMPACT (unlocked, hadap depan lagi, bukan
  /// mirror — lihat penanganan `showBack` di build()).
  double _angleFor(double t) {
    if (t <= _anticipationEnd) return 0;
    if (t >= _flipEnd) return math.pi;
    final local = (t - _anticipationEnd) / (_flipEnd - _anticipationEnd);
    return math.pi * Curves.easeInOut.transform(local);
  }

  /// Skala keseluruhan kartu — turun dikit pas anticipation, balik normal
  /// selama flip, lalu overshoot (bounce) pas settle di akhir.
  double _scaleFor(double t) {
    if (t <= _anticipationEnd) {
      final local = _anticipationEnd == 0 ? 0.0 : t / _anticipationEnd;
      return 1 - 0.12 * Curves.easeIn.transform(local);
    }
    if (t <= _flipEnd) {
      final local = (t - _anticipationEnd) / (_flipEnd - _anticipationEnd);
      return 0.88 + 0.12 * Curves.easeOut.transform(local);
    }
    if (t <= _settleEnd) {
      final local = (t - _flipEnd) / (_settleEnd - _flipEnd);
      // Kurva sin: 0 -> 1 -> 0 sepanjang local, jadi kartu "membesar"
      // sebentar lalu balik pas ke ukuran normal (bounce simetris).
      return 1 + 0.18 * math.sin(math.pi * local);
    }
    return 1;
  }

  @override
  Widget build(BuildContext context) {
    final vaccine = widget.vaccine;
    final isLastInQueue = widget.index == widget.total;

    return Material(
      color: Colors.black.withValues(alpha: 0.92),
      child: SafeArea(
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: ConfettiWidget(
                confettiController: _confettiController,
                blastDirectionality: BlastDirectionality.explosive,
                shouldLoop: false,
                numberOfParticles: 28,
                maxBlastForce: 18,
                minBlastForce: 6,
                gravity: 0.25,
                colors: const [
                  AppColors.gamify,
                  AppColors.coral,
                  AppColors.success,
                  Colors.white,
                ],
              ),
            ),
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (widget.total > 1) ...[
                    Text(
                      'Vaksin baru ${widget.index} dari ${widget.total}',
                      style: const TextStyle(
                        color: Colors.white70,
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                        letterSpacing: 0.3,
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                  GestureDetector(
                    onTap: _reveal,
                    child: SizedBox(
                      width: 220,
                      height: 220,
                      child: AnimatedBuilder(
                        animation: _controller,
                        builder: (context, _) {
                          final t = _controller.value;
                          final angle = _angleFor(t);
                          final scale = _scaleFor(t);
                          // Pas nampilin sisi belakang (unlocked), kurangi
                          // pi dari angle -> kalau tidak, gambarnya
                          // kebalik/mirror (flip 3D klasik: sisi belakang
                          // perlu "dikoreksi" rotasinya sendiri).
                          final displayAngle = _showingBack ? angle - math.pi : angle;

                          final child = _showingBack
                              ? _VaccineRevealPhoto(url: vaccine.photoUrl)
                              : _VaccineLockedPhoto(url: vaccine.photoLockedUrl);

                          return Transform(
                            alignment: Alignment.center,
                            transform: Matrix4.identity()
                              ..setEntry(3, 2, 0.0018) // perspective — biar flip-nya kerasa 3D, bukan gepeng
                              ..rotateY(displayAngle)
                              ..scale(scale),
                            child: t == 0
                                ? child
                                    // Idle: locked card "berdenyut" pelan
                                    // mengundang ketukan — cuma diputar
                                    // sebelum user tap (controller masih 0).
                                    .animate(onPlay: (c) => c.repeat(reverse: true))
                                    .scale(
                                      begin: const Offset(1, 1),
                                      end: const Offset(1.04, 1.04),
                                      duration: 900.ms,
                                      curve: Curves.easeInOut,
                                    )
                                : child,
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    _showingBack ? vaccine.name : 'Ketuk untuk membuka',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 32),
                  if (_settled)
                    FilledButton(
                      onPressed: () => Navigator.of(context).pop(),
                      style: FilledButton.styleFrom(
                        backgroundColor: AppColors.gamify,
                        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                      ),
                      child: Text(isLastInQueue ? 'Selesai' : 'Lanjut'),
                    ).animate().fadeIn(duration: 250.ms).slideY(begin: 0.2, end: 0)
                  else
                    const SizedBox(height: 48), // reserve ruang, cegah layout "loncat"
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _VaccineLockedPhoto extends StatelessWidget {
  const _VaccineLockedPhoto({super.key, required this.url, this.size = 220});

  final String? url;
  final double size;

  @override
  Widget build(BuildContext context) {
    // width/height WAJIB eksplisit di sini (bukan cuma andalin parent
    // SizedBox) — AnimatedSwitcher melapisi child lewat Stack, dan widget
    // non-Positioned di dalam Stack dikasih constraint LOOSE (bebas),
    // bukan tight. Kalau Container ini nggak dikasih ukuran sendiri,
    // hasilnya bisa jadi persegi panjang bukan persegi, dan ClipOval
    // motong bentuk itu jadi elips (gepeng) bukan lingkaran sempurna.
    return ClipOval(
      child: Container(
        width: size,
        height: size,
        color: Colors.white10,
        child: url == null
            ? Icon(Icons.lock_outline, size: size * 0.25, color: Colors.white54)
            : CachedNetworkImage(
                imageUrl: url!,
                width: size,
                height: size,
                fit: BoxFit.cover,
                errorWidget: (_, __, ___) =>
                    Icon(Icons.lock_outline, size: size * 0.25, color: Colors.white54),
              ),
      ),
    );
  }
}

class _VaccineRevealPhoto extends StatelessWidget {
  const _VaccineRevealPhoto({super.key, required this.url, this.size = 220});

  final String? url;
  final double size;

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Container(
        width: size,
        height: size,
        color: AppColors.gamify.withValues(alpha: 0.15),
        child: url == null
            ? Icon(Icons.vaccines_outlined, size: size * 0.25, color: AppColors.gamify)
            : CachedNetworkImage(
                imageUrl: url!,
                width: size,
                height: size,
                fit: BoxFit.cover,
                errorWidget: (_, __, ___) =>
                    Icon(Icons.vaccines_outlined, size: size * 0.25, color: AppColors.gamify),
              ),
      ),
    );
  }
}