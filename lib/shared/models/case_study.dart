import 'package:freezed_annotation/freezed_annotation.dart';

part 'case_study.freezed.dart';
part 'case_study.g.dart';

/// Bagian `case_study` dari response `GET /sections/{section}/case-study`
/// (Api\CaseStudy\CaseStudyController::show()) — HANYA teks yang diisi
/// admin untuk layar Briefing Kasus & Ruang Keputusan.
///
/// Teks template (header "SIMULASI PROBLEM-BASED LEARNING", kartu Peran
/// Pemain/Aturan Main, dst.) sengaja TIDAK ada di sini — hardcode di
/// Flutter dengan nama wabah disisipkan otomatis (progress.md).
/// `feedback_correct`/`feedback_incorrect` juga tidak ada di sini: baru
/// dikirim di response submit.
@freezed
abstract class CaseStudy with _$CaseStudy {
  const factory CaseStudy({
    required int id,
    @Default('') String title,
    @Default('') String description,
    @JsonKey(name: 'challenge_text') @Default('') String challengeText,

    /// Deskripsi di atas kolom alasan (Ruang Keputusan) — isi admin.
    @JsonKey(name: 'reason_description') @Default('') String reasonDescription,
  }) = _CaseStudy;

  factory CaseStudy.fromJson(Map<String, dynamic> json) =>
      _$CaseStudyFromJson(json);
}