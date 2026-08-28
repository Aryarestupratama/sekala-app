import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../providers/history_providers.dart';

/// GET /api/public/eras — INFO-01 entry point, guest & user login sama-sama
/// bisa akses (R-GUEST-01).
class EraListScreen extends ConsumerWidget {
  const EraListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final erasAsync = ref.watch(erasProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Informasi Sejarah')),
      body: erasAsync.when(
        data: (eras) => ListView(
          padding: const EdgeInsets.all(16),
          children: [
            for (final era in eras)
              Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: EraAccents.ofSlug(era.slug),
                  ),
                  title: Text(era.name),
                  subtitle: era.description != null ? Text(era.description!) : null,
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => context.go('/history/${era.slug}'),
                ),
              ),
          ],
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('Gagal memuat data: $error')),
      ),
    );
  }
}
