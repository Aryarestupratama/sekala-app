import 'package:freezed_annotation/freezed_annotation.dart';

part 'quiz_answer_feedback.freezed.dart';
part 'quiz_answer_feedback.g.dart';

/// DIKONFIRMASI ke `UserQuizController::submitAttempt()` — shape persis
/// dari `$feedback` yang dibentuk di situ:
/// `{ question_id, selected_option_id, is_correct }`.
///
/// PENTING (koreksi dari asumsi versi sebelumnya): TIDAK ADA
/// `correct_option_id` di response ini. Backend cuma memberi tahu apakah
/// opsi yang DIPILIH user itu benar/salah (R-QUIZ-04) — kalau salah,
/// Flutter TIDAK PUNYA cara untuk tahu opsi mana yang seharusnya benar
/// dari response ini. Ini sengaja (bukan bug): mempertahankan filosofi
/// "kuis bukan alat tes kepintaran" sekaligus tidak membocorkan jawaban
/// yang belum dipilih. Implikasi UI: highlight cuma bisa diterapkan ke
/// opsi yang DIPILIH user (hijau kalau `isCorrect`, merah kalau tidak) —
/// TIDAK bisa menghighlight opsi benar yang lain kalau user salah jawab
/// (beda dari simulasi preview admin di `PhonePreview.jsx` yang memang
/// cuma simulasi, bukan perilaku asli dari user-facing endpoint).
///
/// `selectedOptionId` nullable karena request `answers` sendiri boleh
/// mengirim `null` per soal (rule backend: `'answers.*' =>
/// 'nullable|integer|...'`) — meski alur normal UI mengharuskan semua
/// soal dijawab sebelum submit.
@freezed
abstract class QuizAnswerFeedback with _$QuizAnswerFeedback {
  const factory QuizAnswerFeedback({
    @JsonKey(name: 'question_id') required int questionId,
    @JsonKey(name: 'selected_option_id') int? selectedOptionId,
    @JsonKey(name: 'is_correct') required bool isCorrect,
  }) = _QuizAnswerFeedback;

  factory QuizAnswerFeedback.fromJson(Map<String, dynamic> json) =>
      _$QuizAnswerFeedbackFromJson(json);
}