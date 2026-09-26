import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/models/badge_card.dart';
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

          return RefreshIndicator(
            onRefresh: () async => ref.invalidate(badgeListProvider),
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
                            valueColor: const AlwaysStoppedAnimation(AppColors.gamify),
                          ),
                        ),
                      ],
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
                              'Belum ada badge di kategori ini.',
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(color: AppColors.textSecondary),
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
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 12,
                        crossAxisSpacing: 12,
                        childAspectRatio: 0.85,
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
        loading: () => Center(child: CircularProgressIndicator(color: AppColors.gamify)),
        error: (error, _) => Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.error_outline_rounded,
                    size: 40, color: AppColors.textSecondary.withValues(alpha: 0.6)),
                const SizedBox(height: 12),
                Text('Gagal memuat data: $error', textAlign: TextAlign.center),
                const SizedBox(height: 12),
                TextButton(
                  onPressed: () => ref.invalidate(badgeListProvider),
                  child: const Text('Coba lagi'),
                ),
              ],
            ),
          ),
        ),
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
class _BadgeDetailSheet extends StatelessWidget {
  const _BadgeDetailSheet({required this.badge});

  final BadgeCard badge;

  @override
  Widget build(BuildContext context) {
    final locked = !badge.unlocked;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
        child: Column(
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
              style: const TextStyle(color: AppColors.textSecondary, fontSize: 12.5),
            ),
            const SizedBox(height: 12),
            if (locked)
              const Text(
                'Selesaikan studi kasus wabah ini dengan tepat untuk membuka badge.',
                textAlign: TextAlign.center,
                style: TextStyle(color: AppColors.textSecondary),
              )
            else if (badge.description != null && badge.description!.isNotEmpty)
              Text(
                badge.description!,
                textAlign: TextAlign.center,
                style: const TextStyle(color: AppColors.textSecondary, height: 1.4),
              ),
          ],
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
            : Image.network(badge.iconUrl!, fit: BoxFit.cover),
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
      labelStyle: TextStyle(
        color: selected ? Colors.white : AppColors.textSecondary,
        fontWeight: FontWeight.w600,
        fontSize: 12.5,
      ),
      backgroundColor: AppColors.surface,
      side: BorderSide(color: selected ? AppColors.ink : AppColors.border),
    );
  }
}