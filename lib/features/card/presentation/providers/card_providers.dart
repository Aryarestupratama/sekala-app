import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sekala_app/features/auth/presentation/providers/auth_providers.dart';
import '../../../../core/network/dio_client.dart';
import '../../../../shared/models/card_list_response.dart';
import '../../../../shared/models/vaccine_detail.dart';
import '../../data/card_api.dart';
import '../../data/card_repository_impl.dart';
import '../../domain/card_repository.dart';

final cardApiProvider = Provider<CardApi>((ref) {
  return CardApi(DioClient.instance.dio);
});

final cardRepositoryProvider = Provider<CardRepository>((ref) {
  return CardRepositoryImpl(ref.watch(cardApiProvider));
});

/// Rute ini cuma bisa dicapai user login terverifikasi (guard router +
/// middleware backend), jadi nggak perlu jaga-jaga guest di sini kayak
/// homeSummaryProvider.
///
/// BUGFIX: sebelumnya `.autoDispose`. Provider ini SELALU di-watch terus-
/// menerus oleh `MainShell` (badge titik merah tab Koleksi) sepanjang
/// sesi login, jadi tidak pernah benar-benar "tidak terpakai" — autoDispose
/// di sini tidak memberi manfaat apa pun, tapi menciptakan race: saat
/// `quiz_screen.dart::_finish()` memanggil `ref.invalidate(cardListProvider)`
/// tepat sebelum `context.go()` menavigasi (membongkar widget tree lama),
/// ada jendela singkat provider ini bisa kehilangan listener aktif
/// sebelum sempat refetch, sehingga invalidate "hilang" dan badge/animasi
/// reveal baru muncul setelah ada trigger watch/invalidate lain (mis.
/// pull-to-refresh manual di VaccineListScreen). Pola sama dengan bugfix
/// `caseStudyControllerProvider` sebelumnya — dihapus `.autoDispose`-nya,
/// provider ini aman hidup selama app berjalan (bukan `.family`).
final cardListProvider = FutureProvider<CardListResponse>((ref) async {
  // BUGFIX: sama seperti badgeListProvider — ikut rebuild saat status
  // verifikasi email berubah, tanpa perlu "Coba lagi" manual.
  await ref.watch(
    currentUserProvider.selectAsync((u) => u?.isEmailVerified),
  );
  return ref.watch(cardRepositoryProvider).fetchCards();
});

final vaccineDetailProvider =
    FutureProvider.family.autoDispose<VaccineDetail, int>((ref, vaccineId) {
  return ref.watch(cardRepositoryProvider).fetchVaccineDetail(vaccineId);
});