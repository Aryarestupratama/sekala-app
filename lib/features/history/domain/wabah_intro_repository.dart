import '../../../shared/models/wabah_intro.dart';

abstract class WabahIntroRepository {
  /// Null kalau konten belum diisi admin / belum di-publish — dipakai
  /// pemanggil untuk memutuskan apakah modal/ikon info perlu ditampilkan
  /// sama sekali.
  Future<WabahIntro?> fetchWabahIntro();
}