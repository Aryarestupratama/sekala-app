import 'package:freezed_annotation/freezed_annotation.dart';

part 'era.freezed.dart';
part 'era.g.dart';

/// Mengacu Schema.md §2.2 `eras` (Kolonial/Kemerdekaan/Modern).
@freezed
abstract class Era with _$Era {
  const factory Era({
    required int id,
    required String name,
    required String slug,
    String? description,
    required int order,
  }) = _Era;

  factory Era.fromJson(Map<String, dynamic> json) => _$EraFromJson(json);
}
