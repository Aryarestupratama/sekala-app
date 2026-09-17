import 'package:freezed_annotation/freezed_annotation.dart';

part 'year_summary_option.freezed.dart';
part 'year_summary_option.g.dart';

/// 1 opsi kalimat di dalam poin Rangkuman Interaktif — TANPA `isCorrect`
/// sama sekali (Rules.md R-SUM-05/YearSummaryService::getPointsForAttempt())
/// karena backend sengaja tidak mengirim kunci jawaban sebelum dijawab,
/// sama filosofi dengan QuizQuestion.options yang juga tanpa `isCorrect`.
@freezed
abstract class YearSummaryOption with _$YearSummaryOption {
  const factory YearSummaryOption({
    required int id,
    @JsonKey(name: 'option_text') required String optionText,
  }) = _YearSummaryOption;

  factory YearSummaryOption.fromJson(Map<String, dynamic> json) =>
      _$YearSummaryOptionFromJson(json);
}