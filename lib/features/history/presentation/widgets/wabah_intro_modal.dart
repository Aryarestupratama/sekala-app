import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/models/wabah_intro.dart';
import '../../../../shared/widgets/rich_body_text.dart';
import '../providers/wabah_intro_providers.dart';

/// Tampilkan modal ini (bottom sheet) untuk konten "Apa itu Wabah".
/// Satu-satunya entry point (INTRO-02): ikon info di header roadmap era
/// (era_roadmap_screen.dart). Tidak ada auto-show maupun banner per-era,
/// dan tidak ada konsep "sudah lihat" untuk fitur ini.
///
/// REDESIGN: konten fade+slide masuk begitu data selesai loading, ikon
/// bertema di atas judul, dan skeleton berdenyut menggantikan spinner
/// polos saat loading — konsisten dengan pola di layar lain.
Future<void> showWabahIntroModal(BuildContext context, WidgetRef ref) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    constraints: BoxConstraints(
      maxHeight: MediaQuery.of(context).size.height * 0.85,
    ),
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
          loading: () => const _LoadingContent(),
          // Kalau gagal fetch (mis. offline), modal tetap ditutup dengan
          // pesan singkat -- bukan blank/crash, tapi juga tidak ada
          // fallback konten karena memang tidak ada apa-apa untuk
          // ditampilkan tanpa data dari backend.
          error: (_, __) => Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const _DragHandle(),
              const SizedBox(height: 4),
              const Text(
                'Penjelasan wabah belum bisa dimuat',
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
              SizedBox(
                height: 50,
                child: FilledButton(
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.ink,
                    shape: const StadiumBorder(),
                  ),
                  onPressed: () => ref.invalidate(wabahIntroProvider),
                  child: const Text('Coba lagi', style: TextStyle(fontWeight: FontWeight.w700)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DragHandle extends StatelessWidget {
  const _DragHandle();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 40,
        height: 4,
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: AppColors.border,
          borderRadius: BorderRadius.circular(2),
        ),
      ),
    );
  }
}

class _LoadingContent extends StatefulWidget {
  const _LoadingContent();

  @override
  State<_LoadingContent> createState() => _LoadingContentState();
}

class _LoadingContentState extends State<_LoadingContent> with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1000),
  )..repeat(reverse: true);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _skeletonBox({required double height, double? width}) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        return Container(
          height: height,
          width: width ?? double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
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

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const _DragHandle(),
        _skeletonBox(height: 24, width: 180),
        const SizedBox(height: 16),
        _skeletonBox(height: 16),
        const SizedBox(height: 8),
        _skeletonBox(height: 16),
        const SizedBox(height: 8),
        _skeletonBox(height: 16, width: 220),
        const SizedBox(height: 20),
        _skeletonBox(height: 48),
      ],
    );
  }
}

class _Content extends StatefulWidget {
  const _Content({required this.intro});

  final WabahIntro? intro;

  @override
  State<_Content> createState() => _ContentState();
}

class _ContentState extends State<_Content> with SingleTickerProviderStateMixin {
  late final AnimationController _entrance = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 450),
  )..forward();

  @override
  void dispose() {
    _entrance.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final animation = CurvedAnimation(parent: _entrance, curve: Curves.easeOutCubic);

    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return Opacity(
          opacity: animation.value.clamp(0.0, 1.0),
          child: Transform.translate(
            offset: Offset(0, (1 - animation.value) * 16),
            child: child,
          ),
        );
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const _DragHandle(),
          Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: AppColors.ink.withValues(alpha: 0.08),
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: const Icon(Icons.coronavirus_outlined, size: 19, color: AppColors.ink),
              ),
              const SizedBox(width: 10),
              const Text(
                'Apa itu Wabah?',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
              ),
            ],
          ),
          const SizedBox(height: 14),
          if (widget.intro?.content != null)
            Flexible(
              child: SingleChildScrollView(
                child: RichBodyText(
                  widget.intro!.content!,
                  style: const TextStyle(
                    fontSize: 16,
                    height: 1.55,
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
            ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.ink,
                shape: const StadiumBorder(),
              ),
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Mengerti', style: TextStyle(fontWeight: FontWeight.w700)),
            ),
          ),
        ],
      ),
    );
  }
}