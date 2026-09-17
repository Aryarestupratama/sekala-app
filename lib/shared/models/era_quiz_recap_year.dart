import 'package:freezed_annotation/freezed_annotation.dart';

part 'era_quiz_recap_year.freezed.dart';
part 'era_quiz_recap_year.g.dart';

/// Model kecil BARU — info tahun asal 1 soal di rekap kuis sumatif
/// (konsekuensi dari revisi "soal sumatif ditarik dari bank formatif
/// per year"). DIKONFIRMASI ke `UserEraQuizController::recap()`:
/// ```json
/// { "id": 3, "year": 1974 }
/// ```
/// Opsional dipakai atau tidak di UI — mis. label kecil "dari tahun 1974"
/// di tiap item rekap, murni tambahan konteks, bukan requirement wajib.
@freezed
abstract class EraQuizRecapYear with _$EraQuizRecapYear {
  const factory EraQuizRecapYear({
    required int id,
    required int year,
  }) = _EraQuizRecapYear;

  factory EraQuizRecapYear.fromJson(Map<String, dynamic> json) =>
      _$EraQuizRecapYearFromJson(json);
}