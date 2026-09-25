import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Menandai apakah video intro splash sudah selesai diputar (atau gagal
/// dimuat dan langsung dianggap selesai). Redirect guard di
/// app_router.dart perlu menunggu provider ini `true` sebelum memindahkan
/// user ke /auth atau /home — TAMBAHAN di atas pengecekan authStatus yang
/// sudah ada, bukan pengganti.
final splashVideoFinishedProvider = StateProvider<bool>((ref) => false);