import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/network/dio_client.dart';
import '../../../../core/router/auth_state.dart';
import '../../../../shared/models/home_progress.dart';
import '../../data/home_api.dart';
import '../../data/home_repository_impl.dart';
import '../../domain/home_repository.dart';

final homeApiProvider = Provider<HomeApi>((ref) {
  return HomeApi(DioClient.instance.dio);
});

final homeRepositoryProvider = Provider<HomeRepository>((ref) {
  return HomeRepositoryImpl(ref.watch(homeApiProvider));
});

/// null untuk guest/unauthenticated (R-GUEST-02: guest nggak punya
/// progress record sama sekali, jadi endpoint /home nggak usah dipanggil).
/// Auto re-fetch tiap kali status auth berubah (login/logout) karena
/// watch authNotifierProvider di bawah.
final homeSummaryProvider = FutureProvider.autoDispose<HomeSummary?>((ref) async {
  final authStatus = ref.watch(authNotifierProvider).status;
  if (authStatus != AuthStatus.authenticated) return null;

  return ref.watch(homeRepositoryProvider).fetchHomeSummary();
});
