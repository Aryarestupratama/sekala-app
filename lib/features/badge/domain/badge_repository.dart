import '../../../shared/models/badge_list_response.dart';

abstract class BadgeRepository {
  Future<BadgeListResponse> fetchBadges();

  /// Tandai badge (case_study) sudah dilihat user — dot merah bottom nav
  /// "Profil", dot menu "Koleksi Badge", dan tag "Baru" di grid ikut
  /// hilang begitu provider di-invalidate setelah panggilan ini. Mirror
  /// CardRepository.markVaccineSeen.
  Future<void> markBadgeSeen(int caseStudyId);
}