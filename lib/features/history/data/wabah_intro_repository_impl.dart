import '../../../shared/models/wabah_intro.dart';
import '../domain/wabah_intro_repository.dart';
import 'wabah_intro_api.dart';

class WabahIntroRepositoryImpl implements WabahIntroRepository {
  WabahIntroRepositoryImpl(this._api);
  final WabahIntroApi _api;

  @override
  Future<WabahIntro?> fetchWabahIntro() async {
    final json = await _api.getWabahIntro();
    if (json == null) return null;
    return WabahIntro.fromJson(json);
  }
}