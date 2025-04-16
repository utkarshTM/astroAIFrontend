import 'package:astro_ai_app/core/features/auth/screens/forgot_password_screen.dart';
import 'package:astro_ai_app/core/features/auth/screens/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'package:astro_ai_app/core/theme/app_colors.dart';
import 'package:astro_ai_app/core/theme/app_text_style.dart';
import 'package:astro_ai_app/core/theme/app_spacing.dart';
import 'package:astro_ai_app/core/theme/app_button.dart';

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  int _currentIndex = 0;
  void _navigateToPage(int index, BuildContext context) {
    setState(() {
      _currentIndex = index;
    });
    if (index == 1) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpPage()));
    } else if (index == 2) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
    }
  }
  @override
  Widget build(BuildContext context) {
    final isTablet = MediaQuery
        .of(context)
        .size
        .shortestSide > 600;

    return Scaffold(
      backgroundColor: AppColors.blackWhite(context),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              children: [
                const SizedBox(height: 160),
                Stack(
                  children: [
                    Container(
                      height: 150,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/logo.png'),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),

                    // **************** For change the Position *****************

                    const Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: SizedBox(height: 15),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  child: Column(
                    children: [
                      Text(
                        'Hello,Welcome to Astro Ai.',
                        style: isTablet ? AppTextStyles.heading.copyWith(
                            color: AppColors.adaptiveTextColor(context))
                            : AppTextStyles.heading.copyWith(
                            color: AppColors.adaptiveTextColor(context)),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Astro',
                        textAlign: TextAlign.center,
                        style: isTablet ? AppTextStyles.bodyText16.copyWith(
                            color: AppColors.adaptiveTextColor(context))
                            : AppTextStyles.bodyText16.copyWith(
                            color: AppColors.adaptiveTextColor(context)),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(3, (index) {
                          return GestureDetector(
                            onTap: () => _navigateToPage(index, context),
                            child: Container(
                              margin: const EdgeInsets.symmetric(horizontal: AppSpacing.xs),
                              width: 10,
                              height: 10,
                              decoration: BoxDecoration(
                                color: _currentIndex == index
                                    ? AppColors.highlight
                                    : AppColors.inactiveDot,
                                shape: BoxShape.circle,
                              ),
                            ),
                          );
                        }),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: AppButtonStyle.primary,
                          onPressed: () => _navigateToPage(1, context),
                          child: const Text(
                            'CREATE ACCOUNT',
                            style: AppTextStyles.btnText,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: AppButtonStyle.primary,
                          onPressed: () => _navigateToPage(2, context),
                          child: const Text(
                            'SIGN IN',
                            style: AppTextStyles.btnText,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ForgotPasswordScreen()),
                          );
                        },
                        child: const Text(
                          'Forgot your account? Click here',
                          style: AppTextStyles.footerText,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
