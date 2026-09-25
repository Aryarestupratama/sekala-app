import 'package:freezed_annotation/freezed_annotation.dart';

part 'case_study_badge.freezed.dart';
part 'case_study_badge.g.dart';

/// Badge per wabah (diisi admin: nama, deskripsi opsional, ikon).
///
/// SAAT INI backend (CaseStudyController::submit()) mengirim
/// `image_link` = link Google Drive MENTAH (`case_studies.badge_image_link`),
/// BUKAN URL yang sudah di-resolve seperti resource lain
/// (`LinkParserService::toDriveImageUrl()`). Link mentah tidak bisa
/// langsung dipakai `Image.network`/`CachedNetworkImage`.
///
/// `imageUrl` disiapkan untuk perbaikan sisi backend (kirim `image_url`
/// yang sudah di-resolve) — null selama backend belum mengirimnya.
/// Layar Badge nanti wajib memakai `imageUrl` dan menyiapkan fallback
/// kalau null/gagal dimuat.
@freezed
abstract class CaseStudyBadge with _$CaseStudyBadge {
  const factory CaseStudyBadge({
    @Default('') String name,
    String? description,
    @JsonKey(name: 'image_link') String? imageLink,
    @JsonKey(name: 'image_url') String? imageUrl,
  }) = _CaseStudyBadge;

  factory CaseStudyBadge.fromJson(Map<String, dynamic> json) =>
      _$CaseStudyBadgeFromJson(json);
}