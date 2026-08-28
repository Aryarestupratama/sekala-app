import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../../../core/router/auth_state.dart';
import '../../../../shared/models/section.dart';
import '../../../auth/presentation/providers/auth_providers.dart';
import '../providers/history_providers.dart';
import '../widgets/content_block_view.dart';

/// GET /api/public/sections/{section} — INFO-02, plus deteksi
/// scroll-to-bottom (INFO-03, R-PROG-02) & tombol "Mulai Kuis"
/// (INFO-04, R-QUIZ-01).
///
/// CATATAN: backend nggak expose status "sudah completed" balik ke
/// client (lihat Section model) — jadi status itu dilacak lokal per sesi
/// lewat sectionJustCompletedProvider, bukan dari field API.
class SectionDetailScreen extends ConsumerStatefulWidget {
  const SectionDetailScreen({super.key, required this.sectionId});

  final String sectionId;

  @override
  ConsumerState<SectionDetailScreen> createState() =>
      _SectionDetailScreenState();
}

class _SectionDetailScreenState extends ConsumerState<SectionDetailScreen> {
  bool _completionTriggered = false;

  int get _id => int.parse(widget.sectionId);

  void _handleBottomVisible(VisibilityInfo info) {
    if (_completionTriggered) return;
    if (info.visibleFraction < 0.9) return;
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
    final section = ref.read(sectionDetailProvider(_id)).valueOrNull;
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

    // Design.md §3.3 poin 4: notifikasi ringan "Card baru terbuka!" kalau
    // section ini punya tokoh terkait. Disederhanakan jadi SnackBar
    // (bukan animasi/popup) sesuai opsi yang disebut di dokumen itu sendiri.
    final message = (section != null && section.figures.isNotEmpty)
        ? 'Selesai dibaca! Card tokoh baru terbuka 🎉'
        : 'Selesai dibaca!';
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  Widget _buildContent(BuildContext context, Section section) {
    final blocks = [...section.contentBlocks]
      ..sort((a, b) => a.order.compareTo(b.order));

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(section.title, style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: 4),
        Text(
          '${section.year.year} — ${section.year.era.name}',
          style: Theme.of(context).textTheme.bodySmall,
        ),
        const SizedBox(height: 16),
        for (final block in blocks) ContentBlockView(block: block),
        const SizedBox(height: 24),
        // Marker tak-kelihatan di paling bawah konten — dipakai buat
        // deteksi "user sudah scroll sampai akhir" (INFO-03). Diletakkan
        // SETELAH semua block (termasuk summary yang R-CMS-03 pastikan
        // selalu di urutan terakhir), jadi baru trigger kalau summary-nya
        // juga udah kebaca.
        VisibilityDetector(
          key: ValueKey('section-bottom-marker-$_id'),
          onVisibilityChanged: _handleBottomVisible,
          child: const SizedBox(height: 1),
        ),
        const SizedBox(height: 24),
      ],
    );
  }

  Widget? _buildQuizButton(Section section, bool justCompleted) {
    // R-QUIZ-01: tombol aktif hanya kalau section sudah completed (di
    // sesi ini) DAN quiz_link terisi (R-CMS-07).
    final quizLink = section.quizLink;
    if (quizLink == null || quizLink.isEmpty) return null;
    if (!justCompleted) return null;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: FilledButton.icon(
          onPressed: () => launchUrl(
            Uri.parse(quizLink),
            mode: LaunchMode.externalApplication,
          ),
          icon: const Icon(Icons.quiz_outlined),
          label: const Text('Mulai Kuis'),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final sectionAsync = ref.watch(sectionDetailProvider(_id));
    final justCompleted = ref.watch(sectionJustCompletedProvider(_id));

    return Scaffold(
      appBar: AppBar(title: Text(sectionAsync.valueOrNull?.title ?? 'Memuat...')),
      body: sectionAsync.when(
        data: (section) => _buildContent(context, section),
        loading: () => const Center(child: CircularProgressIndicator()),
        // 404 (section draft/belum publish, R-CMS-01) juga bakal muncul
        // di sini sebagai pesan error generik lewat ApiException.message.
        error: (error, _) => Center(child: Text('Gagal memuat section: $error')),
      ),
      bottomNavigationBar: sectionAsync.maybeWhen(
        data: (section) => _buildQuizButton(section, justCompleted),
        orElse: () => null,
      ),
    );
  }
}
