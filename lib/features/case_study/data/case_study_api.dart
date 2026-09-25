import 'package:dio/dio.dart';
import '../../../core/network/api_result.dart';

/// Endpoint Studi Kasus (Fase 1) — Api\CaseStudy\CaseStudyController.
/// Param path `{section}` = id section (integer) bertipe `case_study`
/// (selalu order 8), BUKAN id year.
///
/// Butuh auth:sanctum + verified (grup middleware yang sama dengan kuis &
/// rangkuman). Gate akses = SectionAccessService::isUnlocked() — 403 kalau
/// section sebelumnya belum selesai, 404 kalau section bukan case_study
/// atau studi kasusnya belum published.
class CaseStudyApi {
  CaseStudyApi(this._dio);
  final Dio _dio;

  /// GET /sections/{section}/case-study
  Future<Map<String, dynamic>> getCaseStudy(int sectionId) {
    return unwrapApiCall(() async {
      final response = await _dio.get('/sections/$sectionId/case-study');
      return response.data as Map<String, dynamic>;
    });
  }

  /// POST /sections/{section}/case-study/submit
  ///
  /// Payload persis sesuai StoreCaseStudySubmitRequest: 3 slot (wajib
  /// opsi BERBEDA) + `reason` (min CaseStudyService::REASON_MIN_LENGTH
  /// karakter). Validasi gagal -> 422.
  Future<Map<String, dynamic>> submit({
    required int sectionId,
    required int slot1OptionId,
    required int slot2OptionId,
    required int slot3OptionId,
    required String reason,
  }) {
    return unwrapApiCall(() async {
      final response = await _dio.post(
        '/sections/$sectionId/case-study/submit',
        data: {
          'slot_1_option_id': slot1OptionId,
          'slot_2_option_id': slot2OptionId,
          'slot_3_option_id': slot3OptionId,
          'reason': reason,
        },
      );
      return response.data as Map<String, dynamic>;
    });
  }
}