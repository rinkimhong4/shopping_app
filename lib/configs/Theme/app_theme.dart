import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFF007A50);
  static const Color background = Color(0xFFFFFFFF);
  static const Color card = Color(0xFFFAFAFA);
  static const Color accent = Color(0xFFF7F7F7);
  static const Color textPrimary = Color(0xFF1E1E1E);
  static const Color textSecondary = Color(0xFF6E6E6E);
  static const Color error = Color(0xFFFF3B30);
  static const Color success = Color(0xFF34C759);
}

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.background,
    primaryColor: AppColors.primary,
    cardColor: AppColors.card,
    fontFamily: 'Poppins',
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.background,
      elevation: 0,
      iconTheme: IconThemeData(color: AppColors.textPrimary),
      titleTextStyle: TextStyle(
        color: AppColors.textPrimary,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
    textTheme: TextTheme(
      headlineLarge: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: AppColors.textPrimary,
      ),
      headlineMedium: TextStyle(fontSize: 28, color: AppColors.textPrimary),
      titleLarge: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      ),
      titleMedium: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      ),
      titleSmall: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      ),
      bodyLarge: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.normal,
        color: AppColors.textPrimary,
      ),

      bodyMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: AppColors.textPrimary,
      ),
      bodySmall: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: AppColors.textPrimary,
      ),
      labelLarge: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      ),
      labelMedium: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: AppColors.textPrimary,
      ),
      labelSmall: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.normal,
        color: AppColors.textPrimary,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.background,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        minimumSize: const Size(double.infinity, 56),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: AppColors.accent),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: AppColors.primary),
      ),
      hintStyle: TextStyle(color: AppColors.textSecondary),
    ),
    iconTheme: IconThemeData(color: AppColors.textPrimary),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: AppColors.primary,
      unselectedItemColor: AppColors.textSecondary,
      backgroundColor: AppColors.background,
    ),
  );
}
