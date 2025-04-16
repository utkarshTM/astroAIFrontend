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
//                     theme: Theme.of(context).textTheme.titleLarge?.copyWith(
//                       fontWeight: FontWeight.bold,
//                       fontSize: isTablet ? 22 : 18,
//                     ),
//                   ),
//                   SizedBox(height: isTablet ? 12 : 8),
//                   Text(
//                     'View your daily predictions',
//                     textAlign: TextAlign.center,
//                     theme: Theme.of(context).textTheme.bodyMedium?.copyWith(
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
import 'package:astro_ai_app/core/theme/app_colors.dart';
import 'package:astro_ai_app/core/theme/app_text_style.dart';
import 'package:astro_ai_app/core/theme/app_radius.dart';

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
    final isTablet = MediaQuery
        .of(context)
        .size
        .shortestSide > 600;
    return Card(
      shape: RoundedRectangleBorder(borderRadius: AppRadius.sm3),
      elevation: 3,
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: Icon(Icons.notifications, color: AppColors.iconColor(context)),
        title: Text(
            title,
            style: isTablet
                ? AppTextStyles.appBarTitle.copyWith(color: AppColors.adaptiveTextColor(context))
                : AppTextStyles.appBarTitle.copyWith(color: AppColors.adaptiveTextColor(context))
        ),
         // const TextStyle(fontWeight: FontWeight.bold)
        subtitle: Text(subtitle),
        trailing: Text(
          time,
          style: TextStyle(color: Colors.grey[600], fontSize: 12),
        ),
      ),
    );
  }
}
