import 'package:flutter/material.dart';
import '../../../widgets/notification_card.dart';
import 'notification_detail_screen.dart';
import 'package:astro_ai_app/core/theme/app_colors.dart';
import 'package:astro_ai_app/core/theme/app_text_style.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List<Map<String, dynamic>> notifications = [
    {
      'title': 'Daily Horoscope',
      'subtitle': 'You may experience emotional clarity today 🌞',
      'time': 'Just now',
      'isRead': false,
    },
    {
      'title': 'Moon Alert 🌙',
      'subtitle': 'The moon is in Scorpio, expect deep conversations.',
      'time': '2 hours ago',
      'isRead': false,
    },
    {
      'title': 'Love Forecast ❤️',
      'subtitle': 'Great day to express your feelings.',
      'time': 'Yesterday',
      'isRead': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Notifications',
            // style: TextStyle(
            //   color: Colors.white,
            //   fontWeight: FontWeight.w500,
            //   fontSize: 22,
            // ),
           style: AppTextStyles.appBarTitle,
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        centerTitle: true,
        backgroundColor: AppColors.bhagwa_Saffron,
      ),
      body: notifications.isEmpty
          ? const Center(child: Text('No notifications yet 🌌'))
          : ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: notifications.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final n = notifications[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => NotificationDetailScreen(
                    title: n['title'],
                    subtitle: n['subtitle'],
                    time: n['time'],
                  ),
                ),
              );
            },
            child: Opacity(
              opacity: n['isRead'] ? 0.6 : 1.0,
              child: NotificationCard(
                title: n['title'],
                subtitle: n['subtitle'],
                time: n['time'],
              ),
            ),
          );
        },
      ),
    );
  }
}
