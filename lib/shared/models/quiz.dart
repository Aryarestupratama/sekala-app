import 'package:freezed_annotation/freezed_annotation.dart';
import 'quiz_question.dart';

part 'quiz.freezed.dart';
part 'quiz.g.dart';

/// Bentuk field TIDAK berubah dari versi sebelumnya (masih Eloquent model
/// `Quiz` apa adanya: id, year_id, is_published, questions). TAPI shape
/// RESPONS `GET /api/years/{year}/quiz` sekarang MEMBUNGKUS objek ini —
/// jangan lagi parse response endpoint itu langsung jadi `Quiz`, pakai
/// `QuizShowResponse` di bawah (quiz_show_response.dart, file baru).
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