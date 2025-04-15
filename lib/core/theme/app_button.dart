import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_spacing.dart';
import 'app_text_style.dart';

class AppButtonStyle {
  static final primary = ElevatedButton.styleFrom(
    padding: EdgeInsets.symmetric(horizontal: AppSpacing.xxl, vertical: AppSpacing.sm2),
    backgroundColor: AppColors.bhagwa_Saffron,
    foregroundColor: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
  );

  static final disabled = ElevatedButton.styleFrom(
    backgroundColor: AppColors.bhagwa_Saffron.withOpacity(0.5),
    foregroundColor: Colors.white,
    padding: AppSpacing.buttonPadding,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
  );

  static final small = ElevatedButton.styleFrom(
    backgroundColor: AppColors.bhagwa_Saffron,
    foregroundColor: Colors.white,
    //padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    minimumSize: Size(120, 55),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    textStyle: AppTextStyles.bodyText16.copyWith(fontWeight: FontWeight.bold),
  );

  static final iconButton = IconButton.styleFrom(
    backgroundColor: AppColors.bhagwa_Saffron,
    foregroundColor: Colors.white,
    //padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    minimumSize: Size(120, 55),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
  );
}


class AppIconButtons {

  // **************** Toggle Button Code *****************
  // static Widget themeToggle({
  //   required bool isDarkMode,
  //   required VoidCallback onPressed,
  // }) {
  //   return IconButton(
  //     icon: Icon(
  //       isDarkMode ? Icons.wb_sunny : Icons.nightlight_round,  // sun for light, moon for dark
  //       color: isDarkMode ? Colors.white : Colors.white,       // white in dark mode, white in light mode
  //     ),
  //     onPressed: onPressed,
  //   );
  // }

  static Widget notifications({
    required VoidCallback onPressed,
  }) {
    return IconButton(
      icon: const Icon(
          Icons.notifications,
          color: Colors.white,
      ),
      onPressed: onPressed,
    );
  }
  static Widget profile({
    required VoidCallback onPressed,
  }) {
    return IconButton(
      icon: const Icon(
          Icons.person,
          color: Colors.white,
      ),
      onPressed: onPressed,
    );
  }

  static Widget menu({
    required BuildContext context,
    required VoidCallback onPressed,
  }) {
    return IconButton(
      icon: const Icon(
          Icons.menu,
          color: Colors.white,
      ),
      onPressed: onPressed,
    );
  }
}

//
// class AppIconButtons {
//   static IconButton menu({
//     required BuildContext context,
//     required VoidCallback onPressed,
//   }) {
//     return IconButton(
//       icon: const Icon(
//           Icons.menu,
//           color: Colors.white
//       ),
//       onPressed: onPressed,
//     );
//   }
//
//   // static Widget themeToggle({
//   //   required bool isDarkMode,
//   //   required VoidCallback onPressed,
//   // }) {
//   //   return IconButton(
//   //     icon: Icon(
//   //       isDarkMode ? Icons.wb_sunny : Icons.nightlight_round, // Icon changes
//   //       color: isDarkMode ? Colors.white : Colors.black,      // Color changes
//   //     ),
//   //     onPressed: onPressed,
//   //   );
//   // }
//
//   static notifications({
//     required VoidCallback onPressed,
//   }) {
//     return IconButton(
//       icon: Icon(
//           Icons.notifications,
//           color: Colors.white
//       ),
//       onPressed: onPressed,
//     );
//   }
//
//   static IconButton profile({
//     required VoidCallback onPressed,
//   }) {
//     return IconButton(
//       icon: const Icon(Icons.person, color: Colors.white),
//       onPressed: onPressed,
//     );
//   }
// }


class AppStyles {
  // Icon sizes
  static const double socialIconSize = 40.0;

  // Icon colors
  static const Color googleIconColor = Colors.red;
  static const Color facebookIconColor = Colors.blue;
}

