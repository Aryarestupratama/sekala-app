import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/network/dio_client.dart';
import '../../../../shared/models/year_summary_attempt.dart';
import '../../../../shared/models/year_summary_point_check_result.dart';
import '../../../../shared/models/year_summary_submit_result.dart';
import '../../../history/presentation/providers/history_providers.dart';
import '../../data/year_summary_api.dart';
import '../../data/year_summary_repository_impl.dart';
import '../../domain/year_summary_repository.dart';

final yearSummaryApiProvider = Provider<YearSummaryApi>((ref) {
  return YearSummaryApi(DioClient.instance.dio);
});

final yearSummaryRepositoryProvider = Provider<YearSummaryRepository>((ref) {
  return YearSummaryRepositoryImpl(ref.watch(yearSummaryApiProvider));
});

/// GET /years/{year}/summary — dipanggil ulang tiap YearSummaryScreen
/// dibuka (autoDispose), termasuk saat user tap "Kerjakan Ulang" (lewat
/// `ref.invalidate` di controller di bawah) supaya opsi diacak fresh lagi.
final yearSummaryAttemptProvider =
    FutureProvider.family.autoDispose<YearSummaryAttempt, int>((ref, yearId) {
  return ref.watch(yearSummaryRepositoryProvider).fetchSummary(yearId);
});

/// State loading/error untuk aksi checkAnswer()/submit() — sama pola
/// dengan QuizAnswerController di quiz_providers.dart.
class YearSummaryController extends StateNotifier<AsyncValue<void>> {
  YearSummaryController(this._ref) : super(const AsyncData(null));
  final Ref _ref;

  /// SUM-02: feedback instan 1 poin, TIDAK ada state loading global untuk
  /// ini (dibiarkan micro-interaction cepat, ditangani `_isChecking` lokal
  /// di widget, sama pola dengan QuizScreen._selectOption()) — return null
  /// kalau gagal (network dsb.), caller yang decide fallback UI-nya.
  Future<YearSummaryPointCheckResult?> checkAnswer({
    required int yearId,
    required int pointId,
    required int optionId,
  }) async {
    try {
      return await _ref.read(yearSummaryRepositoryProvider).checkAnswer(
            yearId: yearId,
            pointId: pointId,
            optionId: optionId,
          );
    } catch (_) {
      return null;
    }
  }

  /// Submit akhir setelah poin ke-7 (SUM-05/R-SUM-11). Begitu sukses,
  /// invalidate `yearsProvider(eraSlug)` supaya roadmap & field
  /// `yearSummaryCompleted`/status tombol Kuis ter-refresh (sama pola
  /// dengan SectionCompletionController di history_providers.dart), DAN
  /// invalidate `yearSummaryAttemptProvider(yearId)` supaya cache-nya
  /// tidak basi (completion masih null) kalau user balik lagi ke layar
  /// ini nanti. Dulu yang kedua ini sengaja TIDAK di-invalidate karena
  /// takut bikin layar hasil submit ke-teardown balik ke spinner — sudah
  /// tidak masalah lagi setelah YearSummaryScreen dipindah dari
  /// `.when(loading:...)` ke pola `.hasValue` (lihat komentar di sana).
  Future<YearSummarySubmitResult?> submit({
    required int yearId,
    required Map<int, int> answers,
    required String eraSlug,
  }) async {
    state = const AsyncLoading();
    try {
      final result = await _ref.read(yearSummaryRepositoryProvider).submit(
            yearId: yearId,
            answers: answers,
          );
      _ref.invalidate(yearsProvider(eraSlug));
      _ref.invalidate(yearSummaryAttemptProvider(yearId));
      state = const AsyncData(null);
      return result;
    } catch (e, st) {
      state = AsyncError(e, st);
      return null;
    }
  }
}

final yearSummaryControllerProvider =
    StateNotifierProvider.autoDispose<YearSummaryController, AsyncValue<void>>(
  (ref) => YearSummaryController(ref),
);