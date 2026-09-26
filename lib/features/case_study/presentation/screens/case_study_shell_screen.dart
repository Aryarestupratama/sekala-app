import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/models/case_study_badge.dart';
import '../../../../shared/models/case_study_detail.dart';
import '../../../../shared/models/case_study_submit_result.dart';
import '../../../../shared/models/era.dart';
import '../../../../shared/models/year.dart';
import '../../../history/presentation/providers/history_providers.dart';
import '../providers/case_study_providers.dart';
import '../widgets/case_study_common.dart';
import 'case_study_badge_view.dart';
import 'case_study_briefing_view.dart';
import 'case_study_decision_view.dart';
import 'case_study_opening_view.dart';

enum _Stage { opening, briefing, decision, badge }

/// Shell Studi Kasus — route top-level `/section/:sectionId/case-study`
/// (lihat `app_router.dart`). Menyambungkan
/// `caseStudyDetailProvider`/`caseStudyControllerProvider` (data) dengan
/// 4 view presentasi murni (Opening/Briefing/Decision/Badge). Perpindahan
/// antar layar TIDAK memakai push/pop route baru — hanya ganti `_stage`
/// di state lokal — supaya data yang sudah di-fetch & draft pengerjaan
/// (di dalam `CaseStudyDecisionView`) tidak ikut hilang/reset saat user
/// maju-mundur.
///
/// [yearId]/[eraSlug] dioper via query string oleh pemanggil
/// (`SectionDetailScreen`, lihat redirect & CTA "Mulai Studi Kasus" di
/// sana) — dipakai untuk 2 hal:
/// 1. Mengambil `Year.title` lewat `yearInEraProvider` untuk kalimat
///    template Opening/Badge (`CaseStudyTexts`) — SENGAJA tidak menerima
///    `wabahName` langsung sebagai parameter, karena `SectionYear` (nested
///    di `Section`) belum tentu membawa `title`, sedangkan `Year` penuh
///    dari roadmap (dipakai `YearNode`) sudah pasti punya.
/// 2. Menghitung section sesudah studi kasus ini (order 9+) untuk tombol
///    "Lanjut ke materi berikutnya" di Badge — LOGIKA SAMA dengan
///    `_orderedSections`/`isLastSection` di `SectionDetailScreen`
///    (sengaja diduplikasi kecil di sini, bukan diekstrak, supaya kedua
///    layar tetap independen).
///
/// KEPUTUSAN "buka ulang yang sudah completed" (opsi B, progress.md
/// "Detail yang masih terbuka"): kalau `completed == true` DAN
/// `detail.badge != null`, shell membuka LANGSUNG ke layar Badge (dengan
/// tombol tambahan "Kerjakan ulang studi kasus" yang TIDAK memberi badge
/// baru). Kalau belum completed, atau completed tapi backend BELUM
/// mengirim `badge` di `show()` (lihat catatan `CaseStudyDetail.badge`),
/// fallback ke Opening seperti pengerjaan pertama kali.
///
/// PENTING — DEPENDENSI BACKEND YANG BELUM ADA:
/// `CaseStudyController::show()` SAAT INI tidak pernah mengisi field
/// `badge` (selalu null). Sampai itu ditambahkan, jalur "completed" di
/// sini otomatis jatuh ke fallback Opening — shell sudah siap, tinggal
/// backend menyusul, TIDAK perlu ubah shell lagi nanti.
class CaseStudyShellScreen extends ConsumerStatefulWidget {
  const CaseStudyShellScreen({
    super.key,
    required this.sectionId,
    required this.yearId,
    required this.eraSlug,
  });

  final int sectionId;
  final int yearId;
  final String eraSlug;

  @override
  ConsumerState<CaseStudyShellScreen> createState() =>
      _CaseStudyShellScreenState();
}

class _CaseStudyShellScreenState extends ConsumerState<CaseStudyShellScreen> {
  _Stage? _stage;

  /// Data badge yang lagi ditampilkan di layar Badge — bisa dari
  /// `detail.badge` (jalur "sudah completed") ATAU dari hasil submit yang
  /// baru saja benar. Disimpan terpisah dari provider supaya layar Badge
  /// tidak hilang kalau provider di-invalidate dari luar.
  CaseStudyBadge? _activeBadge;
  String _activeDescription = '';

  void _initStageFrom(CaseStudyDetail detail) {
    if (_stage != null) return; // hanya sekali, saat data pertama datang.

    final badge = detail.badge;
    if (detail.completed && badge != null) {
      _stage = _Stage.badge;
      _activeBadge = badge;
      _activeDescription = badge.description?.trim() ?? '';
    } else {
      _stage = _Stage.opening;
    }
  }

  Future<CaseStudySubmitResult?> _submit(
    List<int> slotOptionIds,
    String reason,
  ) {
    return ref.read(caseStudyControllerProvider.notifier).submit(
          sectionId: widget.sectionId,
          slotOptionIds: slotOptionIds,
          reason: reason,
          eraSlug: widget.eraSlug,
        );
  }

  void _onCorrect(CaseStudySubmitResult result) {
    final badgeDescription = result.badge?.description?.trim();
    setState(() {
      _activeBadge = result.badge;
      // Fallback: kalau admin tidak mengisi deskripsi badge, pakai
      // feedback_correct tingkat kasus supaya layar Badge tidak kosong.
      _activeDescription =
          (badgeDescription != null && badgeDescription.isNotEmpty)
              ? badgeDescription
              : result.feedback;
      _stage = _Stage.badge;
    });

    // Notifikasi terpisah dari layar Badge itu sendiri — badge per wabah,
    // border lintas-wabah, dan (nanti) vaksin adalah 3 reward berbeda,
    // jangan dicampur jadi satu tampilan. postFrameCallback supaya
    // SnackBar muncul SETELAH CaseStudyBadgeView ter-render (setState di
    // atas baru dijadwalkan, belum tentu context masih attach ke tree yang
    // sama kalau ditampilkan sinkron di sini).
    //
    // `badgeNewlyUnlocked` (dari `UserProgress::wasRecentlyCreated` sisi
    // backend) membedakan "baru pertama kali dapat badge ini" dari
    // "retake yang kebetulan benar lagi" — retake TIDAK menampilkan
    // notifikasi lagi (badge-nya memang sudah lama didapat, cuma layar
    // Badge yang ditampilkan ulang sebagai konfirmasi visual).
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      if (result.badgeNewlyUnlocked) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: AppColors.gamify,
            content: Row(
              children: [
                const Icon(Icons.military_tech_rounded,
                    color: Colors.white, size: 20),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Badge "${result.badge?.name ?? ''}" berhasil didapat! Lihat di Koleksi Badge.',
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
            duration: const Duration(seconds: 4),
          ),
        );
      }

      if (result.borderUnlocked) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: AppColors.gamify,
            content: Row(
              children: [
                Icon(Icons.auto_awesome_rounded, color: Colors.white, size: 20),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Border SEKALA terbuka! Pasang di foto profilmu.',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
            duration: Duration(seconds: 4),
          ),
        );
      }
    });
  }

  /// "Kerjakan ulang studi kasus" dari layar Badge (jalur sudah completed)
  /// — balik ke Opening, TANPA refetch (opsi masih sama, dari cache
  /// `caseStudyDetailProvider`, lihat catatan di sana kenapa tidak
  /// di-invalidate).
  void _retryFromBadge() {
    setState(() {
      _stage = _Stage.opening;
      _activeBadge = null;
      _activeDescription = '';
    });
  }

  /// Keluar dari Studi Kasus -> roadmap era ini. Studi kasus tidak
  /// mem-punyai "section sebelumnya" untuk di-back (section sebelumnya
  /// sudah completed begitu CTA-nya dipakai untuk masuk ke sini).
  void _goBack() {
    if (widget.eraSlug.isEmpty) {
      if (context.canPop()) context.pop();
      return;
    }
    context.go('/history/${widget.eraSlug}');
  }

  /// Lanjut ke section sesudah studi kasus (order 9+), atau ke Rangkuman
  /// Wabah kalau studi kasus ini kebetulan section terakhir di year-nya.
  void _goNext(Year? year) {
    if (year == null) {
      _goBack();
      return;
    }
    final ordered = [...year.sections]
      ..sort((a, b) => a.order.compareTo(b.order));
    final idx = ordered.indexWhere((s) => s.id == widget.sectionId);
    if (idx == -1 || idx == ordered.length - 1) {
      context.go('/year/${widget.yearId}/summary?era=${widget.eraSlug}');
      return;
    }
    context.go('/section/${ordered[idx + 1].id}');
  }

  @override
  Widget build(BuildContext context) {
    final detailAsync = ref.watch(caseStudyDetailProvider(widget.sectionId));
    final yearAsync = ref.watch(
      yearInEraProvider((eraSlug: widget.eraSlug, yearId: widget.yearId)),
    );

    // Warna era tersedia dari widget.eraSlug sejak awal (tidak menunggu
    // detail/year selesai fetch) — dipakai semua stage & scaffold
    // error/loading di bawah, menggantikan oren hardcode yang sebelumnya
    // sama di semua era.
    final accent = EraAccents.ofSlug(widget.eraSlug);

    if (detailAsync.hasError) {
      return _CaseStudyErrorScaffold(
        error: detailAsync.error!,
        onRetry: () =>
            ref.invalidate(caseStudyDetailProvider(widget.sectionId)),
        onBack: _goBack,
        accent: accent,
      );
    }
    if (!detailAsync.hasValue) {
      return _CaseStudyLoadingScaffold(accent: accent);
    }

    final detail = detailAsync.value!;
    _initStageFrom(detail);

    // Nama wabah dari Year.title (bukan SectionYear, lihat docstring
    // class). Kalau belum siap, fallback string kosong ('Wabah' sudah
    // ditangani `CaseStudyTexts`) — TIDAK memblokir Opening/Briefing
    // dengan spinner tambahan, karena keduanya tidak butuh info navigasi.
    final year = yearAsync.valueOrNull;
    final wabahName = year?.title ?? '';

    return _buildStage(detail, wabahName, year, accent);
  }

  Widget _buildStage(CaseStudyDetail detail, String wabahName, Year? year, Color accent) {
    switch (_stage!) {
      case _Stage.opening:
        return CaseStudyOpeningView(
          wabahName: wabahName,
          onStart: () => setState(() => _stage = _Stage.briefing),
          onBack: _goBack,
          accent: accent,
        );

      case _Stage.briefing:
        return CaseStudyBriefingView(
          title: detail.caseStudy.title,
          description: detail.caseStudy.description,
          challengeText: detail.caseStudy.challengeText,
          onNext: () => setState(() => _stage = _Stage.decision),
          onBack: () => setState(() => _stage = _Stage.opening),
          accent: accent,
        );

      case _Stage.decision:
        return CaseStudyDecisionView(
          wabahName: wabahName,
          options: detail.options,
          reasonDescription: detail.caseStudy.reasonDescription,
          onSubmit: _submit,
          onCorrect: _onCorrect,
          onBack: () => setState(() => _stage = _Stage.briefing),
          accent: accent,
        );

      case _Stage.badge:
        final badge = _activeBadge;
        // Jaring pengaman: seharusnya tidak pernah null di stage ini
        // (diisi di `_initStageFrom`/`_onCorrect` sebelum pindah ke sini).
        if (badge == null) {
          return _CaseStudyErrorScaffold(
            error: StateError('Data badge tidak tersedia'),
            onRetry: () => setState(() => _stage = _Stage.opening),
            onBack: _goBack,
            accent: accent,
          );
        }
        return CaseStudyBadgeView(
          wabahName: wabahName,
          badge: badge,
          description: _activeDescription,
          onNext: () => _goNext(year),
          accent: accent,
          // Tombol "Kerjakan ulang" HANYA muncul kalau memang masuk lewat
          // jalur "sudah completed" (detail.completed true) — bukan
          // momen baru saja submit benar pertama kali.
          onRetry: detail.completed ? _retryFromBadge : null,
        );
    }
  }
}

class _CaseStudyLoadingScaffold extends StatelessWidget {
  const _CaseStudyLoadingScaffold({this.accent});

  final Color? accent;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(child: CircularProgressIndicator(color: accent)),
    );
  }
}

/// Sama pola dengan error di `SectionDetailScreen`
/// ("Gagal memuat section: $error") — pesan generik dari `ApiException`,
/// plus tombol back & coba lagi (yang tidak dipunyai layar section biasa,
/// karena studi kasus adalah route sendiri, bukan tab di dalam shell nav).
class _CaseStudyErrorScaffold extends StatelessWidget {
  const _CaseStudyErrorScaffold({
    required this.error,
    required this.onRetry,
    required this.onBack,
    required this.accent,
  });

  final Object error;
  final VoidCallback onRetry;
  final VoidCallback onBack;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
              kCaseStudyHPad, 12, kCaseStudyHPad, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: CaseStudyBackButton(onTap: onBack),
              ),
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.error_outline_rounded,
                        size: 40,
                        color: AppColors.textSecondary,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Gagal memuat studi kasus: $error',
                        textAlign: TextAlign.center,
                        style: AppTextStyles.bodySecondary,
                      ),
                      const SizedBox(height: 20),
                      CaseStudyPrimaryButton(
                        label: 'Coba lagi',
                        icon: Icons.refresh_rounded,
                        color: accent,
                        onTap: onRetry,
                      ),
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