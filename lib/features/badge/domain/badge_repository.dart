import '../../../shared/models/badge_list_response.dart';

abstract class BadgeRepository {
  Future<BadgeListResponse> fetchBadges();
}