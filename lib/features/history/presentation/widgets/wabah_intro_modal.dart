import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/models/wabah_intro.dart';
import '../providers/wabah_intro_providers.dart';

/// Tampilkan modal ini (bottom sheet) untuk konten "Apa itu Wabah".
/// Dipanggil dari 2 tempat:
/// 1. Otomatis sekali saat pertama kali tab Informasi Sejarah dibuka
///    (lihat catatan di era_list_screen.dart -- belum diwiring di sesi
///    ini, lihat TODO terpisah).
/// 2. Manual kapan saja lewat ikon info di header roadmap / banner era
///    (sudah diwiring di era_roadmap_screen.dart).
///
/// `markAsSeen` HANYA dipanggil di sini (bukan di pemanggil) supaya
/// perilakunya konsisten di mana pun modal ini dibuka dari.
Future<void> showWabahIntroModal(BuildContext context, WidgetRef ref) {
  // markAsSeen aman dipanggil berkali-kali (WabahIntroSeenNotifier sudah
  // guard `if (state) return`), jadi dibuka manual lewat ikon info pun
  // tidak masalah walau sebelumnya sudah pernah "seen".
  ref.read(wabahIntroSeenProvider.notifier).markAsSeen();

  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (context) => const _WabahIntroSheetContent(),
  );
}

class _WabahIntroSheetContent extends ConsumerWidget {
  const _WabahIntroSheetContent();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final introAsync = ref.watch(wabahIntroProvider);

    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
        child: introAsync.when(
          data: (intro) => _Content(intro: intro),
          loading: () => const SizedBox(
            height: 200,
            child: Center(child: CircularProgressIndicator()),
          ),
          // Kalau gagal fetch (mis. offline), modal tetap ditutup dengan
          // pesan singkat -- bukan blank/crash, tapi juga tidak ada
          // fallback konten karena memang tidak ada apa-apa untuk
          // ditampilkan tanpa data dari backend.
          error: (_, __) => const SizedBox(
            height: 120,
            child: Center(child: Text('Gagal memuat konten. Coba lagi nanti.')),
          ),
        ),
      ),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content({required this.intro});

  final WabahIntro? intro;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Center(
          child: Container(
            width: 40,
            height: 4,
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: AppColors.border,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ),
        const Text(
          'Apa itu Wabah?',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        if (intro?.imageUrl != null)
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              intro!.imageUrl!,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => const SizedBox.shrink(),
            ),
          ),
        if (intro?.caption != null && intro!.caption!.isNotEmpty) ...[
          const SizedBox(height: 12),
          Text(
            intro!.caption!,
            style: const TextStyle(fontSize: 14, color: AppColors.textSecondary, height: 1.5),
          ),
        ],
        const SizedBox(height: 20),
        SizedBox(
          width: double.infinity,
          child: FilledButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Mengerti'),
          ),
        ),
      ],
    );
  }
}