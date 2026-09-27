import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:showcaseview/showcaseview.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../shared/models/era.dart';
import '../../../../shared/models/era_roadmap.dart';
import '../../../../shared/models/section_summary.dart';
import '../../../../shared/models/year.dart';
import '../../../../shared/widgets/pressable_scale.dart';
import '../../../onboarding/tutorial_keys.dart';
import '../../../onboarding/tutorial_showcase_style.dart';
import '../../../onboarding/tutorial_tour_controller.dart';
import '../providers/history_providers.dart';
import '../widgets/final_boss_node.dart';
import '../widgets/roadmap_path_painter.dart';
import '../widgets/wabah_intro_modal.dart';
import '../widgets/year_node.dart';

/// GET /api/public/eras/{era:slug}/years — INFO-01.
///
/// Roadmap divisualisasikan sebagai "jalur perjalanan" berkelok dengan
/// node tahun completed/current/locked, mengikuti Sequential Year Unlock
/// (Rules.md §4.2, R-YEAR-02–05). Status locked/completed datang
/// langsung dari backend (`Year.locked`/`Year.isCompleted`,
/// `SectionSummary.locked`/`.completed`).
///
/// Node "final boss" (ERAQUIZ-01) dirender sebagai titik TERAKHIR jalur,
/// setelah seluruh node tahun — lihat `FinalBossNode`. ASUMSI YANG BELUM
/// DIVERIFIKASI: kode di bawah mengakses `era!.id` (int) untuk dikirim ke
/// `EraQuizApi` — belum dicek apakah model `Era` Flutter memang punya
/// field `id`.
///
/// REDESIGN (animasi "mengalir"): jalur & node roadmap sekarang muncul
/// bertahap — jalur tergambar dari atas ke bawah, tiap node pop-in
/// begitu jalur "sampai" ke posisinya (lihat `_pathProgress`/
/// `_nodeReveal` di `_RoadmapBodyState`). Animasi mulai langsung begitu
/// layar ini pertama kali dibuka (`initState`) — tidak ada gerbang/delay
/// eksternal, karena animasi reveal "buka vaksin" berjalan sepenuhnya di
/// halamannya sendiri dan tidak pernah tampil bersamaan dengan roadmap
/// ini, jadi tidak ada risiko tabrakan.
///
/// Selain itu, node yang baru saja berubah dari locked -> terbuka (mis.
/// user menyelesaikan tahun sebelumnya lalu kembali ke roadmap ini,
/// memicu refetch `yearsProvider`) mendapat efek "pulse" cincin sekali
/// — lihat `_UnlockPulse`. Deteksi ini pakai `year.year` sebagai key unik
/// per node (aman selama satu era tidak punya dua tahun bernilai sama).
class EraRoadmapScreen extends ConsumerWidget {
  const EraRoadmapScreen({super.key, required this.eraSlug});

  final String eraSlug;

  static const double _nodeSpacing = 190;
  static const double _topPadding = 90;
  static const double _bottomPadding = 64;

  static const List<double> _xFractions = [
    0.22,
    0.62,
    0.42,
    0.16,
    0.58,
    0.30,
    0.68,
    0.20,
    0.50,
  ];

  YearNodeState _stateOf(Year year) {
    if (year.locked) return YearNodeState.locked;
    if (year.isCompleted) return YearNodeState.completed;
    return YearNodeState.current;
  }

  SectionSummary? _targetSection(Year year) {
    if (year.sections.isEmpty) return null;
    for (final section in year.sections) {
      if (!section.locked && !section.completed) return section;
    }
    return year.sections.first;
  }

  void _openYear(BuildContext context, Year year) {
    final target = _targetSection(year);
    if (target == null) return;
    context.go('/section/${target.id}');
  }

  void _showLockedMessage(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Selesaikan tahun sebelumnya dulu untuk membuka ini.'),
      ),
    );
  }

  void _showFinalBossLockedMessage(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Selesaikan seluruh tahun pada era ini terlebih dahulu sebelum mengerjakan kuis sumatif.'),
      ),
    );
  }

  void _openFinalBossUnattempted(BuildContext context, int eraId) {
    context.push('/era-quiz/$eraId');
  }

  void _openFinalBossResult(BuildContext context, int eraId) {
    context.push('/era-quiz/$eraId/result');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final yearsAsync = ref.watch(yearsProvider(eraSlug));
    final erasAsync = ref.watch(erasProvider);

    Era? era;
    for (final candidate in erasAsync.valueOrNull ?? const <Era>[]) {
      if (candidate.slug == eraSlug) {
        era = candidate;
        break;
      }
    }
    final accent = EraAccents.ofSlug(eraSlug);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: yearsAsync.when(
        data: (roadmap) => _RoadmapBody(
          era: era,
          eraSlug: eraSlug,
          roadmap: roadmap,
          accent: accent,
          stateOf: _stateOf,
          onTapUnlocked: (year) => _openYear(context, year),
          onTapLocked: () => _showLockedMessage(context),
          onTapFinalBossLocked: () => _showFinalBossLockedMessage(context),
          onTapFinalBossUnattempted: (eraId) => _openFinalBossUnattempted(context, eraId),
          onTapFinalBossAttempted: (eraId) => _openFinalBossResult(context, eraId),
          nodeSpacing: _nodeSpacing,
          topPadding: _topPadding,
          bottomPadding: _bottomPadding,
          xFractions: _xFractions,
        ),
        loading: () => Center(
          child: CircularProgressIndicator(color: accent),
        ),
        error: (error, _) => Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Text(
              'Gagal memuat data: $error',
              textAlign: TextAlign.center,
              style: const TextStyle(color: AppColors.textSecondary),
            ),
          ),
        ),
      ),
    );
  }
}

class _RoadmapBody extends ConsumerStatefulWidget {
  const _RoadmapBody({
    required this.era,
    required this.eraSlug,
    required this.roadmap,
    required this.accent,
    required this.stateOf,
    required this.onTapUnlocked,
    required this.onTapLocked,
    required this.onTapFinalBossLocked,
    required this.onTapFinalBossUnattempted,
    required this.onTapFinalBossAttempted,
    required this.nodeSpacing,
    required this.topPadding,
    required this.bottomPadding,
    required this.xFractions,
  });

  final Era? era;
  final String eraSlug;
  final EraRoadmap roadmap;
  final Color accent;
  final YearNodeState Function(Year) stateOf;
  final void Function(Year) onTapUnlocked;
  final VoidCallback onTapLocked;
  final VoidCallback onTapFinalBossLocked;
  final void Function(int eraId) onTapFinalBossUnattempted;
  final void Function(int eraId) onTapFinalBossAttempted;
  final double nodeSpacing;
  final double topPadding;
  final double bottomPadding;
  final List<double> xFractions;

  @override
  ConsumerState<_RoadmapBody> createState() => _RoadmapBodyState();
}

class _RoadmapBodyState extends ConsumerState<_RoadmapBody> with SingleTickerProviderStateMixin {
  late final AnimationController _entrance = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1500),
  );

  // year.year dipakai sebagai key unik per node untuk deteksi "baru
  // terbuka" -- aman selama satu era tidak punya dua tahun bernilai sama.
  final Map<int, bool> _lastLocked = {};
  final Map<int, int> _unlockPulseGen = {};

  @override
  void initState() {
    super.initState();
    _entrance.forward();
  }

  Animation<double> get _pathProgress => CurvedAnimation(
        parent: _entrance,
        curve: const Interval(0.0, 0.55, curve: Curves.easeInOut),
      );

  Animation<double> _nodeReveal(int index, int nodeCount) {
    final safeCount = nodeCount < 1 ? 1 : nodeCount;
    final start = (0.12 + (index / safeCount) * 0.55).clamp(0.0, 0.85);
    final end = (start + 0.3).clamp(0.15, 1.0);
    return CurvedAnimation(
      parent: _entrance,
      curve: Interval(start, end, curve: Curves.easeOutBack),
    );
  }

  /// Tandai node yang baru saja berubah dari locked -> terbuka. Pulse
  /// cuma diizinkan SETELAH animasi entrance pertama selesai, supaya
  /// node yang memang baru pertama kali tampil (bukan "baru terbuka")
  /// tidak ikut ke-pulse.
  int _pulseTokenFor(Year year) {
    final key = year.year;
    final isLocked = widget.stateOf(year) == YearNodeState.locked;
    if (_entrance.isCompleted) {
      final wasLocked = _lastLocked[key];
      if (wasLocked == true && !isLocked) {
        _unlockPulseGen[key] = (_unlockPulseGen[key] ?? 0) + 1;
      }
    }
    _lastLocked[key] = isLocked;
    return _unlockPulseGen[key] ?? 0;
  }

  @override
  void dispose() {
    _entrance.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final years = widget.roadmap.years;
    final hasFinalBoss = widget.era != null;
    final finalBossUnlocked =
        widget.roadmap.totalYears > 0 && widget.roadmap.completedYears == widget.roadmap.totalYears;
    final nodeCount = years.length + (hasFinalBoss ? 1 : 0);

    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(child: _Header(era: widget.era, eraSlug: widget.eraSlug, accent: widget.accent)),
        SliverToBoxAdapter(child: _ProgressCard(era: widget.era, roadmap: widget.roadmap, accent: widget.accent)),
        SliverToBoxAdapter(
          child: years.isEmpty
              ? const _EmptyRoadmap()
              : LayoutBuilder(
                  builder: (context, constraints) {
                    final width = constraints.maxWidth;
                    final height = widget.topPadding + widget.nodeSpacing * nodeCount + widget.bottomPadding;

                    final points = List<Offset>.generate(nodeCount, (i) {
                      final xFraction = widget.xFractions[i % widget.xFractions.length];
                      return Offset(width * xFraction, widget.topPadding + widget.nodeSpacing * i);
                    });

                    return SizedBox(
                      width: width,
                      height: height,
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Positioned.fill(
                            child: AnimatedBuilder(
                              animation: _pathProgress,
                              builder: (context, _) {
                                return CustomPaint(
                                  painter: RoadmapPathPainter(
                                    points: points,
                                    color: widget.accent.withValues(alpha: 0.22),
                                    progress: _pathProgress.value,
                                  ),
                                );
                              },
                            ),
                          ),
                          for (var i = 0; i < years.length; i++)
                            Positioned(
                              top: points[i].dy - 60,
                              left: points[i].dx - 110,
                              width: 220,
                              child: Center(
                                child: _NodeReveal(
                                  animation: _nodeReveal(i, nodeCount),
                                  child: _UnlockPulse(
                                    triggerToken: _pulseTokenFor(years[i]),
                                    accent: widget.accent,
                                    child: i == 0
                                        // KeyedSubtree luar (eraExploreCardReady-style
                                        // penanda "siap") dicek TutorialTourController.
                                        ? KeyedSubtree(
                                            key: TutorialKeys.roadmapReady,
                                            child: tutorialShowcase(
                                              key: TutorialKeys.roadmapYearNode,
                                              title: 'Node Tahun',
                                              description:
                                                  'Tiap tahun berisi beberapa bagian bacaan yang harus dibaca berurutan. Ketuk untuk mulai membaca.',
                                              currentStep: TutorialTourController.currentStepNumber,
                                              totalSteps: TutorialTourController.totalStepCount,
                                              onSkip: TutorialTourController.skip,
                                              child: YearNode(
                                                year: years[i],
                                                state: widget.stateOf(years[i]),
                                                accent: widget.accent,
                                                nodeX: points[i].dx,
                                                screenWidth: width,
                                                onTap: () {
                                                  if (widget.stateOf(years[i]) == YearNodeState.locked) {
                                                    widget.onTapLocked();
                                                  } else {
                                                    widget.onTapUnlocked(years[i]);
                                                  }
                                                },
                                              ),
                                            ),
                                          )
                                        : YearNode(
                                            year: years[i],
                                            state: widget.stateOf(years[i]),
                                            accent: widget.accent,
                                            nodeX: points[i].dx,
                                            screenWidth: width,
                                            onTap: () {
                                              if (widget.stateOf(years[i]) == YearNodeState.locked) {
                                                widget.onTapLocked();
                                              } else {
                                                widget.onTapUnlocked(years[i]);
                                              }
                                            },
                                          ),
                                  ),
                                ),
                              ),
                            ),
                          if (hasFinalBoss)
                            Positioned(
                              top: points.last.dy - 70,
                              left: points.last.dx - 110,
                              width: 220,
                              child: Center(
                                child: _NodeReveal(
                                  animation: _nodeReveal(nodeCount - 1, nodeCount),
                                  child: FinalBossNode(
                                    eraId: widget.era!.id,
                                    unlocked: finalBossUnlocked,
                                    accent: widget.accent,
                                    nodeX: points.last.dx,
                                    screenWidth: width,
                                    onTapLocked: widget.onTapFinalBossLocked,
                                    onTapUnattempted: () => widget.onTapFinalBossUnattempted(widget.era!.id),
                                    onTapAttempted: () => widget.onTapFinalBossAttempted(widget.era!.id),
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }
}

/// Fade + scale-in, dipakai path progress mengungkap node satu per satu.
class _NodeReveal extends StatelessWidget {
  const _NodeReveal({required this.animation, required this.child});

  final Animation<double> animation;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      child: child,
      builder: (context, child) {
        final raw = animation.value;
        final opacity = raw.clamp(0.0, 1.0);
        final scale = 0.55 + 0.45 * raw; // raw sedikit > 1 saat easeOutBack -> efek "pop"
        return Opacity(
          opacity: opacity,
          child: Transform.scale(scale: scale, child: child),
        );
      },
    );
  }
}

/// Efek "pulse" cincin sekali, dipicu tiap kali [triggerToken] berubah
/// nilai (dipakai untuk menandai "node ini baru saja terbuka"). Murni
/// dekoratif — tidak mengubah tap target/layout child.
///
/// CATATAN: ukuran cincin (96px) dipatok tetap, jadi kurang pas kalau
/// dipasang di final-boss (96-130px) vs year node (68-88px) — cukup
/// dekat untuk dua-duanya, tapi sesuaikan kalau kamu ingin presisi.
class _UnlockPulse extends StatefulWidget {
  const _UnlockPulse({
    required this.triggerToken,
    required this.accent,
    required this.child,
  });

  final int triggerToken;
  final Color accent;
  final Widget child;

  @override
  State<_UnlockPulse> createState() => _UnlockPulseState();
}

class _UnlockPulseState extends State<_UnlockPulse> with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 700),
  );

  @override
  void didUpdateWidget(covariant _UnlockPulse oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.triggerToken != oldWidget.triggerToken) {
      _controller.forward(from: 0);
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
      child: widget.child,
      builder: (context, child) {
        final t = _controller.value;
        return Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            if (t > 0 && t < 1)
              Opacity(
                opacity: (1 - t) * 0.6,
                child: Transform.scale(
                  scale: 1.0 + t * 0.8,
                  child: Container(
                    width: 96,
                    height: 96,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: widget.accent, width: 3),
                    ),
                  ),
                ),
              ),
            child!,
          ],
        );
      },
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.era, required this.eraSlug, required this.accent});

  final Era? era;
  final String eraSlug;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, _) {
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                accent.withValues(alpha: 0.16),
                accent.withValues(alpha: 0.05),
              ],
            ),
          ),
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top + 12,
            bottom: 20,
            left: 16,
            right: 16,
          ),
          child: Row(
            children: [
              PressableScale(
                onTap: () => context.pop(),
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
                  child: const Icon(Icons.arrow_back_rounded, size: 20),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: Text(
                        era?.name ?? eraSlug,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(color: accent, borderRadius: BorderRadius.circular(20)),
                      child: const Text(
                        'Era',
                        style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
              // Satu-satunya entry point ke modal "Apa itu Wabah" (INTRO-02).
              PressableScale(
                onTap: () => showWabahIntroModal(context, ref),
                child: tutorialShowcase(
                  key: TutorialKeys.roadmapInfoIcon,
                  title: 'Apa itu Wabah?',
                  description:
                      'Belum familiar dengan istilah wabah? Ketuk ikon ini kapan saja untuk membaca penjelasannya.',
                  // Sama step (3/5) dengan showcase roadmapYearNode di atas —
                  // keduanya key dari TutorialStep yang sama (lihat
                  // tutorial_tour_controller.dart), jadi progres tidak naik
                  // di antara keduanya, baru naik setelah step ini selesai.
                  currentStep: TutorialTourController.currentStepNumber,
                  totalSteps: TutorialTourController.totalStepCount,
                  onSkip: TutorialTourController.skip,
                  child: Container(
                    width: 40,
                    height: 40,
                    margin: const EdgeInsets.only(left: 8),
                    decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
                    child: const Icon(Icons.info_outline_rounded, size: 20),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _ProgressCard extends StatelessWidget {
  const _ProgressCard({required this.era, required this.roadmap, required this.accent});

  final Era? era;
  final EraRoadmap roadmap;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    final progress = roadmap.totalYears == 0 ? 0.0 : roadmap.completedYears / roadmap.totalYears;

    return Container(
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(color: AppColors.ink.withValues(alpha: 0.04), blurRadius: 14, offset: const Offset(0, 6)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Perjalanan Era', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(color: AppColors.background, borderRadius: BorderRadius.circular(20)),
                child: RichText(
                  text: TextSpan(
                    style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
                    children: [
                      TextSpan(
                        text: '${roadmap.completedYears}',
                        style: TextStyle(color: accent, fontWeight: FontWeight.bold),
                      ),
                      const TextSpan(text: ' dari '),
                      TextSpan(text: '${roadmap.totalYears} tahun dibaca'),
                    ],
                  ),
                ),
              ),
            ],
          ),
          if (era?.description != null && era!.description!.isNotEmpty) ...[
            const SizedBox(height: 4),
            Text(
              era!.description!,
              style: const TextStyle(color: AppColors.textSecondary, fontSize: 13),
            ),
          ],
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: TweenAnimationBuilder<double>(
              tween: Tween(begin: 0, end: progress),
              duration: const Duration(milliseconds: 800),
              curve: Curves.easeOutCubic,
              builder: (context, value, _) {
                return LinearProgressIndicator(
                  value: value,
                  minHeight: 8,
                  backgroundColor: AppColors.border,
                  valueColor: AlwaysStoppedAnimation(accent),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _EmptyRoadmap extends StatelessWidget {
  const _EmptyRoadmap();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(40),
      child: Column(
        children: [
          Icon(Icons.hourglass_empty_rounded, size: 48, color: AppColors.textSecondary.withValues(alpha: 0.5)),
          const SizedBox(height: 12),
          const Text(
            'Belum ada konten di masa ini.',
            textAlign: TextAlign.center,
            style: TextStyle(color: AppColors.textSecondary),
          ),
        ],
      ),
    );
  }
}