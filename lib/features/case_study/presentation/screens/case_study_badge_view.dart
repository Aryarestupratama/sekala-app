import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/models/case_study_badge.dart';
import '../case_study_texts.dart';
import '../widgets/case_study_common.dart';

/// Layar 4 Studi Kasus — Badge / mission complete (mockup Stitch, tema
/// terang). Widget PRESENTASI murni, sama filosofi dengan layar lain di
/// fitur ini.
///
/// - [wabahName]: nama wabah untuk kalimat judul template (`Year.title`).
/// - [badge]: hasil dari response submit yang BENAR
///   (`CaseStudySubmitResult.badge`) — `name` wajib admin isi, `imageUrl`
///   BISA null (backend saat ini hanya kirim `imageLink` mentah dari
///   Drive, BELUM di-resolve — lihat catatan di `CaseStudyBadge`). Kalau
///   `imageUrl` null atau gagal dimuat, lingkaran menampilkan ikon medali
///   placeholder, BUKAN layar error.
/// - [description]: paragraf di bawah judul. Diisi pemanggil dari
///   `badge.description` kalau admin mengisinya, atau fallback ke
///   `feedback_correct` — keputusan itu bukan tanggung jawab widget ini.
/// - [onNext]: tombol "Lanjut ke materi berikutnya" (section 9).
/// - [onRetry]: tombol sekunder opsional "Kerjakan ulang studi kasus" —
///   diisi HANYA saat shell membuka layar ini lewat jalur "studi kasus
///   sudah completed" (bukan momen baru saja submit benar). Mengerjakan
///   ulang tidak menghasilkan badge baru; null = tombol disembunyikan
///   (dipakai untuk momen pertama kali dapat badge, sesuai mockup asli
///   yang cuma punya 1 tombol).
class CaseStudyBadgeView extends StatelessWidget {
  const CaseStudyBadgeView({
    super.key,
    required this.wabahName,
    required this.badge,
    required this.description,
    required this.onNext,
    required this.accent,
    this.onRetry,
    this.notes = const [],
  });

  final String wabahName;
  final CaseStudyBadge badge;
  final String description;
  final VoidCallback onNext;

  /// Warna era (`EraAccents.ofSlug`), dioper dari shell — menggantikan
  /// oren hardcode di medali, glow, dan pil nama badge.
  final Color accent;
  final VoidCallback? onRetry;

  /// Catatan reward tambahan (badge baru masuk koleksi, border terbuka).
  /// Sebelumnya berupa SnackBar 4 detik yang menutupi tombol "Lanjut" —
  /// dua reward berarti tombol terblokir ~8 detik. Sekarang inline & tetap.
  final List<({IconData icon, String text})> notes;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                      horizontal: kCaseStudyHPad,
                      vertical: 16,
                    ),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight:
                            (constraints.maxHeight - 32).clamp(0.0, double.infinity),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          caseStudyReveal(
                            context,
                            0,
                            Semantics(
                              image: true,
                              label: badge.name.trim().isEmpty ? 'Badge' : 'Badge ${badge.name}',
                              child: ExcludeSemantics(
                                child: _BadgeMedallion(badge: badge, accent: accent),
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),
                          caseStudyReveal(
                            context,
                            1,
                            Column(
                              children: [
                                SizedBox(
                                  width: 40,
                                  child: Divider(
                                    color: accent,
                                    thickness: 3,
                                    height: 3,
                                  ),
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  CaseStudyTexts.badgeEyebrow,
                                  textAlign: TextAlign.center,
                                  style: AppTextStyles.caption.copyWith(
                                    color: AppColors.ink,
                                    fontSize: 12.5,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 1.2,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 12),
                          caseStudyReveal(
                            context,
                            2,
                            Text(
                              CaseStudyTexts.badgeTitle(wabahName),
                              textAlign: TextAlign.center,
                              style: AppTextStyles.h1.copyWith(fontSize: 26),
                            ),
                          ),
                          if (description.trim().isNotEmpty) ...[
                            const SizedBox(height: 12),
                            caseStudyReveal(
                              context,
                              3,
                              Text(
                                description.trim(),
                                textAlign: TextAlign.center,
                                style: AppTextStyles.body.copyWith(
                                  fontSize: 16,
                                  height: 1.6,
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            ),
                          ],
                          const SizedBox(height: 24),
                          caseStudyReveal(
                            context,
                            4,
                            _BadgeNamePill(name: badge.name, accent: accent),
                          ),
                          if (notes.isNotEmpty) ...[
                            const SizedBox(height: 16),
                            caseStudyReveal(
                              context,
                              5,
                              Semantics(
                                liveRegion: true,
                                child: Column(
                                  children: [
                                    for (final n in notes) _RewardNote(icon: n.icon, text: n.text),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(
                  kCaseStudyHPad, 8, kCaseStudyHPad, 20),
              child: caseStudyReveal(
                context,
                6,
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _NextButton(onTap: onNext),
                    if (onRetry != null) ...[
                      const SizedBox(height: 4),
                      TextButton(
                        onPressed: onRetry,
                        style: TextButton.styleFrom(
                          foregroundColor: AppColors.textSecondary,
                        ),
                        child: Text(
                          CaseStudyTexts.badgeRetryCta,
                          style: AppTextStyles.caption.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BadgeMedallion extends StatelessWidget {
  const _BadgeMedallion({required this.badge, required this.accent});

  final CaseStudyBadge badge;
  final Color accent;

  static const double _size = 168;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: _size + 32,
      height: _size + 32,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Soft glow di belakang lingkaran.
          Container(
            width: _size + 32,
            height: _size + 32,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: accent.withValues(alpha: 0.25),
                  blurRadius: 32,
                  spreadRadius: 4,
                ),
              ],
            ),
          ),
          Container(
            width: _size,
            height: _size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.ink,
              border: Border.fromBorderSide(
                BorderSide(color: accent, width: 6),
              ),
            ),
            clipBehavior: Clip.antiAlias,
            child: _BadgeImageOrIcon(badge: badge, accent: accent),
          ),
        ],
      ),
    );
  }
}

class _BadgeImageOrIcon extends StatelessWidget {
  const _BadgeImageOrIcon({required this.badge, required this.accent});

  final CaseStudyBadge badge;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    final url = badge.imageUrl;
    if (url == null || url.trim().isEmpty) return _PlaceholderIcon(accent: accent);

    return CachedNetworkImage(
      imageUrl: url,
      fit: BoxFit.cover,
      placeholder: (context, _) => Center(
        child: SizedBox(
          width: 28,
          height: 28,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            color: accent,
          ),
        ),
      ),
      errorWidget: (context, _, __) => _PlaceholderIcon(accent: accent),
    );
  }
}

class _PlaceholderIcon extends StatelessWidget {
  const _PlaceholderIcon({required this.accent});

  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Icon(
        Icons.military_tech_rounded,
        size: 56,
        color: accent,
      ),
    );
  }
}

class _BadgeNamePill extends StatelessWidget {
  const _BadgeNamePill({required this.name, required this.accent});

  final String name;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    if (name.trim().isEmpty) return const SizedBox.shrink();

    final onAccent = caseStudyOnColor(accent);

    return Container(
      constraints: const BoxConstraints(minHeight: 52, maxWidth: 320),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
      decoration: BoxDecoration(
        color: accent,
        borderRadius: BorderRadius.circular(28),
      ),
      child: Text(
        name,
        textAlign: TextAlign.center,
        style: AppTextStyles.button.copyWith(
          color: onAccent,
          fontSize: 16,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _NextButton extends StatelessWidget {
  const _NextButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: OutlinedButton(
        onPressed: onTap,
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.ink,
          side: const BorderSide(color: AppColors.ink, width: 1.5),
          shape: const StadiumBorder(),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              CaseStudyTexts.badgeNextCta,
              style: AppTextStyles.button.copyWith(color: AppColors.ink),
            ),
            const SizedBox(width: 8),
            const Icon(Icons.arrow_forward_rounded, size: 18),
          ],
        ),
      ),
    );
  }
}

/// Satu baris catatan reward (mis. "Border SEKALA terbuka!").
class _RewardNote extends StatelessWidget {
  const _RewardNote({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 360),
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: AppColors.ink),
          const SizedBox(width: 10),
          Flexible(
            child: Text(
              text,
              style: AppTextStyles.body.copyWith(fontSize: 14, height: 1.4),
            ),
          ),
        ],
      ),
    );
  }
}