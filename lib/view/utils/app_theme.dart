import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_text_styles.dart';

class AppTheme {
  static final ThemeData light = ThemeData(
    useMaterial3: true,
    colorScheme:
        ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          brightness: Brightness.light,
        ).copyWith(
          primary: AppColors.primary,
          secondary: AppColors.orangeHover,
          surface: AppColors.surface,
          error: AppColors.dangerRed,
          onPrimary: AppColors.surface,
          onSurface: AppColors.navyDark,
        ),
    scaffoldBackgroundColor: AppColors.pageBackground,
    fontFamily: AppTextStyles.bodyFontFamily,
    textTheme: const TextTheme(
      displayLarge: AppTextStyles.display,
      displayMedium: AppTextStyles.h1,
      headlineLarge: AppTextStyles.h2,
      headlineMedium: TextStyle(
        fontFamily: AppTextStyles.headingFontFamily,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
      headlineSmall: TextStyle(
        fontFamily: AppTextStyles.headingFontFamily,
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
      titleLarge: AppTextStyles.uiSemibold,
      titleMedium: TextStyle(
        fontFamily: AppTextStyles.bodyFontFamily,
        fontSize: 14,
        fontWeight: FontWeight.w600,
      ),
      bodyLarge: AppTextStyles.body,
      bodyMedium: AppTextStyles.body,
      bodySmall: AppTextStyles.caption,
      labelLarge: TextStyle(
        fontFamily: AppTextStyles.bodyFontFamily,
        fontSize: 14,
        fontWeight: FontWeight.w600,
      ),
    ),
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: AppColors.primary,
    ),
    navigationBarTheme: NavigationBarThemeData(
      labelTextStyle: WidgetStatePropertyAll(
        AppTextStyles.body.copyWith(color: AppColors.navyDark),
      ),
      backgroundColor: AppColors.surface,
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.primary,
        textStyle: AppTextStyles.body.copyWith(fontWeight: FontWeight.w600),
      ),
    ),
  );

  static final ThemeData dark = ThemeData(
    useMaterial3: true,
    colorScheme:
        ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          brightness: Brightness.dark,
        ).copyWith(
          primary: AppColors.primary,
          secondary: AppColors.orangeHover,
          surface: const Color(0xFF1E293B),
          error: AppColors.dangerRed,
          onPrimary: Colors.white,
          onSurface: const Color(0xFFF8FAFC),
        ),
    scaffoldBackgroundColor: const Color(0xFF0B1220),
    cardColor: const Color(0xFF1E293B),
    dividerColor: const Color(0xFF334155),
    fontFamily: AppTextStyles.bodyFontFamily,
    textTheme: light.textTheme.apply(
      bodyColor: const Color(0xFFF8FAFC),
      displayColor: const Color(0xFFF8FAFC),
      decorationColor: const Color(0xFFF8FAFC),
    ),
    iconTheme: const IconThemeData(color: Color(0xFFF8FAFC)),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF1E293B),
      foregroundColor: Color(0xFFF8FAFC),
      surfaceTintColor: Color(0xFF1E293B),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      filled: true,
      fillColor: Color(0xFF1E293B),
      hintStyle: TextStyle(color: Colors.white60),
      labelStyle: TextStyle(color: Colors.white70),
      floatingLabelStyle: TextStyle(color: Colors.white70),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xFF475569)),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.primary, width: 1.5),
      ),
    ),
    navigationBarTheme: const NavigationBarThemeData(
      backgroundColor: Color(0xFF1E293B),
      indicatorColor: Color(0x33FF6A00),
      labelTextStyle: WidgetStatePropertyAll(
        TextStyle(color: Color(0xFFF8FAFC)),
      ),
    ),
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: AppColors.primary,
    ),
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: AppColors.primary,
      selectionColor: Color(0x66FF6A00),
      selectionHandleColor: AppColors.primary,
    ),
  );
}
