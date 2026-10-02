import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/models/badge_card.dart';
import '../../../../shared/widgets/pressable_scale.dart';
import '../../../auth/presentation/providers/auth_providers.dart';
import '../providers/badge_providers.dart';
import '../widgets/badge_tile.dart';

enum _BadgeFilter { all, unlocked, locked }

/// GET /api/badges — Koleksi Badge (Fase 2). Rute ini hanya bisa dicapai
/// user login (guard router sama kelas dengan /profile).
///
/// SENGAJA JAUH lebih sederhana dari VaccineListScreen: TIDAK ada antrean
/// reveal/dialog "badge baru!"/confetti — badge tidak punya ritual reveal
/// terpisah (progress.md tidak meminta itu untuk badge, cuma "grid
/// locked/unlocked, pola Koleksi Vaksin" + keputusan produk badge locked
/// cukup diredupkan). YANG DITIRU dari pola vaksin cuma dot merah/tag
/// "Baru" (`BadgeCard.unseen`) + mark-seen — lihat `_showBadgeDetail()` di
/// bawah, dipanggil di titik yang sama dengan `_openDetail()` milik
/// vaccine_list_screen.dart (saat user BENERAN membuka detail, bukan pas
/// grid dirender), supaya dot & tag sempat kelihatan dulu.
class BadgeListScreen extends ConsumerStatefulWidget {
  const BadgeListScreen({super.key});

  @override
  ConsumerState<BadgeListScreen> createState() => _BadgeListScreenState();
}

/// Purple (gamify) mentah di atas track abu hanya ~2.4:1 (grafis butuh 3:1).
final Color _kGamifyStrong = Color.lerp(AppColors.gamify, AppColors.ink, 0.35)!;

class _BadgeListScreenState extends ConsumerState<BadgeListScreen> {
  _BadgeFilter _filter = _BadgeFilter.all;
  String? _eraSlug; // null = Semua Era

  List<BadgeCard> _applyFilter(List<BadgeCard> data) {
    final byStatus = switch (_filter) {
      _BadgeFilter.all => data,
      _BadgeFilter.unlocked => data.where((b) => b.unlocked).toList(),
      _BadgeFilter.locked => data.where((b) => !b.unlocked).toList(),
    };

    if (_eraSlug == null) return byStatus;
    return byStatus.where((b) => b.era.slug == _eraSlug).toList();
  }

  /// Tandai badge sudah dilihat (best-effort, fire-and-forget — mirror
  /// `_openDetail()` di vaccine_list_screen.dart) SEBELUM membuka sheet,
  /// supaya dot bottom nav "Profil" & menu "Koleksi Badge" tidak
  /// menunggu sheet ditutup dulu untuk mulai hilang. Badge yang sudah
  /// `unseen == false` (termasuk badge locked, yang memang selalu
  /// `unseen == false` — lihat BadgeResource.php) tidak memicu request
  /// sama sekali.
  String _emptyMessage() {
    if (_filter == _BadgeFilter.unlocked && _eraSlug == null) {
      return 'Belum ada badge terbuka. Selesaikan studi kasus (materi ke-8 '
          'di setiap tahun) di roadmap untuk mendapatkannya.';
    }
    return 'Belum ada badge di kategori ini.';
  }

  void _showBadgeDetail(BadgeCard badge) {
    if (badge.unseen) {
      unawaited(
        ref.read(badgeRepositoryProvider).markBadgeSeen(badge.id).then((_) {
          if (mounted) ref.invalidate(badgeListProvider);
        }),
      );
    }

    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => _BadgeDetailSheet(badge: badge),
    );
  }

  @override
  Widget build(BuildContext context) {
    final badgesAsync = ref.watch(badgeListProvider);
    // `frameUnlocked` permanen (R-FRAME-01), tidak sama dengan "semua badge
    // terkumpul sekarang" kalau admin menambah studi kasus baru.
    final user = ref.watch(currentUserProvider).valueOrNull;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        title: const Text('Koleksi Badge', style: TextStyle(fontWeight: FontWeight.w800)),
      ),
      body: badgesAsync.when(
        data: (response) {
          // Chip era dinamis dari daftar badge itu sendiri (bukan hardcode
          // 3 era) — sama pola dengan VaccineListScreen, cuma di sini
          // dihitung sisi client karena BadgeListMeta tidak membawa
          // ringkasan per-era (tidak sekritikal Vaksin, jumlah badge jauh
          // lebih sedikit daripada vaksin).
          final eras = <String, BadgeEra>{};
          for (final b in response.data) {
            eras[b.era.slug] = b.era;
          }

          final filtered = _applyFilter(response.data);
          // Teks besar butuh tile lebih tinggi; rasio tetap membuat teks terpotong.
          final textScale = MediaQuery.textScalerOf(context).scale(1.0).clamp(1.0, 2.0).toDouble();
          final gridRatio = 0.85 / (1 + (textScale - 1) * 0.4);

          return RefreshIndicator(
            onRefresh: () async {
              ref.invalidate(badgeListProvider);
              ref.invalidate(currentUserProvider);
              try {
                await ref.read(badgeListProvider.future);
              } catch (_) {}
            },
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${response.meta.unlocked} dari ${response.meta.total} badge terbuka',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(fontWeight: FontWeight.w800),
                        ),
                        const SizedBox(height: 8),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: LinearProgressIndicator(
                            value: response.meta.total == 0
                                ? 0.0
                                : response.meta.unlocked / response.meta.total,
                            minHeight: 6,
                            backgroundColor: AppColors.border,
                            valueColor: AlwaysStoppedAnimation(_kGamifyStrong),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // BARU: tujuan akhir koleksi (R-FRAME-01 sudah ada di backend:
                // semua badge terkumpul -> Border SEKALA terbuka permanen).
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 14),
                    child: _BorderRewardCard(
                      unlocked: response.meta.unlocked,
                      total: response.meta.total,
                      borderUnlocked: user?.frameUnlocked == true,
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 48,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      children: [
                        _FilterChip(
                          label: 'Semua',
                          selected: _filter == _BadgeFilter.all,
                          onTap: () => setState(() => _filter = _BadgeFilter.all),
                        ),
                        const SizedBox(width: 8),
                        _FilterChip(
                          label: 'Terbuka',
                          selected: _filter == _BadgeFilter.unlocked,
                          onTap: () => setState(() => _filter = _BadgeFilter.unlocked),
                        ),
                        const SizedBox(width: 8),
                        _FilterChip(
                          label: 'Terkunci',
                          selected: _filter == _BadgeFilter.locked,
                          onTap: () => setState(() => _filter = _BadgeFilter.locked),
                        ),
                      ],
                    ),
                  ),
                ),
                if (eras.length > 1)
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: 56,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                        children: [
                          _FilterChip(
                            label: 'Semua Era',
                            selected: _eraSlug == null,
                            onTap: () => setState(() => _eraSlug = null),
                          ),
                          for (final era in eras.values) ...[
                            const SizedBox(width: 8),
                            _FilterChip(
                              label: era.name,
                              selected: _eraSlug == era.slug,
                              onTap: () => setState(() => _eraSlug = era.slug),
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
                      child: Padding(
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.emoji_events_outlined,
                              size: 44,
                              color: AppColors.textSecondary.withValues(alpha: 0.5),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              _emptyMessage(),
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(color: AppColors.textSecondary, fontSize: 15, height: 1.4),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                else
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    sliver: SliverGrid(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 12,
                        crossAxisSpacing: 12,
                        childAspectRatio: gridRatio,
                      ),
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final badge = filtered[index];
                          return BadgeTile(
                            badge: badge,
                            onTap: () => _showBadgeDetail(badge),
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
        loading: () => const Center(child: CircularProgressIndicator(color: AppColors.ink)),
        error: (error, _) => _BadgeError(onRetry: () => ref.invalidate(badgeListProvider)),
      ),
    );
  }
}

/// Detail badge ditampilkan sebagai bottom sheet (bukan halaman detail
/// terpisah ala VaccineDetailScreen) — konten badge jauh lebih ringkas
/// (nama + deskripsi opsional + ikon), tidak butuh route/URL sendiri.
/// Badge locked TETAP bisa dibuka (beda dari vaksin yang menolak tap ke
/// detail saat locked) — isinya cuma diberi hint kapan badge ini terbuka,
/// karena nama/ikon asli memang sudah terlihat di grid sekalipun locked.
class _BadgeDetailSheet extends StatefulWidget {
  const _BadgeDetailSheet({required this.badge});

  final BadgeCard badge;

  @override
  State<_BadgeDetailSheet> createState() => _BadgeDetailSheetState();
}

class _BadgeDetailSheetState extends State<_BadgeDetailSheet> with SingleTickerProviderStateMixin {
  late final AnimationController _entrance = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 380),
  )..forward();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Hormati "reduce motion": konten sheet langsung tampil penuh.
    if (MediaQuery.disableAnimationsOf(context)) _entrance.value = 1;
  }

  @override
  void dispose() {
    _entrance.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final badge = widget.badge;
    final locked = !badge.unlocked;
    final animation = CurvedAnimation(parent: _entrance, curve: Curves.easeOutCubic);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
        child: AnimatedBuilder(
          animation: animation,
          builder: (context, child) {
            return Opacity(
              opacity: animation.value.clamp(0.0, 1.0),
              child: Transform.translate(
                offset: Offset(0, (1 - animation.value) * 14),
                child: child,
              ),
            );
          },
          child: SingleChildScrollView(child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 36,
                height: 4,
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: AppColors.border,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              SizedBox(
                width: 88,
                height: 88,
                child: Opacity(
                  opacity: locked ? 0.35 : 1.0,
                  child: _BadgeSheetIcon(badge: badge),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                badge.name,
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 4),
              Text(
                '${badge.era.name} \u00b7 ${badge.year.title}',
                style: const TextStyle(color: AppColors.textSecondary, fontSize: 14),
              ),
              const SizedBox(height: 12),
              if (locked)
                const Text(
                  'Selesaikan studi kasus wabah ini dengan tepat untuk membuka badge.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: AppColors.textSecondary, fontSize: 15, height: 1.4),
                )
              else if (badge.description != null && badge.description!.isNotEmpty)
                Text(
                  badge.description!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: AppColors.textSecondary, fontSize: 15, height: 1.4),
                ),
              if (locked) ...[
                const SizedBox(height: 16),
                FilledButton(
                  onPressed: () {
                    final router = GoRouter.of(context);
                    Navigator.of(context).pop();
                    router.go('/history/${badge.era.slug}');
                  },
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.ink,
                    minimumSize: const Size(double.infinity, 48),
                    shape: const StadiumBorder(),
                  ),
                  child: Text(
                    'Buka roadmap ${badge.era.name}',
                    style: const TextStyle(fontWeight: FontWeight.w700),
                  ),
                ),
              ],
            ],
          )),
        ),
      ),
    );
  }
}

class _BadgeSheetIcon extends StatelessWidget {
  const _BadgeSheetIcon({required this.badge});

  final BadgeCard badge;

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Container(
        color: AppColors.ink.withValues(alpha: 0.06),
        child: badge.iconUrl == null
            ? const Icon(Icons.emoji_events_outlined, size: 36, color: AppColors.textSecondary)
            : Image.network(
                badge.iconUrl!,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) =>
                    const Icon(Icons.emoji_events_outlined, size: 36, color: AppColors.textSecondary),
              ),
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
    return ChoiceChip(
      label: Text(label),
      selected: selected,
      onSelected: (_) => onTap(),
      showCheckmark: false,
      selectedColor: AppColors.ink,
      // Target sentuh 48dp (dulu 32dp di dalam ListView 44dp).
      materialTapTargetSize: MaterialTapTargetSize.padded,
      labelStyle: TextStyle(
        color: selected ? Colors.white : AppColors.textSecondary,
        fontWeight: FontWeight.w600,
        fontSize: 14,
      ),
      backgroundColor: AppColors.surface,
      side: BorderSide(color: selected ? AppColors.ink : AppColors.border),
    );
  }
}

/// Tujuan akhir koleksi badge: Border SEKALA. Aturannya SUDAH ada di backend
/// (R-FRAME-01: semua badge dari studi kasus published terkumpul -> border
/// terbuka permanen; dicek saat studi kasus selesai, R-FRAME-02) dan toggle
/// pasang/lepas ada di Profil — kartu ini hanya membuatnya TERLIHAT di
/// tempat user mengumpulkan badge.
///
/// 3 keadaan:
/// - [borderUnlocked] true  -> "Border SEKALA terbuka" (permanen; tetap benar
///   walau admin menambah studi kasus baru sehingga koleksi tak lagi penuh).
/// - semua badge terkumpul tapi flag belum terbaca -> kemungkinan data
///   belum ter-refresh (tarik layar ke bawah).
/// - selainnya -> tujuan + sisa badge.
class _BorderRewardCard extends StatelessWidget {
  const _BorderRewardCard({
    required this.unlocked,
    required this.total,
    required this.borderUnlocked,
  });

  final int unlocked;
  final int total;
  final bool borderUnlocked;

  @override
  Widget build(BuildContext context) {
    final allCollected = total > 0 && unlocked >= total;
    final remaining = (total - unlocked).clamp(0, total);

    final String title;
    final String body;
    if (borderUnlocked) {
      title = 'Border SEKALA terbuka';
      body = 'Pasang atau lepas border-nya di tab Profil.';
    } else if (allCollected) {
      title = 'Semua badge terkumpul!';
      body = 'Border SEKALA akan muncul di tab Profil. Kalau belum, tarik '
          'layar ini ke bawah untuk memuat ulang.';
    } else {
      title = 'Kumpulkan semua badge, dapatkan Border SEKALA';
      body = total == 0
          ? 'Border dipasang di foto profilmu.'
          : 'Tinggal $remaining badge lagi. Border dipasang di foto profilmu.';
    }

    final reached = borderUnlocked || allCollected;

    return Semantics(
      container: true,
      label: '$title. $body',
      excludeSemantics: true,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: reached ? AppColors.gamify.withValues(alpha: 0.12) : AppColors.surface,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: reached ? _kGamifyStrong : AppColors.border,
            width: reached ? 1.5 : 1,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: reached ? AppColors.gamify : AppColors.ink.withValues(alpha: 0.06),
                border: reached ? null : Border.all(color: AppColors.border),
              ),
              alignment: Alignment.center,
              child: Icon(
                reached ? Icons.auto_awesome_rounded : Icons.lock_outline_rounded,
                size: 24,
                color: reached ? AppColors.ink : AppColors.textSecondary,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                      color: AppColors.ink,
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    body,
                    style: const TextStyle(fontSize: 14, color: AppColors.textSecondary, height: 1.4),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Gagal memuat koleksi badge. Dulu: `Gagal memuat data: $error` (exception
/// mentah) dan tombol "Coba Lagi" tanpa semantik dengan tinggi ~38dp.
class _BadgeError extends StatelessWidget {
  const _BadgeError({required this.onRetry});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.cloud_off_rounded, size: 40, color: AppColors.textSecondary),
            const SizedBox(height: 12),
            const Text(
              'Koleksi badge belum bisa dimuat',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 6),
            const Text(
              'Periksa koneksi internetmu, lalu coba lagi.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15, height: 1.4, color: AppColors.textSecondary),
            ),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: onRetry,
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.ink,
                minimumSize: const Size(140, 48),
                shape: const StadiumBorder(),
              ),
              child: const Text('Coba lagi', style: TextStyle(fontWeight: FontWeight.w700)),
            ),
          ],
        ),
      ),
    );
  }
}