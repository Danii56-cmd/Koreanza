import 'package:flutter/material.dart';

class AppTheme {
  // Korenza Palette
  static const Color primary = Color(0xFFF43F86);
  static const Color background = Color(0xFFFFF5F7);
  static const Color textMain = Color(0xFF2E1F24);

  static final lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: primary,
    scaffoldBackgroundColor: background,

    colorScheme: const ColorScheme.light(
      primary: primary,
      secondary: Color(0xFFFCD5E2),
      surface: Colors.white,
      onPrimary: Colors.white,
      onSurface: textMain,
    ),

    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      foregroundColor: textMain,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        color: textMain,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    ),

    textTheme: const TextTheme(
      displayLarge: TextStyle(color: textMain, fontWeight: FontWeight.bold),
      bodyLarge: TextStyle(color: textMain),
      bodyMedium: TextStyle(color: Color(0xFF8E7E83)), // Mauve secondary text
    ),

    cardTheme: CardThemeData(
      color: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: Color(0xFFF9EBEE)),
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFF9EBEE)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFF9EBEE)),
      ),
    ),
  );
}
