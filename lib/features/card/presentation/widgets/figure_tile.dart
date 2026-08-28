import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/models/figure_card.dart';

/// Design.md §3.4 poin 1: card unlock tampil dengan foto & nama; card
/// belum unlock tampil sebagai siluet/placeholder. Nama "???" untuk yang
/// terkunci sudah dikirim apa adanya dari backend (FigureCardResource),
/// jadi widget ini nggak perlu logic nyamarin nama sendiri.
class FigureTile extends StatelessWidget {
  const FigureTile({super.key, required this.figure, required this.onTap});

  final FigureCard figure;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Column(
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                color: figure.unlocked
                    ? AppColors.gamify.withValues(alpha: 0.12)
                    : AppColors.border.withValues(alpha: 0.35),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: figure.unlocked ? AppColors.gamify : AppColors.border,
                ),
              ),
              child: (figure.unlocked && figure.photoUrl != null)
                  ? CachedNetworkImage(
                      imageUrl: figure.photoUrl!,
                      fit: BoxFit.cover,
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.person_outline, size: 32),
                    )
                  : Icon(
                      figure.unlocked ? Icons.person_outline : Icons.lock_outline,
                      size: 32,
                      color: figure.unlocked ? AppColors.gamify : AppColors.border,
                    ),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            figure.name,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}
