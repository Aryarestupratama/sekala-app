import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/auth_state.dart';
import '../../../../shared/models/home_progress.dart';
import '../../../auth/presentation/widgets/email_verification_banner.dart';
import '../../../history/presentation/providers/history_providers.dart';
import '../providers/home_providers.dart';
import '../widgets/era_card.dart';
import '../widgets/guest_invite_card.dart';
import '../widgets/recommendation_card.dart';

/// Design.md §3.2. Gabungan dari:
/// - erasProvider (publik, sama untuk guest & user) -> 3 kartu masa (HOME-03)
/// - homeSummaryProvider (null untuk guest) -> progress per era (HOME-01)
///   & kartu rekomendasi (HOME-02)
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authStatus = ref.watch(authNotifierProvider).status;
    final isGuest = authStatus == AuthStatus.guest;

    final erasAsync = ref.watch(erasProvider);
    final homeSummaryAsync = ref.watch(homeSummaryProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('SEKALA')),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(erasProvider);
          ref.invalidate(homeSummaryProvider);
        },
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Login user yang belum verifikasi email lihat banner ini;
            // guest & user terverifikasi otomatis nggak lihat apa-apa
            // (lihat EmailVerificationBanner).
            if (!isGuest) const EmailVerificationBanner(),

            if (isGuest)
              GuestInviteCard(onTap: () => context.go('/auth')),

            // Kartu rekomendasi (HOME-02) — cuma tampil kalau user login
            // & sudah pernah baca sesuatu (recommendation != null).
            if (!isGuest)
              homeSummaryAsync.maybeWhen(
                data: (summary) {
                  final rec = summary?.recommendation;
                  if (rec == null) return const SizedBox.shrink();
                  return RecommendationCard(
                    recommendation: rec,
                    // Nggak ada sectionId di data ini (lihat catatan di
                    // HomeRecommendation model) — arahin ke roadmap era
                    // terkait, biarin user pilih tahunnya sendiri di sana.
                    onTap: () => context.go('/history/${rec.era.slug}'),
                  );
                },
                orElse: () => const SizedBox.shrink(),
              ),

            Text('Pilih Masa', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 12),

            erasAsync.when(
              data: (eras) {
                // Cocokkan progress per era (kalau ada) berdasarkan slug.
                final progressBySlug = <String, EraProgress>{
                  for (final p in homeSummaryAsync.valueOrNull?.progressByEra ?? [])
                    p.era.slug: p,
                };

                return Column(
                  children: [
                    for (final era in eras)
                      EraCard(
                        era: era,
                        progress: isGuest ? null : progressBySlug[era.slug],
                        onTap: () => context.go('/history/${era.slug}'),
                      ),
                  ],
                );
              },
              loading: () => const Center(
                child: Padding(
                  padding: EdgeInsets.all(24),
                  child: CircularProgressIndicator(),
                ),
              ),
              error: (error, _) => Padding(
                padding: const EdgeInsets.all(16),
                child: Text('Gagal memuat data masa: $error'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
