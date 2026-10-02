import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/pressable_scale.dart';
import '../providers/card_providers.dart';

/// GET /api/cards/{vaccine} — CARD-02. Cuma bisa diakses kalau vaksin
/// sudah unlock (backend 404 kalau belum, R-VAC-01/05). Pengganti
/// card_detail_screen.dart lama yang masih berbasis Figure/tokoh.
///
/// Field tokoh lama (Lahir/Wafat/Keluarga) diganti field vaksin
/// (Produsen/Penyakit Target/Tahun Diperkenalkan, Schema.md §2.6).
/// "Section terkait" di mockup lama DIHAPUS karena VaccineDetail tidak
/// membawa data itu.
///
/// REDESIGN: `withOpacity` -> `withValues(alpha:)`, tombol back/aksi
/// dibungkus [PressableScale], konten fade-in begitu data siap, dan
/// error/loading state dirapikan (tetap 404 = "belum terbuka/tidak
/// ditemukan", R-VAC-01/05 — pesan itu sendiri tidak berubah).
class VaccineDetailScreen extends ConsumerWidget {
  const VaccineDetailScreen({super.key, required this.vaccineId});

  final String vaccineId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // tryParse: parameter rute rusak (deep link) dulu melempar FormatException.
    final id = int.tryParse(vaccineId);
    if (id == null) {
      return Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(backgroundColor: AppColors.background, elevation: 0),
        body: const _VaccineUnavailable(),
      );
    }
    final vaccineAsync = ref.watch(vaccineDetailProvider(id));

    return Scaffold(
      backgroundColor: AppColors.background,
      body: vaccineAsync.when(
        data: (vaccine) => CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: true,
              expandedHeight: 300,
              backgroundColor: AppColors.background,
              foregroundColor: Colors.white,
              automaticallyImplyLeading: false,
              leadingWidth: 68,
              leading: Padding(
                padding: const EdgeInsets.only(left: 12, top: 4),
                child: Semantics(
                  button: true,
                  label: 'Kembali',
                  child: PressableScale(
                    onTap: () => Navigator.of(context).maybePop(),
                    child: Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        // 0.55 (bukan 0.35): tanpa foto, latar pucat membuat ikon
                        // putih hanya ~2.3:1.
                        color: Colors.black.withValues(alpha: 0.55),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.arrow_back_rounded, size: 22),
                    ),
                  ),
                ),
              ),
              // Tombol bookmark & bagikan DIHAPUS: keduanya `onTap: null`
              // (mati) dan menjanjikan fitur yang belum ada di backend —
              // komentar lama sendiri menyuruh menghapusnya.
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  fit: StackFit.expand,
                  children: [
                    if (vaccine.photoUrl != null)
                      Semantics(image: true, label: 'Foto ${vaccine.name}', child: CachedNetworkImage(
                        imageUrl: vaccine.photoUrl!,
                        fit: BoxFit.cover,
                      ))
                    else
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              AppColors.gamify.withValues(alpha: 0.22),
                              AppColors.gamify.withValues(alpha: 0.08),
                            ],
                          ),
                        ),
                        child: const Icon(Icons.vaccines_outlined, size: 64, color: AppColors.gamify),
                      ),
                    // Scrim supaya tombol back/appbar tetap kebaca di atas foto
                    const DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.black45, Colors.transparent, Colors.black26],
                          stops: [0.0, 0.4, 1.0],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: _FadeIn(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        vaccine.name,
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w800),
                      ),
                      const SizedBox(height: 10),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          _Chip(
                            label: vaccine.diseaseTarget,
                            color: AppColors.gamify,
                            icon: Icons.coronavirus_outlined,
                          ),
                          const _Chip(
                            label: 'Terbuka',
                            color: AppColors.success,
                            icon: Icons.check_circle_outline_rounded,
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.surface,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: AppColors.border),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.ink.withValues(alpha: 0.04),
                              blurRadius: 14,
                              offset: const Offset(0, 6),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            _InfoRow(
                              label: 'Produsen',
                              value: vaccine.manufacturer ?? '-',
                            ),
                            const Divider(height: 1, color: AppColors.border),
                            _InfoRow(
                              label: 'Penyakit Target',
                              value: vaccine.diseaseTarget,
                            ),
                            const Divider(height: 1, color: AppColors.border),
                            _InfoRow(
                              label: 'Tahun Diperkenalkan',
                              value: vaccine.yearIntroduced?.toString() ?? '-',
                              isLast: true,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'Peran dalam Sejarah Kesehatan',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        vaccine.description,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 16, height: 1.6),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        loading: () => Scaffold(
          backgroundColor: AppColors.background,
          appBar: AppBar(backgroundColor: AppColors.background, elevation: 0),
          body: const Center(child: CircularProgressIndicator(color: AppColors.ink)),
        ),
        // 404 (belum unlock / vaksin nggak ada, R-VAC-01/05) ATAU koneksi
        // bermasalah jatuh ke sini — dulu keduanya satu pesan tanpa aksi.
        error: (error, _) => Scaffold(
          backgroundColor: AppColors.background,
          appBar: AppBar(backgroundColor: AppColors.background, elevation: 0),
          body: _VaccineUnavailable(
            onRetry: () => ref.invalidate(vaccineDetailProvider(id)),
          ),
        ),
      ),
    );
  }
}

/// Fade sederhana untuk konten begitu data vaksin siap ditampilkan.
class _FadeIn extends StatefulWidget {
  const _FadeIn({required this.child});

  final Widget child;

  @override
  State<_FadeIn> createState() => _FadeInState();
}

class _FadeInState extends State<_FadeIn> with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 400),
  )..forward();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Hormati "reduce motion": konten langsung tampil penuh.
    if (MediaQuery.disableAnimationsOf(context)) _controller.value = 1;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: CurvedAnimation(parent: _controller, curve: Curves.easeOut),
      child: widget.child,
    );
  }
}

class _Chip extends StatelessWidget {
  const _Chip({required this.label, required this.color, required this.icon});

  final String label;
  final Color color;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: 6),
          // Teks Ink: gamify/success di atas tint-nya hanya ~3.0:1 / ~2.9:1.
          Flexible(
            child: Text(
              label,
              style: const TextStyle(color: AppColors.ink, fontWeight: FontWeight.w600, fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.label, required this.value, this.isLast = false});

  final String label;
  final String value;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: AppColors.textSecondary, fontSize: 15),
            ),
          ),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600, fontSize: 15),
            ),
          ),
        ],
      ),
    );
  }
}

/// Vaksin belum bisa dibuka: belum unlock / tidak ditemukan (404), atau
/// koneksi bermasalah. [onRetry] null = tanpa tombol ulang (rute rusak).
class _VaccineUnavailable extends StatelessWidget {
  const _VaccineUnavailable({this.onRetry});

  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.lock_outline_rounded, size: 44, color: AppColors.textSecondary),
            const SizedBox(height: 12),
            const Text(
              'Vaksin ini belum bisa dibuka',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 6),
            const Text(
              'Mungkin vaksin ini belum terbuka (tuntaskan wabah terkaitnya dulu), '
              'tidak ditemukan, atau koneksimu bermasalah.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15, height: 1.4, color: AppColors.textSecondary),
            ),
            if (onRetry != null) ...[
              const SizedBox(height: 16),
              FilledButton(
                onPressed: onRetry,
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.ink,
                  minimumSize: const Size(140, 48),
                  shape: const StadiumBorder(),
                ),
                child: const Text('Coba lagi', style: TextStyle(fontWeight: FontWeight.w700)),
              ),
            ],
          ],
        ),
      ),
    );
  }
}