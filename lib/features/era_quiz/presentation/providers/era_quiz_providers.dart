import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/network/api_exception.dart';
import '../../../../core/network/dio_client.dart';
import '../../../../shared/models/era_quiz.dart';
import '../../../../shared/models/era_quiz_recap_response.dart';
import '../../../../shared/models/era_quiz_result_response.dart';
import '../../data/era_quiz_api.dart';
import '../../data/era_quiz_repository_impl.dart';
import '../../domain/era_quiz_repository.dart';

final eraQuizApiProvider = Provider<EraQuizApi>((ref) {
  return EraQuizApi(DioClient.instance.dio);
});

final eraQuizRepositoryProvider = Provider<EraQuizRepository>((ref) {
  return EraQuizRepositoryImpl(ref.watch(eraQuizApiProvider));
});

/// GET soal kuis sumatif era (ERAQUIZ-01/02). `.family` karena butuh
/// parameter eraId. Kalau backend menolak (belum semua year completed,
/// R-ERAQUIZ-02, 403) atau quiz belum di-publish (404), ditangani di
/// screen (AsyncError biasa) — provider ini murni fetch mentah, sama
/// pola dengan `quizProvider`.
final eraQuizProvider =
    FutureProvider.family.autoDispose<EraQuiz, int>((ref, eraId) {
  return ref.watch(eraQuizRepositoryProvider).fetchQuiz(eraId);
});

/// GET hasil skor TANPA submit baru (ERAQUIZ-05) — dipakai saat user tap
/// ikon "sudah dikerjakan" dari roadmap untuk langsung buka halaman
/// Hasil dari attempt tersimpan sebelumnya. `result.message` SELALU null
/// di jalur ini (server memang tidak mengirimnya di endpoint result()) —
/// UI perlu fallback kalimat sendiri kalau mau tetap menyapa user (lihat
/// catatan di era_quiz_result_response.dart). Melempar 404
/// (`ApiException.statusCode == 404`) kalau belum pernah ada attempt sama
/// sekali — screen pemanggil provider ini WAJIB sudah tahu status
/// "attempted" = true sebelumnya (dari `eraQuizAttemptStatusProvider` di
/// bawah) supaya 404 di sini seharusnya tidak pernah terjadi di alur
/// normal.
final eraQuizResultProvider = FutureProvider.family
    .autoDispose<EraQuizResultResponse, int>((ref, eraId) {
  return ref.watch(eraQuizRepositoryProvider).fetchResult(eraId);
});

/// GET rekap semua soal (ERAQUIZ-04) — dipanggil dari halaman Hasil
/// lewat tombol "Lihat Rekapan". Sama seperti result, selalu
/// merefleksikan attempt TERKINI, dan melempar 404 dengan alasan sama.
final eraQuizRecapProvider = FutureProvider.family
    .autoDispose<EraQuizRecapResponse, int>((ref, eraId) {
  return ref.watch(eraQuizRepositoryProvider).fetchRecap(eraId);
});

/// BARU — deteksi status "sudah dikerjakan" (ikon final-boss di roadmap:
/// centang vs merah mencolok, ERAQUIZ-01/05). Controller TIDAK punya
/// endpoint status eksplisit (lihat catatan panjang di era_quiz.dart) —
/// cara yang sesuai source saat ini adalah memanggil `GET .../quiz/result`
/// dan menafsirkan 404 (`NotFoundHttpException` dari
/// `latestAttemptOrFail()`) sebagai "belum pernah dikerjakan".
///
/// `DioClient._onError` (lihat dio_client.dart) sudah menormalisasi semua
/// error jadi `ApiException` custom lewat `DioException.error` — jadi `e`
/// yang ditangkap `catch` di sini seharusnya sudah berupa `ApiException`
/// langsung (BUKAN `DioException` yang membungkusnya), TAPI ini belum
/// sempat ditest end-to-end untuk endpoint era quiz khususnya. Kalau
/// ternyata error yang sampai ke sini masih `DioException`, ganti jadi
/// `e.error as ApiException?`.
///
/// CATATAN DESAIN (perlu didiskusikan ke tim, bukan keputusan teknis
/// semata): kalau roadmap menampilkan node final-boss, provider ini
/// berarti 1 request tambahan per era yang sudah unlocked, murni untuk
/// tahu status ikon. Alternatifnya minta backend menambah field
/// `era_quiz_attempted` di response roadmap publik
/// (`GET /public/eras/{era}/years`) supaya tidak perlu request terpisah
/// — tapi itu perubahan backend, bukan sesuatu yang bisa diperbaiki dari
/// Flutter saja. Untuk sekarang, panggil provider ini HANYA saat node
/// final-boss sudah lolos gate unlocked di sisi client (semua year
/// completed), bukan untuk semua era tanpa syarat.
final eraQuizAttemptStatusProvider =
    FutureProvider.family.autoDispose<bool, int>((ref, eraId) async {
  try {
    await ref.watch(eraQuizRepositoryProvider).fetchResult(eraId);
    return true;
  } on ApiException catch (e) {
    if (e.statusCode == 404) {
      return false;
    }
    rethrow;
  }
});

/// State submit kuis sumatif era (ERAQUIZ-02/03/04, boleh retake
/// ERAQUIZ-05/R-ERAQUIZ-08). Dipisah dari `eraQuizProvider` (read) supaya
/// UI bisa menampilkan loading state khusus pas submit tanpa memicu
/// refetch soal dari awal — sama pola dengan `QuizSubmitController`.
///
/// BEDA dari `QuizSubmitController` (kuis year): TIDAK ADA invalidate
/// untuk status year completed/lock tahun berikutnya — kuis sumatif era
/// TIDAK mempengaruhi R-PROG-07/08 (year completion) maupun sequential
/// unlock apapun (Architecture.md §4.9 hanya MEMBACA year completion
/// yang sudah tercapai sebagai syarat gate, satu arah, tidak menulis
/// balik). Yang di-invalidate di sini murni provider era-quiz sendiri
/// supaya status "attempted"/skor/rekap konsisten setelah submit atau
/// retake — kalau suatu saat backend menambah field status attempted di
/// response roadmap publik (lihat catatan `eraQuizAttemptStatusProvider`
/// di atas), invalidate provider roadmap terkait perlu ditambahkan di
/// sini juga.
class EraQuizSubmitController
    extends StateNotifier<AsyncValue<EraQuizResultResponse?>> {
  EraQuizSubmitController(this._ref) : super(const AsyncData(null));
  final Ref _ref;

  Future<EraQuizResultResponse?> submit({
    required int eraId,
    required Map<int, int> answersByQuestionId,
  }) async {
    state = const AsyncLoading();
    try {
      final response = await _ref
          .read(eraQuizRepositoryProvider)
          .submitAttempt(eraId, answersByQuestionId);

      _ref.invalidate(eraQuizResultProvider(eraId));
      _ref.invalidate(eraQuizRecapProvider(eraId));
      _ref.invalidate(eraQuizAttemptStatusProvider(eraId));

      state = AsyncData(response);
      return response;
    } catch (e, st) {
      state = AsyncError(e, st);
      return null;
    }
  }
}

final eraQuizSubmitControllerProvider = StateNotifierProvider.autoDispose<
    EraQuizSubmitController, AsyncValue<EraQuizResultResponse?>>(
  (ref) => EraQuizSubmitController(ref),
);