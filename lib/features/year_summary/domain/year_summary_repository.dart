import '../../../shared/models/year_summary_attempt.dart';
import '../../../shared/models/year_summary_point_check_result.dart';
import '../../../shared/models/year_summary_submit_result.dart';

abstract class YearSummaryRepository {
  /// GET /years/{year}/summary. Lempar exception (mis. 403 belum semua
  /// section completed, atau 404 rangkuman belum published) — ditangani
  /// caller lewat `AsyncValue.error` di provider.
  Future<YearSummaryAttempt> fetchSummary(int yearId);

  /// POST /years/{year}/summary/points/{point}/answer (SUM-02).
  Future<YearSummaryPointCheckResult> checkAnswer({
    required int yearId,
    required int pointId,
    required int optionId,
  });

  /// POST /years/{year}/summary/complete — [answers] wajib tepat 7 pasang
  /// (pointId, optionId), urutan bebas.
  Future<YearSummarySubmitResult> submit({
    required int yearId,
    required Map<int, int> answers,
  });
}