import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/network/dio_client.dart';
import '../../../../shared/models/wabah_intro.dart';
import '../../data/wabah_intro_api.dart';
import '../../data/wabah_intro_repository_impl.dart';
import '../../domain/wabah_intro_repository.dart';

final wabahIntroApiProvider = Provider<WabahIntroApi>((ref) {
  return WabahIntroApi(DioClient.instance.dio);
});

final wabahIntroRepositoryProvider = Provider<WabahIntroRepository>((ref) {
  return WabahIntroRepositoryImpl(ref.watch(wabahIntroApiProvider));
});

/// Konten "Apa itu Wabah" — dipanggil untuk guest MAUPUN user login (beda
/// dari homeSummaryProvider yang cuma jalan kalau authenticated), karena
/// endpoint publiknya memang tidak butuh auth sama sekali (PRD.md INFO
/// intro wajib terjangkau guest juga). Null kalau admin belum publish
/// konten -> pemanggil (ikon info / modal) harus sembunyikan diri total.
///
/// CATATAN (INTRO-01 dihapus): tidak ada lagi konsep "sudah lihat" untuk
/// fitur ini — dulu ada `wabahIntroSeenProvider`/`WabahIntroSeenNotifier`
/// (FlutterSecureStorage) untuk auto-show sekali di awal, tapi auto-show
/// sudah dihapus total dari spec (satu-satunya entry point sekarang ikon
/// info di header roadmap era, lihat era_roadmap_screen.dart). Jangan
/// tambahkan lagi provider "seen" ini kecuali auto-show benar-benar
/// dihidupkan kembali di masa depan.
final wabahIntroProvider = FutureProvider.autoDispose<WabahIntro?>((ref) {
  return ref.watch(wabahIntroRepositoryProvider).fetchWabahIntro();
});