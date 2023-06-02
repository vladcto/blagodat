import 'package:flutter/material.dart';

import 'app_colors.dart';

sealed class AppTheme {
  static final lightTheme = ThemeData(
    colorScheme: const ColorScheme.light(
      primary: AppColors.gold,
      onPrimary: AppColors.softDark,
      secondary: AppColors.darkOrange,
      onSecondary: AppColors.softDark,
      surface: AppColors.softWhite,
      surfaceVariant: AppColors.white,
      onSurface: AppColors.softDark,
      tertiary: AppColors.grey,
    ),
    brightness: Brightness.light,
    useMaterial3: true,
  );
}
