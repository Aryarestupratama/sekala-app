import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/card_providers.dart';
import '../widgets/figure_tile.dart';

/// GET /api/cards — CARD-01. Rute ini hanya bisa dicapai user login
/// (guard router di app_router.dart nendang guest ke /auth — R-CARD-05).
class CardListScreen extends ConsumerWidget {
  const CardListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cardsAsync = ref.watch(cardListProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Collectible Card')),
      body: cardsAsync.when(
        data: (response) => RefreshIndicator(
          onRefresh: () async => ref.invalidate(cardListProvider),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    '${response.meta.unlocked}/${response.meta.total} tokoh terbuka',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                sliver: SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: 0.75,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final figure = response.data[index];
                      return FigureTile(
                        figure: figure,
                        // CARD-02: detail hanya untuk yang sudah unlock —
                        // yang masih siluet dikasih hint doang, bukan
                        // navigasi ke halaman yang bakal 404 (R-CARD-02).
                        onTap: figure.unlocked
                            ? () => context.go('/cards/${figure.id}')
                            : () => ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      'Belum terbuka — baca section terkait dulu.',
                                    ),
                                  ),
                                ),
                      );
                    },
                    childCount: response.data.length,
                  ),
                ),
              ),
              const SliverPadding(padding: EdgeInsets.only(bottom: 16)),
            ],
          ),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('Gagal memuat data: $error')),
      ),
    );
  }
}
