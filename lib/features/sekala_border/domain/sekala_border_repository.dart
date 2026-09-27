import '../../../shared/models/sekala_border.dart';

abstract class SekalaBorderRepository {
  /// Selalu mengembalikan object (tidak pernah null) — beda dari
  /// WabahIntroRepository. Gate publish dicek lewat
  /// `SekalaBorder.displayImageUrl`, bukan lewat nullability di sini.
  Future<SekalaBorder> fetchSekalaBorder();
}