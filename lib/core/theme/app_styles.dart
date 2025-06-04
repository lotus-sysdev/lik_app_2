import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppStyles {
  // Text Styles
  static const headlineLarge = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: AppColors.black,
  );

  static const headlineMedium = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: AppColors.black,
  );

  static const TextStyle headlineSmall = TextStyle(
    fontSize: 16,

    fontWeight: FontWeight.w500,
  );

  static const bodyLarge = TextStyle(fontSize: 16, color: AppColors.black);

  static const bodyMedium = TextStyle(fontSize: 14, color: AppColors.black);

  static const buttonText = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.white,
  );

  // Input Styles
  static const inputLabel = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.black,
  );

  // Error Styles
  static const errorText = TextStyle(color: AppColors.danger, fontSize: 12);

  // App Bar
  static const appBarTitle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.white,
  );
}
