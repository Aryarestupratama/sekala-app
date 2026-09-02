import 'package:freezed_annotation/freezed_annotation.dart';
import 'quiz_question.dart';

part 'quiz.freezed.dart';
part 'quiz.g.dart';

/// DIKONFIRMASI ke `Api/Quiz/UserQuizController::show()` (GET
/// /api/years/{year}/quiz). Response ini adalah Eloquent model `Quiz` yang
/// di-`load()` relasinya langsung (bukan lewat JsonResource), jadi field
/// mengikuti nama kolom asli Schema.md §2.8 `quizzes`.
///
/// R-QUIZ-02: backend menolak (403) kalau section di year tsb belum semua
/// completed — Flutter tetap perlu guard tombol "Kerjakan Kuis" di sisi UI
/// (baru muncul setelah semua section completed, INFO-05) sebagai lapis
/// pertama sebelum request ini dipanggil sama sekali.
///
/// R-QUIZ-09: guest ditolak total (endpoint di grup middleware
/// auth:sanctum + verified) — jangan panggil ini kalau user belum login.
///
/// CATATAN: TIDAK ada field `already_attempted` di response ini (beda dari
/// asumsi versi sebelumnya) — backend hanya membedakan submit
/// pertama/ulang lewat teks `message` di response submit
/// (`QuizSubmitResponse`), bukan lewat field terpisah di sini.
@freezed
abstract class Quiz with _$Quiz {
  const factory Quiz({
    required int id,
    @JsonKey(name: 'year_id') required int yearId,
    @JsonKey(name: 'is_published') required bool isPublished,
    @Default(<QuizQuestion>[]) List<QuizQuestion> questions,
  }) = _Quiz;

  factory Quiz.fromJson(Map<String, dynamic> json) => _$QuizFromJson(json);
}