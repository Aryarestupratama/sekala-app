import '../../../shared/models/era.dart';
import '../../../shared/models/section.dart';
import '../../../shared/models/year.dart';
import '../domain/history_repository.dart';
import 'history_api.dart';

class HistoryRepositoryImpl implements HistoryRepository {
  HistoryRepositoryImpl(this._api);
  final HistoryApi _api;

  List<dynamic> _asList(dynamic raw) {
    return raw is Map<String, dynamic> ? raw['data'] as List : raw as List;
  }

  Map<String, dynamic> _asObject(dynamic raw) {
    if (raw is Map<String, dynamic> && raw['data'] is Map<String, dynamic>) {
      return raw['data'] as Map<String, dynamic>;
    }
    return raw as Map<String, dynamic>;
  }

  @override
  Future<List<Era>> fetchEras() async {
    final raw = await _api.getEras();
    return _asList(raw)
        .map((json) => Era.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<List<Year>> fetchYears(String eraSlug) async {
    final raw = await _api.getYears(eraSlug);
    return _asList(raw)
        .map((json) => Year.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<Section> fetchSectionDetail(int sectionId) async {
    final raw = await _api.getSection(sectionId);
    return Section.fromJson(_asObject(raw));
  }

  @override
  Future<void> completeSection(int sectionId) {
    return _api.completeSection(sectionId);
  }
}
