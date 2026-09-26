import 'package:freezed_annotation/freezed_annotation.dart';

part 'badge_card.freezed.dart';
part 'badge_card.g.dart';

/// Mengacu tabel `years` (Schema.md §2.3) — dikirim BadgeResource biar
/// Koleksi Badge bisa mengelompokkan/menautkan badge ke wabah asalnya
/// tanpa request terpisah.
@freezed
abstract class BadgeYear with _$BadgeYear {
  const factory BadgeYear({
    required int id,
    required int year,
    required String title,
  }) = _BadgeYear;

  factory BadgeYear.fromJson(Map<String, dynamic> json) =>
      _$BadgeYearFromJson(json);
}

/// Mengacu tabel `eras` (Schema.md §2.2). Dipakai buat chip filter era di
/// BadgeListScreen — pola sama dengan VaccineEra di vaccine_card.dart.
@freezed
abstract class BadgeEra with _$BadgeEra {
  const factory BadgeEra({
    required int id,
    required String name,
    required String slug,
  }) = _BadgeEra;

  factory BadgeEra.fromJson(Map<String, dynamic> json) =>
      _$BadgeEraFromJson(json);
}

/// Mengacu BadgeResource.php (Fase 2 — Koleksi Badge, diturunkan dari
/// `case_studies` published + `user_case_study_attempts.completed_at`).
///
/// PENTING, BEDA dari VaccineCard: `name`/`iconUrl` TIDAK PERNAH
/// disamarkan walau `unlocked == false` — backend sengaja tetap mengirim
/// data asli (lihat catatan class-level BadgeResource.php), keputusan
/// produk: badge locked cukup diredupkan secara visual (lihat BadgeTile),
/// BUKAN disembunyikan seperti VaccineCardResource ("???" + photo_url
/// null). Jangan tiru pola `locked ? '???' : name` dari VaccineDetailScreen
/// untuk widget badge manapun.
@freezed
abstract class BadgeCard with _$BadgeCard {
  const factory BadgeCard({
    // id di sini = id `case_studies`, BUKAN id badge terpisah (memang
    // tidak ada tabel badges sendiri — lihat progress.md).
    required int id,

    @JsonKey(name: 'section_id') required int sectionId,

    required String name,
    String? description,

    @JsonKey(name: 'icon_url') String? iconUrl,

    // Turunan dari UserCaseStudyAttempt.completed_at (R-CASE-08 — sticky,
    // sekali true tidak akan pernah kembali false lagi walau user retake
    // dan salah).
    @JsonKey(name: 'unlocked', defaultValue: false) required bool unlocked,

    @JsonKey(name: 'unlocked_at') DateTime? unlockedAt,

    // Dot merah bottom nav "Profil" + menu "Koleksi Badge" + tag "Baru" di
    // grid (BadgeTile) — mirror VaccineCard.unseen. Turunan dari
    // `user_case_study_attempts.seen_at` masih null. Selalu false kalau
    // `unlocked == false` (badge locked tidak pernah dianggap "perlu
    // dilihat") — dijamin backend (BadgeResource::$isUnseen).
    @JsonKey(name: 'unseen', defaultValue: false) required bool unseen,

    required BadgeYear year,
    required BadgeEra era,
  }) = _BadgeCard;

  factory BadgeCard.fromJson(Map<String, dynamic> json) =>
      _$BadgeCardFromJson(json);
}