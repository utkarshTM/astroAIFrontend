import 'package:flutter/material.dart';
import 'package:astro_ai_app/styles/app_Styles.dart';

class NotificationDetailScreen extends StatelessWidget {
  final String title;
  final String subtitle;
  final String time;

  const NotificationDetailScreen({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.time,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notification Detail'),
        backgroundColor: AppColors.bhagwa_Saffron,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(time, style: TextStyle(color: Colors.grey[600], fontSize: 12)),
            const SizedBox(height: 12),
            Text(title, style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 16),
            Text(
              subtitle,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }
}
