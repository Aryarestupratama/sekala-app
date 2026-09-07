import '../../../shared/models/era_quiz.dart';
import '../../../shared/models/era_quiz_recap_response.dart';
import '../../../shared/models/era_quiz_result_response.dart';

abstract class EraQuizRepository {
  /// GET .../quiz (ERAQUIZ-01/02). Backend menolak (403) kalau belum
  /// semua year dalam era completed, dan 404 kalau quiz belum
  /// di-publish — biarkan exception naik ke UI (ditangani sebagai
  /// AsyncError), jangan ditelan di sini, sama pola dengan
  /// `QuizRepository.fetchQuiz()`.
  Future<EraQuiz> fetchQuiz(int eraId);

  /// POST .../quiz/attempt (ERAQUIZ-02/03/04, R-ERAQUIZ-04). Berbeda
  /// dari `QuizRepository.submitAttempt()`: WAJIB semua soal terjawab
  /// (tidak ada entry nullable), dan boleh dipanggil ulang berkali-kali
  /// (retake, R-ERAQUIZ-08) — tiap panggilan MENIMPA attempt sebelumnya,
  /// bukan ditolak sebagai duplikat. Response SELALU membawa `message`
  /// (kalimat template selamat) — beda dari `fetchResult()`.
  Future<EraQuizResultResponse> submitAttempt(
    int eraId,
    Map<int, int> answersByQuestionId,
  );

  /// GET .../quiz/result — buka ulang halaman Hasil dari attempt
  /// tersimpan terakhir tanpa submit baru (ERAQUIZ-05, retake kapan
  /// saja). Skor dihitung on-the-fly (R-ERAQUIZ-05). Response TIDAK
  /// membawa `message` (selalu null). Melempar 404 kalau user belum
  /// pernah submit attempt sama sekali — dipakai juga sebagai sinyal
  /// status "attempted", lihat catatan di era_quiz.dart.
  Future<EraQuizResultResponse> fetchResult(int eraId);

  /// GET .../quiz/recap (ERAQUIZ-04). Dipanggil dari halaman Hasil lewat
  /// tombol "Lihat Rekapan". Melempar 404 dengan alasan sama seperti
  /// `fetchResult()`.
  Future<EraQuizRecapResponse> fetchRecap(int eraId);
}