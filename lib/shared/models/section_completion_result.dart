import 'package:freezed_annotation/freezed_annotation.dart';

part 'section_completion_result.freezed.dart';
part 'section_completion_result.g.dart';

/// Bungkus response POST /api/sections/{section}/complete
/// (ProgressController::complete()). Sebelumnya body response ini dibuang
/// total oleh HistoryApi.completeSection() — sekarang diparse supaya
/// `year_completed` bisa dipakai buat auto-redirect ke Rangkuman Wabah
/// (backlog progress.md, konsumsi field yang sudah disiapkan backend).
///
/// PENTING soal semantik `year_completed`: baru true kalau SEMUA section
/// year ini completed DAN kuis year-nya juga sudah dikerjakan
/// (R-PROG-07/08). Di alur baca maju normal, kuis baru bisa dikerjakan
/// dari halaman Rangkuman (sesudah section terakhir) — jadi field ini
/// TIDAK akan true tepat saat section terakhir baru selesai dibaca
/// (itu masih ditentukan heuristic lokal `isLastSection` di
/// SectionDetailScreen, yang tetap benar untuk kasus itu). Nilai field
/// ini justru berguna di skenario non-linear: user membaca ulang/
/// menyelesaikan section yang belum completed padahal year-nya SUDAH
/// completed sebelumnya (mis. deep link ke section lama setelah kuis &
/// year selesai) — di situ backend adalah sumber kebenaran yang lebih
/// bisa dipercaya ketimbang hitungan client "section terakhir by order".
///
/// `newlyUnlockedVaccineIds` ikut diparse sekalian (data-nya sudah ada di
/// response, sayang dibuang) tapi BELUM dipakai UI apa pun di sini —
/// disiapkan untuk backlog terpisah (animasi "Vaksin baru terbuka!",
/// INFO-06) kalau nanti dikerjakan, bukan bagian dari scope redirect ini.
@freezed
abstract class SectionCompletionResult with _$SectionCompletionResult {
  const factory SectionCompletionResult({
    @JsonKey(name: 'completed_at') String? completedAt,
    @JsonKey(name: 'year_completed') @Default(false) bool yearCompleted,
    @JsonKey(name: 'newly_unlocked_vaccine_ids')
    @Default(<int>[])
    List<int> newlyUnlockedVaccineIds,
  }) = _SectionCompletionResult;

  factory SectionCompletionResult.fromJson(Map<String, dynamic> json) =>
      _$SectionCompletionResultFromJson(json);
}