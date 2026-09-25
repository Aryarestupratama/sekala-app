import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:video_player/video_player.dart';

import '../providers/splash_providers.dart';

/// Splash screen dengan video intro SEKALA (tanpa suara, asset lokal).
///
/// Logic cek token tetap jalan otomatis di AuthNotifier._restoreSession()
/// (dipanggil dari constructor) — TIDAK diubah di sini.
///
/// Yang baru: screen ini menahan redirect sampai video selesai diputar
/// (lihat `splashVideoFinishedProvider`). Redirect guard di app_router.dart
/// perlu diperbarui supaya menunggu KEDUA kondisi: authStatus != checking
/// DAN splashVideoFinishedProvider == true. Lihat catatan di bawah class ini.
///
/// Kalau video gagal dimuat (file corrupt/asset hilang), fallback: tidak
/// ada splash visual sama sekali, langsung tandai selesai supaya redirect
/// jalan tanpa nunggu.
class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  /// Ganti path ini sesuai nama file video final & pastikan terdaftar
  /// di pubspec.yaml (lihat catatan di bawah).
  static const String _videoAssetPath = 'assets/videos/splash_intro.mp4';

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  VideoPlayerController? _controller;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _initVideo();
  }

  Future<void> _initVideo() async {
    final controller =
        VideoPlayerController.asset(SplashScreen._videoAssetPath);
    _controller = controller;

    try {
      await controller.initialize();
      if (!mounted) return;

      await controller.setVolume(0); // tanpa suara
      await controller.setLooping(false);

      controller.addListener(_onVideoTick);
      await controller.play();
      setState(() {}); // trigger rebuild supaya VideoPlayer tampil
    } catch (_) {
      // Asset gagal dimuat — fallback: tidak ada splash visual,
      // langsung tandai selesai supaya redirect jalan.
      if (!mounted) return;
      setState(() => _hasError = true);
      _markFinished();
    }
  }

  void _onVideoTick() {
    final controller = _controller;
    if (controller == null || !controller.value.isInitialized) return;

    final isFinished = controller.value.position >= controller.value.duration;
    if (isFinished) {
      controller.removeListener(_onVideoTick);
      _markFinished();
    }
  }

  void _markFinished() {
    // Idempotent — aman dipanggil lebih dari sekali.
    if (!ref.read(splashVideoFinishedProvider)) {
      ref.read(splashVideoFinishedProvider.notifier).state = true;
    }
  }

  @override
  void dispose() {
    _controller?.removeListener(_onVideoTick);
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = _controller;

    // Video gagal dimuat: layar kosong, tidak ada spinner/splash visual,
    // sesuai keputusan — redirect sudah dipicu dari _initVideo().
    if (_hasError) {
      return const Scaffold(body: SizedBox.shrink());
    }

    final isReady = controller != null && controller.value.isInitialized;

    return Scaffold(
      backgroundColor: Colors.black,
      body: isReady
          ? Center(
              child: AspectRatio(
                aspectRatio: controller.value.aspectRatio,
                child: VideoPlayer(controller),
              ),
            )
          // Selagi video masih dimuat (belum initialized), tidak ada
          // spinner — cukup layar kosong supaya tidak "kedip" sebelum
          // video mulai.
          : const SizedBox.shrink(),
    );
  }
}