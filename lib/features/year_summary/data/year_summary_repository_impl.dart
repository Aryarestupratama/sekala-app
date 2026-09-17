import '../../../shared/models/year_summary_attempt.dart';
import '../../../shared/models/year_summary_point_check_result.dart';
import '../../../shared/models/year_summary_submit_result.dart';
import '../domain/year_summary_repository.dart';
import 'year_summary_api.dart';

class YearSummaryRepositoryImpl implements YearSummaryRepository {
  YearSummaryRepositoryImpl(this._api);
  final YearSummaryApi _api;

  @override
  Future<YearSummaryAttempt> fetchSummary(int yearId) async {
    final raw = await _api.getSummary(yearId);
    return YearSummaryAttempt.fromJson(raw);
  }

  @override
  Future<YearSummaryPointCheckResult> checkAnswer({
    required int yearId,
    required int pointId,
    required int optionId,
  }) async {
    final raw = await _api.checkAnswer(yearId: yearId, pointId: pointId, optionId: optionId);
    return YearSummaryPointCheckResult.fromJson(raw);
  }

  @override
  Future<YearSummarySubmitResult> submit({
    required int yearId,
    required Map<int, int> answers,
  }) async {
    final payload = answers.entries
        .map((e) => {'point_id': e.key, 'option_id': e.value})
        .toList();
    final raw = await _api.submit(yearId: yearId, answers: payload);
    return YearSummarySubmitResult.fromJson(raw);
  }
}