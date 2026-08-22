import 'package:flutter/material.dart';

/// Palette warna final SEKALA — sinkron dengan Design.md §5.2
/// dan `src/config/branding.js` di React Admin SPA.
class AppColors {
  AppColors._();

  // === Core palette (Design.md §5.2) ===
  static const Color ink = Color(0xFF0C0C0C);
  static const Color green = Color(0xFF4BA95F);
  static const Color sky = Color(0xFF77DDFA);
  static const Color orange = Color(0xFFFEA339);
  static const Color purple = Color(0xFF9985FB);
  static const Color coral = Color(0xFFFF908D);

  // === Semantic roles ===
  static const Color primary = ink;
  static const Color success = green;   // progress / badge "Published"/"Selesai"
  static const Color warning = orange;  // CTA / highlight rekomendasi
  static const Color info = sky;        // aksen info
  static const Color gamify = purple;   // collectible card, badge unlock
  static const Color highlight = coral; // aksen hangat, BUKAN warna destructive

  // Destructive tetap merah standar (bukan Coral — sesuai catatan Design.md §5.2)
  static const Color destructive = Color(0xFFDC2626);

  // === Neutral scale (untuk background, border, teks sekunder) ===
  static const Color background = Color(0xFFFAFAFA);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color border = Color(0xFFE5E5E5);
  static const Color textSecondary = Color(0xFF6B6B6B);
  static const Color textDisabled = Color(0xFFA3A3A3);
}

/// Enum masa/era — dipakai bareng ERA_ACCENTS di bawah.
enum HistoryEra { kolonial, kemerdekaan, modern }

/// Aksen warna per era — sinkron dengan Design.md §5.4
/// dan ERA_ACCENTS + getEraAccent() di branding.js React Admin.
class EraAccents {
  EraAccents._();

  static const Map<HistoryEra, Color> _accents = {
    HistoryEra.kolonial: AppColors.orange,     // nuansa hangat/vintage
    HistoryEra.kemerdekaan: AppColors.green,   // nuansa semangat/pertumbuhan
    HistoryEra.modern: AppColors.sky,          // nuansa bersih/kontemporer
  };

  static Color of(HistoryEra era) => _accents[era] ?? AppColors.primary;

  /// Helper kalau era datang sebagai slug string dari API
  /// (mis. response backend: "kolonial" | "kemerdekaan" | "modern")
  static Color ofSlug(String slug) {
    switch (slug.toLowerCase()) {
      case 'kolonial':
        return AppColors.orange;
      case 'kemerdekaan':
        return AppColors.green;
      case 'modern':
        return AppColors.sky;
      default:
        return AppColors.primary;
    }
  }
}