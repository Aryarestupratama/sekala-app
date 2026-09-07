import 'package:dio/dio.dart';
import '../../../core/network/api_result.dart';

/// PATH DIKONFIRMASI ke `routes/api.php`:
/// - GET    /eras/{era}/quiz
/// - POST   /eras/{era}/quiz/attempt
/// - GET    /eras/{era}/quiz/result
/// - GET    /eras/{era}/quiz/recap
///
/// PARAMETER `{era}` DIKONFIRMASI berupa `era_id` (integer) — `Era` model
/// TIDAK meng-override `getRouteKeyName()` (lihat `Era.php`), jadi
/// binding-nya default Laravel (`id`). BEDA dari `eraSlug` yang dipakai
/// `yearsProvider` untuk roadmap publik (route publik itu eksplisit
/// `{era:slug}`) — dua konvensi param era yang berbeda di app yang sama,
/// jangan disamakan. Semua method di bawah pakai `eraId` (int).
///
/// Semua endpoint WAJIB auth:sanctum + verified (sama seperti kuis year,
/// R-QUIZ-02/09 setara) — jangan panggil sebelum user login &
/// terverifikasi. Endpoint quiz & attempt digate backend lewat
/// `EraQuizAccessService::isUnlocked()` (R-ERAQUIZ-02, 403 kalau belum
/// semua year dalam era completed; 404 kalau quiz belum di-publish) —
/// Flutter tetap wajib guard ikon final-boss di roadmap sebagai lapis
/// pertama.
///
/// Toleran ke response dengan/tanpa wrapper "data" (meski dari source
/// controller terlihat TIDAK ada wrapper — response()->json() langsung),
/// sama pola seperti QuizApi untuk konsistensi.
class EraQuizApi {
  EraQuizApi(this._dio);
  final Dio _dio;

  Future<dynamic> getQuiz(int eraId) {
    return unwrapApiCall(() async {
      final response = await _dio.get('/eras/$eraId/quiz');
      return response.data;
    });
  }

  /// Submit SEKALIGUS (bukan progresif per-soal seperti kuis year,
  /// Architecture.md §4.9) — body wajib berisi jawaban SEMUA soal.
  /// DIKONFIRMASI ke `StoreEraQuizAttemptRequest.php`: format body
  /// persis pola `QuizApi.submitAttempt()` — object map
  /// `{ "<question_id>": <option_id> }`. Backend memvalidasi setiap soal
  /// WAJIB terjawab (`answers.*` required, beda dari kuis year yang
  /// boleh partial) — TIDAK ADA entry yang boleh diskip di map ini,
  /// pastikan UI sudah menjamin semua soal terjawab sebelum method ini
  /// dipanggil (tombol Submit baru aktif di soal terakhir, ERAQUIZ-02).
  Future<dynamic> submitAttempt(
    int eraId,
    Map<int, int> answersByQuestionId,
  ) {
    return unwrapApiCall(() async {
      final response = await _dio.post(
        '/eras/$eraId/quiz/attempt',
        data: {
          'answers': {
            for (final entry in answersByQuestionId.entries)
              entry.key.toString(): entry.value,
          },
        },
      );
      return response.data;
    });
  }

  /// Dipakai buka ulang halaman Hasil tanpa submit baru (mis. user tap
  /// ikon "sudah dikerjakan" di roadmap, ERAQUIZ-05) — skor tetap
  /// dihitung on-the-fly dari attempt tersimpan terakhir (R-ERAQUIZ-05).
  /// Melempar 404 kalau belum pernah ada attempt.
  Future<dynamic> getResult(int eraId) {
    return unwrapApiCall(() async {
      final response = await _dio.get('/eras/$eraId/quiz/result');
      return response.data;
    });
  }

  /// Melempar 404 dengan alasan sama seperti getResult().
  Future<dynamic> getRecap(int eraId) {
    return unwrapApiCall(() async {
      final response = await _dio.get('/eras/$eraId/quiz/recap');
      return response.data;
    });
  }
}