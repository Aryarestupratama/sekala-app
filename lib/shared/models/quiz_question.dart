import 'package:freezed_annotation/freezed_annotation.dart';
import 'quiz_question_option.dart';

part 'quiz_question.freezed.dart';
part 'quiz_question.g.dart';

/// Mengacu Schema.md §2.9 `quiz_questions` (revisi minor: kolom `type` &
/// `correct_answer` DIHAPUS TOTAL dari skema — kuis kini murni pilihan
/// ganda, R-QUIZ-07). TIDAK ADA field `type` di model ini sama sekali;
/// jangan tambahkan cabang UI untuk tipe esai di widget manapun.
@freezed
abstract class QuizQuestion with _$QuizQuestion {
  const factory QuizQuestion({
    required int id,
    required int order,
    required String question,

    // Minimal 2 opsi per soal (R-QUIZ-07). Tidak ada is_correct di sini,
    // lihat catatan di quiz_question_option.dart.
    @Default(<QuizQuestionOption>[]) List<QuizQuestionOption> options,
  }) = _QuizQuestion;

  factory QuizQuestion.fromJson(Map<String, dynamic> json) =>
      _$QuizQuestionFromJson(json);
}