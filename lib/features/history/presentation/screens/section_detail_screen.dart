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
import '../widgets/slide_to_confirm.dart';

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
/// (`section.headerImageUrl`, opsional per section, bisa null). AppBar
/// juga tidak lagi menampilkan `section.title` (hanya tombol back).
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
///
/// BARU (R-CASE, Studi Kasus): section bertipe `case_study` TIDAK punya
/// `content_blocks` untuk dirender di layar ini sama sekali — kalau
/// terbuka di sini (lewat deep link Home, tap tahun di roadmap, atau
/// balik browser ke section 8), layar ini SEGERA redirect ke
/// `CaseStudyShellScreen` (`/section/:id/case-study`) begitu data section
/// selesai di-fetch, lihat `_redirectToCaseStudyIfNeeded`. Section
/// SEBELUM studi kasus (biasanya section 7) juga diberi CTA khusus
/// "Mulai Studi Kasus" kalau section BERIKUTNYA bertipe `case_study` —
/// lihat percabangan `next.isCaseStudy` di `_buildBottomCta`.
class SectionDetailScreen extends ConsumerStatefulWidget {
  const SectionDetailScreen({super.key, required this.sectionId});

  final String sectionId;

  @override
  ConsumerState<SectionDetailScreen> createState() =>
      _SectionDetailScreenState();
}

class _SectionDetailScreenState extends ConsumerState<SectionDetailScreen> {
  bool _navigating = false;

  // Guard supaya `context.go` ke Studi Kasus cuma dipanggil sekali per
  // instance layar ini, meskipun `sectionAsync` rebuild beberapa kali
  // (mis. saat provider lain ikut trigger rebuild) sebelum navigasi
  // benar-benar berpindah keluar dari layar ini.
  bool _redirectedToCaseStudy = false;

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

  /// Section bertipe `case_study` (mis. section 8) tidak punya konten
  /// untuk dirender di layar ini — redirect otomatis ke shell Studi Kasus
  /// begitu data section ini datang. `addPostFrameCallback` dipakai
  /// supaya navigasi tidak terjadi di tengah `build()` (side effect saat
  /// build memicu warning/undefined behavior di Flutter).
  void _redirectToCaseStudyIfNeeded(Section section) {
    if (!section.isCaseStudy || _redirectedToCaseStudy) return;
    _redirectedToCaseStudy = true;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      context.go(
        '/section/$_id/case-study'
        '?era=${section.year.era.slug}&year=${section.year.id}',
      );
    });
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
  /// bilang year-nya sudah completed di titik ini. Dipakai juga untuk CTA
  /// "Mulai Studi Kasus" (section berikutnya `case_study`) — completion
  /// section SAAT INI tetap ditandai seperti biasa sebelum masuk studi
  /// kasus, `navigate` yang beda tujuannya saja.
  Future<void> _handleCtaTap({
    required bool alreadyCompleted,
    required int yearId,
    required String eraSlug,
    required VoidCallback navigate,
  }) async {
    if (_navigating) return;
    setState(() => _navigating = true);

    var redirectToSummary = false;
    var saveFailed = false;

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
          // Kegagalan completion tetap TIDAK menghentikan navigasi (user
          // tidak macet), tapi sekarang user diberi tahu -- dulu diam-diam,
          // sehingga bagian berikutnya bisa terkunci tanpa penjelasan.
          // Kalau mau observability, tambahkan logging (mis. Sentry) di sini.
          saveFailed = true;
        }
      }
    }

    if (!mounted) return;
    setState(() => _navigating = false);

    if (saveFailed) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Progres bagian ini belum tersimpan. Periksa koneksi internetmu.',
          ),
        ),
      );
    }

    if (redirectToSummary) {
      context.go('/year/$yearId/summary?era=$eraSlug');
      return;
    }

    navigate();
  }

  /// Kembali ke roadmap era. Antar-section memakai `context.go`, jadi
  /// tumpukan navigasi tidak bisa diandalkan untuk `pop()`.
  void _goBack(String? eraSlug) {
    if (eraSlug != null) {
      context.go('/history/$eraSlug');
    } else if (context.canPop()) {
      context.pop();
    } else {
      context.go('/history');
    }
  }

  /// "Materi 3 dari 9" + bar tipis. Judul section tidak dirender lagi
  /// (keputusan desain), jadi user butuh penanda posisi & sisa materi.
  Widget _buildPosition(Section section) {
    final year = ref
        .watch(yearInEraProvider((eraSlug: section.year.era.slug, yearId: section.year.id)))
        .valueOrNull;
    if (year == null) return const SizedBox.shrink();

    final ordered = _orderedSections(year);
    final index = ordered.indexWhere((s) => s.id == _id);
    if (index == -1) return const SizedBox.shrink();

    final accent = EraAccents.ofSlug(section.year.era.slug);
    final barColor = Color.lerp(accent, AppColors.ink, 0.45)!;

    return Padding(
      padding: const EdgeInsets.only(top: 4, bottom: 12),
      child: Semantics(
        label: 'Materi ${index + 1} dari ${ordered.length}',
        excludeSemantics: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Materi ${index + 1} dari ${ordered.length}',
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 6),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: (index + 1) / ordered.length,
                minHeight: 6,
                backgroundColor: AppColors.border,
                valueColor: AlwaysStoppedAnimation(barColor),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Progres hanya tersimpan untuk user login + email terverifikasi
  /// (R-AUTH-03). Tanpa catatan ini, tamu / user belum verifikasi membaca
  /// satu tahun penuh tanpa tahu tidak ada yang tercatat.
  Widget _buildProgressNotice() {
    final authStatus = ref.watch(authNotifierProvider).status;
    final user = ref.watch(currentUserProvider).valueOrNull;

    String? message;
    if (authStatus == AuthStatus.guest) {
      message = 'Kamu membaca sebagai tamu, jadi progres tidak tersimpan. '
          'Masuk atau daftar untuk menyimpannya.';
    } else if (authStatus == AuthStatus.authenticated &&
        user != null &&
        !user.isEmailVerified) {
      message = 'Email kamu belum diverifikasi, jadi progres bacaan belum '
          'tersimpan. Buka email verifikasi dari kami (cek juga folder spam), '
          'atau kirim ulang dari tab Profil.';
    }
    if (message == null) return const SizedBox.shrink();

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF6E5),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE6B450)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.info_outline_rounded, size: 20, color: AppColors.ink),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(fontSize: 14, height: 1.35, color: AppColors.ink),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context, Section section) {
    final blocks = [...section.contentBlocks]
      ..sort((a, b) => a.order.compareTo(b.order));

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 150),
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: EraAccents.ofSlug(section.year.era.slug),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                section.year.era.name,
                style: const TextStyle(
                  color: AppColors.ink,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              '${section.year.year}',
              style: const TextStyle(
                color: AppColors.ink,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        _buildPosition(section),
        _buildProgressNotice(),
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
            slideLabel: 'Geser untuk rangkuman',
            accent: EraAccents.ofSlug(section.year.era.slug),
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

        // BARU (R-CASE): section berikutnya adalah Studi Kasus — CTA beda
        // label/ikon & tujuan navigasi, tapi completion section SAAT INI
        // tetap ditandai seperti biasa lewat `_handleCtaTap` yang sama.
        if (next.isCaseStudy) {
          return _CtaButton(
            label: 'Mulai Studi Kasus',
            slideLabel: 'Geser untuk studi kasus',
            accent: EraAccents.ofSlug(section.year.era.slug),
            icon: Icons.psychology_alt_outlined,
            loading: _navigating,
            onTap: () => _handleCtaTap(
              alreadyCompleted: completed,
              yearId: yearId,
              eraSlug: eraSlug,
              navigate: () => context.go(
                '/section/${next.id}/case-study?era=$eraSlug&year=$yearId',
              ),
            ),
          );
        }

        return _CtaButton(
          label: 'Baca Materi Berikutnya',
          slideLabel: 'Geser untuk lanjut baca',
          accent: EraAccents.ofSlug(section.year.era.slug),
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
      appBar: AppBar(
        leading: IconButton(
          tooltip: 'Kembali',
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => _goBack(sectionAsync.valueOrNull?.year.era.slug),
        ),
      ),
      body: sectionAsync.when(
        data: (section) {
          if (section.isCaseStudy) {
            _redirectToCaseStudyIfNeeded(section);
            // Layar sementara sampai redirect di atas berpindah keluar
            // dari route ini — section case_study tidak punya konten
            // untuk dirender di sini sama sekali.
            return const Center(child: CircularProgressIndicator());
          }

          return Stack(
            children: [
              _buildContent(context, section),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Theme.of(context).scaffoldBackgroundColor.withValues(alpha: 0),
                        Theme.of(context).scaffoldBackgroundColor,
                      ],
                      stops: const [0, 0.4],
                    ),
                  ),
                  child: SafeArea(
                    top: false,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 28, 16, 16),
                      child: _buildBottomCta(context, section),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        // 404 (section draft/belum publish, R-CMS-01) juga bakal muncul
        // di sini sebagai pesan error generik lewat ApiException.message.
        error: (error, _) => _SectionLoadError(
          onRetry: () => ref.invalidate(sectionDetailProvider(_id)),
          onBack: () => _goBack(null),
        ),
      ),
    );
  }
}

/// CTA bawah section. Aksi "lanjut" berupa geser-untuk-lanjut
/// ([SlideToConfirm]) supaya tidak terpencet saat user scroll materi.
/// - [slideLabel] terisi -> mode geser.
/// - [onTap] null -> mode geser nonaktif (data belum siap; ukuran sama
///   sehingga layout tidak melompat).
/// - Selain itu (mis. "Coba Lagi") tetap tombol biasa: aksi aman & berulang
///   tidak perlu digeser.
class _CtaButton extends StatelessWidget {
  const _CtaButton({
    required this.label,
    required this.icon,
    required this.onTap,
    this.loading = false,
    this.slideLabel,
    this.accent,
  });

  final String label;
  final IconData icon;
  final VoidCallback? onTap;
  final bool loading;
  final String? slideLabel;
  final Color? accent;

  @override
  Widget build(BuildContext context) {
    if (slideLabel != null || onTap == null) {
      return SlideToConfirm(
        label: slideLabel ?? 'Geser untuk lanjut',
        onConfirm: onTap,
        loading: loading,
        accent: accent,
      );
    }

    final disabled = loading;

    return SizedBox(
      width: double.infinity,
      child: FilledButton(
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.ink,
          disabledBackgroundColor: AppColors.ink,
          disabledForegroundColor: Colors.white70,
          minimumSize: const Size.fromHeight(52),
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
        ),
        onPressed: disabled ? null : onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
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

/// Gagal memuat section. Penyebab umum: bagian ini masih terkunci karena
/// progres bagian sebelumnya belum tersimpan, atau koneksi terputus.
class _SectionLoadError extends StatelessWidget {
  const _SectionLoadError({required this.onRetry, required this.onBack});

  final VoidCallback onRetry;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.cloud_off_rounded, size: 40, color: AppColors.textSecondary),
            const SizedBox(height: 12),
            const Text(
              'Materi ini belum bisa dibuka',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 6),
            const Text(
              'Koneksimu mungkin terputus, atau bagian sebelumnya belum '
              'tersimpan sebagai selesai. Coba lagi, atau kembali ke roadmap.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, height: 1.4, color: AppColors.textSecondary),
            ),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: onRetry,
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.ink,
                minimumSize: const Size(160, 48),
                shape: const StadiumBorder(),
              ),
              child: const Text('Coba lagi', style: TextStyle(fontWeight: FontWeight.w700)),
            ),
            TextButton(
              onPressed: onBack,
              style: TextButton.styleFrom(
                foregroundColor: AppColors.ink,
                minimumSize: const Size(160, 48),
              ),
              child: const Text('Kembali', style: TextStyle(fontWeight: FontWeight.w700)),
            ),
          ],
        ),
      ),
    );
  }
}