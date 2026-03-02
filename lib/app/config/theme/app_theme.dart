import 'package:flutter/material.dart';

class AppTheme {
  // 浅色主题 - 沙石庭院
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    scaffoldBackgroundColor: const Color(0xFFE8E4DC),
    primaryColor: const Color(0xFF7C9885),
    colorScheme: const ColorScheme.light(
      primary: Color(0xFF7C9885),
      secondary: Color(0xFF3A3A3A),
      surface: Color(0xFFE8E4DC),
      onSurface: Color(0xFF3A3A3A),
    ),
  );

  // 深色主题 - 夜间竹林
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: const Color(0xFF2B2D2A),
    primaryColor: const Color(0xFF8FA896),
    colorScheme: const ColorScheme.dark(
      primary: Color(0xFF8FA896),
      secondary: Color(0xFFE8E4DC),
      surface: Color(0xFF2B2D2A),
      onSurface: Color(0xFFE8E4DC),
    ),
  );
}
