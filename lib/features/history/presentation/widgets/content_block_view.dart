import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../shared/models/content_block.dart';
import '../../../../shared/models/content_block_type.dart';

/// Render satu ContentBlock sesuai tipenya (CMS-02, Schema.md §2.5).
///
/// CATATAN KETERBATASAN MVP:
/// - `text` di-render sebagai plain text. Schema.md bilang kolomnya "bisa
///   berisi HTML" (dari rich text editor CMS-03) — kalau admin nyimpen
///   HTML beneran, tag-nya bakal kelihatan mentah di sini. Perlu nambah
///   package `flutter_html` kalau mau render HTML proper.
/// - `pdf` dibuka via WebView in-app (dialog fullscreen) yang me-render
///   link "preview" Google Drive (`LinkParserService::toDrivePdfEmbedUrl()`)
///   — SENGAJA bukan lagi browser eksternal (`url_launcher`): membuka di
///   browser device memakai sesi Google yang sudah login di device
///   tsb, jadi Drive suka munculin prompt "pilih akun" duluan sebelum
///   nampilin filenya. WebView in-app ini nggak bawa sesi Google apapun,
///   jadi selama file di-share "Anyone with the link", langsung tampil
///   tanpa perlu pilih akun.
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

      case ContentBlockType.image:
        final imageUrl = block.resolvedUrl ?? block.content;
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
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
              // (Baru) Caption -- opsional, sumber/keterangan gambar.
              // Cuma dirender kalau memang diisi admin, tidak ada
              // placeholder kalau kosong.
              if (block.caption != null && block.caption!.trim().isNotEmpty) ...[
                const SizedBox(height: 6),
                Text(
                  block.caption!,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondary,
                        fontStyle: FontStyle.italic,
                      ),
                ),
              ],
            ],
          ),
        );

      case ContentBlockType.video:
        // FIX (sebelumnya stuck loading selamanya): `resolvedUrl` dari
        // backend ternyata full embed URL (`LinkParserService::
        // toYoutubeEmbedUrl()` -> "https://www.youtube.com/embed/{id}"),
        // BUKAN video ID murni seperti asumsi lama. Kode lama pakai
        // `block.resolvedUrl` apa adanya sebagai `initialVideoId` tanpa
        // konversi -> YoutubePlayerController dikasih string URL penuh,
        // gagal resolve video, dan macet di loading spinner tanpa error
        // yang kelihatan (cuma jalur fallback `block.content` yang
        // sebelumnya dilewatkan `convertUrlToId()`).
        //
        // Sekarang KEDUA sumber selalu dinormalisasi lewat
        // `convertUrlToId()` — package ini bisa handle baik URL penuh
        // (watch?v=, youtu.be/, embed/) maupun ID murni 11 karakter,
        // jadi aman dipakai untuk format resolvedUrl apapun yang
        // dihasilkan backend saat ini maupun kalau nanti berubah.
        final videoId = _extractYoutubeVideoId(block.resolvedUrl) ??
            _extractYoutubeVideoId(block.content);
        if (videoId == null || videoId.isEmpty) {
          return const _UnavailableMediaCard(label: 'Video tidak tersedia');
        }
        // FIX (thumbnail + tombol play muncul tapi tap tidak merespons):
        // sebelumnya `YoutubePlayerController` dibuat langsung di sini,
        // di dalam `build()` milik `ContentBlockView` yang StatelessWidget.
        // Setiap kali ancestor rebuild (mis. `setState(_navigating)` di
        // `SectionDetailScreen` saat CTA ditekan), method `build()` ini
        // ikut jalan lagi dan bikin instance controller BARU dari nol,
        // menggantikan yang lama tanpa pernah di-`dispose()`. Controller
        // lama yang WebView-nya sedang proses init jadi "digantung", dan
        // controller baru yang terpasang ke `YoutubePlayer` sering tidak
        // ke-attach sempurna ke State internal package pada saat itu —
        // hasilnya thumbnail/tombol play tampil (render awal sebelum
        // WebView player siap) tapi tap tidak direspons karena controller
        // yang "hidup" di layar sudah beda identitas dari yang seharusnya
        // dipakai. Fix: pindah ke widget terpisah (`_YoutubeBlockPlayer`)
        // yang StatefulWidget, controller dibuat sekali di `initState()`
        // dan hidup selama widget itu sendiri hidup (key by `videoId`
        // supaya kalau video-nya beneran ganti, baru controller dibuat
        // ulang) — bukan setiap kali parent rebuild.
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: _YoutubeBlockPlayer(key: ValueKey(videoId), videoId: videoId),
              ),
              // (Baru) Caption -- opsional, sumber/keterangan video.
              if (block.caption != null && block.caption!.trim().isNotEmpty) ...[
                const SizedBox(height: 6),
                Text(
                  block.caption!,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondary,
                        fontStyle: FontStyle.italic,
                      ),
                ),
              ],
            ],
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
            onTap: () => showDialog<void>(
              context: context,
              barrierDismissible: false,
              builder: (_) => _PdfPreviewDialog(url: pdfUrl),
            ),
          ),
        );
    }
  }
}

/// Dialog fullscreen berisi WebView in-app untuk render preview PDF dari
/// Google Drive (link `.../file/d/{id}/preview`). Dipakai alih-alih
/// browser eksternal supaya tidak memicu prompt "pilih akun Google" —
/// lihat catatan di docstring `ContentBlockView`.
class _PdfPreviewDialog extends StatefulWidget {
  const _PdfPreviewDialog({required this.url});

  final String url;

  @override
  State<_PdfPreviewDialog> createState() => _PdfPreviewDialogState();
}

class _PdfPreviewDialogState extends State<_PdfPreviewDialog> {
  late final WebViewController _controller;
  bool _loading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (_) {
            if (mounted) setState(() => _loading = false);
          },
          onWebResourceError: (error) {
            // Cuma tangkap error di main frame — resource pendukung
            // (font/tracking script dari Drive) sering gagal juga tapi
            // tidak menghalangi PDF-nya sendiri ke-render.
            if (mounted && error.isForMainFrame != false) {
              setState(() {
                _loading = false;
                _errorMessage = 'Gagal memuat dokumen. Periksa koneksi internet.';
              });
            }
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Dialog.fullscreen(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Dokumen PDF'),
          leading: IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: Stack(
          children: [
            if (_errorMessage == null)
              WebViewWidget(controller: _controller)
            else
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.error_outline, size: 40),
                      const SizedBox(height: 12),
                      Text(_errorMessage!, textAlign: TextAlign.center),
                    ],
                  ),
                ),
              ),
            if (_loading && _errorMessage == null)
              const Center(child: CircularProgressIndicator()),
          ],
        ),
      ),
    );
  }
}

/// MIGRASI dari `youtube_player_flutter` ke `youtube_player_iframe`
/// (lihat catatan di `pubspec.yaml`): tombol play sebelumnya diam total
/// tanpa reaksi apa pun di WebView Android versi baru — root cause,
/// `youtube_player_flutter` mengandalkan JS bridge tersembunyi
/// (`postMessage` ke halaman IFrame API yang di-embed manual) yang mulai
/// tidak kompatibel dengan update `webview_flutter`/Android System
/// WebView terbaru, dan package tsb sudah lama tidak dimaintain aktif.
/// `youtube_player_iframe` memakai `webview_flutter` secara langsung
/// (bukan trik JS bridge terpisah), lebih stabil untuk versi WebView
/// sekarang & ke depan.
///
/// Controller tetap dibuat sekali di `initState()` (bukan di `build()`
/// milik parent yang stateless) — alasan yang sama seperti fix
/// sebelumnya: supaya rebuild dari ancestor manapun (mis. `setState`
/// CTA di `SectionDetailScreen`) tidak membuat controller baru yang
/// memutus koneksi player yang sedang berjalan.
class _YoutubeBlockPlayer extends StatefulWidget {
  const _YoutubeBlockPlayer({super.key, required this.videoId});

  final String videoId;

  @override
  State<_YoutubeBlockPlayer> createState() => _YoutubeBlockPlayerState();
}

class _YoutubeBlockPlayerState extends State<_YoutubeBlockPlayer> {
  late final YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController.fromVideoId(
      videoId: widget.videoId,
      autoPlay: false,
      params: const YoutubePlayerParams(
        showControls: true,
        showFullscreenButton: true,
        mute: false,
      ),
    );
  }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }

  Future<void> _openInYoutubeApp() async {
    final uri = Uri.parse('https://www.youtube.com/watch?v=${widget.videoId}');
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    // FIX (video "diam total" tanpa reaksi apapun, error player 100/101/
    // 150/154 dari YouTube IFrame API): sebelumnya widget ini langsung
    // render `YoutubePlayer` tanpa cek status error dari controller —
    // kalau pemilik video mematikan opsi "Allow embedding" di YouTube
    // Studio, WebView player berhasil dimuat tapi YouTube sendiri
    // menolak memutar video-nya (kode error 101/150 = video ini,
    // 100/154 = video tidak ditemukan/dihapus/private) — dari sisi UI
    // Flutter, ini kelihatan identik dengan "diam total" karena player
    // shell-nya tetap ter-render, cuma konten videonya yang ditolak,
    // TANPA exception yang bisa ditangkap `try/catch` biasa (errornya
    // dikomunikasikan lewat `postMessage` internal ke `controller.value`,
    // bukan dilempar sebagai Dart exception).
    //
    // Sekarang didengarkan lewat `YoutubeValueBuilder` (widget builder
    // bawaan package ini, membungkus `controller.stream` secara
    // internal) — begitu `value.error != YoutubeError.none`, ganti
    // tampilan jadi pesan yang jelas + tombol buka langsung ke
    // app/browser YouTube, alih-alih user cuma lihat player kosong yang
    // kelihatan "nge-hang".
    return YoutubeValueBuilder(
      controller: _controller,
      builder: (context, value) {
        if (value.error != YoutubeError.none) {
          final message = switch (value.error) {
            YoutubeError.notEmbeddable || YoutubeError.sameAsNotEmbeddable =>
              'Video ini tidak bisa diputar di dalam aplikasi (pemilik video menonaktifkan opsi embed).',
            YoutubeError.videoNotFound || YoutubeError.cannotFindVideo =>
              'Video tidak ditemukan — mungkin sudah dihapus atau diset privat oleh pemiliknya.',
            _ => 'Video tidak bisa diputar di dalam aplikasi.',
          };
          return _UnavailableMediaCard(
            label: message,
            actionLabel: 'Buka di YouTube',
            onAction: _openInYoutubeApp,
          );
        }

        // `YoutubePlayer` (iframe) butuh constraint eksplisit, tidak
        // otomatis 16:9 seperti package lama — dibungkus `AspectRatio`
        // supaya tidak collapse jadi tinggi 0 di dalam `ListView`.
        return AspectRatio(
          aspectRatio: 16 / 9,
          child: YoutubePlayer(controller: _controller),
        );
      },
    );
  }
}

/// Ekstrak VIDEO_ID (11 karakter) dari berbagai format link YouTube.
///
/// FIX (video jadi "tidak tersedia" semua setelah migrasi package):
/// versi sebelumnya pakai 3 pola regex tetap (`youtu.be/`, `?v=`,
/// `youtube.com/embed/`) — kurang permisif dibanding `convertUrlToId`
/// bawaan package lama, sehingga format lain (mis. `/v/ID`, `/shorts/ID`,
/// atau urutan query param yang beda) gagal ke-parse dan jatuh ke
/// fallback "Video tidak tersedia" padahal link-nya valid.
///
/// Sekarang pakai `Uri.parse()` + baca `queryParameters`/`pathSegments`
/// langsung, jauh lebih toleran terhadap variasi format & urutan param
/// dibanding tebak-regex.
String? _extractYoutubeVideoId(String? url) {
  if (url == null || url.trim().isEmpty) return null;

  final trimmed = url.trim();

  // Fallback paling akhir: value sudah berupa ID murni 11 karakter
  // tanpa embel-embel URL sama sekali.
  bool looksLikeRawId(String s) => RegExp(r'^[a-zA-Z0-9_-]{11}$').hasMatch(s);

  final uri = Uri.tryParse(trimmed);
  if (uri == null || uri.host.isEmpty) {
    return looksLikeRawId(trimmed) ? trimmed : null;
  }

  final host = uri.host.toLowerCase();
  final segments = uri.pathSegments;

  // youtu.be/{ID}
  if (host.contains('youtu.be') && segments.isNotEmpty) {
    final candidate = segments.first;
    if (looksLikeRawId(candidate)) return candidate;
  }

  if (host.contains('youtube.com') || host.contains('youtube-nocookie.com')) {
    // watch?v={ID}  (juga menangkap m.youtube.com, music.youtube.com, dst.)
    final vParam = uri.queryParameters['v'];
    if (vParam != null && looksLikeRawId(vParam)) return vParam;

    // /embed/{ID}, /v/{ID}, /shorts/{ID}, /live/{ID}
    const prefixedPaths = ['embed', 'v', 'shorts', 'live'];
    for (var i = 0; i < segments.length - 1; i++) {
      if (prefixedPaths.contains(segments[i]) &&
          looksLikeRawId(segments[i + 1])) {
        return segments[i + 1];
      }
    }
  }

  // Terakhir: coba tiap path segment, siapa tahu link generik/pendek
  // yang tidak cocok pola di atas tapi salah satu segmennya persis ID.
  for (final segment in segments) {
    if (looksLikeRawId(segment)) return segment;
  }

  return looksLikeRawId(trimmed) ? trimmed : null;
}

class _UnavailableMediaCard extends StatelessWidget {
  const _UnavailableMediaCard({
    required this.label,
    this.actionLabel,
    this.onAction,
  });

  final String label;
  final String? actionLabel;
  final VoidCallback? onAction;

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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.error_outline),
              const SizedBox(width: 8),
              Expanded(child: Text(label)),
            ],
          ),
          if (actionLabel != null && onAction != null) ...[
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton.icon(
                onPressed: onAction,
                icon: const Icon(Icons.open_in_new, size: 18),
                label: Text(actionLabel!),
              ),
            ),
          ],
        ],
      ),
    );
  }
}