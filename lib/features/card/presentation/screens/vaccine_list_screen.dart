import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    final cardsAsync = ref.watch(cardListProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('Koleksi Vaksin')),
      body: cardsAsync.when(
        data: (response) {
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
                                ? () => context.go('/cards/${vaccine.id}')
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