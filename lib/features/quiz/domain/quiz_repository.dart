import '../../../shared/models/quiz.dart';
import '../../../shared/models/quiz_answer_check_result.dart';
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
  ///
  /// CATATAN: sejak skema kuis "instan per soal" (lihat answerQuestion()
  /// di bawah), QuizScreen TIDAK LAGI memanggil method ini — dipertahankan
  /// di sini murni untuk kompatibilitas kalau ada pemanggil lain di masa
  /// depan (mis. review/riwayat kuis).
  Future<QuizSubmitResponse> submitAttempt(
    int yearId,
    Map<int, int?> answersByQuestionId,
  );

  /// POST /api/years/{year}/quiz/questions/{questionId}/answer — BARU.
  /// Dipanggil setiap kali user menjawab 1 soal (bukan sekaligus di
  /// akhir). Progresif: backend menyimpan jawaban ini ke attempt yang
  /// sedang berjalan, dan begitu SEMUA soal quiz ini sudah terjawab,
  /// backend otomatis menandai attempt selesai (`quizCompleted: true`
  /// pada respons soal TERAKHIR) dan mengecek unlock vaksin (R-PROG-07/08,
  /// R-VAC-01/02) — tidak perlu panggilan submit terpisah setelah ini.
  Future<QuizAnswerCheckResult> answerQuestion(
    int yearId,
    int questionId,
    int optionId,
  );
}