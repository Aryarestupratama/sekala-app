import '../../../shared/models/era.dart';
import '../../../shared/models/era_roadmap.dart';
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
  Future<EraRoadmap> fetchYears(String eraSlug) async {
    final raw = await _api.getYears(eraSlug);

    final years = _asList(raw)
        .map((json) => Year.fromJson(json as Map<String, dynamic>))
        .toList();

    // meta.completed_years/total_years (Architecture.md §4.7). Fallback ke
    // hitung manual dari `years` kalau backend belum di-deploy dengan field
    // ini (fail-safe, bukan bikin app crash gara-gara field baru).
    final meta = raw is Map<String, dynamic>
        ? raw['meta'] as Map<String, dynamic>?
        : null;

    return EraRoadmap(
      years: years,
      completedYears:
          meta?['completed_years'] as int? ?? years.where((y) => y.isCompleted).length,
      totalYears: meta?['total_years'] as int? ?? years.length,
    );
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