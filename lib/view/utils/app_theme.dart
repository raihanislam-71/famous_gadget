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
        color: AppColors.navyDark,
      ),
      headlineSmall: TextStyle(
        fontFamily: AppTextStyles.headingFontFamily,
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: AppColors.navyDark,
      ),
      titleLarge: AppTextStyles.uiSemibold,
      titleMedium: TextStyle(
        fontFamily: AppTextStyles.bodyFontFamily,
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: AppColors.navyDark,
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
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.primary,
        textStyle: AppTextStyles.body.copyWith(fontWeight: FontWeight.w600),
      ),
    ),
  );
}
