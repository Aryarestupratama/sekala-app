import '../../../shared/models/case_study_detail.dart';
import '../../../shared/models/case_study_submit_result.dart';

/// Konstanta aturan Studi Kasus di sisi client. Sumber kebenaran tetap
/// backend (`CaseStudyService`/`CaseStudy`) — nilai di sini hanya untuk
/// mengaktifkan/menonaktifkan tombol Submit lebih awal di UI.
class CaseStudyRules {
  const CaseStudyRules._();

  /// Mirror `CaseStudyService::REASON_MIN_LENGTH` (R-CASE-07). BELUM
  /// final di backend (usulan 30) — kalau angkanya berubah di sana,
  /// ubah di sini juga (atau minta backend mengirimnya di `show()`).
  /// Backend menghitung setelah `trim()` di service, jadi UI sebaiknya
  /// menghitung `reason.trim().length`.
  static const int reasonMinLength = 30;

  /// Jumlah slot prioritas (R-CASE-03).
  static const int slotCount = 3;

  /// Jumlah opsi tetap per kasus (R-CASE-02).
  static const int optionCount = 5;
}

abstract class CaseStudyRepository {
  /// GET /sections/{section}/case-study. Melempar exception (403 gate
  /// belum terbuka, 404 bukan case_study/belum published) — ditangani
  /// caller lewat `AsyncValue.error` di provider.
  Future<CaseStudyDetail> fetchCaseStudy(int sectionId);

  /// POST /sections/{section}/case-study/submit.
  ///
  /// [slotOptionIds] wajib berisi TEPAT 3 id opsi berbeda, urutan =
  /// prioritas 1, 2, 3.
  Future<CaseStudySubmitResult> submit({
    required int sectionId,
    required List<int> slotOptionIds,
    required String reason,
  });
}