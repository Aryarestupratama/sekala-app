import '../../../shared/models/era_quiz.dart';
import '../../../shared/models/era_quiz_recap_response.dart';
import '../../../shared/models/era_quiz_result_response.dart';
import '../domain/era_quiz_repository.dart';
import 'era_quiz_api.dart';

class EraQuizRepositoryImpl implements EraQuizRepository {
  EraQuizRepositoryImpl(this._api);
  final EraQuizApi _api;

  // DIKONFIRMASI: controller pakai response()->json([...]) langsung
  // (bukan API Resource), jadi TIDAK ada wrapper "data" untuk endpoint
  // era quiz manapun. Helper ini dipertahankan (bukan dihapus) supaya
  // tetap toleran kalau suatu saat dibungkus Resource — konsisten
  // dengan pola QuizRepositoryImpl.
  Map<String, dynamic> _asObject(dynamic raw) {
    if (raw is Map<String, dynamic> && raw['data'] is Map<String, dynamic>) {
      return raw['data'] as Map<String, dynamic>;
    }
    return raw as Map<String, dynamic>;
  }

  @override
  Future<EraQuiz> fetchQuiz(int eraId) async {
    final raw = await _api.getQuiz(eraId);
    return EraQuiz.fromJson(_asObject(raw));
  }

  @override
  Future<EraQuizResultResponse> submitAttempt(
    int eraId,
    Map<int, int> answersByQuestionId,
  ) async {
    final raw = await _api.submitAttempt(eraId, answersByQuestionId);
    return EraQuizResultResponse.fromJson(_asObject(raw));
  }

  @override
  Future<EraQuizResultResponse> fetchResult(int eraId) async {
    final raw = await _api.getResult(eraId);
    return EraQuizResultResponse.fromJson(_asObject(raw));
  }

  @override
  Future<EraQuizRecapResponse> fetchRecap(int eraId) async {
    final raw = await _api.getRecap(eraId);
    return EraQuizRecapResponse.fromJson(_asObject(raw));
  }
}