import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../era_quiz/presentation/providers/era_quiz_providers.dart';

/// Node "final boss" (ERAQUIZ-01) — dirender sebagai node TERAKHIR di
/// roadmap era, setelah seluruh node tahun. 3 kemungkinan visual:
///
/// - `locked` (belum semua year completed, R-ERAQUIZ-02): lingkaran abu +
///   gembok, sama gaya `_LockedNode` di year_node.dart, tapi lebih besar
///   supaya tetap terasa "mencolok" sebagai puncak perjalanan meski
///   masih terkunci.
/// - unlocked + belum attempted: lingkaran MERAH besar mencolok (ERAQUIZ-01
///   eksplisit minta ini beda dari node tahun biasa) dengan ikon mahkota/
///   petir (`Icons.local_fire_department` dipakai sementara — ganti kalau
///   Design.md punya ikon spesifik yang belum saya lihat).
/// - unlocked + sudah attempted: lingkaran warna era + checkmark (mirip
///   `_CompletedNode` tahun), tap membuka halaman Hasil langsung dari
///   attempt tersimpan (bukan mengerjakan ulang — retake ada tombol
///   terpisah di halaman Hasil sendiri, ERAQUIZ-05).
///
/// CATATAN PENTING (gap yang perlu diketahui sebelum dipakai production):
/// `eraQuizAttemptStatusProvider` (lewat `fetchResult()`) 404 untuk DUA
/// kondisi yang tak terbedakan dari backend: "belum pernah attempt" ATAU
/// "era ini memang tidak punya kuis sumatif ter-publish". Widget ini
/// menutup gap itu dengan mengecek `eraQuizProvider` (endpoint `show()`)
/// LEBIH DULU — kalau itu sendiri 404 (quiz tidak ada/belum publish),
/// node ini disembunyikan total (`SizedBox.shrink()`), BUKAN dianggap
/// "belum attempted". Konsekuensinya: butuh sampai 2 request tambahan
/// (`show()` lalu `result()`) tiap kali node ini perlu dirender untuk
/// era yang unlocked — pertimbangkan cache/optimasi lebih lanjut kalau
/// roadmap terasa lambat, TAPI jangan hilangkan pengecekan `show()`-nya
/// karena itu satu-satunya cara yang benar dari source yang ada saat ini.
class FinalBossNode extends ConsumerWidget {
  const FinalBossNode({
    super.key,
    required this.eraId,
    required this.unlocked,
    required this.accent,
    required this.onTapLocked,
    required this.onTapUnattempted,
    required this.onTapAttempted,
    this.nodeX,
    this.screenWidth,
  });

  final int eraId;
  final bool unlocked;
  final Color accent;
  final VoidCallback onTapLocked;
  final VoidCallback onTapUnattempted;
  final VoidCallback onTapAttempted;
  final double? nodeX;
  final double? screenWidth;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (!unlocked) {
      return _LockedFinalBoss(onTap: onTapLocked, nodeX: nodeX, screenWidth: screenWidth);
    }

    final quizAsync = ref.watch(eraQuizProvider(eraId));

    return quizAsync.when(
      // Quiz ada & published -> lanjut cek status attempted.
      data: (_) {
        final attemptedAsync = ref.watch(eraQuizAttemptStatusProvider(eraId));
        return attemptedAsync.when(
          data: (attempted) => attempted
              ? _AttemptedFinalBoss(
                  accent: accent,
                  onTap: onTapAttempted,
                  nodeX: nodeX,
                  screenWidth: screenWidth,
                )
              : _UnattemptedFinalBoss(
                  onTap: onTapUnattempted,
                  nodeX: nodeX,
                  screenWidth: screenWidth,
                ),
          loading: () => const _LoadingFinalBoss(),
          // Kalau ternyata error di sini BUKAN 404 (mis. 401/500), tampilkan
          // versi unattempted apa adanya supaya node tidak hilang total dari
          // roadmap tanpa penjelasan — tap akan mencoba fetch lagi & error
          // aslinya akan muncul di layar kuis (AsyncError biasa di sana).
          error: (_, __) => _UnattemptedFinalBoss(
            onTap: onTapUnattempted,
            nodeX: nodeX,
            screenWidth: screenWidth,
          ),
        );
      },
      loading: () => const _LoadingFinalBoss(),
      // 404 (atau error lain) dari show() -> anggap era ini memang belum
      // punya kuis sumatif ter-publish, sembunyikan node sepenuhnya
      // (lihat catatan panjang di atas kelas ini).
      error: (_, __) => const SizedBox.shrink(),
    );
  }
}

class _LoadingFinalBoss extends StatelessWidget {
  const _LoadingFinalBoss();

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 88,
      height: 88,
      child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
    );
  }
}

class _LockedFinalBoss extends StatelessWidget {
  const _LockedFinalBoss({required this.onTap, this.nodeX, this.screenWidth});

  final VoidCallback onTap;
  final double? nodeX;
  final double? screenWidth;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 84,
            height: 84,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.border,
            ),
            alignment: Alignment.center,
            child: const Icon(Icons.lock, size: 28, color: AppColors.textDisabled),
          ),
          const SizedBox(height: 8),
          Container(
            constraints: const BoxConstraints(maxWidth: 160),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColors.border),
            ),
            child: const Text(
              'Kuis Sumatif — Selesaikan semua tahun',
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: AppColors.textDisabled,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Belum dikerjakan sama sekali — SENGAJA dibuat paling mencolok
/// (merah + ikon besar + shadow tebal) karena ERAQUIZ-01 minta ikon ini
/// tampil "besar/mencolok" beda dari node tahun biasa.
class _UnattemptedFinalBoss extends StatelessWidget {
  const _UnattemptedFinalBoss({required this.onTap, this.nodeX, this.screenWidth});

  final VoidCallback onTap;
  final double? nodeX;
  final double? screenWidth;

  static const _red = Color(0xFFE53935);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 96,
            height: 96,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _red,
              boxShadow: [
                BoxShadow(color: _red.withOpacity(0.45), blurRadius: 20, offset: const Offset(0, 6)),
              ],
              border: Border.all(color: Colors.white, width: 3),
            ),
            alignment: Alignment.center,
            // TODO: ganti ikon kalau Design.md menetapkan ikon final-boss
            // yang spesifik — ini placeholder sementara.
            child: const Icon(Icons.local_fire_department, size: 40, color: Colors.white),
          ),
          const SizedBox(height: 8),
          Container(
            constraints: const BoxConstraints(maxWidth: 170),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.ink,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Kuis Sumatif Era',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
                ),
                SizedBox(height: 2),
                Text(
                  'Uji semua yang sudah kamu pelajari →',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white70, fontSize: 10),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Sudah pernah dikerjakan (permanen, R-ERAQUIZ-09 — independen dari
/// retake berikutnya). Tap membuka halaman Hasil dari attempt tersimpan
/// terakhir (bukan mengerjakan ulang otomatis).
class _AttemptedFinalBoss extends StatelessWidget {
  const _AttemptedFinalBoss({
    required this.accent,
    required this.onTap,
    this.nodeX,
    this.screenWidth,
  });

  final Color accent;
  final VoidCallback onTap;
  final double? nodeX;
  final double? screenWidth;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: 84,
                height: 84,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: accent,
                  boxShadow: [
                    BoxShadow(color: accent.withOpacity(0.35), blurRadius: 12, offset: const Offset(0, 4)),
                  ],
                ),
                alignment: Alignment.center,
                child: const Icon(Icons.emoji_events, size: 34, color: Colors.white),
              ),
              Positioned(
                top: -4,
                right: -4,
                child: Container(
                  width: 22,
                  height: 22,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.success,
                    border: Border.fromBorderSide(BorderSide(color: Colors.white, width: 2)),
                  ),
                  child: const Icon(Icons.check, size: 13, color: Colors.white),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            constraints: const BoxConstraints(maxWidth: 150),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColors.border),
            ),
            child: const Text(
              'Kuis Sumatif — Lihat Hasil',
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.ink),
            ),
          ),
        ],
      ),
    );
  }
}