import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

/// Design.md §3.2: untuk guest, kartu progress diganti ajakan
/// "Masuk untuk melacak progress bacaanmu".
class GuestInviteCard extends StatelessWidget {
  const GuestInviteCard({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.gamify.withValues(alpha: 0.08),
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            const Icon(Icons.lock_open_outlined, color: AppColors.gamify),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                'Masuk untuk melacak progress bacaanmu, ikut kuis, '
                'dan kumpulkan collectible card tokoh sejarah.',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            const SizedBox(width: 8),
            FilledButton(onPressed: onTap, child: const Text('Masuk')),
          ],
        ),
      ),
    );
  }
}
