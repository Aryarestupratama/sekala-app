import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/auth_providers.dart';

/// R-AUTH-03: user login tapi email belum terverifikasi tetap bisa browse,
/// tapi diblok dari kuis/progress/card.
///
/// REVISI: dulu ini `EmailVerificationBanner` -- kotak besar berwarna
/// `errorContainer` yang dipasang di Home DAN Profil (dobel, redundan
/// dengan chip "Email terverifikasi" yang sudah ada di Profil). Sekarang
/// disederhanakan jadi [EmailVerificationNotice]: teks kecil + tombol
/// kirim ulang, TANPA kotak/warna latar -- ditempatkan HANYA di
/// `ProfileScreen`, persis di slot yang sama dengan chip "Email
/// terverifikasi" (`if (user.isEmailVerified) ... else
/// EmailVerificationNotice()`), tepat di bawah foto profil/nama/email.
/// Home TIDAK lagi menampilkan apa pun soal ini -- supaya tidak
/// mengganggu konten utama Home (lihat catatan desain sebelumnya).
///
/// Warna pakai `Theme.of(context).colorScheme.error` (bawaan Material),
/// BUKAN token `AppColors` kustom -- proyek ini tidak punya
/// `AppColors.warning`/`AppColors.error` yang dikonfirmasi ada (yang
/// dikonfirmasi cuma `success`/`destructive`/`coral`/dst di file lain),
/// jadi dipilih yang paling aman dan pasti tersedia. Kalau tim desain
/// sudah punya token warna warning resmi, tinggal ganti baris warna di
/// bawah.
///
/// Otomatis `SizedBox.shrink()` kalau user guest atau sudah terverifikasi
/// -- pemanggil (ProfileScreen) sudah pasti hanya merender ini saat
/// `!user.isEmailVerified`, tapi guard ini dipertahankan supaya widget
/// tetap aman dipakai berdiri sendiri di tempat lain nanti.
class EmailVerificationNotice extends ConsumerWidget {
  const EmailVerificationNotice({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsync = ref.watch(currentUserProvider);
    final warningColor = Theme.of(context).colorScheme.error;

    return userAsync.when(
      data: (user) {
        if (user == null || user.isEmailVerified) return const SizedBox.shrink();

        final isSending = ref.watch(authControllerProvider).isLoading;

        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.error_outline_rounded, size: 15, color: warningColor),
            const SizedBox(width: 6),
            Text(
              'Email belum diverifikasi',
              style: TextStyle(
                color: warningColor,
                fontSize: 12.5,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(width: 4),
            isSending
                ? const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: SizedBox(
                      height: 12,
                      width: 12,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  )
                : TextButton(
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                      minimumSize: const Size(0, 24),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    onPressed: () async {
                      final success = await ref
                          .read(authControllerProvider.notifier)
                          .resendVerificationEmail();
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              success
                                  ? 'Email verifikasi terkirim ulang.'
                                  : 'Gagal mengirim ulang. Coba lagi.',
                            ),
                          ),
                        );
                      }
                    },
                    child: const Text(
                      'Kirim ulang',
                      style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w700),
                    ),
                  ),
          ],
        );
      },
      loading: () => const SizedBox.shrink(),
      error: (_, __) => const SizedBox.shrink(),
    );
  }
}