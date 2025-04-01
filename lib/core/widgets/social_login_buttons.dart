import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SocialLoginButtons extends StatelessWidget {
  const SocialLoginButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: const FaIcon(FontAwesomeIcons.google, size: 40, color: Colors.red),
          onPressed: () {
            // Handle Google sign-in
          },
        ),
        const SizedBox(width: 20),
        IconButton(
          icon: const FaIcon(FontAwesomeIcons.facebook, size: 40, color: Colors.blue),
          onPressed: () {
            // Handle Facebook sign-in
          },
        ),
      ],
    );
  }
}
