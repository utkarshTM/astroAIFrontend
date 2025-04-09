import 'package:flutter/material.dart';
import 'package:astro_ai_app/core/features/chatWithAi/screens/chat_screen.dart';


class ChatCard extends StatelessWidget {
  final VoidCallback onTap;

  const ChatCard({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isTablet = MediaQuery.of(context).size.shortestSide > 600;

    return LayoutBuilder(
      builder: (context, constraints) {
        return Card(
          elevation: 4,
          margin: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AstroChatScreen(),
                ),
              );
            },
            borderRadius: BorderRadius.circular(12),
            child: Padding(
              padding: EdgeInsets.all(isTablet ? 24 : 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                      Icons.chat,
                      size: isTablet ? 56 : 48,
                      color: Colors.blue
                  ),
                  SizedBox(height: isTablet ? 16 : 12),
                  Text(
                    'Astro Chat',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: isTablet ? 22 : 18,
                    ),
                  ),
                  SizedBox(height: isTablet ? 12 : 8),
                  Text(
                    'Chat with our AI astrologer',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: isTablet ? 16 : 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}