import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/auth_providers.dart';

/// R-AUTH-03: user login tapi email belum terverifikasi tetap bisa browse,
/// tapi diblok dari kuis/progress/card. Banner ini dipasang di
/// Home/Profile (atau screen lain yang relevan) untuk ingetin & kasih
/// tombol kirim ulang — BUKAN blocking dialog, biar nggak ganggu guest
/// experience (sesuai prinsip "ramah, bukan memaksa" di Design.md §1).
///
/// Otomatis nggak nampilin apa-apa (SizedBox.shrink) kalau user guest
/// atau sudah terverifikasi.
class EmailVerificationBanner extends ConsumerWidget {
  const EmailVerificationBanner({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsync = ref.watch(currentUserProvider);

    return userAsync.when(
      data: (user) {
        if (user == null || user.isEmailVerified) return const SizedBox.shrink();

        final isSending = ref.watch(authControllerProvider).isLoading;

        return Container(
          width: double.infinity,
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.errorContainer,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Verifikasi email kamu',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const SizedBox(height: 4),
              const Text(
                'Cek inbox untuk mengaktifkan kuis, progress, dan '
                'collectible card.',
              ),
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: isSending
                      ? null
                      : () async {
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
                  child: isSending
                      ? const SizedBox(
                          height: 16,
                          width: 16,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text('Kirim Ulang'),
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
