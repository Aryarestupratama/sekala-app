import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/card_providers.dart';

const _indoMonths = [
  'Jan', 'Feb', 'Mar', 'Apr', 'Mei', 'Jun',
  'Jul', 'Agu', 'Sep', 'Okt', 'Nov', 'Des',
];

/// Format manual (bukan lewat package intl) supaya nggak perlu
/// initializeDateFormatting('id_ID') tambahan di main.dart.
String? _formatIndoDate(String? iso) {
  if (iso == null) return null;
  final date = DateTime.tryParse(iso);
  if (date == null) return iso;
  return '${date.day} ${_indoMonths[date.month - 1]} ${date.year}';
}

/// GET /api/cards/{figure} — CARD-02. Cuma bisa diakses kalau figure
/// sudah unlock (backend 404 kalau belum, R-CARD-02).
class CardDetailScreen extends ConsumerWidget {
  const CardDetailScreen({super.key, required this.figureId});

  final String figureId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final id = int.parse(figureId);
    final figureAsync = ref.watch(figureDetailProvider(id));

    return Scaffold(
      appBar: AppBar(title: Text(figureAsync.valueOrNull?.name ?? 'Detail Tokoh')),
      body: figureAsync.when(
        data: (figure) {
          final birth = _formatIndoDate(figure.birthDate);
          final death = _formatIndoDate(figure.deathDate);
          final lifespan = (birth == null && death == null)
              ? null
              : '${birth ?? '?'} – ${death ?? 'sekarang'}';

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              if (figure.photoUrl != null)
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: CachedNetworkImage(
                    imageUrl: figure.photoUrl!,
                    height: 240,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              const SizedBox(height: 16),
              Text(figure.name, style: Theme.of(context).textTheme.headlineSmall),
              if (lifespan != null) ...[
                const SizedBox(height: 4),
                Text(lifespan, style: Theme.of(context).textTheme.bodyMedium),
              ],
              if (figure.family != null && figure.family!.isNotEmpty) ...[
                const SizedBox(height: 20),
                Text('Keluarga', style: Theme.of(context).textTheme.titleSmall),
                const SizedBox(height: 4),
                Text(figure.family!),
              ],
              const SizedBox(height: 20),
              Text('Peran dalam Dunia Kesehatan',
                  style: Theme.of(context).textTheme.titleSmall),
              const SizedBox(height: 4),
              Text(figure.roleDescription),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        // 404 (belum unlock / figure nggak ada, R-CARD-02) jatuh ke sini.
        error: (error, _) => const Center(
          child: Padding(
            padding: EdgeInsets.all(24),
            child: Text('Kartu ini belum terbuka atau tidak ditemukan.'),
          ),
        ),
      ),
    );
  }
}
