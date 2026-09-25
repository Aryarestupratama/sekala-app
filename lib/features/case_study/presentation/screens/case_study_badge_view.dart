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
    this.onRetry,
  });

  final String wabahName;
  final CaseStudyBadge badge;
  final String description;
  final VoidCallback onNext;
  final VoidCallback? onRetry;

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
                          caseStudyReveal(context, 0, _BadgeMedallion(badge: badge)),
                          const SizedBox(height: 24),
                          caseStudyReveal(
                            context,
                            1,
                            Column(
                              children: [
                                const SizedBox(
                                  width: 40,
                                  child: Divider(
                                    color: AppColors.warning,
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
                                    fontSize: 11.5,
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
                                  fontSize: 15,
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
                            _BadgeNamePill(name: badge.name),
                          ),
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
                5,
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
  const _BadgeMedallion({required this.badge});

  final CaseStudyBadge badge;

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
                  color: AppColors.warning.withValues(alpha: 0.25),
                  blurRadius: 32,
                  spreadRadius: 4,
                ),
              ],
            ),
          ),
          Container(
            width: _size,
            height: _size,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.ink,
              border: Border.fromBorderSide(
                BorderSide(color: AppColors.warning, width: 6),
              ),
            ),
            clipBehavior: Clip.antiAlias,
            child: _BadgeImageOrIcon(badge: badge),
          ),
        ],
      ),
    );
  }
}

class _BadgeImageOrIcon extends StatelessWidget {
  const _BadgeImageOrIcon({required this.badge});

  final CaseStudyBadge badge;

  @override
  Widget build(BuildContext context) {
    final url = badge.imageUrl;
    if (url == null || url.trim().isEmpty) return const _PlaceholderIcon();

    return CachedNetworkImage(
      imageUrl: url,
      fit: BoxFit.cover,
      placeholder: (context, _) => const Center(
        child: SizedBox(
          width: 28,
          height: 28,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            color: AppColors.warning,
          ),
        ),
      ),
      errorWidget: (context, _, __) => const _PlaceholderIcon(),
    );
  }
}

class _PlaceholderIcon extends StatelessWidget {
  const _PlaceholderIcon();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Icon(
        Icons.military_tech_outlined,
        size: 56,
        color: AppColors.warning,
      ),
    );
  }
}

class _BadgeNamePill extends StatelessWidget {
  const _BadgeNamePill({required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    if (name.trim().isEmpty) return const SizedBox.shrink();

    return Container(
      constraints: const BoxConstraints(minHeight: 52, maxWidth: 320),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
      decoration: BoxDecoration(
        color: AppColors.warning,
        borderRadius: BorderRadius.circular(28),
      ),
      child: Text(
        name,
        textAlign: TextAlign.center,
        style: AppTextStyles.button.copyWith(
          color: AppColors.ink,
          fontSize: 15,
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
            const Icon(Icons.arrow_forward, size: 18),
          ],
        ),
      ),
    );
  }
}