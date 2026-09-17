import 'package:dio/dio.dart';
import '../../../core/network/api_result.dart';

/// GET /api/years/{year}/quiz, POST .../questions/{q}/answer,
/// POST .../quiz/retry (BARU). Semua WAJIB auth:sanctum + verified
/// (R-QUIZ-02, R-QUIZ-09).
///
/// Sama seperti HistoryApi: toleran ke response dengan/tanpa wrapper "data".
class QuizApi {
  QuizApi(this._dio);
  final Dio _dio;

  /// REVISI: response sekarang MEMBUNGKUS quiz — bukan objek Quiz langsung
  /// (lihat QuizShowResponse). Ikut membawa `passing_grade`,
  /// `question_count`, `attempt_status`, `latest_score` — WAJIB
  /// ditampilkan ke user sebelum masuk soal pertama.
  Future<dynamic> getQuiz(int yearId) {
    return unwrapApiCall(() async {
      final response = await _dio.get('/years/$yearId/quiz');
      return response.data;
    });
  }

  /// ⚠️ DIHAPUS: `submitAttempt()` (POST /years/{year}/quiz/attempt) —
  /// endpoint ini sudah tidak ada di backend sejak kuis year jadi
  /// progresif per-soal (lihat catatan di api.php: "endpoint lama sudah
  /// dibuang total"). Kalau ada kode lain yang masih memanggil method ini
  /// dari class QuizApi versi sebelumnya, itu akan selalu gagal (404) —
  /// ganti ke `answerQuestion()` per soal.

  /// POST /api/years/{year}/quiz/questions/{questionId}/answer —
  /// progresif per-soal, feedback instan. TIDAK BERUBAH dari versi
  /// sebelumnya. Begitu SEMUA soal terjawab, response soal TERAKHIR
  /// membawa `quiz_completed: true` + `final_score`/`is_passing` (BARU,
  /// lihat QuizAnswerCheckResult) — kalau `is_passing == false`, user
  /// perlu panggil `retryQuiz()` sebelum bisa menjawab lagi.
  Future<dynamic> answerQuestion(int yearId, int questionId, int optionId) {
    return unwrapApiCall(() async {
      final response = await _dio.post(
        '/years/$yearId/quiz/questions/$questionId/answer',
        data: {'option_id': optionId},
      );
      return response.data;
    });
  }

  /// BARU — POST /api/years/{year}/quiz/retry (R-QUIZ-08, kuis formatif
  /// boleh dikerjakan ulang sampai lulus). Reset attempt ke kosong supaya
  /// `answerQuestion()` bisa dipanggil lagi dari soal pertama. Backend
  /// menolak (422) kalau attempt SUDAH lulus — biarkan exception itu naik
  /// ke UI, jangan ditelan di sini.
  Future<dynamic> retryQuiz(int yearId) {
    return unwrapApiCall(() async {
      final response = await _dio.post('/years/$yearId/quiz/retry');
      return response.data;
    });
  }
}