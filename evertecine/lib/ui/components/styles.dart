import 'package:flutter/material.dart';

class AppColors {
  static const Color background = Color(0xFF02040A);
  static const Color surface = Color(0xFF111319);
  static const Color primary = Color(0xFF741AFF);
  static const Color accent = Color(0xFF00E5FF);
  static const Color textPrimary = Colors.white;
  static const Color textSecondary = Color(0xFF9CA3AF);
}

class AppTextStyles {
  static const TextStyle titleMain = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
    letterSpacing: -0.5,
  );

  static const TextStyle CategoryTitle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.primary,
  );

  static const TextStyle body = TextStyle(
    fontSize: 14,
    color: AppColors.textSecondary,
    height: 1.4,
  );
}