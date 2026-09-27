import '../../../shared/models/sekala_border.dart';
import '../domain/sekala_border_repository.dart';
import 'sekala_border_api.dart';

class SekalaBorderRepositoryImpl implements SekalaBorderRepository {
  SekalaBorderRepositoryImpl(this._api);
  final SekalaBorderApi _api;

  @override
  Future<SekalaBorder> fetchSekalaBorder() async {
    final json = await _api.getSekalaBorder();
    return SekalaBorder.fromJson(json);
  }
}