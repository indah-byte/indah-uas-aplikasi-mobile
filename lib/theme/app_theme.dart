import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFF2D5A4C); // Dark teal from FAB
  static const Color backgroundColor = Color(0xFFF9FBFB);
  static const Color cardColor = Colors.white;
  static const Color textColor = Color(0xFF1D1D1D);
  static const Color subtitleColor = Color(0xFF757575);

  static const Color leafBg = Color(0xFFA8D5BA);
  static const Color bulbBg = Color(0xFFCFE3FF);
  static const Color moonBg = Color(0xFFD4C1EC);
  static const Color waveBg = Color(0xFFFFD6D6);

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: backgroundColor,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryColor,
        primary: primaryColor,
      ),
      textTheme: GoogleFonts.outfitTextTheme().copyWith(
        displayLarge: GoogleFonts.outfit(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: textColor,
        ),
        titleLarge: GoogleFonts.outfit(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: textColor,
        ),
        bodyMedium: GoogleFonts.outfit(
          fontSize: 16,
          color: subtitleColor,
        ),
      ),
    );
  }
}
