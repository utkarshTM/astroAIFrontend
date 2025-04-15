import 'package:flutter/material.dart';

class AppColors {
  //static const primary = Color(0xFF0A84FF);
  static const secondary = Color(0xFF5AC8FA);
  static const background = Color(0xFFF5F5F5);
  static const google = Colors.red;
  static const facebook = Colors.blue;
  static const textPrimary = Colors.black87;
  static const textSecondary = Colors.black45;

  static const Color primary = Color(0xFFFFFFFF); // background
  static const Color highlight = Colors.orange;
  static const Color inactiveDot = Colors.grey;
  static const Color bhagwa_Saffron = Color(0xFFFF6F00);

  static Color bhagwaSaffron(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? Color(0xFF121212) : AppColors.bhagwa_Saffron;
  }

  // static const Color primary = Colors.white;
  // static const Color textLight = Colors.black;
  // static const Color highlight = Color(0xFFFF6F00);
  // static const Color color = Colors.red;
  // static const Color templeWhite = Color(0xFFFFF8E1);
  // static const Color background = Colors.white;  // Background
  // static const Color bhagwa_Saffron = Color(0xFFFF6F00);  // Foreground
  // static const Color moonlightGrey = Color(0xFFB0A99F);
  // static const Color nebulaBlue = Color(0xFF2C3E50);
  // static const Color goldLeaf = Color(0xFFD4AF37);
}
