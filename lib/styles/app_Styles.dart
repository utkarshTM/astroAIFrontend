import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Colors.white;
  static const Color textLight = Colors.black;
  static const Color highlight = Colors.blue;
  static const Color templeWhite = Color(0xFFFFF8E1);
  static const Color background = Colors.white;  // Background
  static const Color bhagwa_Saffron = Color(0xFFFF6F00);  // Foreground
  static const Color moonlightGrey = Color(0xFFB0A99F);
  static const Color nebulaBlue = Color(0xFF2C3E50);
  static const Color goldLeaf = Color(0xFFD4AF37);
}

class AppTextStyles {
  static const TextStyle appBarTitle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.primary,
  );

  static const TextStyle pageTitle = TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.bold,
    color: AppColors.textLight,
  );

  static const TextStyle bodyText16 = TextStyle(
    fontSize: 16,
    height: 1.5,
    color: AppColors.highlight,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle socialLogin = TextStyle(
    fontSize: 40,
    color: Colors.red,
  );

  static const TextStyle bodyText18 = TextStyle(
    fontSize: 18,
    height: 1.5,
    color: AppColors.bhagwa_Saffron,
  );

  static const TextStyle subheading = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle subheading20 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle footerText = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: AppColors.highlight,
  );


}
