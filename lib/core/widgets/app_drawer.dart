import 'package:astro_ai_app/core/features/horoscope/screen/horoscope_list_screen.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.orange,
            ),
            child: Text(
              'Astro AI',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          _buildDrawerItem(
            icon: Icons.home,
            title: 'Home',
            onTap: () => Navigator.pop(context),
          ),
          _buildDrawerItem(
            icon: Icons.chat,
            title: 'New Chat',
            onTap: () => Navigator.pop(context),
          ),
          _buildDrawerItem(
            icon: Icons.star,
            title: 'Horoscope',
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
            onTap: () => Navigator.pop(context),
          ),
          Divider(),
          _buildDrawerItem(
            icon: Icons.feedback,
            title: 'Feedback',
            onTap: () => Navigator.pop(context),
          ),
          _buildDrawerItem(
            icon: Icons.share,
            title: 'Share App',
            onTap: () => Navigator.pop(context),
          ),
          _buildDrawerItem(
            icon: Icons.star_rate,
            title: 'Rate App',
            onTap: () => Navigator.pop(context),
          ),
          _buildDrawerItem(
            icon: Icons.info,
            title: 'About Us',
            onTap: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: onTap,
    );
  }
}