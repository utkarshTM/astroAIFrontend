// import 'package:flutter/material.dart';
//
// class NotificationCard extends StatelessWidget {
//   final VoidCallback onTap;
//
//   const NotificationCard({Key? key, required this.onTap}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final isTablet = MediaQuery.of(context).size.shortestSide > 600;
//
//     return LayoutBuilder(
//       builder: (context, constraints) {
//         return Card(
//           elevation: 4,
//           margin: EdgeInsets.zero,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(12),
//           ),
//           child: InkWell(
//             onTap: onTap,
//             borderRadius: BorderRadius.circular(12),
//             child: Padding(
//               padding: EdgeInsets.all(isTablet ? 24 : 16),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Icon(
//                     Icons.notifications_active,
//                     size: isTablet ? 56 : 48,
//                     color: Colors.orange,
//                   ),
//                   SizedBox(height: isTablet ? 16 : 12),
//                   Text(
//                     'Notifications',
//                     styles: Theme.of(context).textTheme.titleLarge?.copyWith(
//                       fontWeight: FontWeight.bold,
//                       fontSize: isTablet ? 22 : 18,
//                     ),
//                   ),
//                   SizedBox(height: isTablet ? 12 : 8),
//                   Text(
//                     'View your daily predictions',
//                     textAlign: TextAlign.center,
//                     styles: Theme.of(context).textTheme.bodyMedium?.copyWith(
//                       fontSize: isTablet ? 16 : 14,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

import 'package:flutter/material.dart';

class NotificationCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String time;

  const NotificationCard({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.time,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: const Icon(Icons.notifications, color: Colors.deepPurple),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
        trailing: Text(
          time,
          style: TextStyle(color: Colors.grey[600], fontSize: 12),
        ),
      ),
    );
  }
}
