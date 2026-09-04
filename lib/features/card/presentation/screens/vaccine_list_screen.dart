import 'dart:async';
import 'dart:math' as math;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/models/vaccine_card.dart';
import '../providers/card_providers.dart';
import '../widgets/vaccine_tile.dart';

enum _VaccineFilter { all, unlocked, locked }

/// GET /api/cards — CARD-01. Rute ini hanya bisa dicapai user login
/// (guard router di app_router.dart nendang guest ke /auth — R-VAC-05).
///
/// CATATAN DESAIN: mockup asli (era Figure/tokoh) pakai filter chip
/// per-era (Kolonial/Kemerdekaan/Modern). `VaccineCard` saat ini TIDAK
/// membawa info era per item (cuma id/name/photoUrl/photoLockedUrl/
/// unlocked), jadi filter diganti Semua/Terbuka/Terkunci — bisa dihitung
/// murni dari data yang sudah ada. Kalau filter era tetap diinginkan,
/// `VaccineCardResource` di backend perlu ditambah field era dulu.
class VaccineListScreen extends ConsumerStatefulWidget {
  const VaccineListScreen({super.key});

  @override
  ConsumerState<VaccineListScreen> createState() => _VaccineListScreenState();
}

class _VaccineListScreenState extends ConsumerState<VaccineListScreen> {
  _VaccineFilter _filter = _VaccineFilter.all;
  bool _revealQueueStarted = false;

  List<VaccineCard> _applyFilter(List<VaccineCard> data) {
    switch (_filter) {
      case _VaccineFilter.all:
        return data;
      case _VaccineFilter.unlocked:
        return data.where((v) => v.unlocked).toList();
      case _VaccineFilter.locked:
        return data.where((v) => !v.unlocked).toList();
    }
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
    if (_revealQueueStarted) return;
    final pending = allData.where((v) => v.unlocked && v.unseen).toList();
    if (pending.isEmpty) return;
    _revealQueueStarted = true;

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
  }

  /// Dipanggil pas user beneran ketuk kartu vaksin unlocked (mau yang
  /// baru maupun yang sudah lama dilihat). Kalau vaksin ini masih
  /// `unseen`, tandai "sudah dilihat" dulu (best-effort — kegagalan tidak
  /// menghalangi navigasi ke detail) sebelum pindah halaman, supaya glow
  /// & badge dot ikut hilang begitu user balik ke grid/bottom nav.
  void _openDetail(VaccineCard vaccine) {
    if (vaccine.unseen) {
      unawaited(
        ref.read(cardRepositoryProvider).markVaccineSeen(vaccine.id).then((_) {
          if (mounted) ref.invalidate(cardListProvider);
        }),
      );
    }
    context.go('/cards/${vaccine.id}');
  }

  @override
  Widget build(BuildContext context) {
    final cardsAsync = ref.watch(cardListProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('Koleksi Vaksin')),
      body: cardsAsync.when(
        data: (response) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _maybeStartRevealQueue(response.data);
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
  const _FilterChip({required this.label, required this.selected, required this.onTap});

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(999),
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: selected ? AppColors.gamify : AppColors.surface,
          borderRadius: BorderRadius.circular(999),
          border: Border.all(color: selected ? AppColors.gamify : AppColors.border),
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