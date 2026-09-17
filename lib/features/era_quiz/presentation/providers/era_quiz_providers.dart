import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/network/api_exception.dart';
import '../../../../core/network/dio_client.dart';
import '../../../../shared/models/era_quiz_start.dart';
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

/// ⚠️ REVISI PENTING — `eraQuizProvider` (versi lama, plain
/// `FutureProvider.family.autoDispose<EraQuiz, int>`) DIHAPUS TOTAL dan
/// diganti `EraQuizSessionController` di bawah. Alasan:
///
/// Backend sekarang RANDOM ULANG 20 soal (dari bank formatif, dibagi
/// proporsional per year) SETIAP `GET .../quiz` dipanggil — bukan lagi
/// subset tetap dari 1 pool statis. Kalau dipakai lewat plain
/// `FutureProvider.family.autoDispose`, Riverpod bisa diam-diam
/// re-fetch & memberi SET SOAL BARU tiap kali provider di-watch ulang
/// setelah sempat di-dispose (mis. user pindah tab lalu balik lagi di
/// tengah mengerjakan) — user akan kehilangan konsistensi soal
/// pertengahan attempt tanpa sadar.
///
/// `EraQuizSessionController` memaksa fetch HANYA terjadi 1x per sesi,
/// eksplisit lewat `start()`, dan hasilnya disimpan di state sampai user
/// submit atau `clear()` dipanggil (mis. keluar dari screen kuis) — TIDAK
/// ADA auto-refetch diam-diam.
class EraQuizSessionController extends StateNotifier<AsyncValue<EraQuizStart?>> {
  EraQuizSessionController(this._ref) : super(const AsyncData(null));
  final Ref _ref;

  /// Panggil SEKALI saat user menekan "Mulai Kuis"/"Kerjakan Ulang" di
  /// layar info (sebelum masuk soal pertama). JANGAN dipanggil ulang di
  /// tengah sesi mengerjakan (lihat alasan di docblock class ini) — kalau
  /// screen di-rebuild, baca `state` yang sudah ada, jangan panggil
  /// `start()` lagi.
  Future<void> start(int eraId) async {
    state = const AsyncLoading();
    try {
      final data = await _ref.read(eraQuizRepositoryProvider).fetchQuiz(eraId);
      state = AsyncData(data);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  /// Panggil setelah submit berhasil, atau saat user keluar dari alur
  /// kuis tanpa submit — supaya sesi berikutnya (retake) wajib panggil
  /// `start()` lagi dan dapat set soal baru yang sengaja di-random ulang.
  void clear() {
    state = const AsyncData(null);
  }
}

final eraQuizSessionControllerProvider = StateNotifierProvider.autoDispose<
    EraQuizSessionController, AsyncValue<EraQuizStart?>>(
  (ref) => EraQuizSessionController(ref),
);

/// GET hasil skor TANPA submit baru (ERAQUIZ-05) — dipakai saat user tap
/// ikon "sudah dikerjakan" dari roadmap untuk langsung buka halaman
/// Hasil dari attempt tersimpan sebelumnya. `result.message` SELALU null
/// di jalur ini (server memang tidak mengirimnya di endpoint result()) —
/// UI perlu fallback kalimat sendiri kalau mau tetap menyapa user.
/// `result.passingGrade` (BARU) + `result.result.isPassing` (BARU) dipakai
/// bareng untuk render label "Lulus"/"Belum Lulus". Melempar 404
/// (`ApiException.statusCode == 404`) kalau belum pernah ada attempt sama
/// sekali.
final eraQuizResultProvider = FutureProvider.family
    .autoDispose<EraQuizResultResponse, int>((ref, eraId) {
  return ref.watch(eraQuizRepositoryProvider).fetchResult(eraId);
});

/// GET rekap semua soal (ERAQUIZ-04) — dipanggil dari halaman Hasil
/// lewat tombol "Lihat Rekapan". Sama seperti result, selalu
/// merefleksikan attempt TERKINI, dan melempar 404 dengan alasan sama.
/// Tiap item rekap sekarang BISA membawa `year` (opsional, info tahun
/// asal soal — konsekuensi soal ditarik dari bank formatif per year).
final eraQuizRecapProvider = FutureProvider.family
    .autoDispose<EraQuizRecapResponse, int>((ref, eraId) {
  return ref.watch(eraQuizRepositoryProvider).fetchRecap(eraId);
});

/// BARU — MENGGANTIKAN pemakaian `eraQuizProvider` lama untuk keperluan
/// CEK KEBERADAAN kuis sumatif (mis. `FinalBossNode` di roadmap, yang
/// perlu tahu apakah node final-boss ini harus disembunyikan total kalau
/// era-nya memang belum punya kuis sumatif ter-publish, 404).
///
/// SENGAJA TERPISAH dari `EraQuizSessionController` — controller itu
/// khusus untuk SESI user benar-benar mengerjakan kuis (state-nya
/// disimpan & dipakai selama attempt berjalan). Provider ini murni
/// read-only "ya/tidak ada", hasil fetch-nya DIBUANG begitu dapat
/// jawaban, tidak disimpan untuk dipakai mengerjakan soal — supaya tidak
/// mencampur 2 concern yang beda siklus hidup.
///
/// Konsekuensi yang perlu disadari: karena `fetchQuiz()` (GET .../quiz)
/// sekarang SELALU random 20 soal tiap dipanggil (lihat catatan di
/// era_quiz_start.dart), provider ini tetap memicu random tsb — tapi
/// hasilnya langsung dibuang, jadi TIDAK berdampak ke sesi manapun,
/// cuma buang-buang kerja komputasi kecil di backend tiap roadmap
/// dirender untuk era yang unlocked. Kalau ini jadi masalah performa,
/// solusi jangka panjang adalah backend menambah field status terpisah
/// di response roadmap publik (dicatat juga di catatan
/// `eraQuizAttemptStatusProvider` di bawah) — bukan sesuatu yang bisa
/// dioptimalkan lebih jauh dari Flutter saja tanpa perubahan backend.
final eraQuizExistsProvider =
    FutureProvider.family.autoDispose<bool, int>((ref, eraId) async {
  try {
    await ref.watch(eraQuizRepositoryProvider).fetchQuiz(eraId);
    return true;
  } on ApiException catch (e) {
    if (e.statusCode == 404) {
      return false;
    }
    rethrow;
  }
});

/// Deteksi status "sudah dikerjakan" (ikon final-boss di roadmap: centang
/// vs merah mencolok, ERAQUIZ-01/05). TIDAK BERUBAH dari versi
/// sebelumnya — masih pakai 404 dari `fetchResult()` sebagai sinyal
/// "belum pernah dikerjakan", cuma dipindah supaya konsisten dengan
/// `eraQuizResultProvider` yang tipenya sudah pakai model baru.
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
/// ERAQUIZ-05/R-ERAQUIZ-08). Dipisah dari `EraQuizSessionController`
/// (read/soal) supaya UI bisa menampilkan loading state khusus pas submit
/// tanpa memicu refetch soal.
///
/// TIDAK ADA invalidate untuk status year completed/lock tahun
/// berikutnya — kuis sumatif TIDAK mempengaruhi R-PROG-07/08 sama sekali
/// (cuma MEMBACA year completion sebagai syarat gate, satu arah).
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

      // BARU: bersihkan sesi soal setelah submit berhasil — kalau user
      // retake nanti, wajib panggil start() lagi dan dapat set soal baru
      // yang sengaja di-random ulang (bukan reuse soal attempt sebelumnya).
      _ref.read(eraQuizSessionControllerProvider.notifier).clear();

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