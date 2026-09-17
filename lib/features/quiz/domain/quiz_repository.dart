import '../../../shared/models/quiz_show_response.dart';
import '../../../shared/models/quiz_answer_check_result.dart';
import '../../../shared/models/quiz_retry_response.dart';

abstract class QuizRepository {
  /// GET /api/years/{year}/quiz (QUIZ-01, R-QUIZ-02). REVISI: return type
  /// sekarang `QuizShowResponse` (bukan `Quiz` langsung) — membawa
  /// passing_grade/question_count/attempt_status/latest_score sekaligus.
  /// Backend menolak (403) kalau section di year tsb belum semua
  /// completed — biarkan exception itu naik ke UI, jangan ditelan di sini.
  Future<QuizShowResponse> fetchQuiz(int yearId);

  /// POST /api/years/{year}/quiz/questions/{questionId}/answer.
  /// Dipanggil setiap kali user menjawab 1 soal. Begitu SEMUA soal quiz
  /// ini sudah terjawab, backend menandai attempt selesai
  /// (`quizCompleted: true` pada respons soal TERAKHIR) sekaligus
  /// mengirim skor akhir & status lulus/tidak (`finalScore`/`isPassing`,
  /// BARU) — kalau gagal, panggil `retryQuiz()` sebelum bisa menjawab lagi.
  Future<QuizAnswerCheckResult> answerQuestion(
    int yearId,
    int questionId,
    int optionId,
  );

  /// BARU — POST /api/years/{year}/quiz/retry (R-QUIZ-08). Reset attempt
  /// yang belum lulus supaya bisa dikerjakan ulang dari soal pertama.
  /// Backend menolak (422) kalau attempt sudah lulus.
  Future<QuizRetryResponse> retryQuiz(int yearId);
}