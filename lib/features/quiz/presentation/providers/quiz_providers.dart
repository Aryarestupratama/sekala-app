import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/network/dio_client.dart';
import '../../../../shared/models/quiz.dart';
import '../../../../shared/models/quiz_answer_check_result.dart';
import '../../../../shared/models/quiz_submit_response.dart';
import '../../../history/presentation/providers/history_providers.dart';
import '../../data/quiz_api.dart';
import '../../data/quiz_repository_impl.dart';
import '../../domain/quiz_repository.dart';

final quizApiProvider = Provider<QuizApi>((ref) {
  return QuizApi(DioClient.instance.dio);
});

final quizRepositoryProvider = Provider<QuizRepository>((ref) {
  return QuizRepositoryImpl(ref.watch(quizApiProvider));
});

/// GET quiz per year (QUIZ-01). `.family` karena butuh parameter yearId.
/// Kalau backend menolak (belum semua section completed, R-QUIZ-02) atau
/// quiz belum di-publish, itu ditangani di QuizScreen (AsyncError biasa /
/// cek `quiz.isPublished`) — provider ini murni fetch mentah.
final quizProvider =
    FutureProvider.family.autoDispose<Quiz, int>((ref, yearId) {
  return ref.watch(quizRepositoryProvider).fetchQuiz(yearId);
});

/// State submit kuis (QUIZ-02/03/04). Dipisah dari quizProvider (read)
/// supaya UI bisa nunjukin loading state khusus pas submit tanpa bikin
/// soal ke-refetch dari awal — sama polanya dengan
/// SectionCompletionController di history_providers.dart.
class QuizSubmitController extends StateNotifier<AsyncValue<QuizSubmitResponse?>> {
  QuizSubmitController(this._ref) : super(const AsyncData(null));
  final Ref _ref;

  Future<QuizSubmitResponse?> submit({
    required int yearId,
    required String eraSlug,
    required Map<int, int?> answersByQuestionId,
  }) async {
    state = const AsyncLoading();
    try {
      final response = await _ref
          .read(quizRepositoryProvider)
          .submitAttempt(yearId, answersByQuestionId);

      // R-PROG-07/08: submit kuis salah satu syarat "year completed" —
      // invalidate roadmap era terkait supaya status completed/locked
      // tahun berikutnya (R-YEAR-02) & vaksin (R-VAC-01/02) ter-update
      // begitu user balik ke roadmap.
      _ref.invalidate(yearsProvider(eraSlug));

      state = AsyncData(response);
      return response;
    } catch (e, st) {
      state = AsyncError(e, st);
      return null;
    }
  }
}

final quizSubmitControllerProvider = StateNotifierProvider.autoDispose<
    QuizSubmitController, AsyncValue<QuizSubmitResponse?>>(
  (ref) => QuizSubmitController(ref),
);

/// BARU — state cek jawaban real-time per soal (skema kuis "instan").
/// Dipakai QuizScreen: setiap user tap 1 opsi, panggil `answer()`, lalu
/// hasilnya (warna benar/salah + opsi benar + explanation) langsung
/// dipakai buat render soal yang sedang aktif — TIDAK ADA lagi fase
/// replay seperti `QuizSubmitController` di atas.
///
/// Dipisah dari `QuizSubmitController` (bukan reuse) karena bentuk
/// state-nya beda total (`QuizAnswerCheckResult` per SATU soal, bukan
/// `QuizSubmitResponse` untuk SEMUA soal) dan siklus hidupnya beda (state
/// di sini di-reset tiap pindah soal, bukan sekali di akhir kuis).
class QuizAnswerController extends StateNotifier<AsyncValue<QuizAnswerCheckResult?>> {
  QuizAnswerController(this._ref) : super(const AsyncData(null));
  final Ref _ref;

  Future<QuizAnswerCheckResult?> answer({
    required int yearId,
    required int questionId,
    required int optionId,
    required String eraSlug,
  }) async {
    state = const AsyncLoading();
    try {
      final result = await _ref
          .read(quizRepositoryProvider)
          .answerQuestion(yearId, questionId, optionId);

      if (result.quizCompleted) {
        // R-PROG-07/08: soal ini adalah soal TERAKHIR yang belum
        // terjawab -> attempt baru saja ditandai selesai di backend.
        // Invalidate roadmap era supaya status year completed/locked
        // tahun berikutnya (R-YEAR-02) langsung ter-update begitu user
        // kembali ke roadmap.
        _ref.invalidate(yearsProvider(eraSlug));
      }

      state = AsyncData(result);
      return result;
    } catch (e, st) {
      state = AsyncError(e, st);
      return null;
    }
  }

  /// Dipanggil QuizScreen setiap pindah ke soal berikutnya, supaya state
  /// soal sebelumnya tidak "bocor" ke soal baru sebelum dijawab.
  void reset() {
    state = const AsyncData(null);
  }
}

final quizAnswerControllerProvider = StateNotifierProvider.autoDispose<
    QuizAnswerController, AsyncValue<QuizAnswerCheckResult?>>(
  (ref) => QuizAnswerController(ref),
);