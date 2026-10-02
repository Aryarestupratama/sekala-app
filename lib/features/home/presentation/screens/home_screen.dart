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
import '../../../history/presentation/providers/history_providers.dart';
import '../providers/home_providers.dart';
import '../widgets/guest_invite_card.dart';
import '../widgets/overall_progress_card.dart';
import '../widgets/recommendation_card.dart';

/// Design.md §3.2. Gabungan dari:
/// - homeSummaryProvider (null untuk guest) -> kartu rekomendasi (HOME-02)
///   & progress keseluruhan (HOME-01)
/// - tombol "Jelajahi" -> tab Informasi Sejarah (HOME-03)
///
/// REVISI (design review) — logic/provider/tutorial TIDAK berubah:
/// 1) Satu section ringkasan (rekomendasi + progress) dengan 3 state jelas:
///    skeleton saat loading, kartu error + "Coba lagi" saat gagal (dulu
///    hilang diam-diam -> Home terlihat kosong tanpa penjelasan), data.
///    Skeleton progress ditambahkan supaya layout tidak melompat.
/// 2) Judul "Langkah Berikutnya" (netral; "Lanjutkan" salah untuk user baru).
/// 3) Guest: tombol Jelajahi di ATAS, ajakan daftar di bawahnya — prinsip
///    "ramah guest, temukan dulu sebelum diminta daftar" (Design.md §1).
///    Tukar dua blok di `build()` kalau mau urutan lama.
/// 4) Pull-to-refresh menunggu data selesai dimuat (dulu spinner hilang
///    seketika).
/// 5) Sapaan: 00.00-03.59 = malam (dulu "Selamat pagi" jam 2 dini hari).
/// 6) Reduce-motion dihormati; animasi dibuat sekali (bukan tiap build);
///    `_Pressable` duplikat diganti `PressableScale`; teks >= 14sp.
class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen>
    with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  // Guard supaya pengecekan auto-start tutorial cuma jalan sekali.
  //
  // PENTING: pengecekan ini SENGAJA ditaruh di sini (HomeScreen), BUKAN di
  // MainShell -- context MainShell berada DI LUAR `navigationShell`, jadi
  // StatefulNavigationShell.of(context) akan gagal di sana.
  bool _didCheckAutoStartTutorial = false;
  bool _entranceStarted = false;

  late final AnimationController _entrance = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 800),
  );

  late final Animation<double> _aHeader = _slot(0.0, 0.5);
  late final Animation<double> _aFirst = _slot(0.15, 0.65);
  late final Animation<double> _aCta = _slot(0.4, 0.9);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || _didCheckAutoStartTutorial) return;
      _didCheckAutoStartTutorial = true;
      TutorialTourController.maybeAutoStart(context, ref);
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_entranceStarted) return;
    _entranceStarted = true;
    if (MediaQuery.disableAnimationsOf(context)) {
      _entrance.value = 1;
    } else {
      _entrance.forward();
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // User login tapi belum verifikasi email biasanya minimize app -> buka
    // email -> klik link verifikasi -> balik lagi ke app. Momen "balik ke
    // app" ini satu-satunya sinyal bahwa verifikasi mungkin baru terjadi di
    // luar app. currentUserProvider di-invalidate supaya status verifikasi
    // (Profil) ikut re-fetch tanpa logout-login manual.
    if (state == AppLifecycleState.resumed) {
      ref.invalidate(currentUserProvider);
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
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
    if (hour < 4) return 'Selamat malam';
    if (hour < 11) return 'Selamat pagi';
    if (hour < 15) return 'Selamat siang';
    if (hour < 18) return 'Selamat sore';
    return 'Selamat malam';
  }

  Future<void> _refresh() async {
    ref.invalidate(erasProvider);
    ref.invalidate(homeSummaryProvider);
    ref.invalidate(currentUserProvider);
    // Tunggu ringkasan selesai dimuat supaya indikator refresh tidak hilang
    // sebelum data baru tampil. Error ditangani kartu error di UI.
    try {
      await ref.read(homeSummaryProvider.future);
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authNotifierProvider);
    final isGuest = authState.status == AuthStatus.guest;

    // Data User (nama dsb) datang dari currentUserProvider, sama seperti
    // ProfileScreen.
    final currentUserAsync = ref.watch(currentUserProvider);
    final userName = currentUserAsync.valueOrNull?.name ?? 'Sobat Sejarah';

    final ctaAnimation = isGuest ? _aFirst : _aCta;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: RefreshIndicator(
          color: AppColors.ink,
          onRefresh: _refresh,
          // PENTING: SingleChildScrollView + Column, BUKAN ListView, supaya
          // GlobalKey Showcase (TutorialKeys.homeCtaButton) selalu attach
          // tanpa harus di-scroll dulu (ListView malas mem-build).
          // AlwaysScrollable: supaya pull-to-refresh tetap jalan walau
          // konten lebih pendek dari layar.
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
            child: Align(
              alignment: Alignment.topCenter,
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 560),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Status verifikasi email sengaja TIDAK di Home (lihat
                    // keputusan produk + `EmailVerificationNotice`).
                    _FadeSlideUp(
                      animation: _aHeader,
                      child: _buildHeader(context, isGuest, userName),
                    ),
                    const SizedBox(height: 18),

                    if (isGuest) ...[
                      // CTA jelajah dulu (guest: temukan sebelum daftar).
                      // Fade saja (tanpa translate) supaya posisi target
                      // Showcase tutorial tidak bergeser saat diukur.
                      FadeTransition(
                        opacity: ctaAnimation,
                        child: _buildCta(context),
                      ),
                      const SizedBox(height: 18),
                      _FadeSlideUp(
                        animation: _aFirst,
                        child: GuestInviteCard(
                          onTap: () => context.go('/auth'),
                        ),
                      ),
                    ] else ...[
                      _FadeSlideUp(
                        animation: _aFirst,
                        child: _buildSummary(context),
                      ),
                      FadeTransition(
                        opacity: ctaAnimation,
                        child: _buildCta(context),
                      ),
                    ],
                  ],
                ),
              ),
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
                'Yuk jelajahi sejarah kesehatan Indonesia',
                style: textTheme.bodyMedium?.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 14),
        // TODO(design): avatar ini masih inisial. Profil sudah punya foto +
        // Border SEKALA (`ProfileAvatar`) — ganti ke widget itu supaya user
        // yang sudah unggah foto / dapat border melihatnya juga di Home.
        ExcludeSemantics(
          child: Container(
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
        ),
      ],
    );
  }

  Widget _sectionTitle(BuildContext context, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Semantics(
        header: true,
        child: Text(
          text,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w800,
                letterSpacing: -0.2,
              ),
        ),
      ),
    );
  }

  /// Rekomendasi + progress dalam satu section dengan state loading/error
  /// yang konsisten. Pakai `hasValue` (bukan `.when(loading:)`) supaya data
  /// lama tetap tampil saat refresh — pelajaran bug Rangkuman.
  Widget _buildSummary(BuildContext context) {
    final async = ref.watch(homeSummaryProvider);

    if (!async.hasValue) {
      if (async.hasError) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 18),
          child: _SummaryError(
            onRetry: () => ref.invalidate(homeSummaryProvider),
          ),
        );
      }
      return const Padding(
        padding: EdgeInsets.only(bottom: 18),
        child: Column(
          children: [
            _SkeletonBox(height: 110),
            SizedBox(height: 18),
            _SkeletonBox(height: 124),
          ],
        ),
      );
    }

    final summary = async.value;
    final rec = summary?.recommendation;
    final progressByEra = summary?.progressByEra ?? [];

    final progressBySlug = <String, EraProgress>{
      for (final p in progressByEra) p.era.slug: p,
    };
    final completed = progressByEra.fold<int>(0, (sum, p) => sum + p.completed);
    final total = progressByEra.fold<int>(0, (sum, p) => sum + p.total);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (rec != null) ...[
          _sectionTitle(context, 'Langkah Berikutnya'),
          RecommendationCard(
            recommendation: rec,
            eraProgress: progressBySlug[rec.era.slug],
            onTap: () => context.go('/history/${rec.era.slug}'),
          ),
          const SizedBox(height: 18),
        ],
        if (progressByEra.isNotEmpty) ...[
          _sectionTitle(context, 'Progress Belajarmu'),
          OverallProgressCard(completed: completed, total: total),
          const SizedBox(height: 18),
        ],
      ],
    );
  }

  Widget _buildCta(BuildContext context) {
    return tutorialShowcase(
      key: TutorialKeys.homeCtaButton,
      title: 'Mulai Jelajahi',
      description:
          'Tekan tombol ini untuk mulai membaca sejarah kesehatan Indonesia dari masa ke masa.',
      currentStep: TutorialTourController.currentStepNumber,
      totalSteps: TutorialTourController.totalStepCount,
      onSkip: TutorialTourController.skip,
      child: Semantics(
        button: true,
        onTap: () => context.go('/history'),
        label: 'Jelajahi lebih lanjut. Sejarah kesehatan dari masa ke masa.',
        excludeSemantics: true,
        child: PressableScale(
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
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 3),
                      Text(
                        'Sejarah kesehatan dari masa ke masa',
                        style: TextStyle(
                          color: Color(0xB3FFFFFF),
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  width: 48,
                  height: 48,
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

/// Kartu error ringkasan (offline / server error) dengan aksi ulang.
class _SummaryError extends StatelessWidget {
  const _SummaryError({required this.onRetry});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Semantics(
      liveRegion: true,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(22),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          children: [
            const Icon(
              Icons.cloud_off_rounded,
              size: 28,
              color: AppColors.textSecondary,
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Progresmu belum bisa dimuat',
                    style: textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppColors.ink,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Periksa koneksi internetmu, lalu coba lagi.',
                    style: textTheme.bodyMedium?.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            TextButton(
              onPressed: onRetry,
              style: TextButton.styleFrom(
                foregroundColor: AppColors.ink,
                minimumSize: const Size(48, 48),
              ),
              child: const Text(
                'Coba lagi',
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Placeholder abu berdenyut selama data loading (pengganti spinner).
/// Berhenti berdenyut kalau animasi sistem dimatikan.
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
  );
  bool _started = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_started) return;
    _started = true;
    if (MediaQuery.disableAnimationsOf(context)) {
      _controller.value = 0.5;
    } else {
      _controller.repeat(reverse: true);
    }
  }

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