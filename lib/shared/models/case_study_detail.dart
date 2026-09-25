import 'package:freezed_annotation/freezed_annotation.dart';

import 'case_study.dart';
import 'case_study_badge.dart';
import 'case_study_option.dart';

part 'case_study_detail.freezed.dart';
part 'case_study_detail.g.dart';

/// Response `GET /sections/{section}/case-study`
/// (Api\CaseStudy\CaseStudyController::show()).
///
/// - `options`: 5 opsi, urutan SUDAH diacak backend per request, tanpa
///   `correct_rank`. Karena diacak tiap request, sesi pengerjaan harus
///   memegang 1 hasil fetch saja (jangan re-fetch di tengah jalan).
/// - `completed`/`completedAt`: state mentah dari attempt user (sticky,
///   R-CASE-08). Alur layar saat `completed == true` (langsung Badge vs
///   tawaran "Kerjakan Ulang") masih open decision — sengaja tidak
///   diputuskan di layer data.
/// - `badge`: BELUM dikirim backend di `show()` (hanya di response
///   submit yang benar). Field disiapkan nullable supaya kalau backend
///   nanti menambahkannya saat `completed == true`, model ini langsung
///   siap tanpa perubahan.
@freezed
abstract class CaseStudyDetail with _$CaseStudyDetail {
  const factory CaseStudyDetail({
    @JsonKey(name: 'case_study') required CaseStudy caseStudy,
    @JsonKey(name: 'options', defaultValue: <CaseStudyOption>[])
    @Default(<CaseStudyOption>[])
    List<CaseStudyOption> options,
    @Default(false) bool completed,
    @JsonKey(name: 'completed_at') DateTime? completedAt,
    CaseStudyBadge? badge,
  }) = _CaseStudyDetail;

  factory CaseStudyDetail.fromJson(Map<String, dynamic> json) =>
      _$CaseStudyDetailFromJson(json);
}