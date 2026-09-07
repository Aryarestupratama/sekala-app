import 'package:freezed_annotation/freezed_annotation.dart';
import 'era_quiz_question.dart';

part 'era_quiz.freezed.dart';
part 'era_quiz.g.dart';

/// DIKONFIRMASI ke `UserEraQuizController::show()`
/// (`GET /api/eras/{era}/quiz`). Mengacu Schema.md §2.14 `era_quizzes`.
///
/// Mirror `Quiz` (kuis year), tapi `eraId` bukan `yearId` (kuis melekat
/// ke era, 1:1, R-ERAQUIZ-01).
///
/// TIDAK ADA field `already_attempted`/status di sini — ini sesuai
/// controller aslinya, endpoint `show()` cuma mengembalikan soal apa
/// adanya. CARA FLUTTER TAHU STATUS "attempted" (untuk ikon final-boss di
/// roadmap, ERAQUIZ-01/05): controller TIDAK punya endpoint status
/// terpisah — `result()`/`recap()` melempar 404 (`NotFoundHttpException`)
/// lewat `latestAttemptOrFail()` kalau belum ada row
/// `user_era_quiz_attempts`. Jadi cara paling sesuai source saat ini:
/// panggil `GET .../quiz/result`, tangkap 404 sebagai "belum dikerjakan",
/// respons sukses berarti "sudah dikerjakan" — lihat
/// `eraQuizAttemptStatusProvider` di era_quiz_providers.dart. INI PERLU
/// DIKONFIRMASI ke tim backend apakah pola 404-sebagai-sinyal ini
/// disengaja atau perlu endpoint status eksplisit terpisah supaya
/// roadmap tidak perlu request tambahan per era.
///
/// Gate akses (R-ERAQUIZ-02): backend menolak request ini kalau belum
/// SEMUA year dalam era tsb berstatus "completed"
/// (`EraQuizAccessService::isUnlocked()`, 403) — Flutter tetap wajib
/// guard di UI (ikon final-boss locked/disabled di roadmap) sebagai
/// lapis pertama sebelum endpoint ini dipanggil. Kalau quiz belum
/// di-publish, backend melempar 404 murni (bukan 403).
@freezed
abstract class EraQuiz with _$EraQuiz {
  const factory EraQuiz({
    required int id,
    @JsonKey(name: 'era_id') required int eraId,
    @JsonKey(name: 'is_published') required bool isPublished,
    @Default(<EraQuizQuestion>[]) List<EraQuizQuestion> questions,
  }) = _EraQuiz;

  factory EraQuiz.fromJson(Map<String, dynamic> json) => _$EraQuizFromJson(json);
}