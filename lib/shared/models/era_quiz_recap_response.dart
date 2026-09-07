import 'package:freezed_annotation/freezed_annotation.dart';
import 'era_quiz_recap_item.dart';

part 'era_quiz_recap_response.freezed.dart';
part 'era_quiz_recap_response.g.dart';

/// DIKONFIRMASI ke `UserEraQuizController::recap()`:
/// ```json
/// { "completed_at": "...", "questions": [ ...EraQuizRecapItem ] }
/// ```
@freezed
abstract class EraQuizRecapResponse with _$EraQuizRecapResponse {
  const factory EraQuizRecapResponse({
    @JsonKey(name: 'completed_at') required String completedAt,
    @Default(<EraQuizRecapItem>[]) List<EraQuizRecapItem> questions,
  }) = _EraQuizRecapResponse;

  factory EraQuizRecapResponse.fromJson(Map<String, dynamic> json) =>
      _$EraQuizRecapResponseFromJson(json);
}