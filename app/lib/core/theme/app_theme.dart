import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Cores Base
  static const Color primaryColor = Color(0xFF1F4E5F);
  static const Color primaryLightColor = Color(0xFF3A7D8C);
  static const Color actionColor = Color(0xFFF4A261);
  static const Color backgroundColor = Color(0xFFF7F9FA);
  static const Color surfaceColor = Color(0xFFFFFFFF);
  static const Color textMainColor = Color(0xFF1A1A1A);
  static const Color textMutedColor = Color(0xFF6B7280);

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: backgroundColor,
      primaryColor: primaryColor,
      colorScheme: const ColorScheme.light(
        primary: primaryColor,
        secondary: primaryLightColor,
        surface: surfaceColor,
        onSurface: textMainColor,
        error: Colors.redAccent,
      ),
      textTheme: GoogleFonts.poppinsTextTheme().copyWith(
        displaySmall: GoogleFonts.poppins(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: primaryColor,
        ),
        headlineMedium: GoogleFonts.poppins(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: textMainColor,
        ),
        bodyLarge: GoogleFonts.poppins(
          fontSize: 16,
          color: textMainColor,
        ),
        bodyMedium: GoogleFonts.poppins(
          fontSize: 14,
          color: textMainColor,
        ),
        labelSmall: GoogleFonts.poppins(
          fontSize: 12,
          color: textMutedColor,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: actionColor,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          textStyle: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      cardTheme: CardThemeData(
        color: surfaceColor,
        surfaceTintColor: Colors.transparent,
        elevation: 2,
        shadowColor: Colors.black.withOpacity(0.05),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surfaceColor,
        hintStyle: GoogleFonts.poppins(color: textMutedColor),
        labelStyle: GoogleFonts.poppins(color: textMainColor),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: textMutedColor.withOpacity(0.3)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: textMutedColor.withOpacity(0.3)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: primaryColor, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      ),
    );
  }
}
