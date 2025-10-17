import 'package:flutter/material.dart';

// App Colors
class AppColors {
  // Primary Colors
  static const Color primary = Color(0xFF1E88E5); // Blue
  static const Color primaryDark = Color(0xFF1565C0);
  static const Color primaryLight = Color(0xFF42A5F5);

  // Secondary Colors
  static const Color secondary = Color(0xFF26A69A); // Teal
  static const Color secondaryDark = Color(0xFF00695C);
  static const Color secondaryLight = Color(0xFF4DB6AC);

  // Status Colors
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFF9800);
  static const Color error = Color(0xFFF44336);
  static const Color info = Color(0xFF2196F3);

  // Severity Colors for Events
  static const Color severityLow = Color(0xFF4CAF50);
  static const Color severityMedium = Color(0xFFFF9800);
  static const Color severityHigh = Color(0xFFF44336);

  // Neutral Colors
  static const Color background = Color(0xFFF5F5F5);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color onSurface = Color(0xFF212121);
  static const Color onSurfaceVariant = Color(0xFF757575);

  // Text Colors
  static const Color textPrimary = Color(0xFF212121);
  static const Color textSecondary = Color(0xFF757575);
  static const Color textHint = Color(0xFFBDBDBD);

  // Card Colors
  static const Color cardBackground = Color(0xFFFFFFFF);
  static const Color cardShadow = Color(0x1F000000);

  // Gradient Colors
  static const LinearGradient primaryGradient = LinearGradient(colors: [primary, primaryLight], begin: Alignment.topLeft, end: Alignment.bottomRight);

  static const LinearGradient backgroundGradient = LinearGradient(colors: [Color(0xFFF8F9FA), Color(0xFFE9ECEF)], begin: Alignment.topCenter, end: Alignment.bottomCenter);
}

// App Dimensions
class AppDimensions {
  // Padding & Margin
  static const double paddingXS = 4.0;
  static const double paddingS = 8.0;
  static const double paddingM = 16.0;
  static const double paddingL = 24.0;
  static const double paddingXL = 32.0;

  // Border Radius
  static const double radiusS = 8.0;
  static const double radiusM = 12.0;
  static const double radiusL = 16.0;
  static const double radiusXL = 24.0;

  // Icon Sizes
  static const double iconS = 16.0;
  static const double iconM = 24.0;
  static const double iconL = 32.0;
  static const double iconXL = 48.0;

  // Button Heights
  static const double buttonHeight = 48.0;
  static const double buttonHeightSmall = 36.0;
  static const double buttonHeightLarge = 56.0;

  // Card Dimensions
  static const double cardElevation = 4.0;
  static const double cardMinHeight = 120.0;

  // App Bar
  static const double appBarHeight = 56.0;
}

// App Text Styles
class AppTextStyles {
  static const TextStyle h1 = TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: AppColors.textPrimary, height: 1.2);

  static const TextStyle h2 = TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.textPrimary, height: 1.3);

  static const TextStyle h3 = TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: AppColors.textPrimary, height: 1.3);

  static const TextStyle h4 = TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: AppColors.textPrimary, height: 1.4);

  static const TextStyle bodyLarge = TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: AppColors.textPrimary, height: 1.5);

  static const TextStyle bodyMedium = TextStyle(fontSize: 14, fontWeight: FontWeight.normal, color: AppColors.textPrimary, height: 1.5);

  static const TextStyle bodySmall = TextStyle(fontSize: 12, fontWeight: FontWeight.normal, color: AppColors.textSecondary, height: 1.4);

  static const TextStyle caption = TextStyle(fontSize: 11, fontWeight: FontWeight.normal, color: AppColors.textHint, height: 1.3);

  static const TextStyle button = TextStyle(fontSize: 14, fontWeight: FontWeight.w600, height: 1.2);
}
