import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import '../providers/auth_providers.dart';

/// R-AUTH-03: user login tapi email belum terverifikasi tetap bisa browse,
/// tapi diblok dari kuis/progress/card.
///
/// Dipasang HANYA di `ProfileScreen`, di slot chip "Email terverifikasi"
/// (`if (user.isEmailVerified) ... else EmailVerificationNotice()`).
///
/// REVISI (design review):
/// - Teks 12.5sp -> 14sp; tombol "Kirim ulang" setinggi ~24dp -> 48dp.
/// - Menjelaskan AKIBAT-nya ("progres belum tersimpan") dan apa yang harus
///   dilakukan (cek inbox/spam) — dulu hanya "Email belum diverifikasi".
/// - Jeda 60 detik setelah kirim ulang berhasil (mencegah spam & throttle
///   server), dengan hitung mundur terlihat.
/// - Merah mentah bawaan tema diganti merah berkontras tinggi (#B3261D).
///
/// Otomatis `SizedBox.shrink()` kalau user guest atau sudah terverifikasi.
class EmailVerificationNotice extends ConsumerStatefulWidget {
  const EmailVerificationNotice({super.key});

  @override
  ConsumerState<EmailVerificationNotice> createState() => _EmailVerificationNoticeState();
}

class _EmailVerificationNoticeState extends ConsumerState<EmailVerificationNotice> {
  static const _cooldownSeconds = 60;
  static const _danger = Color(0xFFB3261D); // ~6.5:1 di atas putih

  Timer? _timer;
  int _cooldown = 0;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startCooldown() {
    _timer?.cancel();
    setState(() => _cooldown = _cooldownSeconds);
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (!mounted) {
        t.cancel();
        return;
      }
      setState(() => _cooldown--);
      if (_cooldown <= 0) t.cancel();
    });
  }

  Future<void> _resend() async {
    final success = await ref.read(authControllerProvider.notifier).resendVerificationEmail();
    if (!mounted) return;
    if (success) _startCooldown();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          success
              ? 'Email verifikasi terkirim ulang. Cek inbox atau folder spam.'
              : 'Gagal mengirim ulang. Coba lagi.',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final userAsync = ref.watch(currentUserProvider);

    return userAsync.when(
      data: (user) {
        if (user == null || user.isEmailVerified) return const SizedBox.shrink();

        final isSending = ref.watch(authControllerProvider).isLoading;
        final coolingDown = _cooldown > 0;

        return Semantics(
          container: true,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.error_outline_rounded, size: 18, color: _danger),
                  SizedBox(width: 6),
                  Flexible(
                    child: Text(
                      'Email belum diverifikasi',
                      style: TextStyle(color: _danger, fontSize: 14.5, fontWeight: FontWeight.w700),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              const Text(
                'Progres belajar dan kuis baru tersimpan setelah email '
                'diverifikasi. Cek inbox atau folder spam.',
                textAlign: TextAlign.center,
                style: TextStyle(color: AppColors.textSecondary, fontSize: 14, height: 1.4),
              ),
              const SizedBox(height: 4),
              if (isSending)
                const SizedBox(
                  height: 48,
                  child: Center(
                    child: SizedBox(
                      height: 18,
                      width: 18,
                      child: CircularProgressIndicator(strokeWidth: 2, color: AppColors.ink),
                    ),
                  ),
                )
              else
                TextButton(
                  onPressed: coolingDown ? null : _resend,
                  style: TextButton.styleFrom(
                    foregroundColor: AppColors.ink,
                    minimumSize: const Size(48, 48),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                  ),
                  child: Text(
                    coolingDown ? 'Kirim ulang dalam ${_cooldown}d' : 'Kirim ulang email verifikasi',
                    style: const TextStyle(fontSize: 14.5, fontWeight: FontWeight.w700),
                  ),
                ),
            ],
          ),
        );
      },
      loading: () => const SizedBox.shrink(),
      error: (_, __) => const SizedBox.shrink(),
    );
  }
}