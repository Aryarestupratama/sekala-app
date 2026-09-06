import 'package:dio/dio.dart';
import '../../../core/network/api_result.dart';

/// GET /api/years/{year}/quiz & POST /api/years/{year}/quiz/attempt.
/// Kedua endpoint WAJIB auth:sanctum + verified (R-QUIZ-02, R-QUIZ-09) —
/// jangan panggil sebelum user login & terverifikasi, guard di sisi UI
/// (tombol "Kerjakan Kuis" cuma muncul di YearSummaryScreen setelah year
/// completed section-nya, dan halaman itu sendiri praktis tak terjangkau
/// guest karena `completed` section selalu false untuk guest, R-PROG-06).
///
/// Sama seperti HistoryApi: toleran ke response dengan/tanpa wrapper "data".
class QuizApi {
  QuizApi(this._dio);
  final Dio _dio;

  Future<dynamic> getQuiz(int yearId) {
    return unwrapApiCall(() async {
      final response = await _dio.get('/years/$yearId/quiz');
      return response.data;
    });
  }

  /// DIKONFIRMASI ke source backend (StoreQuizAttemptRequest.php +
  /// UserQuizController::submitAttempt()): body dikirim sebagai OBJECT/MAP
  /// `{ "answers": { "<question_id>": <quiz_question_option_id>, ... } }`
  /// — BUKAN array of objects seperti asumsi awal. Key di JSON selalu
  /// string (batasan JSON), tapi backend cast ke int saat validasi
  /// (`(int) $questionId`), jadi aman dikirim apa adanya di sini.
  ///
  /// Soal yang belum dijawab (option masih null) sengaja TIDAK disertakan
  /// di map — backend treat `answers` sebagai partial map dan cuma
  /// menganggap soal terjawab kalau key-nya ada, jadi mengirim key dengan
  /// value null tidak dibutuhkan (dan validasi backend juga skip value
  /// null di withValidator()).
  Future<dynamic> submitAttempt(
    int yearId,
    Map<int, int?> answersByQuestionId,
  ) {
    return unwrapApiCall(() async {
      final response = await _dio.post(
        '/years/$yearId/quiz/attempt',
        data: {
          'answers': {
            for (final entry in answersByQuestionId.entries)
              if (entry.value != null) entry.key.toString(): entry.value,
          },
        },
      );
      return response.data;
    });
  }

  /// POST /api/years/{year}/quiz/questions/{questionId}/answer — BARU,
  /// dipakai skema kuis "instan per soal" (menggantikan pola submit-di-
  /// akhir + replay yang dipakai `submitAttempt()` di atas untuk
  /// QuizScreen). Progresif: setiap panggilan menyimpan 1 jawaban ke
  /// attempt di backend, dan begitu SEMUA soal sudah terjawab, backend
  /// otomatis menandai attempt selesai (`quiz_completed: true` di
  /// response) dan mengecek unlock vaksin — tidak perlu panggilan
  /// terpisah lagi ke `submitAttempt()` untuk menyelesaikan kuis ini.
  Future<dynamic> answerQuestion(int yearId, int questionId, int optionId) {
    return unwrapApiCall(() async {
      final response = await _dio.post(
        '/years/$yearId/quiz/questions/$questionId/answer',
        data: {'option_id': optionId},
      );
      return response.data;
    });
  }
}