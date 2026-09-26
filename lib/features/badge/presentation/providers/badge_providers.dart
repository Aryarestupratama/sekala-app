import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/network/dio_client.dart';
import '../../../../shared/models/badge_list_response.dart';
import '../../data/badge_api.dart';
import '../../data/badge_repository_impl.dart';
import '../../domain/badge_repository.dart';

final badgeApiProvider = Provider<BadgeApi>((ref) {
  return BadgeApi(DioClient.instance.dio);
});

final badgeRepositoryProvider = Provider<BadgeRepository>((ref) {
  return BadgeRepositoryImpl(ref.watch(badgeApiProvider));
});

/// SENGAJA TIDAK `.autoDispose` — sama alasan dengan bugfix cardListProvider
/// (lihat card_providers.dart): kalau nanti ada invalidate dipanggil tepat
/// sebelum navigasi keluar dari BadgeListScreen (mis. dari
/// CaseStudyShellScreen setelah submit benar, kalau nanti ditambahkan),
/// autoDispose bisa menciptakan race yang sama — provider kehilangan
/// listener sebelum sempat refetch. Provider ini bukan `.family`, aman
/// hidup selama app berjalan.
final badgeListProvider = FutureProvider<BadgeListResponse>((ref) {
  return ref.watch(badgeRepositoryProvider).fetchBadges();
});