import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

/// Mengacu UserResource aktual.
///
/// Fase 3 (progress.md) — 4 field baru: `avatar_url` (null = belum pernah
/// upload, Flutter fallback inisial), `frame_unlocked`/`frame_unlocked_at`
/// (PERMANEN sekali true, lihat User::hasFrameUnlocked() backend — tidak
/// pernah kembali false), `frame_equipped` (toggle pasang/lepas, hanya
/// bermakna kalau frame_unlocked true).
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
    @JsonKey(name: 'avatar_url') String? avatarUrl,
    @JsonKey(name: 'frame_unlocked') @Default(false) bool frameUnlocked,
    @JsonKey(name: 'frame_unlocked_at') DateTime? frameUnlockedAt,
    @JsonKey(name: 'frame_equipped') @Default(false) bool frameEquipped,
    // BARU — status "sudah lihat tutorial onboarding" level AKUN,
    // MENGGANTIKAN flag SharedPreferences murni-lokal di
    // TutorialTourController (yang salah asumsi per-device, bukan per-akun
    // — lihat catatan panjang di sana). Guest tidak punya User (fetchMe()
    // cuma dipanggil untuk authenticated), jadi guest tetap pakai flag
    // lokal terpisah.
    @JsonKey(name: 'has_seen_onboarding_tutorial')
    @Default(false)
    bool hasSeenOnboardingTutorial,
  }) = _User;

  const User._();

  bool get isAdmin => role == 'admin';

  /// `frameEquipped` dikirim backend apa adanya (default false), TAPI kalau
  /// suatu saat backend/kondisi race mengirim true padahal belum unlocked,
  /// UI baiknya tetap patuh ke frameUnlocked sebagai syarat tampil —
  /// dipakai widget avatar/border, bukan cuma baca frameEquipped mentah.
  bool get shouldShowFrame => frameUnlocked && frameEquipped;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}