import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color surface = Color(0xFF091421);
  static const Color surfaceContainerLowest = Color(0xFF050F1C);
  static const Color surfaceContainer = Color(0xFF16202E);
  static const Color surfaceContainerHigh = Color(0xFF212B39);
  static const Color primary = Color(0xFFF7BD48);
  static const Color secondary = Color(0xFFE9C17B);
  static const Color tertiaryFixed = Color(0xFFF8DDCE);
  static const Color onTertiaryFixed = Color(0xFF26190F);
  static const Color onTertiaryFixedVariant = Color(0xFF554338);
  static const Color onSurface = Color(0xFFD9E3F6);
  static const Color onSurfaceVariant = Color(0xFFD3C4AF);
  static const Color outlineVariant = Color(0xFF4F4535);
  static const Color primaryContainer = Color(0xFFBA880F);
  static const Color onPrimaryContainer = Color(0xFF392700);
  static const Color onPrimary = Color(0xFF412D00);
  static const Color secondaryContainer = Color(0xFF604408);
  
  static ThemeData get themeData {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: surface,
      colorScheme: const ColorScheme.dark(
        surface: surface,
        primary: primary,
        secondary: secondary,
        onSurface: onSurface,
        onPrimary: onPrimary,
        surfaceContainerLowest: surfaceContainerLowest,
        surfaceContainer: surfaceContainer,
        surfaceContainerHighest: surfaceContainerHigh,
      ),
      textTheme: TextTheme(
        displayLarge: GoogleFonts.syne(fontSize: 60, fontWeight: FontWeight.w700, color: onSurface, letterSpacing: -1.8),
        displayMedium: GoogleFonts.syne(fontSize: 40, fontWeight: FontWeight.w700, color: onSurface, letterSpacing: -0.8),
        headlineLarge: GoogleFonts.syne(fontSize: 40, fontWeight: FontWeight.w700, color: onSurface, letterSpacing: -0.8),
        headlineMedium: GoogleFonts.syne(fontSize: 28, fontWeight: FontWeight.w600, color: onSurface, letterSpacing: -0.4),
        titleLarge: GoogleFonts.syne(fontSize: 20, fontWeight: FontWeight.w600, color: onSurface),
        bodyLarge: GoogleFonts.plusJakartaSans(fontSize: 18, color: onSurfaceVariant, height: 1.7),
        bodyMedium: GoogleFonts.plusJakartaSans(fontSize: 16, color: onSurface, height: 1.65),
        bodySmall: GoogleFonts.plusJakartaSans(fontSize: 14, color: onSurfaceVariant, height: 1.55),
        labelLarge: GoogleFonts.plusJakartaSans(fontSize: 14, fontWeight: FontWeight.w600, color: onSurface, letterSpacing: 0.2),
        labelMedium: GoogleFonts.plusJakartaSans(fontSize: 12, fontWeight: FontWeight.w600, color: onSurface, letterSpacing: 0.4),
      ),
    );
  }
}
