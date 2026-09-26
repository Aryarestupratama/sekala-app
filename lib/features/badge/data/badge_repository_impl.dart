import '../../../shared/models/badge_list_response.dart';
import '../domain/badge_repository.dart';
import 'badge_api.dart';

class BadgeRepositoryImpl implements BadgeRepository {
  BadgeRepositoryImpl(this._api);
  final BadgeApi _api;

  @override
  Future<BadgeListResponse> fetchBadges() async {
    final json = await _api.getBadges();
    return BadgeListResponse.fromJson(json);
  }
}