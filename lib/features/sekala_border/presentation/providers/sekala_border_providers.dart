import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/network/dio_client.dart';
import '../../../../shared/models/sekala_border.dart';
import '../../data/sekala_border_api.dart';
import '../../data/sekala_border_repository_impl.dart';
import '../../domain/sekala_border_repository.dart';

final sekalaBorderApiProvider = Provider<SekalaBorderApi>((ref) {
  return SekalaBorderApi(DioClient.instance.dio);
});

final sekalaBorderRepositoryProvider = Provider<SekalaBorderRepository>((ref) {
  return SekalaBorderRepositoryImpl(ref.watch(sekalaBorderApiProvider));
});

/// Aset Border SEKALA — dipanggil untuk guest MAUPUN user login, sama
/// alasan `wabahIntroProvider` (endpoint publik tidak butuh auth). TIDAK
/// pernah null (beda dari wabahIntroProvider) — pemanggil (ProfileAvatar)
/// baca `SekalaBorder.displayImageUrl` untuk tahu apakah aset siap
/// ditampilkan (sudah publish & link valid) atau belum.
///
/// Bukan `.autoDispose` -- SENGAJA berbeda dari wabahIntroProvider, karena
/// ini dipakai `ProfileAvatar` yang bisa mount/unmount berkali-kali dalam
/// satu sesi (mis. tiap kali ProfileScreen dibuka dari bottom nav) dan
/// aset border praktis tidak berubah selama sesi berjalan -- tidak perlu
/// fetch ulang tiap kali widget rebuild dari nol.
final sekalaBorderProvider = FutureProvider<SekalaBorder>((ref) {
  return ref.watch(sekalaBorderRepositoryProvider).fetchSekalaBorder();
});