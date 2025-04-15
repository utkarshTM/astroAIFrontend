//***************************Preivous Code***************************************//
// import 'package:astro_ai_app/core/features/profile/screens/edit_user_details_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:astro_ai_app/core/features/notification/screens/notification_screen.dart';
// import 'package:astro_ai_app/core/theme/app_colors.dart';
// import 'package:astro_ai_app/core/theme/app_text_style.dart';
// import 'package:astro_ai_app/core/theme/app_button.dart';
// import 'package:astro_ai_app/core/theme/theme_provider.dart';
// import 'package:provider/provider.dart';
//
// class AppHeader extends StatelessWidget implements PreferredSizeWidget {
//   @override
//   Size get preferredSize => Size.fromHeight(kToolbarHeight);
//
//   @override
//   Widget build(BuildContext context) {
//     return AppBar(
//       title: Text('Astro AI',
//       style: AppTextStyles.appBarTitle,
//       ),
//       centerTitle: true,
//       elevation: 0,
//       //backgroundColor: AppColors.bhagwa_Saffron,
//       backgroundColor: AppColors.bhagwaSaffron(context),
//       leading: Builder(
//         builder: (context) => AppIconButtons.menu(
//           context: context,
//           onPressed: () => Scaffold.of(context).openDrawer(),
//         ),
//       ),
//       actions: [
//
//         //******************** Code For Toggling Theme ************************//
//
//         AppIconButtons.themeToggle(
//           isDarkMode: Provider.of<ThemeProvider>(context).isDarkMode,   // pass current state
//           onPressed: () {
//             Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
//           },
//         ),
//
//         AppIconButtons.notifications(
//           onPressed: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => const NotificationScreen()),
//             );
//           },
//         ),
//         AppIconButtons.profile(
//           onPressed: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => EditUserDetailsScreen()),
//             );
//           },
//         ),
//       ],
//     );
//   }
// }

import 'package:astro_ai_app/core/features/profile/screens/edit_user_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:astro_ai_app/core/features/notification/screens/notification_screen.dart';
import 'package:astro_ai_app/core/theme/app_colors.dart';
import 'package:astro_ai_app/core/theme/app_text_style.dart';
import 'package:astro_ai_app/core/theme/app_button.dart';

class AppHeader extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        'Astro AI',
        style: AppTextStyles.appBarTitle,
      ),
      centerTitle: true,
      elevation: 0,
      backgroundColor: AppColors.bhagwaSaffron(context),
      leading: Builder(
        builder: (context) => AppIconButtons.menu(
          context: context,
          onPressed: () => Scaffold.of(context).openDrawer(),
        ),
      ),
      actions: [

        // ******************* Toggle Button Code ******************
        // Wrapped this part in Consumer to listen for theme changes
        // Consumer<ThemeProvider>(
        //   builder: (context, themeProvider, child) {
        //     return AppIconButtons.themeToggle(
        //       isDarkMode: themeProvider.isDarkMode,
        //       onPressed: () {
        //         themeProvider.toggleTheme();
        //       },
        //     );
        //   },
        // ),
        AppIconButtons.notifications(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const NotificationScreen()),
            );
          },
        ),
        AppIconButtons.profile(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => EditUserDetailsScreen()),
            );
          },
        ),
      ],
    );
  }
}
