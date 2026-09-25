import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:showcaseview/showcaseview.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/pressable_scale.dart';
import '../../../auth/presentation/providers/auth_providers.dart';
import '../../../auth/presentation/widgets/email_verification_banner.dart';
import '../../../onboarding/tutorial_keys.dart';
import 'change_password_screen.dart';
import 'help_support_screen.dart';
import 'about_sekala_screen.dart';

import '../../../home/presentation/providers/home_providers.dart';
import '../../../card/presentation/providers/card_providers.dart';

/// Design.md §3.5 — avatar inisial, badge verifikasi, 2 stat card, menu
/// pengaturan, tombol Keluar sebagai text button merah.
///
/// Rute ini hanya bisa dicapai user login (guard nendang guest ke /auth).
///
/// REDESIGN: `withOpacity` -> `withValues(alpha:)`, avatar jadi gradasi
/// warna, stat card angkanya animasi mengisi, menu list pakai kartu +
/// [PressableScale] (bukan `ListTile` polos), dan konten fade-up saat
/// pertama tampil. Semua provider watch, `_initials()`, `_confirmLogout()`
/// dan navigasi menu TIDAK berubah.
class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _entrance = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 700),
  )..forward();

  @override
  void dispose() {
    _entrance.dispose();
    super.dispose();
  }

  Animation<double> _slot(double begin, double end) {
    return CurvedAnimation(
      parent: _entrance,
      curve: Interval(begin, end, curve: Curves.easeOutCubic),
    );
  }

  String _initials(String name) {
    final parts =
        name.trim().split(RegExp(r'\s+')).where((p) => p.isNotEmpty).toList();
    if (parts.isEmpty) return '?';
    if (parts.length == 1) return parts.first.substring(0, 1).toUpperCase();
    return (parts.first.substring(0, 1) + parts.last.substring(0, 1))
        .toUpperCase();
  }

  Future<void> _confirmLogout(BuildContext context, WidgetRef ref) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Keluar dari akun?'),
        content: const Text('Kamu bisa login kembali kapan saja.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: const Text('Keluar',
                style: TextStyle(color: AppColors.destructive)),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await ref.read(authControllerProvider.notifier).logout();
    }
  }

  @override
  Widget build(BuildContext context) {
    final userAsync = ref.watch(currentUserProvider);
    final isLoggingOut = ref.watch(authControllerProvider).isLoading;

    // Stat "tahun dibaca" — jumlah `completed` di seluruh era, dari
    // HomeSummary.progressByEra. homeSummaryProvider mengembalikan null
    // untuk guest (rute Profil sendiri sudah di-guard, tapi tetap jaga2).
    final homeSummaryAsync = ref.watch(homeSummaryProvider);
    final yearsRead = homeSummaryAsync.maybeWhen(
      data: (summary) => summary == null
          ? null
          : summary.progressByEra.fold<int>(0, (sum, e) => sum + e.completed),
      orElse: () => null,
    );

    // Stat "vaksin terbuka" — reuse cardListProvider (sumber yang sama
    // dipakai badge dot bottom nav di main_shell.dart).
    final cardListAsync = ref.watch(cardListProvider);
    final vaccinesUnlocked = cardListAsync.maybeWhen(
      data: (list) => list.meta.unlocked,
      orElse: () => null,
    );

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        title: const Text('Profil', style: TextStyle(fontWeight: FontWeight.w800)),
      ),
      // Sama seperti home_screen.dart & era_list_screen.dart:
      // SingleChildScrollView+Column, BUKAN ListView, supaya menu "Bantuan
      // & Dukungan" (target Showcase tutorial) langsung ke-mount tanpa
      // perlu di-scroll dulu.
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const EmailVerificationBanner(),
            _FadeSlideUp(
              animation: _slot(0.0, 0.5),
              child: userAsync.when(
                data: (user) {
                  if (user == null) {
                    return const Padding(
                      padding: EdgeInsets.all(16),
                      child: Text('Data user tidak ditemukan.'),
                    );
                  }
                  return Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 16),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: AppColors.border),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.ink.withValues(alpha: 0.04),
                          blurRadius: 16,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Container(
                          width: 84,
                          height: 84,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [AppColors.ink, AppColors.ink.withValues(alpha: 0.75)],
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.ink.withValues(alpha: 0.25),
                                blurRadius: 16,
                                offset: const Offset(0, 6),
                              ),
                            ],
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            _initials(user.name),
                            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                  fontWeight: FontWeight.w800,
                                  color: Colors.white,
                                ),
                          ),
                        ),
                        const SizedBox(height: 14),
                        Text(
                          user.name,
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
                        ),
                        const SizedBox(height: 2),
                        Text(user.email, style: const TextStyle(color: AppColors.textSecondary)),
                        const SizedBox(height: 12),
                        // Field dikonfirmasi dari shared/models/user.dart:
                        // backend kirim `is_email_verified` (bool langsung).
                        if (user.isEmailVerified)
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: AppColors.success.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.check_circle_rounded, size: 16, color: AppColors.success),
                                SizedBox(width: 6),
                                Text(
                                  'Email terverifikasi',
                                  style: TextStyle(color: AppColors.success, fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  );
                },
                loading: () => const Padding(
                  padding: EdgeInsets.all(24),
                  child: Center(child: CircularProgressIndicator()),
                ),
                error: (error, _) => Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text('Gagal memuat data akun: $error'),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // === Stat cards ===
            _FadeSlideUp(
              animation: _slot(0.15, 0.65),
              child: Row(
                children: [
                  Expanded(
                    child: _StatCard(
                      icon: Icons.menu_book_rounded,
                      value: yearsRead,
                      unit: 'tahun dibaca',
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _StatCard(
                      icon: Icons.vaccines_rounded,
                      value: vaccinesUnlocked,
                      unit: 'vaksin terbuka',
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // === Menu list ===
            _FadeSlideUp(
              animation: _slot(0.25, 0.75),
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: AppColors.border),
                ),
                clipBehavior: Clip.antiAlias,
                child: Column(
                  children: [
                    _MenuTile(
                      icon: Icons.lock_outline_rounded,
                      label: 'Ubah Kata Sandi',
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const ChangePasswordScreen()),
                      ),
                    ),
                    const Divider(height: 1, color: AppColors.border),
                    _MenuTile(
                      icon: Icons.info_outline_rounded,
                      label: 'Tentang SEKALA',
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const AboutSekalaScreen()),
                      ),
                    ),
                    const Divider(height: 1, color: AppColors.border),
                    Showcase(
                      key: TutorialKeys.profileHelpMenuTile,
                      title: 'Butuh Bantuan?',
                      description:
                          'Tonton ulang tutorial ini kapan saja, atau baca panduan belajar di sini.',
                      child: _MenuTile(
                        icon: Icons.help_outline_rounded,
                        label: 'Bantuan & Dukungan',
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => const HelpSupportScreen()),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),

            _FadeSlideUp(
              animation: _slot(0.35, 0.85),
              child: Center(
                child: TextButton.icon(
                  onPressed: isLoggingOut ? null : () => _confirmLogout(context, ref),
                  icon: isLoggingOut
                      ? const SizedBox(
                          height: 16,
                          width: 16,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.logout_rounded, color: AppColors.destructive),
                  label: const Text('Keluar', style: TextStyle(color: AppColors.destructive, fontWeight: FontWeight.w700)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Fade + slide dari bawah — sama seperti pola di layar lain.
class _FadeSlideUp extends StatelessWidget {
  const _FadeSlideUp({required this.animation, required this.child});

  final Animation<double> animation;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      child: child,
      builder: (context, child) {
        return Opacity(
          opacity: animation.value.clamp(0.0, 1.0),
          child: Transform.translate(
            offset: Offset(0, (1 - animation.value) * 18),
            child: child,
          ),
        );
      },
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({required this.icon, required this.value, required this.unit});

  final IconData icon;
  final int? value;
  final String unit;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 14),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(color: AppColors.ink.withValues(alpha: 0.08), shape: BoxShape.circle),
            alignment: Alignment.center,
            child: Icon(icon, size: 17, color: AppColors.ink),
          ),
          const SizedBox(height: 10),
          value == null
              ? const Text('—', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18))
              : TweenAnimationBuilder<int>(
                  tween: IntTween(begin: 0, end: value),
                  duration: const Duration(milliseconds: 700),
                  curve: Curves.easeOutCubic,
                  builder: (context, v, _) => Text(
                    '$v',
                    style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 18),
                  ),
                ),
          const SizedBox(height: 2),
          Text(
            unit,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(color: AppColors.textSecondary, fontSize: 12.5),
          ),
        ],
      ),
    );
  }
}

class _MenuTile extends StatelessWidget {
  const _MenuTile({
    required this.icon,
    required this.label,
    required this.onTap,
    this.trailing,
  });

  final IconData icon;
  final String label;
  final String? trailing;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return PressableScale(
      scale: 0.99,
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(color: AppColors.ink.withValues(alpha: 0.06), shape: BoxShape.circle),
              alignment: Alignment.center,
              child: Icon(icon, size: 18, color: AppColors.ink),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Text(label, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14.5)),
            ),
            if (trailing != null) ...[
              Text(trailing!, style: const TextStyle(color: AppColors.textSecondary)),
              const SizedBox(width: 4),
            ],
            const Icon(Icons.chevron_right_rounded, color: AppColors.textDisabled),
          ],
        ),
      ),
    );
  }
}