import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../shared/models/section_summary.dart';
import '../providers/history_providers.dart';

/// GET /api/public/eras/{era:slug}/years — INFO-01.
///
/// GAP BACKEND TERSISA (per 28 Agt 2026): checkmark "sudah dibaca"
/// (Design.md §3.3 poin 1) belum bisa ditampilkan — YearResource belum
/// ngirim status completion (beda kasus sama sectionId, yang sudah
/// dipatch & bisa dipakai). Untuk sekarang, semua tahun tampil polos
/// tanpa tanda sudah/belum dibaca.
class EraRoadmapScreen extends ConsumerWidget {
  const EraRoadmapScreen({super.key, required this.eraSlug});

  final String eraSlug;

  void _openYear(BuildContext context, List<SectionSummary> sections) {
    if (sections.isEmpty) return; // seharusnya nggak terjadi (backend cuma
    // ngirim tahun yang punya >=1 section published)
    if (sections.length == 1) {
      context.go('/section/${sections.first.id}');
      return;
    }
    // Edge case: satu tahun punya >1 section (Schema.md §2.4) — biarin
    // user milih dulu lewat bottom sheet daripada nebak salah satu.
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (final section in sections)
              ListTile(
                title: Text(section.title),
                onTap: () {
                  Navigator.of(context).pop();
                  context.go('/section/${section.id}');
                },
              ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final yearsAsync = ref.watch(yearsProvider(eraSlug));

    return Scaffold(
      appBar: AppBar(title: Text('Roadmap — $eraSlug')),
      body: yearsAsync.when(
        data: (years) {
          if (years.isEmpty) {
            return const Center(child: Text('Belum ada konten di masa ini.'));
          }
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: years.length,
            itemBuilder: (context, index) {
              final year = years[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  title: Text('${year.year}'),
                  subtitle: Text(year.title),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => _openYear(context, year.sections),
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('Gagal memuat data: $error')),
      ),
    );
  }
}
