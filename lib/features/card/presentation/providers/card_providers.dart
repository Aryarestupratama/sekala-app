import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/network/dio_client.dart';
import '../../../../shared/models/card_list_response.dart';
import '../../../../shared/models/figure_detail.dart';
import '../../data/card_api.dart';
import '../../data/card_repository_impl.dart';
import '../../domain/card_repository.dart';

final cardApiProvider = Provider<CardApi>((ref) {
  return CardApi(DioClient.instance.dio);
});

final cardRepositoryProvider = Provider<CardRepository>((ref) {
  return CardRepositoryImpl(ref.watch(cardApiProvider));
});

/// Rute ini cuma bisa dicapai user login terverifikasi (guard router +
/// middleware backend), jadi nggak perlu jaga-jaga guest di sini kayak
/// homeSummaryProvider.
final cardListProvider = FutureProvider.autoDispose<CardListResponse>((ref) {
  return ref.watch(cardRepositoryProvider).fetchCards();
});

final figureDetailProvider =
    FutureProvider.family.autoDispose<FigureDetail, int>((ref, figureId) {
  return ref.watch(cardRepositoryProvider).fetchFigureDetail(figureId);
});
