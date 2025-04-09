import 'package:astro_ai_app/core/features/profile/screens/edit_user_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:astro_ai_app/core/features/notification/screens/notification_screen.dart';
import 'package:astro_ai_app/styles/app_Styles.dart';

class AppHeader extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text('Astro AI',
      style: AppTextStyles.appBarTitle,
      ),
      centerTitle: true,
      elevation: 0,
      backgroundColor: AppColors.bhagwa_Saffron,
      leading: Builder(
        builder: (context) => IconButton(
          icon: Icon(Icons.menu, color: Colors.white),
          onPressed: () => Scaffold.of(context).openDrawer(),
        ),
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.brightness_4, color: Colors.white),
          onPressed: () {
            // Toggle dark/light mode
          },
        ),
        IconButton(
          icon: Icon(Icons.notifications, color: Colors.white),
          onPressed: () {
            // Handle notifications
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const NotificationScreen()),
            );
          },
        ),
        IconButton(
          icon: Icon(Icons.person, color: Colors.white),
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