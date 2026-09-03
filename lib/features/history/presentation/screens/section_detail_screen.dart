import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../../../core/router/auth_state.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/models/section.dart';
import '../../../../shared/models/section_summary.dart';
import '../../../../shared/models/year.dart';
import '../../../auth/presentation/providers/auth_providers.dart';
import '../providers/history_providers.dart';
import '../widgets/content_block_view.dart';

/// GET /api/public/sections/{section} — INFO-02, plus deteksi
/// scroll-to-bottom (INFO-03, R-PROG-02).
///
/// REDESIGN (flow linear tanpa sheet, menggantikan versi sebelumnya):
/// setelah section ini completed, CTA di bawah berubah otomatis jadi
/// "Baca Materi Berikutnya" (kalau masih ada section lain di year yang
/// sama) atau "Lihat Rangkuman" (kalau ini section terakhir) — dihitung
/// dari `Year.sections` (cache `yearInEraProvider`, lihat
/// history_providers.dart), BUKAN dari sheet/menu terpisah. Rangkuman &
/// kuis SENGAJA tidak lagi nyempil di layar ini (sudah naik level ke
/// `year`, Architecture.md §4.2/§4.8) — begitu juga banner
/// vaksin/tokoh, yang cuma relevan setelah status "year completed"
/// tercapai (R-VAC-01), bukan per-section.
class SectionDetailScreen extends ConsumerStatefulWidget {
  const SectionDetailScreen({super.key, required this.sectionId});

  final String sectionId;

  @override
  ConsumerState<SectionDetailScreen> createState() =>
      _SectionDetailScreenState();
}

class _SectionDetailScreenState extends ConsumerState<SectionDetailScreen> {
  bool _completionTriggered = false;
  final ScrollController _scrollController = ScrollController();

  int get _id => int.parse(widget.sectionId);

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  /// Fallback untuk section pendek (Bug 1): kalau kontennya sendiri sudah
  /// muat penuh di viewport (nggak ada apa pun buat di-scroll), marker
  /// `VisibilityDetector` di bawah konten kadang nggak sempat ke-scan
  /// tepat waktu oleh periodic check-nya. Dicek sekali setelah frame
  /// pertama section ini selesai di-render — kalau memang tidak ada
  /// scroll extent sama sekali, langsung anggap "selesai baca" tanpa
  /// nunggu event visibility.
  void _checkShortContentFallback() {
    if (_completionTriggered) return;
    if (!_scrollController.hasClients) return;
    if (_scrollController.position.maxScrollExtent > 0) return;
    _attemptCompletion();
  }

  void _handleBottomVisible(VisibilityInfo info) {
    if (info.visibleFraction < 0.9) return;
    _attemptCompletion();
  }

  void _attemptCompletion() {
    if (_completionTriggered) return;
    if (ref.read(sectionJustCompletedProvider(_id))) return; // sudah sesi ini

    // R-PROG-02: hanya login TERVERIFIKASI yang progress-nya dicatat.
    // Guest & user belum verifikasi tetap bisa baca sampai sini, cuma
    // nggak trigger completion (diam-diam, tanpa error mengganggu baca).
    final authStatus = ref.read(authNotifierProvider).status;
    if (authStatus != AuthStatus.authenticated) return;

    final user = ref.read(currentUserProvider).valueOrNull;
    if (user == null || !user.isEmailVerified) return;

    setState(() => _completionTriggered = true);
    _triggerCompletion();
  }

  Future<void> _triggerCompletion() async {
    final success = await ref
        .read(sectionCompletionControllerProvider.notifier)
        .complete(_id);
    if (!mounted) return;

    if (!success) {
      // Gagal (mis. hiccup jaringan) — izinkan retry kalau marker
      // kelihatan lagi, daripada user macet nggak pernah tercatat.
      setState(() => _completionTriggered = false);
      return;
    }
    // CTA di bawah otomatis berubah sendiri (watch yearInEraProvider yang
    // ter-invalidate dari controller) — tidak perlu snackbar manual lagi.
  }

  /// Urutkan `sections` berdasarkan `order` — jangan asumsikan array dari
  /// API sudah terurut.
  List<SectionSummary> _orderedSections(Year year) {
    final sections = [...year.sections];
    sections.sort((a, b) => a.order.compareTo(b.order));
    return sections;
  }

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

  Widget _buildContent(BuildContext context, Section section) {
    final blocks = [...section.contentBlocks]
      ..sort((a, b) => a.order.compareTo(b.order));

    // Dijadwalkan tiap build content selesai (harmless kalau dipanggil
    // berkali-kali — dijaga `_completionTriggered` di dalamnya): begitu
    // frame pertama section ini kelar layout, cek apakah kontennya
    // sependek itu sampai tidak ada scroll extent sama sekali.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      _checkShortContentFallback();
    });

    return ListView(
      controller: _scrollController,
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
        Text(section.title, style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: 16),
        for (final block in blocks) ContentBlockView(block: block),
        const SizedBox(height: 24),
        // Marker tak-kelihatan di paling bawah konten — dipakai buat
        // deteksi "user sudah scroll sampai akhir" (INFO-03).
        VisibilityDetector(
          key: ValueKey('section-bottom-marker-$_id'),
          onVisibilityChanged: _handleBottomVisible,
          child: const SizedBox(height: 1),
        ),
      ],
    );
  }

  /// CTA bawah — satu-satunya tempat navigasi "lanjut" dari section ini.
  /// Sengaja return `SizedBox.shrink()` (tidak render apa-apa) kalau
  /// section belum completed atau data year belum siap, supaya user tidak
  /// diberi tombol yang mengarah ke tempat yang belum semestinya.
  Widget _buildBottomCta(BuildContext context, Section section) {
    final yearAsync = ref.watch(
      yearInEraProvider((eraSlug: section.year.era.slug, yearId: section.year.id)),
    );

    return yearAsync.when(
      data: (year) {
        final completed = _isThisSectionCompleted(year);
        if (!completed || year == null) return const SizedBox.shrink();

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
            onTap: () => context.go('/year/$yearId/summary?era=$eraSlug'),
          );
        }

        final next = ordered[currentIndex + 1];
        return _CtaButton(
          label: 'Baca Materi Berikutnya',
          icon: Icons.arrow_forward,
          onTap: () => context.go('/section/${next.id}'),
        );
      },
      // Belum siap / gagal muat data year — jangan blok baca section,
      // cukup sembunyikan CTA (bisa dicoba lagi begitu provider retry).
      loading: () => const SizedBox.shrink(),
      error: (_, __) => const SizedBox.shrink(),
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
  const _CtaButton({required this.label, required this.icon, required this.onTap});

  final String label;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: FilledButton(
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.ink,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
        ),
        onPressed: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
            const SizedBox(width: 8),
            Icon(icon, size: 18),
          ],
        ),
      ),
    );
  }
}