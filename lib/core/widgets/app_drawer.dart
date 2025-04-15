import 'package:astro_ai_app/core/features/horoscope/screen/horoscope_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:astro_ai_app/core/features/About/screens/about_screen.dart';
import 'package:astro_ai_app/core/features/chatWithAi/screens/chat_screen.dart';
import 'package:astro_ai_app/core/theme/app_colors.dart';
import 'package:astro_ai_app/core/theme/app_text_style.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: AppColors.bhagwa_Saffron,
            ),
            child: Text(
              'Astro AI',
                style: AppTextStyles.appBarTitle,
            ),
          ),
          _buildDrawerItem(
            icon: Icons.home,
            title: 'Home',
            iconColor: AppColors.bhagwa_Saffron,
            onTap: () => Navigator.pop(context),
          ),
          _buildDrawerItem(
            icon: Icons.chat,
            title: 'New Chat',
            iconColor: AppColors.bhagwa_Saffron,
            onTap: () => {
                Navigator.push(
                context,
                MaterialPageRoute(
                builder: (context) => const AstroChatScreen(),
                ),
                ),
            },
          ),
          _buildDrawerItem(
            icon: Icons.star,
            title: 'Horoscope',
            iconColor: AppColors.bhagwa_Saffron,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const HoroscopeListScreen(),
                ),
              );
            },
          ),
          _buildDrawerItem(
            icon: Icons.language,
            title: 'Change Language',
            iconColor: AppColors.bhagwa_Saffron,
            onTap: () => Navigator.pop(context),
          ),
          Divider(),
          _buildDrawerItem(
            icon: Icons.feedback,
            title: 'Feedback',
            iconColor: AppColors.bhagwa_Saffron,
            onTap: () => Navigator.pop(context),
          ),
          _buildDrawerItem(
            icon: Icons.share,
            title: 'Share App',
            iconColor: AppColors.bhagwa_Saffron,
            onTap: () => Navigator.pop(context),
          ),
          _buildDrawerItem(
            icon: Icons.star_rate,
            title: 'Rate App',
            iconColor: AppColors.bhagwa_Saffron,
            onTap: () => Navigator.pop(context),
          ),
          _buildDrawerItem(
            icon: Icons.info,
            title: 'About Us',
            iconColor: AppColors.bhagwa_Saffron,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AboutUsScreen(),
              ),
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildDrawerItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color iconColor = Colors.black,
  }) {
    return ListTile(
      leading: Icon(
          icon,
          color: iconColor,
      ),
      title: Text(title),
      onTap: onTap,
    );
  }
}