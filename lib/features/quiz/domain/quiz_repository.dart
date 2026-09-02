import '../../../shared/models/quiz.dart';
import '../../../shared/models/quiz_submit_response.dart';

abstract class QuizRepository {
  /// GET /api/years/{year}/quiz (QUIZ-01, R-QUIZ-02). Backend menolak
  /// (403) kalau section di year tsb belum semua completed — biarkan
  /// exception itu naik ke UI (ditangani sebagai AsyncError biasa),
  /// jangan ditelan di sini.
  Future<Quiz> fetchQuiz(int yearId);

  /// POST /api/years/{year}/quiz/attempt (QUIZ-02/03/04, R-QUIZ-08).
  /// Idempotent di backend — aman dipanggil ulang, tapi tidak akan
  /// mengubah `completed_at`/`answers` kalau sudah pernah submit
  /// sebelumnya (lihat QuizSubmitResponseX.isFirstSubmission).
  Future<QuizSubmitResponse> submitAttempt(
    int yearId,
    Map<int, int?> answersByQuestionId,
  );
}