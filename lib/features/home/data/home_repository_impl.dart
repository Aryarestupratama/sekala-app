import '../../../shared/models/home_progress.dart';
import '../domain/home_repository.dart';
import 'home_api.dart';

class HomeRepositoryImpl implements HomeRepository {
  HomeRepositoryImpl(this._api);
  final HomeApi _api;

  @override
  Future<HomeSummary> fetchHomeSummary() async {
    final json = await _api.getHomeSummary();
    return HomeSummary.fromJson(json);
  }
}
