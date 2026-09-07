import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
// NOTE: sesuaikan path import ini kalau lokasi app_colors.dart di project
// Anda beda (diasumsikan lib/core/theme/app_colors.dart).
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/models/era.dart';
import '../../../../shared/models/era_roadmap.dart';
import '../../../../shared/models/section_summary.dart';
import '../../../../shared/models/year.dart';
import '../providers/history_providers.dart';
import '../widgets/final_boss_node.dart';
import '../widgets/roadmap_path_painter.dart';
import '../widgets/year_node.dart';

/// GET /api/public/eras/{era:slug}/years — INFO-01.
///
/// Redesign total (Design.md §3.3 poin 1) — roadmap kini divisualisasikan
/// sebagai "jalur perjalanan" berkelok dengan node tahun completed/
/// current/locked, mengikuti Sequential Year Unlock (Rules.md §4.2,
/// R-YEAR-02–05). Status locked/completed sekarang datang langsung dari
/// backend (`Year.locked`/`Year.isCompleted`, `SectionSummary.locked`/
/// `.completed`) — gap lama ("checkmark belum bisa ditampilkan") sudah
/// ditutup di sesi revisi backend sebelumnya.
///
/// **BARU (ERAQUIZ-01)**: node "final boss" ditambahkan sebagai titik
/// TERAKHIR jalur, setelah seluruh node tahun — lihat `FinalBossNode`.
/// ASUMSI YANG BELUM DIVERIFIKASI: kode di bawah mengakses `era!.id`
/// (int) untuk dikirim ke `EraQuizApi` (yang butuh `era_id`, dikonfirmasi
/// lewat `Era.php` tidak override `getRouteKeyName()`) — belum saya cek
/// apakah model `Era` Flutter (`shared/models/era.dart`) memang punya
/// field `id`. Kalau modelnya cuma punya `slug`/`name`/`description`
/// tanpa `id`, field itu perlu ditambah dulu (dan dipetakan dari
/// response `GET /public/eras` yang seharusnya memang membawa `id` juga
/// sebagai primary key Eloquent standar).
class EraRoadmapScreen extends ConsumerWidget {
  const EraRoadmapScreen({super.key, required this.eraSlug});

  final String eraSlug;

  static const double _nodeSpacing = 190;
  static const double _topPadding = 90;
  static const double _bottomPadding = 64;

  // Fraksi horizontal (0..1) posisi tiap node, di-cycle per index supaya
  // jalurnya kelihatan "berkelok" alami, bukan lurus/simetris kaku.
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

  /// Section target saat tahun di-tap: section pertama yang belum locked &
  /// belum completed (lanjut baca), atau section pertama kalau semua
  /// sudah completed (buka lagi buat review).
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

  // TODO: sesuaikan path route ini begitu layar Kerjakan Kuis/Hasil kuis
  // sumatif era sudah ada (2 sub-tugas backlog berikutnya) — untuk
  // sekarang murni placeholder supaya wiring navigasi dari roadmap sudah
  // siap lebih dulu.
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
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('Gagal memuat data: $error')),
      ),
    );
  }
}

class _RoadmapBody extends StatelessWidget {
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
  Widget build(BuildContext context) {
    final years = roadmap.years;
    // ERAQUIZ-01: node final-boss cuma bisa dirender kalau kita tahu
    // era.id (dibutuhkan EraQuizApi, yang pakai era_id integer — lihat
    // catatan di era_quiz_api.dart). Kalau `era` belum ke-resolve dari
    // erasProvider (mis. masih loading atau slug tidak ketemu), node ini
    // untuk sementara disembunyikan total daripada nge-crash — akan
    // muncul begitu `era` ter-resolve karena widget ini rebuild seiring
    // provider lain settle.
    final hasFinalBoss = era != null;
    // R-ERAQUIZ-02: unlocked hanya kalau SELURUH year (yang published,
    // makanya cek dari totalYears bukan years.length) sudah completed.
    final finalBossUnlocked =
        roadmap.totalYears > 0 && roadmap.completedYears == roadmap.totalYears;

    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(child: _Header(era: era, eraSlug: eraSlug, accent: accent)),
        SliverToBoxAdapter(child: _ProgressCard(era: era, roadmap: roadmap, accent: accent)),
        SliverToBoxAdapter(
          child: years.isEmpty
              ? const Padding(
                  padding: EdgeInsets.all(32),
                  child: Center(child: Text('Belum ada konten di masa ini.')),
                )
              : LayoutBuilder(
                  builder: (context, constraints) {
                    final width = constraints.maxWidth;
                    // +1 slot node kalau final-boss dirender, supaya jalur
                    // & tinggi Stack ikut memanjang menampung node itu.
                    final nodeCount = years.length + (hasFinalBoss ? 1 : 0);
                    final height = topPadding + nodeSpacing * nodeCount + bottomPadding;

                    final points = List<Offset>.generate(nodeCount, (i) {
                      final xFraction = xFractions[i % xFractions.length];
                      return Offset(width * xFraction, topPadding + nodeSpacing * i);
                    });

                    return SizedBox(
                      width: width,
                      height: height,
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Positioned.fill(
                            child: CustomPaint(
                              painter: RoadmapPathPainter(
                                points: points,
                                color: accent.withOpacity(0.22),
                              ),
                            ),
                          ),
                          for (var i = 0; i < years.length; i++)
                            Positioned(
                              top: points[i].dy - 60,
                              left: points[i].dx - 110,
                              width: 220,
                              child: Center(
                                child: YearNode(
                                  year: years[i],
                                  state: stateOf(years[i]),
                                  accent: accent,
                                  nodeX: points[i].dx,
                                  screenWidth: width,
                                  onTap: () {
                                    if (stateOf(years[i]) == YearNodeState.locked) {
                                      onTapLocked();
                                    } else {
                                      onTapUnlocked(years[i]);
                                    }
                                  },
                                ),
                              ),
                            ),
                          if (hasFinalBoss)
                            Positioned(
                              top: points.last.dy - 70,
                              left: points.last.dx - 110,
                              width: 220,
                              child: Center(
                                child: FinalBossNode(
                                  eraId: era!.id,
                                  unlocked: finalBossUnlocked,
                                  accent: accent,
                                  nodeX: points.last.dx,
                                  screenWidth: width,
                                  onTapLocked: onTapFinalBossLocked,
                                  onTapUnattempted: () => onTapFinalBossUnattempted(era!.id),
                                  onTapAttempted: () => onTapFinalBossAttempted(era!.id),
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

class _Header extends StatelessWidget {
  const _Header({required this.era, required this.eraSlug, required this.accent});

  final Era? era;
  final String eraSlug;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: accent.withOpacity(0.12),
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 12,
        bottom: 20,
        left: 16,
        right: 16,
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => context.pop(),
            child: Container(
              width: 40,
              height: 40,
              decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
              child: const Icon(Icons.arrow_back, size: 20),
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
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
        ],
      ),
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
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 12, offset: const Offset(0, 4)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Perjalanan Era', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
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
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 8,
              backgroundColor: AppColors.border,
              valueColor: AlwaysStoppedAnimation(accent),
            ),
          ),
        ],
      ),
    );
  }
}