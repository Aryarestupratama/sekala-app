import 'package:freezed_annotation/freezed_annotation.dart';

part 'era_quiz_recap_option.freezed.dart';
part 'era_quiz_recap_option.g.dart';

/// DIKONFIRMASI ke `UserEraQuizController::recap()` — map opsi di situ
/// cuma `['id' => ..., 'option_text' => ...]`, TIDAK ADA `is_correct`
/// maupun `order` per opsi (koreksi dari asumsi versi sebelumnya).
///
/// Status benar/salah TIDAK ditaruh per-opsi di sini — dicek dari level
/// `EraQuizRecapItem.correctOptionId` (bandingkan `id` opsi ini dengan
/// itu untuk highlight hijau) dan `EraQuizRecapItem.selectedOptionId`
/// (bandingkan untuk tahu opsi mana yang dipilih user, merah kalau beda
/// dari `correctOptionId`). Lihat `EraQuizRecapItem` untuk field-field
/// tsb.
@freezed
abstract class EraQuizRecapOption with _$EraQuizRecapOption {
  const factory EraQuizRecapOption({
    required int id,
    @JsonKey(name: 'option_text') required String optionText,
  }) = _EraQuizRecapOption;

  factory EraQuizRecapOption.fromJson(Map<String, dynamic> json) =>
      _$EraQuizRecapOptionFromJson(json);
}