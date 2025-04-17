import 'package:flutter/material.dart';
import 'package:astro_ai_app/core/theme/app_colors.dart';
import 'package:astro_ai_app/core/theme/app_text_style.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isTablet = MediaQuery.of(context).size.shortestSide > 600;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        centerTitle: true,
        title: const Text('About Us', style: AppTextStyles.appBarTitle),
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: AppColors.bhagwaSaffron(context),
        //iconTheme: const IconThemeData(color: AppColors.textLight),
      ),

      //*********************** Code for Title and icon without space *************** //
      // appBar: AppBar(
      //   automaticallyImplyLeading: false,  // disable default back button spacing
      //   titleSpacing: 0,                   // remove default padding
      //   title: Row(
      //     children: [
      //       IconButton(
      //         icon: const Icon(Icons.arrow_back),
      //         color: Colors.white,
      //         onPressed: () {
      //           Navigator.pop(context);
      //         },
      //       ),
      //       const Text(
      //         'About Us',
      //         style: AppTextStyles.appBarTitle,
      //       ),
      //     ],
      //   ),
      //   backgroundColor: AppColors.bhagwaSaffron(context),
      // ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.asset(
                'assets/dark_logo.png',
                height: isTablet ? 200 : 150,
                fit: BoxFit.contain,
              ),
              //****** Code For toggling the image for light & Dark Mode
              // Theme.of(context).brightness == Brightness.dark
              //     ? 'assets/dark_logo.png'
              //     : 'assets/light_logo.png',
            ),
            const SizedBox(height: 20),
            Center(
              child: Text(
                'Welcome to Astro AI',
                style:
                    isTablet
                        ? AppTextStyles.heading.copyWith(
                          fontSize: 24,
                          color: AppColors.adaptiveTextColor(context),
                        )
                        : AppTextStyles.heading.copyWith(
                          color: AppColors.adaptiveTextColor(context),
                        ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Astro AI is your personal AI-powered astrologer. Our goal is to provide users with deep astrological insights using modern technology and ancient wisdom. We combine machine learning and astrology to help guide you in areas such as love, career, health, and more.',
              textAlign: TextAlign.justify,
              style:
                  isTablet
                      ? AppTextStyles.bodyText16.copyWith(
                        color: AppColors.adaptiveTextColor(context),
                      )
                      : AppTextStyles.bodyText16.copyWith(
                        color: AppColors.adaptiveTextColor(context),
                      ),
            ),
            const SizedBox(height: 16),
            Text(
              'What We Offer:',
              style:
                  isTablet
                      ? AppTextStyles.subHeading.copyWith(
                        color: AppColors.adaptiveTextColor(context),
                      )
                      : AppTextStyles.subHeading.copyWith(
                        color: AppColors.adaptiveTextColor(context),
                      ),
            ),
            const SizedBox(height: 10),
            _buildBulletPoint(
              context,
              'AI-powered astrological chat assistance.',
            ),
            _buildBulletPoint(
              context,
              'Daily horoscopes and personalized readings.',
            ),
            _buildBulletPoint(
              context,
              'Real-time kundli and birth chart analysis.',
            ),
            _buildBulletPoint(
              context,
              'User-friendly, clean, and secure interface.',
            ),
            const SizedBox(height: 20),
            Text(
              'Our mission is to bridge the gap between traditional astrology and modern technology to empower individuals in understanding their cosmic path.',
              textAlign: TextAlign.justify,
              style:
                  isTablet
                      ? AppTextStyles.bodyText16.copyWith(
                        color: AppColors.adaptiveTextColor(context),
                      )
                      : AppTextStyles.bodyText16.copyWith(
                        color: AppColors.adaptiveTextColor(context),
                      ),
            ),
            const SizedBox(height: 30),
            Center(
              child: Text(
                'Thank you for choosing Astro AI!',
                textAlign: TextAlign.center,
                style: isTablet
                        ? AppTextStyles.footerText.copyWith(fontSize: 20)
                        : AppTextStyles.footerText,
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildBulletPoint(BuildContext context, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '• ',
            style: TextStyle(
              fontSize: 18,
              color: AppColors.adaptiveTextColor(context),
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: AppTextStyles.bodyText16.copyWith(
                height: 1.4,
                color: AppColors.adaptiveTextColor(context),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
