import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/network/dio_client.dart';
import '../../../../shared/models/era.dart';
import '../../../../shared/models/era_roadmap.dart';
import '../../../../shared/models/section.dart';
import '../../../../shared/models/section_completion_result.dart';
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

final erasProvider = FutureProvider.autoDispose<List<Era>>((ref) {
  return ref.watch(historyRepositoryProvider).fetchEras();
});

final yearsProvider =
    FutureProvider.family.autoDispose<EraRoadmap, String>((ref, eraSlug) {
  return ref.watch(historyRepositoryProvider).fetchYears(eraSlug);
});

final yearInEraProvider = FutureProvider.family
    .autoDispose<Year?, ({String eraSlug, int yearId})>((ref, params) async {
  final roadmap = await ref.watch(yearsProvider(params.eraSlug).future);
  for (final year in roadmap.years) {
    if (year.id == params.yearId) return year;
  }
  return null;
});

final sectionDetailProvider =
    FutureProvider.family.autoDispose<Section, int>((ref, sectionId) {
  return ref.watch(historyRepositoryProvider).fetchSectionDetail(sectionId);
});

final sectionJustCompletedProvider =
    StateProvider.family.autoDispose<bool, int>((ref, sectionId) => false);

/// State loading/error untuk aksi "tandai selesai baca" (INFO-03).
class SectionCompletionController extends StateNotifier<AsyncValue<void>> {
  SectionCompletionController(this._ref) : super(const AsyncData(null));
  final Ref _ref;

  /// BARU: return `SectionCompletionResult?` (sebelumnya `bool`) — null
  /// berarti gagal (semantik sama seperti `false` dulu), non-null berarti
  /// sukses DAN sekalian bawa `year_completed`/`newlyUnlockedVaccineIds`
  /// dari backend, dipakai caller (SectionDetailScreen) buat nentuin
  /// auto-redirect ke Rangkuman Wabah.
  Future<SectionCompletionResult?> complete(int sectionId) async {
    state = const AsyncLoading();
    try {
      final result =
          await _ref.read(historyRepositoryProvider).completeSection(sectionId);

      _ref.read(sectionJustCompletedProvider(sectionId).notifier).state = true;

      final cachedSection = _ref.read(sectionDetailProvider(sectionId)).valueOrNull;
      if (cachedSection != null) {
        _ref.invalidate(yearsProvider(cachedSection.year.era.slug));
      }
      _ref.invalidate(homeSummaryProvider);

      state = const AsyncData(null);
      return result;
    } catch (e, st) {
      state = AsyncError(e, st);
      return null;
    }
  }
}

/// BUKAN `.autoDispose` (bugfix — sama persis kelas bug yang sudah pernah
/// ditemukan & diperbaiki di `caseStudyControllerProvider`,
/// `case_study_providers.dart`, progress.md "Bug ke-2"): `SectionDetailScreen`
/// hanya `ref.read(...).complete(sectionId)` untuk memicu aksi, TIDAK
/// pernah `watch` `AsyncValue` controller ini (loading state tombol
/// dikelola state lokal). Selama `.autoDispose`, Riverpod membuang
/// provider ini SEGERA setelah `ref.read()` (tidak ada listener aktif),
/// yaitu SEBELUM `complete()` (async, nunggu network) selesai — begitu
/// response datang dan method mencoba `_ref.invalidate(yearsProvider(...))`
/// / `_ref.invalidate(homeSummaryProvider)`, `_ref` sudah tidak valid lagi
/// (disposed), sehingga kedua invalidate itu gagal diam-diam (exception
/// ketangkep try/catch generik atau race, tergantung timing) — inilah
/// sebab Home & Era List/Roadmap tidak update realtime setelah user
/// menyelesaikan section bacaan biasa (BUKAN studi kasus, yang jalur
/// controllernya sudah tidak `.autoDispose` sejak awal & karena itu aman).
/// Provider ini bukan `.family`, aman hidup selama app berjalan.
final sectionCompletionControllerProvider =
    StateNotifierProvider<SectionCompletionController, AsyncValue<void>>(
  (ref) => SectionCompletionController(ref),
);