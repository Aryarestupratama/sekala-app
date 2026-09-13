import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:showcaseview/showcaseview.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../auth/presentation/providers/auth_providers.dart';
import '../../../auth/presentation/widgets/email_verification_banner.dart';
import '../../../onboarding/tutorial_keys.dart';
import 'change_password_screen.dart';
import 'help_support_screen.dart';

// CATATAN: kedua provider di bawah sudah dikonfirmasi ke file asli
// project (home_providers.dart & card_providers.dart) — bukan tebakan lagi.
import '../../../home/presentation/providers/home_providers.dart';
import '../../../card/presentation/providers/card_providers.dart';

/// Design.md §3.5 — diredesain penuh sesuai mockup terbaru:
/// avatar inisial, badge verifikasi, 2 stat card, menu pengaturan,
/// tombol Keluar sebagai text button merah.
///
/// Rute ini hanya bisa dicapai user login (guard nendang guest ke /auth).
class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  String _initials(String name) {
    final parts =
        name.trim().split(RegExp(r'\s+')).where((p) => p.isNotEmpty).toList();
    if (parts.isEmpty) return '?';
    if (parts.length == 1) return parts.first.substring(0, 1).toUpperCase();
    return (parts.first.substring(0, 1) + parts.last.substring(0, 1))
        .toUpperCase();
  }

  void _showComingSoon(BuildContext context, String label) {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(label, style: Theme.of(ctx).textTheme.titleMedium),
            const SizedBox(height: 8),
            const Text(
              'Fitur ini akan segera hadir.',
              style: TextStyle(color: AppColors.textSecondary),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
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
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsync = ref.watch(currentUserProvider);
    final isLoggingOut = ref.watch(authControllerProvider).isLoading;

    // Stat "tahun dibaca" — jumlah `completed` di seluruh era, dari
    // HomeSummary.progressByEra (home_progress.dart, field JSON
    // "progress_by_era"). homeSummaryProvider mengembalikan null untuk
    // guest (rute Profil sendiri sudah di-guard hanya untuk user login,
    // tapi tetap jaga-jaga null di sini).
    final homeSummaryAsync = ref.watch(homeSummaryProvider);
    final yearsRead = homeSummaryAsync.maybeWhen(
      data: (summary) => summary == null
          ? null
          : summary.progressByEra
              .fold<int>(0, (sum, e) => sum + e.completed),
      orElse: () => null,
    );

    // Stat "vaksin terbuka" — reuse cardListProvider (sumber yang sama
    // dipakai badge dot bottom nav di main_shell.dart). `.meta.unlocked`
    // sudah dikonfirmasi cocok dengan CardListMeta (card_list_response.dart).
    final cardListAsync = ref.watch(cardListProvider);
    final vaccinesUnlocked = cardListAsync.maybeWhen(
      data: (list) => list.meta.unlocked,
      orElse: () => null,
    );

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('Profil')),
      // Sama seperti home_screen.dart & era_list_screen.dart:
      // SingleChildScrollView+Column, BUKAN ListView, supaya menu "Bantuan
      // & Dukungan" (target Showcase step 4 tutorial) langsung ke-mount
      // tanpa perlu di-scroll dulu.
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
          const EmailVerificationBanner(),
          userAsync.when(
            data: (user) {
              if (user == null) {
                return const Padding(
                  padding: EdgeInsets.all(16),
                  child: Text('Data user tidak ditemukan.'),
                );
              }
              return Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.border),
                ),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: AppColors.border,
                      child: Text(
                        _initials(user.name),
                        style:
                            Theme.of(context).textTheme.titleLarge?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.ink,
                                ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(user.name,
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge
                            ?.copyWith(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 2),
                    Text(user.email,
                        style: const TextStyle(color: AppColors.textSecondary)),
                    const SizedBox(height: 12),
                    // Field dikonfirmasi dari shared/models/user.dart:
                    // backend kirim `is_email_verified` (bool langsung),
                    // bukan `email_verified_at` (timestamp nullable).
                    if (user.isEmailVerified)
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: AppColors.success.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Icon(Icons.check_circle,
                                size: 16, color: AppColors.success),
                            SizedBox(width: 6),
                            Text('Email terverifikasi',
                                style: TextStyle(
                                    color: AppColors.success,
                                    fontWeight: FontWeight.w600)),
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
          const SizedBox(height: 16),

          // === Stat cards ===
          Row(
            children: [
              Expanded(
                child: _StatCard(
                  icon: Icons.menu_book_outlined,
                  label: yearsRead == null
                      ? '— tahun dibaca'
                      : '$yearsRead tahun dibaca',
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _StatCard(
                  icon: Icons.vaccines_outlined,
                  label: vaccinesUnlocked == null
                      ? '— vaksin terbuka'
                      : '$vaccinesUnlocked vaksin terbuka',
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // === Menu list ===
          Container(
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.border),
            ),
            child: Column(
              children: [
                _MenuTile(
                  icon: Icons.lock_outline,
                  label: 'Ubah Kata Sandi',
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (_) => const ChangePasswordScreen()),
                  ),
                ),
                const Divider(height: 1),
                _MenuTile(
                  icon: Icons.notifications_none,
                  label: 'Notifikasi',
                  onTap: () => _showComingSoon(context, 'Notifikasi'),
                ),
                const Divider(height: 1),
                _MenuTile(
                  icon: Icons.public,
                  label: 'Bahasa',
                  trailing: 'Indonesia',
                  onTap: () => _showComingSoon(context, 'Bahasa'),
                ),
                const Divider(height: 1),
                _MenuTile(
                  icon: Icons.info_outline,
                  label: 'Tentang SEKALA',
                  onTap: () => _showComingSoon(context, 'Tentang SEKALA'),
                ),
                const Divider(height: 1),
                Showcase(
                  key: TutorialKeys.profileHelpMenuTile,
                  title: 'Butuh Bantuan?',
                  description:
                      'Tonton ulang tutorial ini kapan saja, atau baca panduan belajar di sini.',
                  child: _MenuTile(
                    icon: Icons.help_outline,
                    label: 'Bantuan & Dukungan',
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const HelpSupportScreen()),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),

          Center(
            child: TextButton.icon(
              onPressed:
                  isLoggingOut ? null : () => _confirmLogout(context, ref),
              icon: isLoggingOut
                  ? const SizedBox(
                      height: 16,
                      width: 16,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.logout, color: AppColors.destructive),
              label: const Text('Keluar',
                  style: TextStyle(color: AppColors.destructive)),
            ),
          ),
        ],
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({required this.icon, required this.label});
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Icon(icon, size: 18, color: AppColors.ink),
          const SizedBox(width: 8),
          Expanded(
            child: Text(label,
                style: const TextStyle(fontWeight: FontWeight.w600),
                overflow: TextOverflow.ellipsis),
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
    return ListTile(
      leading: Icon(icon, color: AppColors.ink),
      title: Text(label),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (trailing != null) ...[
            Text(trailing!, style: const TextStyle(color: AppColors.textSecondary)),
            const SizedBox(width: 4),
          ],
          const Icon(Icons.chevron_right, color: AppColors.textDisabled),
        ],
      ),
      onTap: onTap,
    );
  }
}