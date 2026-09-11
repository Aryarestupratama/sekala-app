import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/auth_state.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/models/home_progress.dart';
import '../../../auth/presentation/providers/auth_providers.dart';
import '../../../home/presentation/providers/home_providers.dart';
import '../providers/history_providers.dart';
import '../providers/wabah_intro_providers.dart';
import '../widgets/wabah_intro_modal.dart';

/// GET /api/public/eras — INFO-01 entry point, guest & user login sama-sama
/// bisa akses (R-GUEST-01). Progress per era (HOME-01) cuma tampil untuk
/// user login lewat homeSummaryProvider, sama seperti pola di HomeScreen
/// (guest tidak punya `user_progress` tersimpan — R-PROG-06).
class EraListScreen extends ConsumerStatefulWidget {
  const EraListScreen({super.key});

  @override
  ConsumerState<EraListScreen> createState() => _EraListScreenState();
}

class _EraListScreenState extends ConsumerState<EraListScreen> {
  @override
  void initState() {
    super.initState();
    // Auto-show SEKALI saat tab Informasi Sejarah pertama kali dibuka
    // (INFO intro brainstorm -- lihat riwayat chat pengembangan).
    // addPostFrameCallback supaya modal tidak dibuka di tengah proses
    // build pertama widget ini. `wabahIntroSeenProvider.future` di-await
    // dulu (bukan `.valueOrNull`) karena status "sudah lihat" dari secure
    // storage butuh 1 async read -- kalau langsung baca valueOrNull di
    // frame pertama, hasilnya masih null/loading dan modal salah muncul
    // terus tiap kali layar ini di-rebuild sebelum storage selesai dibaca.
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final seen = await ref.read(wabahIntroSeenProvider.future);
      if (!seen && mounted) {
        showWabahIntroModal(context, ref);
      }
    });
  }

  // Ikon dekoratif watermark per era — murni kosmetik, dipetakan dari slug
  // sama seperti EraAccents.ofSlug (Design.md §5.4).
  static IconData _decorIconOfSlug(String slug) {
    switch (slug.toLowerCase()) {
      case 'kolonial':
        return Icons.account_balance;
      case 'kemerdekaan':
        return Icons.flag;
      case 'modern':
        return Icons.directions_run;
      default:
        return Icons.history_edu;
    }
  }

  // Kolonial & Modern pakai teks gelap di atas warna terang (Orange/Sky),
  // Kemerdekaan (Green) cukup gelap untuk teks putih — selaras mockup.
  static bool _isDarkTextOnSlug(String slug) => slug.toLowerCase() != 'kemerdekaan';

  @override
  Widget build(BuildContext context) {
    final erasAsync = ref.watch(erasProvider);
    final authState = ref.watch(authNotifierProvider);
    final isGuest = authState.status == AuthStatus.guest;
    final homeSummaryAsync = ref.watch(homeSummaryProvider);

    final progressBySlug = <String, EraProgress>{
      for (final p in homeSummaryAsync.valueOrNull?.progressByEra ?? [])
        p.era.slug: p,
    };

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        automaticallyImplyLeading: false,
        title: Text(
          'SEKALA',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
                color: AppColors.ink,
              ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: erasAsync.when(
          data: (eras) => RefreshIndicator(
            onRefresh: () async {
              ref.invalidate(erasProvider);
              ref.invalidate(homeSummaryProvider);
            },
            child: ListView(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 32),
              children: [
                Text(
                  'Informasi Sejarah',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Pilih masa yang ingin kamu jelajahi',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                ),

                // === Progress per Periode — cuma untuk user login ===
                if (!isGuest && progressBySlug.isNotEmpty) ...[
                  const SizedBox(height: 24),
                  Text(
                    'Progress per Periode',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      for (final era in eras) ...[
                        Expanded(
                          child: _EraProgressMiniCard(
                            label: era.name,
                            accent: EraAccents.ofSlug(era.slug),
                            progress: progressBySlug[era.slug],
                          ),
                        ),
                        if (era != eras.last) const SizedBox(width: 10),
                      ],
                    ],
                  ),
                ],

                const SizedBox(height: 28),
                Text(
                  'Jelajahi Masa',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 12),
                for (final era in eras) ...[
                  _EraExploreCard(
                    name: era.name,
                    description: era.description ?? '',
                    accent: EraAccents.ofSlug(era.slug),
                    decorIcon: _decorIconOfSlug(era.slug),
                    darkText: _isDarkTextOnSlug(era.slug),
                    onTap: () => context.go('/history/${era.slug}'),
                  ),
                  if (era != eras.last) const SizedBox(height: 16),
                ],
              ],
            ),
          ),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, _) => Center(child: Text('Gagal memuat data: $error')),
        ),
      ),
    );
  }
}

/// Kartu kecil "Kolonial 5/12 tahun" di section Progress per Periode.
class _EraProgressMiniCard extends StatelessWidget {
  const _EraProgressMiniCard({
    required this.label,
    required this.accent,
    required this.progress,
  });

  final String label;
  final Color accent;
  final EraProgress? progress;

  @override
  Widget build(BuildContext context) {
    final completed = progress?.completed ?? 0;
    final total = progress?.total ?? 0;
    final ratio = total > 0 ? completed / total : 0.0;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(height: 4, color: accent),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  '$completed/$total tahun',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: ratio,
                    minHeight: 5,
                    backgroundColor: AppColors.border,
                    valueColor: AlwaysStoppedAnimation<Color>(accent),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Kartu besar warna solid per era di section "Jelajahi Masa".
class _EraExploreCard extends StatelessWidget {
  const _EraExploreCard({
    required this.name,
    required this.description,
    required this.accent,
    required this.decorIcon,
    required this.darkText,
    required this.onTap,
  });

  final String name;
  final String description;
  final Color accent;
  final IconData decorIcon;
  final bool darkText;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final textColor = darkText ? AppColors.ink : AppColors.surface;
    final chevronBg = (darkText ? AppColors.ink : AppColors.surface).withOpacity(0.12);

    return Material(
      color: accent,
      borderRadius: BorderRadius.circular(20),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Stack(
          children: [
            // Watermark dekoratif — hanya kosmetik, tidak menutupi teks.
            Positioned(
              right: -16,
              bottom: -16,
              child: Icon(
                decorIcon,
                size: 120,
                color: textColor.withOpacity(0.15),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 22, 20, 22),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: textColor,
                              ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          description,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: textColor.withOpacity(0.85),
                              ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: chevronBg,
                    ),
                    child: Icon(Icons.chevron_right, color: textColor),
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