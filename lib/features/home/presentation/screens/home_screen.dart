import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/auth_state.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/models/home_progress.dart';
import '../../../auth/presentation/providers/auth_providers.dart';
import '../../../auth/presentation/widgets/email_verification_banner.dart';
import '../../../history/presentation/providers/history_providers.dart';
import '../providers/home_providers.dart';
import '../widgets/guest_invite_card.dart';
import '../widgets/overall_progress_card.dart';
import '../widgets/recommendation_card.dart';

/// Design.md §3.2 (mockup Home terbaru). Gabungan dari:
/// - erasProvider (publik, sama untuk guest & user) -> 3 kartu masa (HOME-03)
/// - homeSummaryProvider (null untuk guest) -> progress per era (HOME-01),
///   kartu rekomendasi (HOME-02), & ring progress keseluruhan
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authNotifierProvider);
    final isGuest = authState.status == AuthStatus.guest;

    // AuthState (core/router) sengaja cuma nyimpen status+role buat
    // kebutuhan redirect router — data User (nama dsb) datang dari
    // currentUserProvider, sama seperti yang dipakai ProfileScreen.
    final currentUserAsync = ref.watch(currentUserProvider);
    final userName = currentUserAsync.valueOrNull?.name ?? 'Sobat Sejarah';

    final homeSummaryAsync = ref.watch(homeSummaryProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            ref.invalidate(erasProvider);
            ref.invalidate(homeSummaryProvider);
          },
          child: ListView(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
            children: [
              // Login user yang belum verifikasi email lihat banner ini;
              // guest & user terverifikasi otomatis nggak lihat apa-apa.
              if (!isGuest) const EmailVerificationBanner(),

              // === Header sapaan (mockup: "Halo, {nama} 👋" + avatar) ===
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Halo, ${isGuest ? 'Tamu' : userName} 👋',
                          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Yuk lanjut jelajahi sejarah kesehatan Indonesia',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: AppColors.textSecondary,
                              ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Placeholder avatar — user.dart (UserResource) belum
                  // punya field foto profil sama sekali. Kalau backend
                  // nanti menambahkannya, ganti child ini ke
                  // NetworkImage(user.photoUrl) di dalam CircleAvatar.
                  CircleAvatar(
                    radius: 28,
                    backgroundColor: AppColors.border,
                    child: const Icon(Icons.person, color: AppColors.textSecondary),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              if (isGuest) GuestInviteCard(onTap: () => context.go('/auth')),

              // === "Lanjutkan Membaca" (HOME-02) — cuma untuk user login
              // yang sudah pernah baca sesuatu ===
              if (!isGuest)
                homeSummaryAsync.maybeWhen(
                  data: (summary) {
                    final rec = summary?.recommendation;
                    if (rec == null) return const SizedBox.shrink();

                    final progressBySlug = <String, EraProgress>{
                      for (final p in summary?.progressByEra ?? [])
                        p.era.slug: p,
                    };

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Lanjutkan Membaca',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        const SizedBox(height: 12),
                        RecommendationCard(
                          recommendation: rec,
                          eraProgress: progressBySlug[rec.era.slug],
                          onTap: () => context.go('/history/${rec.era.slug}'),
                        ),
                      ],
                    );
                  },
                  orElse: () => const SizedBox.shrink(),
                ),

              // === "Progress Belajarmu" (ring total tahun terbaca) ===
              if (!isGuest)
                homeSummaryAsync.maybeWhen(
                  data: (summary) {
                    final progressByEra = summary?.progressByEra ?? [];
                    if (progressByEra.isEmpty) return const SizedBox.shrink();

                    final completed = progressByEra.fold<int>(
                      0,
                      (sum, p) => sum + p.completed,
                    );
                    final total = progressByEra.fold<int>(
                      0,
                      (sum, p) => sum + p.total,
                    );

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 8),
                        Text(
                          'Progress Belajarmu',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        const SizedBox(height: 12),
                        OverallProgressCard(completed: completed, total: total),
                        const SizedBox(height: 24),
                      ],
                    );
                  },
                  orElse: () => const SizedBox.shrink(),
                ),

              // === CTA "Jelajahi Lebih Lanjut" ===
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.ink,
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32),
                    ),
                  ),
                  onPressed: () => context.go('/history'),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        'Jelajahi Lebih Lanjut',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: 8),
                      Icon(Icons.arrow_forward, size: 18),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}