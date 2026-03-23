import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTextStyles {
  static const TextStyle countdown = TextStyle(
    fontSize: 72,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
    letterSpacing: -2,
  );

  static const TextStyle title = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.normal,
    color: AppColors.textSecondary,
    letterSpacing: 4,
  );

  static const TextStyle buttonBold = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );

  static const TextStyle bodyPrimary = TextStyle(
    fontSize: 16,
    color: AppColors.textPrimary,
  );

  static const TextStyle bodySecondary = TextStyle(
    fontSize: 13,
    color: AppColors.textSecondary,
  );
  
  static const TextStyle labelSmall = TextStyle(
    fontSize: 12,
    color: AppColors.textSecondary,
  );
}
