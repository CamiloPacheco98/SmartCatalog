import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFFE87722);
  static const Color primaryDarkColor = Color(0xFFC85A1B);
  static const Color secondaryColor = Color(0xFFF5EEE6);
  static const Color backgroundColor = Color(0xFFFAFAFA);
  static const Color textColor = Color(0xFF333333);
  static const Color errorColor = Color(0xFFD9534F);
  static const Color successColor = Color(0xFF57BA98);
  static const Color hintColor = Color(0xFFBDBDBD);

  static ThemeData get lightTheme {
    return ThemeData(
      fontFamily: 'Montserrat',
      useMaterial3: true,
      scaffoldBackgroundColor: backgroundColor,
      hintColor: hintColor,
      colorScheme: const ColorScheme.light(
        primary: primaryColor,
        onPrimary: Colors.white,
        secondary: secondaryColor,
        onSecondary: textColor,
        error: errorColor,
        onError: Colors.white,
        surface: backgroundColor,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      textTheme: const TextTheme(
        titleLarge: TextStyle(color: primaryColor, fontSize: 24, fontWeight: FontWeight.bold),
        titleMedium: TextStyle(color: textColor, fontSize: 24, fontWeight: FontWeight.bold),
        bodyLarge: TextStyle(color: textColor, fontSize: 16),
        bodyMedium: TextStyle(color: textColor, fontSize: 14),
        labelLarge: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      inputDecorationTheme: const InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          borderSide: BorderSide.none,
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          borderSide: BorderSide.none,
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          borderSide: BorderSide.none,
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          borderSide: BorderSide.none,
        ),
        labelStyle: TextStyle(color: textColor),
        hintStyle: TextStyle(color: hintColor),
      ),
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: textColor,
        selectionHandleColor: primaryColor,
      ),
    );
  }
}
