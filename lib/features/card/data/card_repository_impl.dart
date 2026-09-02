import '../../../shared/models/card_list_response.dart';
import '../../../shared/models/vaccine_detail.dart';
import '../domain/card_repository.dart';
import 'card_api.dart';

class CardRepositoryImpl implements CardRepository {
  CardRepositoryImpl(this._api);
  final CardApi _api;

  @override
  Future<CardListResponse> fetchCards() async {
    final json = await _api.getCards();
    return CardListResponse.fromJson(json);
  }

  @override
  Future<VaccineDetail> fetchVaccineDetail(int vaccineId) async {
    final raw = await _api.getVaccineDetail(vaccineId);
    // CardController::show balikin `new VaccineDetailResource(...)` langsung
    // — Laravel otomatis bungkus jadi { "data": {...} } secara default,
    // tapi kode ini tetap toleran kalau ternyata nggak dibungkus.
    final data = (raw is Map<String, dynamic> && raw['data'] is Map<String, dynamic>)
        ? raw['data'] as Map<String, dynamic>
        : raw as Map<String, dynamic>;
    return VaccineDetail.fromJson(data);
  }
}