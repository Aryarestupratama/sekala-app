import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../shared/models/content_block.dart';
import '../../../../shared/models/content_block_type.dart';
import '../../../../shared/widgets/pressable_scale.dart';

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
                    child: _MediaSkeleton(),
                  ),
                  errorWidget: (context, url, error) => AspectRatio(
                    aspectRatio: 16 / 9,
                    child: Container(
                      color: AppColors.border.withValues(alpha: 0.3),
                      child: const Icon(Icons.broken_image_outlined, color: AppColors.textSecondary),
                    ),
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
        // MIGRASI YouTube -> Google Drive, lalu MIGRASI LAGI dari WebView
        // (embed halaman `/preview` Drive) -> native player `video_player`
        // + `chewie` (progress.md — backlog "Flutter — render video block
        // via Google Drive").
        //
        // Alasan migrasi kedua: embed `/preview` selalu membawa toolbar
        // bawaan halaman Drive (progress bar, tombol volume/setting/
        // maximize) yang ukurannya relatif besar & tidak bisa
        // disembunyikan tanpa memodifikasi DOM halaman pihak ketiga
        // (rapuh, berisiko rusak sewaktu-waktu). Native player kontrolnya
        // full didesain sendiri, jadi masalah toolbar itu hilang total.
        //
        // `fileId` (bukan lagi full embed URL) yang dioper ke
        // `_DriveVideoBlockPlayer` — dipakai untuk 2 hal: URL thumbnail
        // publik Drive (tampilan sebelum tap Play) dan URL direct-download
        // Drive (byte video mentah yang dikonsumsi `video_player`
        // langsung, lihat catatan risiko di `_directVideoUrl`).
        final fileId = _extractDriveFileId(block.resolvedUrl) ??
            _extractDriveFileId(block.content);
        if (fileId == null || fileId.isEmpty) {
          return const _UnavailableMediaCard(label: 'Video tidak tersedia');
        }
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: _DriveVideoBlockPlayer(
                  key: ValueKey('drive-video-$fileId'),
                  fileId: fileId,
                ),
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
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: PressableScale(
            onTap: () => showDialog<void>(
              context: context,
              barrierDismissible: false,
              builder: (_) => _PdfPreviewDialog(url: pdfUrl),
            ),
            child: Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.border),
              ),
              child: Row(
                children: [
                  Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      color: AppColors.ink.withValues(alpha: 0.08),
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: const Icon(Icons.picture_as_pdf_rounded, color: AppColors.ink, size: 20),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Text(
                      'Buka dokumen PDF',
                      style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
                    ),
                  ),
                  const Icon(Icons.open_in_new_rounded, size: 18, color: AppColors.textSecondary),
                ],
              ),
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

/// MIGRASI YouTube -> Google Drive -> native player (`video_player` +
/// `chewie`) (progress.md, backlog "Flutter — render video block via
/// Google Drive").
///
/// Versi sebelumnya me-render halaman `drive.google.com/.../preview`
/// lewat WebView — ternyata halaman itu punya toolbar bawaan (progress
/// bar, tombol volume/setting/maximize) yang cukup besar dan TIDAK bisa
/// disembunyikan tanpa memodifikasi DOM halaman pihak ketiga (rapuh,
/// berisiko rusak sewaktu-waktu kalau Google ubah markup-nya). Sekarang
/// diganti total: `video_player` memutar **byte video mentah** langsung
/// dari direct-download link Drive (lihat `_directVideoUrl`), dan
/// `chewie` menyediakan UI kontrol (play/pause/seek/volume/fullscreen)
/// yang didesain sendiri — tidak ada lagi WebView/toolbar Drive sama
/// sekali untuk video.
///
/// LAZY-LOAD (tetap dipertahankan dari versi WebView): `VideoPlayerController`
/// baru dibuat & di-`initialize()` saat user tap Play (`_startPlayback`),
/// bukan langsung saat block dirender — sebelum itu cukup thumbnail
/// publik Drive (`drive.google.com/thumbnail?id=...`) + tombol Play,
/// supaya tidak ada beberapa video sekaligus mem-buffer di background
/// begitu section dibuka (section bisa punya maks 2 video sekaligus,
/// lihat Architecture.md §Backend).
///
/// DISPOSE SAAT KELUAR VIEWPORT (tetap dipertahankan): dibungkus
/// `VisibilityDetector` dengan grace period 1 detik setelah start +
/// debounce 400ms sebelum benar-benar dispose (lihat komentar di
/// `_startPlayback`/`onVisibilityChanged` bawah) — mencegah bug loop
/// yang sempat terjadi di versi WebView (`visibleFraction` sempat
/// dilaporkan rendah secara sesaat pas platform view baru attach).
class _DriveVideoBlockPlayer extends StatefulWidget {
  const _DriveVideoBlockPlayer({super.key, required this.fileId});

  final String fileId;

  @override
  State<_DriveVideoBlockPlayer> createState() => _DriveVideoBlockPlayerState();
}

class _DriveVideoBlockPlayerState extends State<_DriveVideoBlockPlayer> {
  VideoPlayerController? _videoController;
  ChewieController? _chewieController;
  bool _playing = false;
  bool _initializing = false;
  String? _errorMessage;

  // Grace period + debounce visibility — lihat docstring class di atas
  // & penjelasan lengkap di `onVisibilityChanged` bawah.
  DateTime? _playbackStartedAt;
  Timer? _visibilityDebounce;

  // Endpoint thumbnail publik Drive — jalan asal file di-share "Anyone
  // with the link" (syarat yang sama dengan validasi link Drive lain,
  // R-CMS-05/06), tanpa perlu API key/OAuth.
  String get _thumbnailUrl =>
      'https://drive.google.com/thumbnail?id=${widget.fileId}&sz=w1024';

  // Direct-download link Drive — byte video mentah, dikonsumsi
  // `video_player` (ExoPlayer/AVPlayer) langsung, BUKAN lagi di-render
  // sebagai halaman HTML lewat WebView seperti versi sebelumnya. Ini
  // yang menghilangkan toolbar/chrome bawaan Drive sepenuhnya.
  //
  // CATATAN RISIKO (baca sebelum debug kalau video gagal muat di
  // lapangan): endpoint ini TIDAK resmi didukung Google untuk hotlink
  // streaming — sama kelas risikonya dengan endpoint thumbnail publik
  // yang sudah lebih dulu dipakai di app ini. Untuk file yang cukup
  // besar, Drive KADANG menyajikan halaman HTML "Google Drive tidak
  // bisa memindai file ini untuk virus" alih-alih byte video langsung
  // — kalau ini terjadi, `video_player` akan gagal `initialize()` dan
  // otomatis jatuh ke `_UnavailableMediaCard` (tombol "Buka di Drive").
  // Karena app ini sudah membatasi maks 50MB/file video (progress.md),
  // risiko ini relatif kecil tapi TIDAK nol — kalau sering kejadian di
  // lapangan, pertimbangkan proxy video lewat backend sendiri sebagai
  // solusi jangka panjang yang lebih robust.
  String get _directVideoUrl =>
      'https://drive.google.com/uc?export=download&id=${widget.fileId}';

  Future<void> _startPlayback() async {
    _visibilityDebounce?.cancel();
    _playbackStartedAt = DateTime.now();
    setState(() {
      _playing = true;
      _initializing = true;
      _errorMessage = null;
    });

    final controller = VideoPlayerController.networkUrl(Uri.parse(_directVideoUrl));
    try {
      await controller.initialize();
      if (!mounted) {
        controller.dispose();
        return;
      }
      final chewie = ChewieController(
        videoPlayerController: controller,
        autoPlay: true,
        looping: false,
        aspectRatio:
            controller.value.aspectRatio == 0 ? 16 / 9 : controller.value.aspectRatio,
        materialProgressColors: ChewieProgressColors(
          playedColor: AppColors.ink,
          handleColor: AppColors.ink,
        ),
        errorBuilder: (context, errorMessage) => _UnavailableMediaCard(
          label: 'Video tidak bisa diputar di dalam aplikasi.',
          actionLabel: 'Buka di Drive',
          onAction: _openInDriveApp,
        ),
      );
      if (!mounted) {
        chewie.dispose();
        controller.dispose();
        return;
      }
      setState(() {
        _videoController = controller;
        _chewieController = chewie;
        _initializing = false;
      });
    } catch (_) {
      controller.dispose();
      // FIX (video gagal dimuat, mis. respons Drive ternyata halaman
      // HTML "tidak bisa scan virus" bukan byte video, atau format
      // tidak didukung codec device) — jangan biarkan `_initializing`
      // nyangkut true selamanya, fallback ke kartu error + tombol
      // "Buka di Drive" (pola sama seperti `_PdfPreviewDialog`).
      if (mounted) {
        setState(() {
          _initializing = false;
          _errorMessage =
              'Gagal memuat video. Video mungkin terlalu besar, formatnya tidak didukung, atau koneksi bermasalah.';
        });
      }
    }
  }

  void _stopPlayback() {
    if (!_playing) return;
    _visibilityDebounce?.cancel();
    _playbackStartedAt = null;
    _chewieController?.dispose();
    _videoController?.dispose();
    _chewieController = null;
    _videoController = null;
    if (mounted) {
      setState(() {
        _playing = false;
        _initializing = false;
        _errorMessage = null;
      });
    }
  }

  Future<void> _openInDriveApp() async {
    final uri = Uri.parse('https://drive.google.com/file/d/${widget.fileId}/view');
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  @override
  void dispose() {
    _visibilityDebounce?.cancel();
    _chewieController?.dispose();
    _videoController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: ValueKey('drive-video-visibility-${widget.fileId}'),
      onVisibilityChanged: (info) {
        if (!_playing) return;

        // Lapis 1: grace period 1 detik sejak playback dimulai —
        // abaikan total, controller masih proses initialize/attach awal
        // (warisan fix bug loop dari versi WebView, tetap relevan di
        // sini karena prinsipnya sama: rebuild/attach awal bisa bikin
        // ukuran widget sempat 0 secara sesaat).
        final startedAt = _playbackStartedAt;
        if (startedAt != null &&
            DateTime.now().difference(startedAt) < const Duration(seconds: 1)) {
          return;
        }

        if (info.visibleFraction >= 0.05) {
          // Masih/kembali terlihat cukup -> batalkan rencana stop kalau
          // ada yang sedang menunggu di lapis 2.
          _visibilityDebounce?.cancel();
          return;
        }

        // Lapis 2: debounce 400ms — baru benar-benar dispose kalau
        // setelah jeda ini video TETAP di bawah ambang (beneran
        // ter-scroll keluar, bukan dip sesaat).
        _visibilityDebounce?.cancel();
        _visibilityDebounce = Timer(const Duration(milliseconds: 400), () {
          if (mounted && _playing) _stopPlayback();
        });
      },
      // Native player tidak punya masalah toolbar Drive lagi, jadi cukup
      // `AspectRatio` 16:9 biasa untuk semua state (thumbnail, loading,
      // error, maupun playing) — tidak perlu lagi hitung tinggi ekstra
      // seperti versi WebView sebelumnya.
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: _errorMessage != null
            ? _UnavailableMediaCard(
                label: _errorMessage!,
                actionLabel: 'Buka di Drive',
                onAction: _openInDriveApp,
              )
            : !_playing
                ? _VideoThumbnailWithPlayButton(
                    thumbnailUrl: _thumbnailUrl,
                    onTap: () => _startPlayback(),
                  )
                : (_initializing || _chewieController == null)
                    ? const ColoredBox(
                        color: Colors.black,
                        child: Center(
                          child: CircularProgressIndicator(color: Colors.white),
                        ),
                      )
                    : Chewie(controller: _chewieController!),
      ),
    );
  }
}

/// Thumbnail + tombol Play — tampilan awal sebelum player native
/// di-mount (lihat docstring `_DriveVideoBlockPlayer`).
class _VideoThumbnailWithPlayButton extends StatelessWidget {
  const _VideoThumbnailWithPlayButton({
    required this.thumbnailUrl,
    required this.onTap,
  });

  final String thumbnailUrl;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return PressableScale(
      scale: 0.98,
      onTap: onTap,
      child: Stack(
        fit: StackFit.expand,
        children: [
          CachedNetworkImage(
            imageUrl: thumbnailUrl,
            fit: BoxFit.cover,
            placeholder: (context, url) => const _MediaSkeleton(),
            // Thumbnail publik Drive kadang gagal dimuat (mis. preview
            // belum sempat di-generate Drive, atau permission "Anyone
            // with the link" belum aktif) — fallback ke ikon video
            // generik, TAPI tombol Play tetap ditampilkan (bukan
            // `_UnavailableMediaCard`), karena thumbnail gagal bukan
            // berarti video-nya sendiri tidak bisa diputar.
            errorWidget: (context, url, error) => Container(
              color: AppColors.ink,
              child: const Icon(Icons.movie_outlined, color: Colors.white54, size: 40),
            ),
          ),
          Container(color: Colors.black.withValues(alpha: 0.25)),
          const Center(
            child: Icon(Icons.play_circle_fill, color: Colors.white, size: 64),
          ),
        ],
      ),
    );
  }
}

/// Ekstrak FILE_ID dari berbagai format link Google Drive
/// (`/file/d/{FILE_ID}/...`, `?id={FILE_ID}` seperti pada `open`/`uc`/
/// `thumbnail`), sama filosofinya dengan validasi `ValidGoogleDriveLink`
/// di backend (Rules.md R-CMS-05) — kalau `Uri.tryParse` gagal kenali
/// host/pathnya, fallback terakhir anggap `url` itu sendiri sudah
/// berupa FILE_ID mentah.
String? _extractDriveFileId(String? url) {
  if (url == null || url.trim().isEmpty) return null;

  final trimmed = url.trim();

  // FILE_ID Google Drive umumnya 25+ karakter alfanumerik/-/_ — dibuat
  // longgar (15+) supaya tetap toleran terhadap variasi panjang ID.
  bool looksLikeRawId(String s) => RegExp(r'^[a-zA-Z0-9_-]{15,}$').hasMatch(s);

  final uri = Uri.tryParse(trimmed);
  if (uri == null || uri.host.isEmpty) {
    return looksLikeRawId(trimmed) ? trimmed : null;
  }

  final host = uri.host.toLowerCase();
  if (!host.contains('drive.google.com') && !host.contains('docs.google.com')) {
    return looksLikeRawId(trimmed) ? trimmed : null;
  }

  final segments = uri.pathSegments;

  // /file/d/{FILE_ID}/(view|preview|...)
  for (var i = 0; i < segments.length - 1; i++) {
    if (segments[i] == 'd' && looksLikeRawId(segments[i + 1])) {
      return segments[i + 1];
    }
  }

  // open?id={FILE_ID}, uc?id={FILE_ID}, thumbnail?id={FILE_ID}
  final idParam = uri.queryParameters['id'];
  if (idParam != null && looksLikeRawId(idParam)) return idParam;

  // Terakhir: coba tiap path segment, siapa tahu formatnya di luar pola
  // di atas tapi salah satu segmennya persis FILE_ID.
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
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.border.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 34,
                height: 34,
                decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                alignment: Alignment.center,
                child: const Icon(Icons.error_outline_rounded, size: 18, color: AppColors.textSecondary),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(label, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
              ),
            ],
          ),
          if (actionLabel != null && onAction != null) ...[
            const SizedBox(height: 14),
            Align(
              alignment: Alignment.centerRight,
              child: PressableScale(
                onTap: onAction,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
                  decoration: BoxDecoration(
                    color: AppColors.ink,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.open_in_new_rounded, size: 15, color: Colors.white),
                      const SizedBox(width: 6),
                      Text(
                        actionLabel!,
                        style: const TextStyle(color: Colors.white, fontSize: 12.5, fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

/// Skeleton berdenyut untuk placeholder media (gambar/video) yang masih
/// loading — menggantikan spinner polos, murni visual, tidak mengubah
/// kapan/bagaimana media sebenarnya dimuat.
class _MediaSkeleton extends StatefulWidget {
  const _MediaSkeleton();

  @override
  State<_MediaSkeleton> createState() => _MediaSkeletonState();
}

class _MediaSkeletonState extends State<_MediaSkeleton> with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1000),
  )..repeat(reverse: true);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        return Container(
          color: Color.lerp(
            const Color(0xFFEDEEF0),
            const Color(0xFFE2E4E7),
            Curves.easeInOut.transform(_controller.value),
          ),
          child: const Center(
            child: Icon(Icons.image_outlined, color: Color(0xFFC7C9CD), size: 28),
          ),
        );
      },
    );
  }
}