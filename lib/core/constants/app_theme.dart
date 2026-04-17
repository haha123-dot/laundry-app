import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

abstract final class AppTheme {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: false,
    scaffoldBackgroundColor: AppColors.pageBg,
    primaryColor: AppColors.primaryNavy,
    fontFamily: GoogleFonts.poppins().fontFamily,

    textTheme: _textTheme,
    appBarTheme: _appBarTheme,
    elevatedButtonTheme: _elevatedButtonTheme,
  );

  // =========================
  // TEXT THEME
  // =========================
  static final TextTheme _textTheme = TextTheme(
    // Onboarding / large headers
    displayLarge: _poppins(
      fontSize: 25,
      fontWeight: FontWeight.w800,
      color: AppColors.textPrimary,
    ),

    // Screen titles
    titleLarge: _poppins(
      fontSize: 18,
      fontWeight: FontWeight.w700,
      color: AppColors.headerNavy,
    ),
    titleMedium: _poppins(
      fontSize: 16,
      fontWeight: FontWeight.w700,
      color: AppColors.headerNavy,
    ),

    // Body
    bodyLarge: _poppins(
      fontSize: 14,
      color: AppColors.textDark,
    ),
    bodyMedium: _poppins(
      fontSize: 13,
      color: AppColors.textSecondary,
    ),

    // Small / caption
    bodySmall: _poppins(
      fontSize: 12,
      color: AppColors.textMuted,
    ),

    // Buttons
    labelLarge: _poppins(
      fontSize: 15,
      fontWeight: FontWeight.w600,
      color: AppColors.white,
    ),
  );

  // =========================
  // APP BAR
  // =========================
  static final AppBarTheme _appBarTheme = AppBarTheme(
    backgroundColor: AppColors.headerNavy,
    foregroundColor: AppColors.textOnNavy,
    elevation: 0,
    titleTextStyle: _poppins(
      fontSize: 18,
      fontWeight: FontWeight.w700,
      color: AppColors.textOnNavy,
    ),
  );

  // =========================
  // BUTTON
  // =========================
  static final ElevatedButtonThemeData _elevatedButtonTheme =
      ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.primaryNavy,
      foregroundColor: AppColors.white,
      textStyle: _poppins(
        fontSize: 15,
        fontWeight: FontWeight.w600,
        color: AppColors.white,
      ),
    ),
  );

  // =========================
  // FONT HELPER
  // =========================
  static TextStyle _poppins({
    required double fontSize,
    FontWeight fontWeight = FontWeight.w400,
    required Color color,
    double height = 1.35,
  }) {
    return GoogleFonts.poppins(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      height: height,
    );
  }
}