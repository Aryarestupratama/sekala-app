import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/network/dio_client.dart';
import '../../../../shared/models/quiz_show_response.dart';
import '../../../../shared/models/quiz_answer_check_result.dart';
import '../../../../shared/models/quiz_retry_response.dart';
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

/// GET quiz per year (QUIZ-01). REVISI: type sekarang `QuizShowResponse`
/// (bukan `Quiz` langsung) — bawa passing_grade/question_count/
/// attempt_status/latest_score sekaligus, dipakai render layar info
/// SEBELUM soal pertama ("Nilai minimum kelulusan: 75%").
///
/// `.family` karena butuh parameter yearId. Kalau backend menolak (belum
/// semua section completed, R-QUIZ-02) atau quiz belum di-publish, itu
/// ditangani di QuizScreen (AsyncError biasa) — provider ini murni fetch
/// mentah.
final quizProvider =
    FutureProvider.family.autoDispose<QuizShowResponse, int>((ref, yearId) {
  return ref.watch(quizRepositoryProvider).fetchQuiz(yearId);
});

/// ⚠️ `QuizSubmitController` (versi lama, submit-sekaligus-di-akhir)
/// DIHAPUS TOTAL — endpoint yang dipanggilnya (`POST .../quiz/attempt`)
/// sudah tidak ada di backend. Alur kuis formatif sekarang progresif per
/// soal lewat `QuizAnswerController` di bawah, TIDAK ADA lagi fase submit
/// terpisah di akhir.

/// State cek jawaban real-time per soal (skema kuis "instan"). Dipakai
/// QuizScreen: setiap user tap 1 opsi, panggil `answer()`, lalu hasilnya
/// (warna benar/salah + opsi benar + explanation) langsung dipakai buat
/// render soal yang sedang aktif.
///
/// REVISI (kuis formatif kini berskor + passing grade 75% + boleh
/// retake): begitu `result.quizCompleted == true`, state ini JUGA
/// membawa `result.finalScore`/`result.isPassing` — QuizScreen wajib
/// menampilkan layar Hasil (skor + lulus/tidak) di titik ini, BUKAN
/// langsung menganggap kuis "selesai & year completed" seperti versi
/// lama. Roadmap (`yearsProvider`) HANYA di-invalidate kalau
/// `result.isPassing == true` — kalau gagal, year BELUM completed di
/// backend (`YearCompletionService::isCompleted()` mensyaratkan lulus),
/// jadi invalidate roadmap saat gagal cuma buang-buang request tanpa ada
/// perubahan status untuk didapat.
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
        // Selalu refresh status quiz (attempt_status/latest_score) sendiri
        // begitu attempt selesai, terlepas lulus/tidak — supaya kalau user
        // balik ke layar info kuis, statusnya sudah "failed"/"passed" yang
        // terbaru, bukan cache lama "not_started"/"in_progress".
        _ref.invalidate(quizProvider(yearId));

        if (result.isPassing == true) {
          // R-PROG-07/08: year baru dianggap completed kalau LULUS —
          // invalidate roadmap era supaya status completed/locked tahun
          // berikutnya (R-YEAR-02) & vaksin (R-VAC-01/02) ter-update.
          _ref.invalidate(yearsProvider(eraSlug));
        }
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

/// BARU — state retry kuis formatif yang belum lulus (R-QUIZ-08). Dipisah
/// dari `QuizAnswerController` karena siklus hidupnya beda (dipanggil
/// SEKALI di awal sesi retry, bukan tiap soal) dan errornya perlu
/// ditangani beda (422 "sudah lulus, tidak perlu retry" — tampilkan pesan
/// itu apa adanya ke user, jangan generic error).
class QuizRetryController extends StateNotifier<AsyncValue<QuizRetryResponse?>> {
  QuizRetryController(this._ref) : super(const AsyncData(null));
  final Ref _ref;

  Future<QuizRetryResponse?> retry(int yearId) async {
    state = const AsyncLoading();
    try {
      final response = await _ref.read(quizRepositoryProvider).retryQuiz(yearId);

      // Attempt di-reset ke kosong di backend -> refresh attempt_status
      // (jadi "in_progress") supaya QuizScreen tahu boleh mulai jawab lagi
      // dari soal pertama.
      _ref.invalidate(quizProvider(yearId));

      state = AsyncData(response);
      return response;
    } catch (e, st) {
      state = AsyncError(e, st);
      return null;
    }
  }
}

final quizRetryControllerProvider = StateNotifierProvider.autoDispose<
    QuizRetryController, AsyncValue<QuizRetryResponse?>>(
  (ref) => QuizRetryController(ref),
);