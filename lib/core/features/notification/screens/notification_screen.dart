// import 'package:flutter/material.dart';
// import '../../../widgets/notification_card.dart';
//
// class NotificationScreen extends StatelessWidget {
//   const NotificationScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final notifications = [
//       {
//         'title': 'Daily Horoscope',
//         'subtitle': 'You may experience emotional clarity today 🌞',
//         'time': 'Just now',
//       },
//       {
//         'title': 'Moon Alert 🌙',
//         'subtitle': 'The moon is in Scorpio, expect deep conversations.',
//         'time': '2 hours ago',
//       },
//       {
//         'title': 'Love Forecast ❤️',
//         'subtitle': 'Great day to express your feelings.',
//         'time': 'Yesterday',
//       },
//     ];
//
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Notifications'),
//         centerTitle: true,
//         backgroundColor: Colors.orange,
//       ),
//       body: notifications.isEmpty
//           ? const Center(child: Text('No notifications yet 🌌'))
//           : ListView.separated(
//         padding: const EdgeInsets.all(16),
//         itemCount: notifications.length,
//         separatorBuilder: (_, __) => const SizedBox(height: 12),
//         itemBuilder: (context, index) {
//           final notification = notifications[index];
//           return NotificationCard(
//             title: notification['title']!,
//             subtitle: notification['subtitle']!,
//             time: notification['time']!,
//           );
//         },
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import '../../../widgets/notification_card.dart';
import 'notification_detail_screen.dart';
import 'package:astro_ai_app/styles/app_Styles.dart';

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

  void markAllAsRead() {
    setState(() {
      for (var n in notifications) {
        n['isRead'] = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Notifications'),
      //   centerTitle: true,
      //   backgroundColor: Colors.deepPurple,
      //   actions: [
      //     TextButton(
      //       onPressed: markAllAsRead,
      //       child: const Text(
      //         'Mark all as read',
      //         styles: TextStyle(color: Colors.white),
      //       ),
      //     )
      //   ],
      // ),
      appBar: AppBar(
        title: const Text(
          'Notifications',
            style: TextStyle(
              color: Colors.white, // or use your custom color
              fontWeight: FontWeight.w500, // optional
              fontSize: 22, // optional
            ),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white, // icon (back button, etc.) color
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
              // setState(() {
              //   notifications[index]['isRead'] = true;
              // });
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
