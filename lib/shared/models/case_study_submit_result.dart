import 'package:freezed_annotation/freezed_annotation.dart';

import 'case_study_badge.dart';

part 'case_study_submit_result.freezed.dart';
part 'case_study_submit_result.g.dart';

/// Toleran terhadap 2 kemungkinan bentuk elemen `newly_unlocked_vaccine_ids`:
/// angka polos (`[3, 5]`, seperti `SectionCompletionResult`) ATAU objek
/// yang punya `id` (`[{"id": 3, ...}]`). Backend mengisi field ini dari
/// `$completion['newly_unlocked_vaccines']->values()` — isi koleksinya
/// (id atau model vaksin) bergantung pada return
/// `YearCompletionService::checkAndUnlockVaccines()`, yang belum saya
/// lihat langsung. Parser defensif ini mencegah crash tipe seperti bug
/// `type 'Null' is not a subtype of type 'num'` sebelumnya.
List<int> _idsFromJson(dynamic json) {
  if (json is! List) return const <int>[];
  final ids = <int>[];
  for (final e in json) {
    if (e is num) {
      ids.add(e.toInt());
    } else if (e is Map && e['id'] is num) {
      ids.add((e['id'] as num).toInt());
    }
  }
  return ids;
}

/// Response `POST /sections/{section}/case-study/submit`
/// (CaseStudyController::submit()).
///
/// `badge`, `yearCompleted`, dan `newlyUnlockedVaccineIds` HANYA dikirim
/// backend kalau `is_correct == true` — pada jawaban salah `badge` null,
/// `yearCompleted` false, dan list id kosong (default).
///
/// `feedback` = teks tingkat kasus (feedback_correct/feedback_incorrect,
/// diisi admin). Sengaja TIDAK memberi tahu slot mana yang salah (R-CASE-06).
@freezed
abstract class CaseStudySubmitResult with _$CaseStudySubmitResult {
  const factory CaseStudySubmitResult({
    @JsonKey(name: 'is_correct') @Default(false) bool isCorrect,
    @Default('') String feedback,
    CaseStudyBadge? badge,
    @JsonKey(name: 'year_completed') @Default(false) bool yearCompleted,
    @JsonKey(name: 'newly_unlocked_vaccine_ids', fromJson: _idsFromJson)
    @Default(<int>[])
    List<int> newlyUnlockedVaccineIds,
  }) = _CaseStudySubmitResult;

  factory CaseStudySubmitResult.fromJson(Map<String, dynamic> json) =>
      _$CaseStudySubmitResultFromJson(json);
}