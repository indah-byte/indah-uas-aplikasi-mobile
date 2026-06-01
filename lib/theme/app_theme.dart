import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Premium Colors (Light)
  static const Color primaryColor = Color(0xFF1B4332); // Deep Emerald
  static const Color accentColor = Color(0xFFD4AF37); // Champagne Gold
  static const Color backgroundColor = Color(0xFFF8F9FA); // Off-white premium
  static const Color cardColor = Colors.white;
  static const Color textColor = Color(0xFF1A1A1A);
  static const Color subtitleColor = Color(0xFF6C757D);

  // Soft Premium Accents
  static const Color leafBg = Color(0xFFE8F5E9);
  static const Color bulbBg = Color(0xFFFFF8E1);
  static const Color waveBg = Color(0xFFE3F2FD);
  static const Color lightningBg = Color(0xFFF3E5F5);
  static const Color moonBg = Color(0xFFECEFF1);

  // Dark Theme Colors
  static const Color darkPrimaryColor = Color(0xFF2D6A4F);
  static const Color darkBackgroundColor = Color(0xFF121212);
  static const Color darkCardColor = Color(0xFF1E1E1E);
  static const Color darkTextColor = Color(0xFFE0E0E0);
  static const Color darkSubtitleColor = Color(0xFFAAAAAA);

  static ThemeData get lightTheme {
    return _buildTheme(
      bg: backgroundColor,
      primary: primaryColor,
      card: cardColor,
      text: textColor,
      subtitle: subtitleColor,
      brightness: Brightness.light,
    );
  }

  static ThemeData get darkTheme {
    return _buildTheme(
      bg: darkBackgroundColor,
      primary: darkPrimaryColor,
      card: darkCardColor,
      text: darkTextColor,
      subtitle: darkSubtitleColor,
      brightness: Brightness.dark,
    );
  }

  static ThemeData _buildTheme({
    required Color bg,
    required Color primary,
    required Color card,
    required Color text,
    required Color subtitle,
    required Brightness brightness,
  }) {
    return ThemeData(
      useMaterial3: true,
      primaryColor: primary,
      scaffoldBackgroundColor: bg,
      brightness: brightness,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primary,
        brightness: brightness,
        background: bg,
        surface: card,
        primary: primary,
        secondary: accentColor,
      ),
      textTheme: GoogleFonts.outfitTextTheme().copyWith(
        displayLarge: GoogleFonts.playfairDisplay(
          color: text,
          fontWeight: FontWeight.bold,
        ),
        titleLarge: GoogleFonts.outfit(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: text,
        ),
        bodyLarge: GoogleFonts.outfit(color: text),
        bodyMedium: GoogleFonts.outfit(color: subtitle),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: primary),
        centerTitle: true,
      ),
      cardTheme: CardThemeData(
        color: card,
        elevation: 8,
        shadowColor: primary.withOpacity(0.08),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          textStyle: GoogleFonts.outfit(
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: card,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: accentColor, width: 2),
        ),
        contentPadding: const EdgeInsets.all(20),
      ),
    );
  }
}


