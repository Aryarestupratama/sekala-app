import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import '../providers/card_providers.dart';

/// GET /api/cards/{vaccine} — CARD-02. Cuma bisa diakses kalau vaksin
/// sudah unlock (backend 404 kalau belum, R-VAC-01/05). Pengganti
/// card_detail_screen.dart lama yang masih berbasis Figure/tokoh.
///
/// Field tokoh lama (Lahir/Wafat/Keluarga) diganti field vaksin
/// (Produsen/Penyakit Target/Tahun Diperkenalkan, Schema.md §2.6).
/// "Section terkait" di mockup lama DIHAPUS karena VaccineDetail tidak
/// membawa data itu.
class VaccineDetailScreen extends ConsumerWidget {
  const VaccineDetailScreen({super.key, required this.vaccineId});

  final String vaccineId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final id = int.parse(vaccineId);
    final vaccineAsync = ref.watch(vaccineDetailProvider(id));

    return Scaffold(
      backgroundColor: AppColors.background,
      body: vaccineAsync.when(
        data: (vaccine) => CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: true,
              expandedHeight: 300,
              backgroundColor: AppColors.background,
              foregroundColor: Colors.white,
              title: const Text('Detail Vaksin'),
              // Placeholder UI — belum ada fitur bookmark/share di backend,
              // sengaja dibiarkan sebagai tombol non-fungsional dulu sesuai
              // referensi visual; hapus kalau tidak ingin menjanjikan fitur.
              actions: [
                IconButton(
                  icon: const Icon(Icons.bookmark_border),
                  onPressed: null,
                ),
                IconButton(
                  icon: const Icon(Icons.ios_share),
                  onPressed: null,
                ),
                const SizedBox(width: 4),
              ],
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  fit: StackFit.expand,
                  children: [
                    if (vaccine.photoUrl != null)
                      CachedNetworkImage(
                        imageUrl: vaccine.photoUrl!,
                        fit: BoxFit.cover,
                      )
                    else
                      Container(
                        color: AppColors.gamify.withValues(alpha: 0.15),
                        child: const Icon(Icons.vaccines_outlined,
                            size: 64, color: AppColors.gamify),
                      ),
                    // Scrim supaya tombol back/appbar tetap kebaca di atas foto
                    const DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.black45, Colors.transparent, Colors.black26],
                          stops: [0.0, 0.4, 1.0],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(vaccine.name, style: Theme.of(context).textTheme.headlineSmall),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        _Chip(
                          label: vaccine.diseaseTarget,
                          color: AppColors.gamify,
                          icon: Icons.coronavirus_outlined,
                        ),
                        const _Chip(
                          label: 'Terbuka',
                          color: AppColors.success,
                          icon: Icons.check_circle_outline,
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: Column(
                        children: [
                          _InfoRow(
                            label: 'Produsen',
                            value: vaccine.manufacturer ?? '-',
                          ),
                          const Divider(height: 1, color: AppColors.border),
                          _InfoRow(
                            label: 'Penyakit Target',
                            value: vaccine.diseaseTarget,
                          ),
                          const Divider(height: 1, color: AppColors.border),
                          _InfoRow(
                            label: 'Tahun Diperkenalkan',
                            value: vaccine.yearIntroduced?.toString() ?? '-',
                            isLast: true,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text('Peran dalam Sejarah Kesehatan',
                        style: Theme.of(context).textTheme.titleSmall),
                    const SizedBox(height: 6),
                    Text(
                      vaccine.description,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(height: 1.5),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        // 404 (belum unlock / vaksin nggak ada, R-VAC-01/05) jatuh ke sini.
        error: (error, _) => Scaffold(
          appBar: AppBar(),
          body: const Center(
            child: Padding(
              padding: EdgeInsets.all(24),
              child: Text('Vaksin ini belum terbuka atau tidak ditemukan.'),
            ),
          ),
        ),
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  const _Chip({required this.label, required this.color, required this.icon});

  final String label;
  final Color color;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(color: color, fontWeight: FontWeight.w600, fontSize: 12.5),
          ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.label, required this.value, this.isLast = false});

  final String label;
  final String value;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: AppColors.textSecondary),
            ),
          ),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}