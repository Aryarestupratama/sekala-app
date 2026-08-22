import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTextStyles {
  AppTextStyles._();

  static TextStyle get _base => GoogleFonts.inter(color: AppColors.ink);

  static TextStyle get h1 => _base.copyWith(
        fontSize: 28,
        fontWeight: FontWeight.w700,
        height: 1.3,
      );

  static TextStyle get h2 => _base.copyWith(
        fontSize: 22,
        fontWeight: FontWeight.w700,
        height: 1.3,
      );

  static TextStyle get h3 => _base.copyWith(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        height: 1.4,
      );

  static TextStyle get body => _base.copyWith(
        fontSize: 15,
        fontWeight: FontWeight.w400,
        height: 1.6,
      );

  static TextStyle get bodySecondary => body.copyWith(
        color: AppColors.textSecondary,
      );

  static TextStyle get caption => _base.copyWith(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: AppColors.textSecondary,
      );

  static TextStyle get button => _base.copyWith(
        fontSize: 15,
        fontWeight: FontWeight.w600,
      );
}