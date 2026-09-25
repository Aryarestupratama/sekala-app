import 'package:freezed_annotation/freezed_annotation.dart';

part 'case_study_option.freezed.dart';
part 'case_study_option.g.dart';

/// 1 dari 5 opsi (A–E) di layar Ruang Keputusan — TANPA `correct_rank`
/// sama sekali (R-CASE-09, CaseStudyService::getOptionsForAttempt()):
/// kunci jawaban tidak pernah dikirim ke client, evaluasi hanya di server
/// saat submit.
///
/// Backend TIDAK mengirim label huruf (A–E) — urutan array sudah diacak
/// server per request. Kalau UI mau menampilkan huruf, beri label di
/// client SETELAH fetch (berdasarkan index), dan JANGAN re-fetch di
/// tengah sesi karena urutannya akan teracak ulang.
@freezed
abstract class CaseStudyOption with _$CaseStudyOption {
  const factory CaseStudyOption({
    required int id,
    @Default('') String title,
    @Default('') String description,
  }) = _CaseStudyOption;

  factory CaseStudyOption.fromJson(Map<String, dynamic> json) =>
      _$CaseStudyOptionFromJson(json);
}