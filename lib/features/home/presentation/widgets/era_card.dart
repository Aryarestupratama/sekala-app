import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/models/era.dart';
import '../../../../shared/models/home_progress.dart';

/// Design.md §3.2: kartu progress per era untuk user login (3 kartu:
/// Kolonial/Kemerdekaan/Modern), tanpa progress bar untuk guest — tapi
/// tetap tampil sebagai entry point navigasi (HOME-03).
class EraCard extends StatelessWidget {
  const EraCard({
    super.key,
    required this.era,
    required this.progress, // null = guest, atau belum ada data
    required this.onTap,
  });

  final Era era;
  final EraProgress? progress;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final accent = EraAccents.ofSlug(era.slug);

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 4,
                height: 48,
                decoration: BoxDecoration(
                  color: accent,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(era.name, style: Theme.of(context).textTheme.titleMedium),
                    const SizedBox(height: 6),
                    if (progress != null) ...[
                      ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: LinearProgressIndicator(
                          value: progress!.progressRatio,
                          minHeight: 6,
                          backgroundColor: AppColors.border,
                          valueColor: AlwaysStoppedAnimation(accent),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${progress!.completed}/${progress!.total} tahun dibaca',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ] else
                      Text(
                        'Jelajahi sejarah masa ${era.name}',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right),
            ],
          ),
        ),
      ),
    );
  }
}
