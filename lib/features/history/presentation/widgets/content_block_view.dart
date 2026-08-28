import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../shared/models/content_block.dart';
import '../../../../shared/models/content_block_type.dart';

/// Render satu ContentBlock sesuai tipenya (CMS-02, Schema.md §2.5).
///
/// CATATAN KETERBATASAN MVP:
/// - `text` & `summary` di-render sebagai plain text. Schema.md bilang
///   kolomnya "bisa berisi HTML" (dari rich text editor CMS-03) — kalau
///   admin nyimpen HTML beneran, tag-nya bakal kelihatan mentah di sini.
///   Perlu nambah package `flutter_html` kalau mau render HTML proper.
/// - `pdf` dibuka via browser eksternal (url_launcher), bukan in-app
///   WebView — lebih simpel, konsisten sama cara kuis dibuka.
class ContentBlockView extends StatelessWidget {
  const ContentBlockView({super.key, required this.block});

  final ContentBlock block;

  @override
  Widget build(BuildContext context) {
    switch (block.type) {
      case ContentBlockType.text:
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Text(block.content, style: Theme.of(context).textTheme.bodyLarge),
        );

      case ContentBlockType.summary:
        return Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(vertical: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.ink.withValues(alpha: 0.04),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.border),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Rangkuman', style: Theme.of(context).textTheme.titleSmall),
              const SizedBox(height: 8),
              Text(block.content, style: Theme.of(context).textTheme.bodyLarge),
            ],
          ),
        );

      case ContentBlockType.image:
        final imageUrl = block.resolvedUrl ?? block.content;
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              fit: BoxFit.cover,
              placeholder: (context, url) => const AspectRatio(
                aspectRatio: 16 / 9,
                child: Center(child: CircularProgressIndicator()),
              ),
              errorWidget: (context, url, error) => const AspectRatio(
                aspectRatio: 16 / 9,
                child: Center(child: Icon(Icons.broken_image_outlined)),
              ),
            ),
          ),
        );

      case ContentBlockType.video:
        // ASUMSI: resolvedUrl berisi VIDEO_ID YouTube murni (bukan URL
        // lengkap) sesuai Architecture.md §4.1. Fallback nyoba ekstrak
        // dari `content` mentah kalau resolvedUrl kosong.
        final videoId = block.resolvedUrl ??
            YoutubePlayer.convertUrlToId(block.content);
        if (videoId == null || videoId.isEmpty) {
          return const _UnavailableMediaCard(label: 'Video tidak tersedia');
        }
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: YoutubePlayer(
              controller: YoutubePlayerController(
                initialVideoId: videoId,
                flags: const YoutubePlayerFlags(autoPlay: false),
              ),
            ),
          ),
        );

      case ContentBlockType.pdf:
        final pdfUrl = block.resolvedUrl ?? block.content;
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: ListTile(
            leading: const Icon(Icons.picture_as_pdf_outlined),
            title: const Text('Buka dokumen PDF'),
            trailing: const Icon(Icons.open_in_new),
            onTap: () => launchUrl(
              Uri.parse(pdfUrl),
              mode: LaunchMode.externalApplication,
            ),
          ),
        );
    }
  }
}

class _UnavailableMediaCard extends StatelessWidget {
  const _UnavailableMediaCard({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.border.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const Icon(Icons.error_outline),
          const SizedBox(width: 8),
          Text(label),
        ],
      ),
    );
  }
}
