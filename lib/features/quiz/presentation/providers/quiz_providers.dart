import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/network/dio_client.dart';
import '../../../../shared/models/quiz.dart';
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