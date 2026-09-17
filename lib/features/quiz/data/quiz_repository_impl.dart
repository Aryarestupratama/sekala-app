import '../../../shared/models/quiz_show_response.dart';
import '../../../shared/models/quiz_answer_check_result.dart';
import '../../../shared/models/quiz_retry_response.dart';
import '../domain/quiz_repository.dart';
import 'quiz_api.dart';

class QuizRepositoryImpl implements QuizRepository {
  QuizRepositoryImpl(this._api);
  final QuizApi _api;

  // Sama seperti HistoryRepositoryImpl — toleran response dengan/tanpa
  // wrapper "data" (konvensi Laravel API Resource).
  Map<String, dynamic> _asObject(dynamic raw) {
    if (raw is Map<String, dynamic> && raw['data'] is Map<String, dynamic>) {
      return raw['data'] as Map<String, dynamic>;
    }
    return raw as Map<String, dynamic>;
  }

  @override
  Future<QuizShowResponse> fetchQuiz(int yearId) async {
    final raw = await _api.getQuiz(yearId);
    return QuizShowResponse.fromJson(_asObject(raw));
  }

  @override
  Future<QuizAnswerCheckResult> answerQuestion(
    int yearId,
    int questionId,
    int optionId,
  ) async {
    final raw = await _api.answerQuestion(yearId, questionId, optionId);
    return QuizAnswerCheckResult.fromJson(_asObject(raw));
  }

  @override
  Future<QuizRetryResponse> retryQuiz(int yearId) async {
    final raw = await _api.retryQuiz(yearId);
    return QuizRetryResponse.fromJson(_asObject(raw));
  }
}