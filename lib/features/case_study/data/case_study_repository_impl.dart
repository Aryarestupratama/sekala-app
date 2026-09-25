import '../../../shared/models/case_study_detail.dart';
import '../../../shared/models/case_study_submit_result.dart';
import '../domain/case_study_repository.dart';
import 'case_study_api.dart';

class CaseStudyRepositoryImpl implements CaseStudyRepository {
  CaseStudyRepositoryImpl(this._api);
  final CaseStudyApi _api;

  @override
  Future<CaseStudyDetail> fetchCaseStudy(int sectionId) async {
    final raw = await _api.getCaseStudy(sectionId);
    return CaseStudyDetail.fromJson(raw);
  }

  @override
  Future<CaseStudySubmitResult> submit({
    required int sectionId,
    required List<int> slotOptionIds,
    required String reason,
  }) async {
    if (slotOptionIds.length != CaseStudyRules.slotCount) {
      throw ArgumentError.value(
        slotOptionIds,
        'slotOptionIds',
        'Wajib tepat ${CaseStudyRules.slotCount} id opsi (prioritas 1, 2, 3).',
      );
    }

    final raw = await _api.submit(
      sectionId: sectionId,
      slot1OptionId: slotOptionIds[0],
      slot2OptionId: slotOptionIds[1],
      slot3OptionId: slotOptionIds[2],
      reason: reason,
    );
    return CaseStudySubmitResult.fromJson(raw);
  }
}