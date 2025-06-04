import 'package:flutter/material.dart';
import 'package:lik_app_2/core/theme/app_colors.dart';
import 'package:lik_app_2/core/theme/app_styles.dart';

class AppTheme {
  static ThemeData lightTheme() {
    return ThemeData(
      primaryColor: AppColors.primary,
      colorScheme: ColorScheme.light(
        primary: AppColors.primary,
        secondary: AppColors.secondary,
        error: AppColors.danger,
      ),
      scaffoldBackgroundColor: AppColors.background,
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.primary,
        titleTextStyle: AppStyles.appBarTitle,
        elevation: 0,
      ),
      textTheme: TextTheme(
        headlineMedium: AppStyles.headlineMedium,
        bodyMedium: AppStyles.bodyMedium,
        labelLarge: AppStyles.buttonText,
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.gray),
        ),
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }
}
