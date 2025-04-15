import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:astro_ai_app/core/theme/app_button.dart';
import 'package:astro_ai_app/core/theme/app_colors.dart';

class SocialLoginButtons extends StatelessWidget {
  const SocialLoginButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: const FaIcon(FontAwesomeIcons.google, size: AppStyles.socialIconSize, color: AppColors.google),
          onPressed: () {
            // Handle Google sign-in
          },
        ),
        const SizedBox(width: 20),
        IconButton(
          icon: const FaIcon(FontAwesomeIcons.facebook, size: AppStyles.socialIconSize, color: AppColors.facebook),
          onPressed: () {
            // Handle Facebook sign-in
          },
        ),
      ],
    );
  }
}
