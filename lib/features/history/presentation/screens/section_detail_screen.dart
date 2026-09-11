import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/auth_state.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/models/section.dart';
import '../../../../shared/models/section_summary.dart';
import '../../../../shared/models/year.dart';
import '../../../auth/presentation/providers/auth_providers.dart';
import '../providers/history_providers.dart';
import '../widgets/content_block_view.dart';

/// GET /api/public/sections/{section} — INFO-02.
///
/// REDESIGN (menggantikan versi scroll-to-bottom detection sebelumnya):
/// CTA "Baca Materi Berikutnya" / "Lihat Rangkuman" sekarang **selalu**
/// tampil fixed di bawah layar, tidak lagi menunggu event
/// `VisibilityDetector`/scroll-to-bottom untuk muncul. Section pendek
/// yang kontennya muat penuh di viewport sempat bikin marker visibility
/// nggak pernah ke-scan tepat waktu (Bug 1 lama) — sekarang dihindari
/// total karena kemunculan tombol tidak lagi bergantung ke scroll sama
/// sekali.
///
/// Completion (R-PROG-02) sekarang **di-trigger oleh tap tombol CTA itu
/// sendiri**, bukan oleh event scroll: begitu user menekan "Lanjut",
/// section ditandai selesai (best-effort — kalau gagal/guest/belum
/// verified, navigasi tetap jalan supaya user tidak macet baca) baru
/// pindah ke section berikutnya/rangkuman. Rangkuman & kuis tetap tidak
/// nyempil di layar ini (sudah naik level ke `year`, Architecture.md
/// §4.2/§4.8).
///
/// REVISI (Header Gambar Section, baru): judul section TIDAK LAGI
/// dirender di body layar ini — posisi paling atas sekarang header gambar
/// (`section.headerImageUrl`, opsional per section, bisa null). AppBar di
/// bawah tetap menampilkan `section.title` sebagai label navigasi
/// (bukan bagian dari "posisi paling atas" konten yang dimaksud revisi).
///
/// REVISI (konsumsi `year_completed` dari response complete-section,
/// backlog progress.md): `_handleCtaTap` sekarang mengecek field
/// `year_completed` yang dibalikin ProgressController::complete()
/// (R-PROG-07/08) alih-alih cuma mengandalkan heuristic lokal "section
/// terakhir by order" buat mutusin kapan ke Rangkuman Wabah. Kalau
/// backend bilang year ini sudah completed (semua section + kuis year
/// tsb selesai) di titik ini, redirect dipaksa ke Rangkuman — override
/// `navigate` bawaan caller (termasuk kalau caller aslinya menuju "Baca
/// Materi Berikutnya"). Di alur baca maju normal `year_completed` tetap
/// false di titik ini (kuis baru bisa dikerjakan dari halaman Rangkuman,
/// sesudah section terakhir), jadi behavior existing untuk kasus umum
/// TIDAK berubah — field ini menutup gap skenario non-linear (mis. user
/// balik baca ulang section lama yang belum completed padahal year-nya
/// sudah completed dari sesi lain).
class SectionDetailScreen extends ConsumerStatefulWidget {
  const SectionDetailScreen({super.key, required this.sectionId});

  final String sectionId;

  @override
  ConsumerState<SectionDetailScreen> createState() =>
      _SectionDetailScreenState();
}

class _SectionDetailScreenState extends ConsumerState<SectionDetailScreen> {
  bool _navigating = false;

  int get _id => int.parse(widget.sectionId);

  bool _isThisSectionCompleted(Year? year) {
    // Sumber utama: state lokal sesi ini (feedback instan begitu
    // completion sukses, sebelum roadmap sempat ke-refetch).
    if (ref.watch(sectionJustCompletedProvider(_id))) return true;
    if (year == null) return false;
    for (final s in year.sections) {
      if (s.id == _id) return s.completed;
    }
    return false;
  }

  /// Urutkan `sections` berdasarkan `order` — jangan asumsikan array dari
  /// API sudah terurut.
  List<SectionSummary> _orderedSections(Year year) {
    final sections = [...year.sections];
    sections.sort((a, b) => a.order.compareTo(b.order));
    return sections;
  }

  /// Dipanggil saat tombol CTA ditekan. Tandai completion dulu (kalau
  /// belum) baru navigate — completion best-effort, tidak mem-block
  /// navigasi kalau gagal (mis. guest, belum verified, atau hiccup
  /// jaringan), supaya tombol "Lanjut" tetap terasa langsung responsif.
  ///
  /// PENTING: try/catch/finally di sini WAJIB ada — tanpanya, kalau
  /// `complete()` throw (mis. timeout/500 pas koneksi lambat), `await`
  /// melempar exception dan baris reset `_navigating` di bawahnya tidak
  /// pernah tercapai, bikin tombol nyangkut spinning selamanya (bug yang
  /// pernah kejadian: video di section belum selesai loading -> koneksi
  /// lambat -> completion request ikut gagal -> tombol macet).
  ///
  /// BARU: `yearId`/`eraSlug` sekarang wajib dioper supaya fungsi ini bisa
  /// mutusin sendiri redirect ke Rangkuman Wabah berdasarkan
  /// `year_completed` dari response complete-section (lihat dokumentasi
  /// class di atas) — override `navigate` bawaan caller kalau backend
  /// bilang year-nya sudah completed di titik ini.
  Future<void> _handleCtaTap({
    required bool alreadyCompleted,
    required int yearId,
    required String eraSlug,
    required VoidCallback navigate,
  }) async {
    if (_navigating) return;
    setState(() => _navigating = true);

    var redirectToSummary = false;

    if (!alreadyCompleted) {
      final authStatus = ref.read(authNotifierProvider).status;
      final user = ref.read(currentUserProvider).valueOrNull;
      final canRecordProgress = authStatus == AuthStatus.authenticated &&
          user != null &&
          user.isEmailVerified;

      if (canRecordProgress) {
        try {
          // Best-effort: tunggu hasilnya supaya state completed konsisten
          // sebelum pindah layar, tapi kegagalan TIDAK menghentikan
          // navigasi — daripada user macet gara-gara satu request gagal.
          final result = await ref
              .read(sectionCompletionControllerProvider.notifier)
              .complete(_id);

          // BARU — konsumsi `year_completed` dari response backend
          // (R-PROG-07/08) alih-alih cuma ngandelin heuristic lokal
          // "section terakhir by order" (`isLastSection` di
          // `_buildBottomCta`). Backend adalah sumber kebenaran soal
          // year completed (butuh semua section + kuis year ini
          // selesai) — kalau true di sini, paksa ke Rangkuman walaupun
          // caller aslinya mau ke "Baca Materi Berikutnya".
          redirectToSummary = result?.yearCompleted ?? false;
        } catch (_) {
          // Sengaja diabaikan (silent): kegagalan completion tidak
          // seharusnya menghalangi user lanjut baca. Kalau mau observability,
          // ganti catch ini dengan logging (mis. Sentry) tanpa rethrow.
        }
      }
    }

    if (!mounted) return;
    setState(() => _navigating = false);

    if (redirectToSummary) {
      context.go('/year/$yearId/summary?era=$eraSlug');
      return;
    }

    navigate();
  }

  Widget _buildContent(BuildContext context, Section section) {
    final blocks = [...section.contentBlocks]
      ..sort((a, b) => a.order.compareTo(b.order));

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 120),
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: EraAccents.ofSlug(section.year.era.slug).withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                section.year.era.name.toUpperCase(),
                style: TextStyle(
                  color: EraAccents.ofSlug(section.year.era.slug),
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              '${section.year.year}',
              style: TextStyle(
                color: EraAccents.ofSlug(section.year.era.slug),
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        // (Revisi) Judul section TIDAK LAGI dirender di sini — posisi
        // paling atas sekarang header gambar (opsional per section, bisa
        // null). Kalau null, langsung lanjut ke blok konten pertama tanpa
        // header apa pun (bukan fallback ke judul teks).
        if (section.headerImageUrl != null &&
            section.headerImageUrl!.trim().isNotEmpty) ...[
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: CachedNetworkImage(
              imageUrl: section.headerImageUrl!,
              fit: BoxFit.cover,
              width: double.infinity,
              placeholder: (context, url) => const AspectRatio(
                aspectRatio: 16 / 9,
                child: Center(child: CircularProgressIndicator()),
              ),
              errorWidget: (context, url, error) => const AspectRatio(
                aspectRatio: 16 / 9,
                child: Center(child: Icon(Icons.broken_image_outlined)),
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],
        for (final block in blocks) ContentBlockView(block: block),
        const SizedBox(height: 24),
      ],
    );
  }

  /// CTA bawah — **selalu** dirender begitu section termuat, terlepas
  /// dari status completed atau posisi scroll. Selagi data `year` (buat
  /// nentuin section berikutnya) masih loading, tombol tetap tampil tapi
  /// disabled + spinner kecil, supaya posisinya konsisten dan tidak
  /// kedip/hilang-muncul seperti versi lama.
  Widget _buildBottomCta(BuildContext context, Section section) {
    final yearAsync = ref.watch(
      yearInEraProvider((eraSlug: section.year.era.slug, yearId: section.year.id)),
    );

    return yearAsync.when(
      data: (year) {
        final completed = _isThisSectionCompleted(year);

        if (year == null) {
          return const _CtaButton(
            label: 'Lanjut',
            icon: Icons.arrow_forward,
            loading: true,
            onTap: null,
          );
        }

        final ordered = _orderedSections(year);
        final currentIndex = ordered.indexWhere((s) => s.id == _id);
        final isLastSection =
            currentIndex == -1 || currentIndex == ordered.length - 1;

        final eraSlug = section.year.era.slug;
        final yearId = section.year.id;

        if (isLastSection) {
          return _CtaButton(
            label: 'Lihat Rangkuman',
            icon: Icons.menu_book_outlined,
            loading: _navigating,
            onTap: () => _handleCtaTap(
              alreadyCompleted: completed,
              yearId: yearId,
              eraSlug: eraSlug,
              navigate: () => context.go('/year/$yearId/summary?era=$eraSlug'),
            ),
          );
        }

        final next = ordered[currentIndex + 1];
        return _CtaButton(
          label: 'Baca Materi Berikutnya',
          icon: Icons.arrow_forward,
          loading: _navigating,
          onTap: () => _handleCtaTap(
            alreadyCompleted: completed,
            yearId: yearId,
            eraSlug: eraSlug,
            navigate: () => context.go('/section/${next.id}'),
          ),
        );
      },
      // Belum siap / gagal muat data year — tombol tetap tampil (disabled)
      // alih-alih hilang total, supaya layout tidak "lompat".
      loading: () => const _CtaButton(
        label: 'Lanjut',
        icon: Icons.arrow_forward,
        loading: true,
        onTap: null,
      ),
      error: (_, __) => _CtaButton(
        label: 'Coba Lagi',
        icon: Icons.refresh,
        loading: false,
        onTap: () => ref.invalidate(
          yearInEraProvider((eraSlug: section.year.era.slug, yearId: section.year.id)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final sectionAsync = ref.watch(sectionDetailProvider(_id));

    return Scaffold(
      appBar: AppBar(title: Text(sectionAsync.valueOrNull?.title ?? 'Memuat...')),
      body: sectionAsync.when(
        data: (section) => Stack(
          children: [
            _buildContent(context, section),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: SafeArea(
                top: false,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: _buildBottomCta(context, section),
                ),
              ),
            ),
          ],
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        // 404 (section draft/belum publish, R-CMS-01) juga bakal muncul
        // di sini sebagai pesan error generik lewat ApiException.message.
        error: (error, _) => Center(child: Text('Gagal memuat section: $error')),
      ),
    );
  }
}

class _CtaButton extends StatelessWidget {
  const _CtaButton({
    required this.label,
    required this.icon,
    required this.onTap,
    this.loading = false,
  });

  final String label;
  final IconData icon;
  final VoidCallback? onTap;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    final disabled = loading || onTap == null;

    return SizedBox(
      width: double.infinity,
      child: FilledButton(
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.ink,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
        ),
        onPressed: disabled ? null : onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
            const SizedBox(width: 8),
            if (loading)
              const SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white70),
              )
            else
              Icon(icon, size: 18),
          ],
        ),
      ),
    );
  }
}