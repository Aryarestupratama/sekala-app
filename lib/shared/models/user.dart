import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

/// Mengacu UserResource aktual (dikonfirmasi lewat testing 28 Agt 2026):
/// { id, name, email, role, is_email_verified }.
///
/// PERUBAHAN: backend kirim `is_email_verified` (boolean langsung),
/// BUKAN `email_verified_at` (timestamp nullable) seperti dugaan awal
/// dari Schema.md. Field & getter disesuaikan.
@freezed
abstract class User with _$User {
  const factory User({
    required int id,
    required String name,
    required String email,
    // 'user' | 'admin' — R-ADMIN-01: tanpa sub-level, jadi cukup String,
    // nggak perlu enum bertingkat.
    required String role,
    @JsonKey(name: 'is_email_verified') required bool isEmailVerified,
  }) = _User;

  const User._();

  bool get isAdmin => role == 'admin';

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
