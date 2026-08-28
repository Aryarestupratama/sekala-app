import 'package:flutter/material.dart';

/// Placeholder — logic cek token sudah jalan otomatis di
/// AuthNotifier._restoreSession() (dipanggil dari constructor).
/// Screen ini cuma tampil sebentar sambil nunggu status berubah dari
/// `checking`, lalu redirect guard di app_router.dart yang mindahin ke
/// /auth atau /home. Nanti tinggal ganti body-nya jadi splash SEKALA
/// (logo, dsb) tanpa perlu ubah logic apapun.
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
