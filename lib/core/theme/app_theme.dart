import 'package:flutter/material.dart';
import 'app_constants.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      primarySwatch: Colors.purple,
      primaryColor: AppConstants.primaryPurple,
      scaffoldBackgroundColor: AppConstants.white,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppConstants.primaryPurple,
        foregroundColor: AppConstants.white,
        elevation: 0,
      ),
      cardTheme: CardThemeData(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: AppConstants.lightGrey,
      ),
    );
  }
}