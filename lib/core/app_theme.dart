import 'package:flutter/material.dart';

class AppColors {
  static const background = Color(0xFF0D1117);
  static const cardBackground = Color(0xFF161B22);
  static const border = Color(0xFF1E2329);
  static const neonCyan = Color(0xFF00E5FF);
  static const limeGreen = Color(0xFFC3FF4D);
  static const textGray = Color(0xFF9CA3AF);
}

class AppTheme {
  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.background,
    cardColor: AppColors.cardBackground,
    primaryColor: AppColors.neonCyan,
    fontFamily: 'Montserrat', // Asta3mel Montserrat bech ykoun kif Figma
  );
}