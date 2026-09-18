import 'package:flutter/material.dart';

class KindredTheme {
  static const parchment = Color(0xFFF4EDE1);
  static const forest = Color(0xFF1B3328);
  static const moss = Color(0xFF3E5A46);
  static const clay = Color(0xFFC45C26);
  static const ink = Color(0xFF1C1814);
  static const cream = Color(0xFFFFFBF4);
  static const sage = Color(0xFF8A9A7B);
  static const line = Color(0xFFD9CFC0);

  static ThemeData data() {
    final scheme = ColorScheme.fromSeed(
      seedColor: forest,
      brightness: Brightness.light,
      primary: forest,
      secondary: clay,
      surface: parchment,
    );

    return ThemeData(
      colorScheme: scheme,
      useMaterial3: true,
      scaffoldBackgroundColor: parchment,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        foregroundColor: ink,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: forest,
          foregroundColor: cream,
          minimumSize: const Size.fromHeight(54),
          textStyle: const TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 16,
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: forest,
          side: const BorderSide(color: forest, width: 1.4),
          minimumSize: const Size.fromHeight(54),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: cream,
        labelStyle: const TextStyle(color: moss),
        helperStyle: TextStyle(color: ink.withValues(alpha: 0.55)),
        errorStyle: const TextStyle(color: clay),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 18,
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: line, width: 1.5),
          borderRadius: BorderRadius.zero,
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: clay, width: 2),
          borderRadius: BorderRadius.zero,
        ),
        errorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: clay, width: 1.5),
          borderRadius: BorderRadius.zero,
        ),
        focusedErrorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: clay, width: 2),
          borderRadius: BorderRadius.zero,
        ),
      ),
    );
  }
}
