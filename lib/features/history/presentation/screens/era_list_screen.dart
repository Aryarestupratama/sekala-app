import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:showcaseview/showcaseview.dart';

import '../../../../core/router/auth_state.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/models/home_progress.dart';
import '../../../../shared/widgets/pressable_scale.dart';
import '../../../onboarding/tutorial_keys.dart';
import '../../../onboarding/tutorial_showcase_style.dart';
import '../../../onboarding/tutorial_tour_controller.dart';
import '../../../auth/presentation/providers/auth_providers.dart';
import '../../../home/presentation/providers/home_providers.dart';
import '../providers/history_providers.dart';

/// GET /api/public/eras — INFO-01 entry point, guest & user login sama-sama
/// bisa akses (R-GUEST-01). Progress per era (HOME-01) cuma tampil untuk
/// user login lewat homeSummaryProvider, sama seperti pola di HomeScreen
/// (guest tidak punya `user_progress` tersimpan — R-PROG-06).
///
/// REDESIGN: logic/provider/tutorial TIDAK berubah, murni visual + animasi:
/// 1) entrance fade-up bertahap per section (judul, mini progress, kartu era)
/// 2) mini progress card: ring kecil menggantikan bar tipis, animasi mengisi
/// 3) kartu era besar: gradasi diagonal + efek tekan (PressableScale)
/// 4) `withOpacity` (deprecated) -> `withValues(alpha:)`
class EraListScreen extends ConsumerStatefulWidget {
  const EraListScreen({super.key});

  @override
  ConsumerState<EraListScreen> createState() => _EraListScreenState();
}

class _EraListScreenState extends ConsumerState<EraListScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _entrance = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 800),
  );

  bool _entranceStarted = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_entranceStarted) return;
    _entranceStarted = true;
    // Hormati "reduce motion": konten langsung tampil penuh.
    if (MediaQuery.disableAnimationsOf(context)) {
      _entrance.value = 1;
    } else {
      _entrance.forward();
    }
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

  // Semua era memakai teks Ink. Putih di atas Green #4BA95F hanya ~2.9:1
  // (AA butuh 4.5:1); Ink di atas Green ~6.6:1, Orange ~10:1, Sky ~12:1.
  static bool _isDarkTextOnSlug(String slug) => true;

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
            color: AppColors.ink,
            onRefresh: () async {
              ref.invalidate(erasProvider);
              ref.invalidate(homeSummaryProvider);
              try {
                await ref.read(erasProvider.future);
              } catch (_) {}
            },
            // Sama seperti home_screen.dart: SingleChildScrollView+Column,
            // BUKAN ListView, supaya semua children (termasuk Showcase
            // eraExploreCard) langsung ke-mount tanpa perlu di-scroll dulu.
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _FadeSlideUp(
                    animation: _slot(0.0, 0.4),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Informasi Sejarah',
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(
                                fontWeight: FontWeight.w800,
                                letterSpacing: -0.3,
                              ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Pilih masa yang ingin kamu jelajahi',
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: AppColors.textSecondary,
                                  ),
                        ),
                      ],
                    ),
                  ),

                  // === Progress per Periode — cuma untuk user login ===
                  if (!isGuest && progressBySlug.isNotEmpty) ...[
                    const SizedBox(height: 22),
                    _FadeSlideUp(
                      animation: _slot(0.1, 0.5),
                      child: _sectionTitle(context, 'Progress per Periode'),
                    ),
                    const SizedBox(height: 12),
                    _FadeSlideUp(
                      animation: _slot(0.15, 0.55),
                      child: Row(
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
                    ),
                  ],

                  const SizedBox(height: 26),
                  _FadeSlideUp(
                    animation: _slot(0.2, 0.6),
                    child: _sectionTitle(context, 'Jelajahi Masa'),
                  ),
                  const SizedBox(height: 12),
                  for (var i = 0; i < eras.length; i++) ...[
                    _FadeSlideUp(
                      animation: _slot(
                        (0.25 + i * 0.12).clamp(0.0, 0.8),
                        (0.65 + i * 0.12).clamp(0.2, 1.0),
                      ),
                      child: eras[i] == eras.first
                          // KeyedSubtree luar (eraExploreCardReady) murni
                          // penanda "siap" yang reliable dicek dari
                          // TutorialTourController -- lihat catatan di
                          // tutorial_keys.dart. Showcase di dalamnya tetap
                          // yang beneran dipakai buat highlight tur.
                          ? KeyedSubtree(
                              key: TutorialKeys.eraExploreCardReady,
                              child: tutorialShowcase(
                                key: TutorialKeys.eraExploreCard,
                                title: 'Jelajahi Masa',
                                description:
                                    'Ketuk salah satu masa untuk melihat roadmap tahun-tahun wabahnya.',
                                currentStep: TutorialTourController.currentStepNumber,
                                totalSteps: TutorialTourController.totalStepCount,
                                onSkip: TutorialTourController.skip,
                                child: _EraExploreCard(
                                  name: eras[i].name,
                                  description: eras[i].description ?? '',
                                  accent: EraAccents.ofSlug(eras[i].slug),
                                  decorIcon: _decorIconOfSlug(eras[i].slug),
                                  darkText: _isDarkTextOnSlug(eras[i].slug),
                                  onTap: () =>
                                      context.go('/history/${eras[i].slug}'),
                                ),
                              ),
                            )
                          : _EraExploreCard(
                              name: eras[i].name,
                              description: eras[i].description ?? '',
                              accent: EraAccents.ofSlug(eras[i].slug),
                              decorIcon: _decorIconOfSlug(eras[i].slug),
                              darkText: _isDarkTextOnSlug(eras[i].slug),
                              onTap: () =>
                                  context.go('/history/${eras[i].slug}'),
                            ),
                    ),
                    if (eras[i] != eras.last) const SizedBox(height: 16),
                  ],
                ],
              ),
            ),
          ),
          loading: () => const _EraListSkeleton(),
          error: (error, _) => Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.cloud_off_rounded, size: 40, color: AppColors.textSecondary),
                  const SizedBox(height: 12),
                  const Text(
                    'Daftar masa belum bisa dimuat',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Periksa koneksi internetmu, lalu coba lagi.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14, color: AppColors.textSecondary),
                  ),
                  const SizedBox(height: 16),
                  FilledButton(
                    onPressed: () => ref.invalidate(erasProvider),
                    style: FilledButton.styleFrom(
                      backgroundColor: AppColors.ink,
                      minimumSize: const Size(140, 48),
                      shape: const StadiumBorder(),
                    ),
                    child: const Text('Coba lagi', style: TextStyle(fontWeight: FontWeight.w700)),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _sectionTitle(BuildContext context, String text) {
    return Text(
      text,
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w800,
            letterSpacing: -0.2,
          ),
    );
  }
}

/// Fade + slide dari bawah ke posisi normal — sama seperti home_screen.dart.
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
            offset: Offset(0, (1 - animation.value) * 18),
            child: child,
          ),
        );
      },
    );
  }
}

/// Kartu kecil ring progress "Kolonial 5/12 tahun" di section
/// Progress per Periode. Ring lebih ringkas & elegan dibanding bar tipis,
/// dan mengisi dengan animasi saat pertama tampil.
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
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      padding: const EdgeInsets.fromLTRB(10, 14, 10, 12),
      child: Column(
        children: [
          SizedBox(
            width: 56,
            height: 56,
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 56,
                  height: 56,
                  child: CircularProgressIndicator(
                    value: 1,
                    strokeWidth: 6,
                    strokeCap: StrokeCap.round,
                    valueColor: AlwaysStoppedAnimation(AppColors.border),
                  ),
                ),
                SizedBox(
                  width: 56,
                  height: 56,
                  child: TweenAnimationBuilder<double>(
                    tween: Tween(begin: 0, end: ratio),
                    duration: const Duration(milliseconds: 700),
                    curve: Curves.easeOutCubic,
                    builder: (context, value, _) {
                      return CircularProgressIndicator(
                        value: value,
                        strokeWidth: 6,
                        strokeCap: StrokeCap.round,
                        backgroundColor: Colors.transparent,
                        valueColor: AlwaysStoppedAnimation(Color.lerp(accent, AppColors.ink, 0.45)!),
                      );
                    },
                  ),
                ),
                Text(
                  '$completed/$total',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: 13,
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w600,
                ),
          ),
        ],
      ),
    );
  }
}

/// Pembungkus semantik: satu tombol dengan nama + deskripsi era.
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
    return Semantics(
      button: true,
      onTap: onTap,
      label: description.trim().isEmpty ? name : '$name. $description',
      excludeSemantics: true,
      child: _EraExploreCardBody(
        name: name,
        description: description,
        accent: accent,
        decorIcon: decorIcon,
        darkText: darkText,
        onTap: onTap,
      ),
    );
  }
}

/// Kartu besar gradasi per era di section "Jelajahi Masa".
class _EraExploreCardBody extends StatelessWidget {
  const _EraExploreCardBody({
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
    final chevronBg =
        (darkText ? AppColors.ink : AppColors.surface).withValues(alpha: 0.14);

    return PressableScale(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [accent, Color.lerp(accent, Colors.white, 0.18)!],
          ),
          boxShadow: [
            BoxShadow(
              color: accent.withValues(alpha: 0.28),
              blurRadius: 18,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            // Watermark dekoratif — hanya kosmetik, tidak menutupi teks.
            Positioned(
              right: -16,
              bottom: -16,
              child: Icon(
                decorIcon,
                size: 120,
                color: textColor.withValues(alpha: 0.15),
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
                          style:
                              Theme.of(context).textTheme.titleLarge?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: textColor,
                                  ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          description,
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: textColor.withValues(alpha: 0.85),
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
                    child: Icon(Icons.chevron_right_rounded, color: textColor),
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

/// Skeleton loading — pengganti spinner polos di tengah layar, supaya
/// bentuk layout (judul + 3 kartu) sudah terlihat sejak awal.
class _EraListSkeleton extends StatelessWidget {
  const _EraListSkeleton();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 32),
      children: const [
        _SkeletonBox(height: 28, width: 200),
        SizedBox(height: 10),
        _SkeletonBox(height: 16, width: 240),
        SizedBox(height: 26),
        _SkeletonBox(height: 140),
        SizedBox(height: 16),
        _SkeletonBox(height: 140),
        SizedBox(height: 16),
        _SkeletonBox(height: 140),
      ],
    );
  }
}

class _SkeletonBox extends StatefulWidget {
  const _SkeletonBox({required this.height, this.width});

  final double height;
  final double? width;

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
          width: widget.width ?? double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
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