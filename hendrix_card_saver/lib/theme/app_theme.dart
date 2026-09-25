import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static const Color hendrixOrange = Color(0xFFF15A29); //hendrix collors
  static const Color nearBlack = Color(0xFF171717);
  static const Color warmWhite = Color(0xFFFFFBF8);

  static ThemeData get lightTheme {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: hendrixOrange,
      brightness: Brightness.light,
      primary: hendrixOrange,
      secondary: const Color.fromARGB(255, 56, 55, 55),
      surface: Colors.white,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: const Color.fromARGB(255, 241, 179, 131),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color.fromARGB(255, 45, 43, 43),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: hendrixOrange,
          foregroundColor: Colors.white,
          minimumSize: const Size.fromHeight(54),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: nearBlack,
          minimumSize: const Size.fromHeight(54),
          side: const BorderSide(color: nearBlack),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}
