import '../../../shared/models/quiz.dart';
import '../../../shared/models/quiz_answer_check_result.dart';
import '../../../shared/models/quiz_submit_response.dart';
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
  Future<Quiz> fetchQuiz(int yearId) async {
    final raw = await _api.getQuiz(yearId);
    return Quiz.fromJson(_asObject(raw));
  }

  @override
  Future<QuizSubmitResponse> submitAttempt(
    int yearId,
    Map<int, int?> answersByQuestionId,
  ) async {
    final raw = await _api.submitAttempt(yearId, answersByQuestionId);
    return QuizSubmitResponse.fromJson(_asObject(raw));
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
}