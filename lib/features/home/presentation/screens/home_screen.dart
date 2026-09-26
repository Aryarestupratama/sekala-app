import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:showcaseview/showcaseview.dart';

import '../../../../core/router/auth_state.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/models/home_progress.dart';
import '../../../onboarding/tutorial_keys.dart';
import '../../../onboarding/tutorial_showcase_style.dart';
import '../../../onboarding/tutorial_tour_controller.dart';
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
///
/// REDESIGN: logic/provider/tutorial TIDAK berubah, murni visual + animasi:
/// 1) sapaan sesuai waktu (pagi/siang/sore/malam) + avatar inisial
/// 2) entrance fade-up bertahap per section
/// 3) skeleton berdenyut saat data ringkasan masih loading
/// 4) CTA jadi kartu hitam besar dengan efek tekan (scale) + ikon panah
class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen>
    with SingleTickerProviderStateMixin {
  // Guard supaya pengecekan auto-start tutorial cuma jalan sekali.
  //
  // PENTING: pengecekan ini SENGAJA ditaruh di sini (HomeScreen), BUKAN di
  // MainShell -- context MainShell berada DI LUAR `navigationShell`, jadi
  // StatefulNavigationShell.of(context) akan gagal di sana.
  bool _didCheckAutoStartTutorial = false;

  late final AnimationController _entrance = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 800),
  );

  @override
  void initState() {
    super.initState();
    _entrance.forward();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || _didCheckAutoStartTutorial) return;
      _didCheckAutoStartTutorial = true;
      TutorialTourController.maybeAutoStart(context);
    });
  }

  @override
  void dispose() {
    _entrance.dispose();
    super.dispose();
  }

  Animation<double> _slot(double begin, double end) {
    return CurvedAnimation(
      parent: _entrance,
      curve: Interval(begin, end, curve: Curves.easeOutCubic),
    );
  }

  String _greeting() {
    final hour = DateTime.now().hour;
    if (hour < 11) return 'Selamat pagi';
    if (hour < 15) return 'Selamat siang';
    if (hour < 18) return 'Selamat sore';
    return 'Selamat malam';
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authNotifierProvider);
    final isGuest = authState.status == AuthStatus.guest;

    // Data User (nama dsb) datang dari currentUserProvider, sama seperti
    // ProfileScreen.
    final currentUserAsync = ref.watch(currentUserProvider);
    final userName = currentUserAsync.valueOrNull?.name ?? 'Sobat Sejarah';

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: RefreshIndicator(
          color: AppColors.ink,
          onRefresh: () async {
            ref.invalidate(erasProvider);
            ref.invalidate(homeSummaryProvider);
          },
          // PENTING: SingleChildScrollView + Column, BUKAN ListView, supaya
          // GlobalKey Showcase (TutorialKeys.homeCtaButton) selalu attach
          // tanpa harus di-scroll dulu (ListView malas mem-build).
          // AlwaysScrollable: supaya pull-to-refresh tetap jalan walau
          // konten lebih pendek dari layar.
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Login user yang belum verifikasi email lihat banner ini.
                if (!isGuest) const EmailVerificationBanner(),

                _FadeSlideUp(
                  animation: _slot(0.0, 0.5),
                  child: _buildHeader(context, isGuest, userName),
                ),
                const SizedBox(height: 18),

                if (isGuest)
                  _FadeSlideUp(
                    animation: _slot(0.15, 0.65),
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 18),
                      child: GuestInviteCard(onTap: () => context.go('/auth')),
                    ),
                  ),

                // === "Lanjutkan Membaca" (HOME-02) — user login saja ===
                if (!isGuest)
                  _FadeSlideUp(
                    animation: _slot(0.15, 0.65),
                    child: _buildRecommendation(context),
                  ),

                // === "Progress Belajarmu" (ring total tahun terbaca) ===
                if (!isGuest)
                  _FadeSlideUp(
                    animation: _slot(0.25, 0.75),
                    child: _buildProgress(context),
                  ),

                // === CTA "Jelajahi Lebih Lanjut" ===
                // Sengaja fade saja (tanpa translate) supaya posisi target
                // Showcase tutorial tidak bergeser saat diukur.
                FadeTransition(
                  opacity: _slot(0.4, 0.9),
                  child: _buildCta(context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, bool isGuest, String userName) {
    final textTheme = Theme.of(context).textTheme;
    final displayName = isGuest ? 'Tamu' : userName;
    final initial =
        displayName.trim().isEmpty ? '?' : displayName.trim()[0].toUpperCase();

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${_greeting()} 👋',
                style: textTheme.bodyMedium?.copyWith(
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                displayName,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.3,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Yuk lanjut jelajahi sejarah kesehatan Indonesia',
                style: textTheme.bodySmall?.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 14),
        // Avatar inisial — user.dart belum punya field foto profil. Kalau
        // backend menambahkannya, ganti child ke NetworkImage(user.photoUrl).
        Container(
          width: 54,
          height: 54,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.ink,
            border: Border.all(color: Colors.white, width: 3),
            boxShadow: [
              BoxShadow(
                color: AppColors.ink.withValues(alpha: 0.18),
                blurRadius: 14,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          alignment: Alignment.center,
          child: isGuest
              ? const Icon(Icons.person_rounded, color: Colors.white, size: 26)
              : Text(
                  initial,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                  ),
                ),
        ),
      ],
    );
  }

  Widget _sectionTitle(BuildContext context, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        text,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w800,
              letterSpacing: -0.2,
            ),
      ),
    );
  }

  Widget _buildRecommendation(BuildContext context) {
    final homeSummaryAsync = ref.watch(homeSummaryProvider);
    return homeSummaryAsync.maybeWhen(
      loading: () => const Padding(
        padding: EdgeInsets.only(bottom: 18),
        child: _SkeletonBox(height: 100),
      ),
      data: (summary) {
        final rec = summary?.recommendation;
        if (rec == null) return const SizedBox.shrink();

        final progressBySlug = <String, EraProgress>{
          for (final p in summary?.progressByEra ?? []) p.era.slug: p,
        };

        return Padding(
          padding: const EdgeInsets.only(bottom: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _sectionTitle(context, 'Lanjutkan Membaca'),
              RecommendationCard(
                recommendation: rec,
                eraProgress: progressBySlug[rec.era.slug],
                onTap: () => context.go('/history/${rec.era.slug}'),
              ),
            ],
          ),
        );
      },
      orElse: () => const SizedBox.shrink(),
    );
  }

  Widget _buildProgress(BuildContext context) {
    final homeSummaryAsync = ref.watch(homeSummaryProvider);
    return homeSummaryAsync.maybeWhen(
      data: (summary) {
        final progressByEra = summary?.progressByEra ?? [];
        if (progressByEra.isEmpty) return const SizedBox.shrink();

        final completed =
            progressByEra.fold<int>(0, (sum, p) => sum + p.completed);
        final total = progressByEra.fold<int>(0, (sum, p) => sum + p.total);

        return Padding(
          padding: const EdgeInsets.only(bottom: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _sectionTitle(context, 'Progress Belajarmu'),
              OverallProgressCard(completed: completed, total: total),
            ],
          ),
        );
      },
      orElse: () => const SizedBox.shrink(),
    );
  }

  Widget _buildCta(BuildContext context) {
    return tutorialShowcase(
      key: TutorialKeys.homeCtaButton,
      title: 'Mulai Jelajahi',
      description:
          'Tekan tombol ini untuk mulai membaca sejarah kesehatan Indonesia dari masa ke masa.',
      child: _Pressable(
        onTap: () => context.go('/history'),
        child: Container(
          padding: const EdgeInsets.fromLTRB(22, 18, 16, 18),
          decoration: BoxDecoration(
            color: AppColors.ink,
            borderRadius: BorderRadius.circular(28),
            boxShadow: [
              BoxShadow(
                color: AppColors.ink.withValues(alpha: 0.22),
                blurRadius: 22,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Row(
            children: [
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Jelajahi Lebih Lanjut',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 3),
                    Text(
                      'Sejarah kesehatan dari masa ke masa',
                      style: TextStyle(
                        color: Color(0xB3FFFFFF),
                        fontSize: 12.5,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Container(
                width: 44,
                height: 44,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: const Icon(
                  Icons.arrow_forward_rounded,
                  size: 22,
                  color: Color(0xFF0C0C0C),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Fade + slide dari bawah ke posisi normal.
class _FadeSlideUp extends StatelessWidget {
  const _FadeSlideUp({required this.animation, required this.child});

  final Animation<double> animation;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      child: child,
      builder: (context, child) {
        return Opacity(
          opacity: animation.value.clamp(0.0, 1.0),
          child: Transform.translate(
            offset: Offset(0, (1 - animation.value) * 20),
            child: child,
          ),
        );
      },
    );
  }
}

/// Efek tekan: mengecil sedikit saat ditahan, kembali saat dilepas.
class _Pressable extends StatefulWidget {
  const _Pressable({required this.child, required this.onTap});

  final Widget child;
  final VoidCallback onTap;

  @override
  State<_Pressable> createState() => _PressableState();
}

class _PressableState extends State<_Pressable> {
  bool _pressed = false;

  void _set(bool value) {
    if (_pressed != value) setState(() => _pressed = value);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTapDown: (_) => _set(true),
      onTapUp: (_) => _set(false),
      onTapCancel: () => _set(false),
      onTap: widget.onTap,
      child: AnimatedScale(
        scale: _pressed ? 0.97 : 1.0,
        duration: const Duration(milliseconds: 120),
        curve: Curves.easeOut,
        child: widget.child,
      ),
    );
  }
}

/// Placeholder abu berdenyut selama data loading (pengganti spinner).
class _SkeletonBox extends StatefulWidget {
  const _SkeletonBox({required this.height});

  final double height;

  @override
  State<_SkeletonBox> createState() => _SkeletonBoxState();
}

class _SkeletonBoxState extends State<_SkeletonBox>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1000),
  )..repeat(reverse: true);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        return Container(
          height: widget.height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
            color: Color.lerp(
              const Color(0xFFEDEEF0),
              const Color(0xFFE2E4E7),
              Curves.easeInOut.transform(_controller.value),
            ),
          ),
        );
      },
    );
  }
}