import 'package:freezed_annotation/freezed_annotation.dart';

part 'era_ref.freezed.dart';
part 'era_ref.g.dart';

/// Shape {id, name, slug} yang berulang di beberapa tempat dalam response
/// HomeController (progress_by_era.era, recommendation.era) — dipisah jadi
/// model sendiri biar nggak duplikat definisi.
@freezed
abstract class EraRef with _$EraRef {
  const factory EraRef({
    required int id,
    required String name,
    required String slug,
  }) = _EraRef;

  factory EraRef.fromJson(Map<String, dynamic> json) => _$EraRefFromJson(json);
}
