import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Color palette
  static const Color _primary = Color(0xFF0A84FF); // vivid blue
  static const Color _secondary = Color(0xFF7C3AED); // violet 
  static const Color _surface = Colors.white;
  static const Color _error = Color(0xFFB00020);

  // Light color scheme
  static const ColorScheme lightColorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: _primary,
    onPrimary: Colors.white,
    secondary: _secondary,
    onSecondary: Colors.white,
    surface: _surface,
    onSurface: Colors.black87,
    error: _error,
    onError: Colors.white,
  );

  // Build a TextTheme using two Google fonts:
  // - Merriweather for headlines (serif, good for emphasis)
  // - Inter for body and UI text (clean sans-serif)
  static TextTheme _buildTextTheme(TextTheme base, Color onBackground) {
    final inter = GoogleFonts.interTextTheme(base).copyWith(
      bodyLarge: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w400),
      bodyMedium: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w400),
      bodySmall: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w400),
      labelLarge: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600),
      labelSmall: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600),
    );

    final merri = GoogleFonts.merriweatherTextTheme(base).copyWith(
      displayLarge: GoogleFonts.merriweather(fontSize: 34, fontWeight: FontWeight.w700),
      displayMedium: GoogleFonts.merriweather(fontSize: 28, fontWeight: FontWeight.w700),
      displaySmall: GoogleFonts.merriweather(fontSize: 22, fontWeight: FontWeight.w600),
      headlineMedium: GoogleFonts.merriweather(fontSize: 20, fontWeight: FontWeight.w600),
      headlineSmall: GoogleFonts.merriweather(fontSize: 18, fontWeight: FontWeight.w600),
    );

    // Merge: use Merriweather for large/display/headline styles, Inter for body/labels.
    return inter.merge(merri).apply(
      bodyColor: onBackground,
      displayColor: onBackground,
    );
  }

  // Light theme available for the app
  static final ThemeData lightTheme = ThemeData(
    colorScheme: lightColorScheme,
    useMaterial3: true,
    iconTheme: const IconThemeData(
      color: Colors.black, // ✅ ensures icons show
      size: 24,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: lightColorScheme.primary,
      foregroundColor: lightColorScheme.onPrimary,
      elevation: 2,
      titleTextStyle: GoogleFonts.merriweather(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: lightColorScheme.onPrimary,
      ),
      iconTheme: IconThemeData(color: lightColorScheme.onPrimary),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: lightColorScheme.secondary,
        foregroundColor: lightColorScheme.onSecondary,
        textStyle: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w600),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: lightColorScheme.primary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: lightColorScheme.surface,
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: lightColorScheme.primary),
        borderRadius: BorderRadius.circular(8),
      ),
    ),
    cardTheme: CardThemeData(
      color: lightColorScheme.surface,
      elevation: 1,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.all(8),
    ),

    visualDensity: VisualDensity.adaptivePlatformDensity,
  );

  // Optional dark theme for parity
  static final ThemeData darkTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: _primary, brightness: Brightness.dark),
    useMaterial3: true,
    iconTheme: const IconThemeData(
      color: Colors.white, // ✅ visible on dark background
      size: 24,
    ),
    scaffoldBackgroundColor: Colors.black,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.black,
      foregroundColor: Colors.white,
      elevation: 1,
      titleTextStyle: GoogleFonts.merriweather(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
    ),
    textTheme: _buildTextTheme(ThemeData.dark().textTheme, Colors.white),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: _secondary,
        foregroundColor: Colors.white,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: const Color(0xFF121212),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
    ),
  );

  static var primaryColor;
}
