import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/network/dio_client.dart';
import '../../../../shared/models/case_study_detail.dart';
import '../../../../shared/models/case_study_submit_result.dart';
import '../../../history/presentation/providers/history_providers.dart';
import '../../../home/presentation/providers/home_providers.dart';
import '../../data/case_study_api.dart';
import '../../data/case_study_repository_impl.dart';
import '../../domain/case_study_repository.dart';

final caseStudyApiProvider = Provider<CaseStudyApi>((ref) {
  return CaseStudyApi(DioClient.instance.dio);
});

final caseStudyRepositoryProvider = Provider<CaseStudyRepository>((ref) {
  return CaseStudyRepositoryImpl(ref.watch(caseStudyApiProvider));
});

/// GET /sections/{section}/case-study — key = id section (case_study).
///
/// PENTING (pelajaran dari bug Rangkuman & era quiz): backend mengacak
/// urutan 5 opsi TIAP request. Provider ini `autoDispose`, jadi selama
/// layar studi kasus terpasang dan meng-`watch`-nya, hasil fetch tetap
/// 1 dan urutan opsi stabil. Konsekuensinya:
/// - Layar WAJIB `watch` provider ini terus selama sesi (jangan hanya
///   `read` sekali), dan pakai pola `.hasValue`/`.valueOrNull` alih-alih
///   `.when(loading:)` yang menghancurkan State lokal saat refresh.
/// - Controller di bawah SENGAJA tidak meng-invalidate provider ini
///   setelah submit (akan mengacak ulang opsi & memicu refetch di tengah
///   layar hasil). Cache basi otomatis hilang saat layar ditutup
///   (autoDispose), dan fetch ulang saat dibuka lagi mengembalikan
///   `completed` yang terbaru.
final caseStudyDetailProvider =
    FutureProvider.family.autoDispose<CaseStudyDetail, int>((ref, sectionId) {
  return ref.watch(caseStudyRepositoryProvider).fetchCaseStudy(sectionId);
});

/// State loading/error untuk aksi submit — sama pola dengan
/// `YearSummaryController`/`SectionCompletionController`.
class CaseStudyController extends StateNotifier<AsyncValue<void>> {
  CaseStudyController(this._ref) : super(const AsyncData(null));
  final Ref _ref;

  /// Submit analisis. Mengembalikan null kalau gagal (network, 422
  /// validasi, 403 gate) — detail error tersedia di `state`
  /// (`AsyncError`), caller yang menentukan pesan ke user (mis.
  /// SnackBar, pelajaran bug kuis sumatif yang diam saja saat 422).
  ///
  /// Kalau `isCorrect == true`, section otomatis completed di backend
  /// (R-CASE-10), jadi di sini:
  /// - `sectionJustCompletedProvider(sectionId)` di-set true (dipakai
  ///   `SectionDetailScreen` untuk status completed sebelum roadmap
  ///   sempat di-refetch),
  /// - `yearsProvider(eraSlug)` & `homeSummaryProvider` di-invalidate
  ///   supaya roadmap/progress/gate section 9 ter-refresh.
  /// [eraSlug] kosong -> invalidate roadmap dilewati (aman, hanya
  /// tertunda sampai roadmap di-refetch sendiri).
  ///
  /// Jawaban salah TIDAK menyentuh cache/progress apa pun (attempt
  /// terakhir memang tersimpan di server, tapi tidak memengaruhi
  /// completion).
  Future<CaseStudySubmitResult?> submit({
    required int sectionId,
    required List<int> slotOptionIds,
    required String reason,
    required String eraSlug,
  }) async {
    state = const AsyncLoading();
    try {
      final result = await _ref.read(caseStudyRepositoryProvider).submit(
            sectionId: sectionId,
            slotOptionIds: slotOptionIds,
            reason: reason,
          );

      if (result.isCorrect) {
        _ref.read(sectionJustCompletedProvider(sectionId).notifier).state =
            true;
        if (eraSlug.isNotEmpty) {
          _ref.invalidate(yearsProvider(eraSlug));
        }
        _ref.invalidate(homeSummaryProvider);
      }

      state = const AsyncData(null);
      return result;
    } catch (e, st) {
      state = AsyncError(e, st);
      return null;
    }
  }
}

/// BUKAN `.autoDispose` (sengaja beda dari `caseStudyDetailProvider` di
/// atas) — `CaseStudyDecisionView` mengelola status loading-nya SENDIRI
/// lewat `_submitting` (variabel lokal di widget), TIDAK PERNAH `watch`
/// `AsyncValue` controller ini. Kalau provider ini `.autoDispose`,
/// Riverpod akan membuangnya begitu tidak ada watcher — yaitu SEGERA
/// setelah `ref.read(...)` dipanggil, sebelum `submit()` (async, nunggu
/// network) sempat selesai. Begitu response datang dan controller
/// mencoba `state = ...`, providernya sudah tidak ada lagi ->
/// `Bad state: Tried to use CaseStudyController after dispose was
/// called.` (bug yang sempat kejadian). Karena provider ini tidak
/// menyimpan data per-section (bukan `.family`), aman dibiarkan hidup
/// selama app berjalan.
final caseStudyControllerProvider =
    StateNotifierProvider<CaseStudyController, AsyncValue<void>>(
  (ref) => CaseStudyController(ref),
);