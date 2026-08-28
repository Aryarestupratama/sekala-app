import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/network/dio_client.dart';
import '../../../../shared/models/era.dart';
import '../../../../shared/models/section.dart';
import '../../../../shared/models/year.dart';
import '../../../home/presentation/providers/home_providers.dart';
import '../../data/history_api.dart';
import '../../data/history_repository_impl.dart';
import '../../domain/history_repository.dart';

final historyApiProvider = Provider<HistoryApi>((ref) {
  return HistoryApi(DioClient.instance.dio);
});

final historyRepositoryProvider = Provider<HistoryRepository>((ref) {
  return HistoryRepositoryImpl(ref.watch(historyApiProvider));
});

/// Endpoint publik — dipakai bareng oleh Home (HOME-03: 3 pilihan masa
/// selalu tampil) dan History (entry point ke roadmap tahun). Sama untuk
/// guest maupun user login, jadi nggak perlu watch authNotifierProvider
/// di sini.
final erasProvider = FutureProvider.autoDispose<List<Era>>((ref) {
  return ref.watch(historyRepositoryProvider).fetchEras();
});

/// Roadmap tahun per era (INFO-01). `.family` karena butuh parameter
/// eraSlug — tiap era punya cache list tahun sendiri-sendiri.
final yearsProvider =
    FutureProvider.family.autoDispose<List<Year>, String>((ref, eraSlug) {
  return ref.watch(historyRepositoryProvider).fetchYears(eraSlug);
});

/// Detail section (INFO-02). `.family` karena butuh parameter sectionId.
final sectionDetailProvider =
    FutureProvider.family.autoDispose<Section, int>((ref, sectionId) {
  return ref.watch(historyRepositoryProvider).fetchSectionDetail(sectionId);
});

/// Status "selesai baca" khusus buat keperluan UI (nampilin tombol kuis)
/// dalam sesi berjalan — BUKAN dari field API (backend nggak expose
/// status completion balik ke client, lihat catatan di Section model).
/// autoDispose: reset ke false lagi kalau user keluar dari screen section
/// ini & balik lagi nanti — konsisten sama makna "per sesi baca".
final sectionJustCompletedProvider =
    StateProvider.family.autoDispose<bool, int>((ref, sectionId) => false);

/// State loading/error untuk aksi "tandai selesai baca" (INFO-03).
/// Dipisah dari sectionDetailProvider (yang murni read) supaya UI bisa
/// nunjukin loading state khusus pas proses completion tanpa bikin
/// seluruh section detail ke-refetch dari awal.
class SectionCompletionController extends StateNotifier<AsyncValue<void>> {
  SectionCompletionController(this._ref) : super(const AsyncData(null));
  final Ref _ref;

  Future<bool> complete(int sectionId) async {
    state = const AsyncLoading();
    try {
      await _ref.read(historyRepositoryProvider).completeSection(sectionId);

      // Tandai selesai secara lokal (lihat sectionJustCompletedProvider) —
      // sectionDetailProvider SENGAJA nggak di-invalidate di sini karena
      // isi section (title/content_blocks/year/figures) nggak berubah
      // sama sekali cuma gara-gara completion, jadi refetch bakal sia-sia.
      _ref.read(sectionJustCompletedProvider(sectionId).notifier).state = true;

      // Refresh progress Home (HOME-01/02). Kalau data section-nya masih
      // ke-cache, sekalian invalidate roadmap era yang relevan (walau
      // checkmark-nya sendiri masih gap backend terpisah, lihat diskusi
      // sebelumnya — ini future-proofing begitu itu ditambahin).
      final cachedSection = _ref.read(sectionDetailProvider(sectionId)).valueOrNull;
      if (cachedSection != null) {
        _ref.invalidate(yearsProvider(cachedSection.year.era.slug));
      }
      _ref.invalidate(homeSummaryProvider);

      state = const AsyncData(null);
      return true;
    } catch (e, st) {
      state = AsyncError(e, st);
      return false;
    }
  }
}

final sectionCompletionControllerProvider =
    StateNotifierProvider.autoDispose<SectionCompletionController, AsyncValue<void>>(
  (ref) => SectionCompletionController(ref),
);
