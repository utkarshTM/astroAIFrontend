// import 'package:flutter/material.dart';
// import '../../../widgets/astro_chat_widget.dart';
//
// class AstroChatScreen extends StatelessWidget {
//   const AstroChatScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: AstroChatWidget(
//         botName: 'AstroBot',
//         avatarAsset: 'assets/astrologer.png',
//         initialMessages: [
//           {'sender': 'ai', 'text': 'Hi, I\'m AstroBot! 🌙 Ask me anything...'},
//         ],
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import '../../../widgets/astro_chat_widget.dart';
import 'package:astro_ai_app/core/theme/app_colors.dart';

class AstroChatScreen extends StatelessWidget {
  const AstroChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bhagwaSaffron(context),
      body: Padding(
        padding: const EdgeInsets.only(top: 40),
        child: AstroChatWidget(
          botName: 'AstroBot',
          avatarAsset: 'assets/logo.png',
          initialMessages: [
            {'sender': 'ai', 'text': 'Hi, I\'m AstroBot! 🌙 Ask me anything...'},
          ],
        ),
      ),
    );
  }
}


//
// import 'package:flutter/material.dart';
// import '../../../widgets/astro_chat_widget.dart';
// import 'package:astro_ai_app/core/theme/app_colors.dart';
//
// class AstroChatScreen extends StatelessWidget {
//   const AstroChatScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.bhagwaSaffron(context),
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.only(top: 50, left: 16, right: 16, bottom: 10),
//             child: Row(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 IconButton(
//                   icon: Icon(Icons.arrow_back, color: Colors.white),
//                   onPressed: () {
//                     Navigator.pop(context);
//                   },
//                 ),
//               ],
//             ),
//           ),
//           Expanded(
//             child: AstroChatWidget(
//               botName: 'AstroBot',
//               avatarAsset: 'assets/logo.png',
//               initialMessages: [
//                 {'sender': 'ai', 'text': 'Hi, I\'m AstroBot! 🌙 Ask me anything...'},
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
