import 'package:flutter/material.dart';
import 'package:astro_ai_app/styles/app_Styles.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isTablet = MediaQuery.of(context).size.shortestSide > 600;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'About Us',
          style: AppTextStyles.appBarTitle,
        ),
        backgroundColor: AppColors.primary,
        iconTheme: const IconThemeData(color: AppColors.textLight),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.asset(
                'assets/logo.png',
                height: isTablet ? 200 : 150,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: Text(
                'Welcome to Astro AI',
                style: isTablet
                    ? AppTextStyles.pageTitle.copyWith(fontSize: 24)
                    : AppTextStyles.pageTitle,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Astro AI is your personal AI-powered astrologer. Our goal is to provide users with deep astrological insights using modern technology and ancient wisdom. We combine machine learning and astrology to help guide you in areas such as love, career, health, and more.',
              textAlign: TextAlign.justify,
              style: isTablet ? AppTextStyles.bodyText18 : AppTextStyles.bodyText16,
            ),
            const SizedBox(height: 16),
            Text(
              'What We Offer:',
              style: isTablet ? AppTextStyles.subheading20 : AppTextStyles.subheading,
            ),
            const SizedBox(height: 10),
            _buildBulletPoint('AI-powered astrological chat assistance.'),
            _buildBulletPoint('Daily horoscopes and personalized readings.'),
            _buildBulletPoint('Real-time kundli and birth chart analysis.'),
            _buildBulletPoint('User-friendly, clean, and secure interface.'),
            const SizedBox(height: 20),
            Text(
              'Our mission is to bridge the gap between traditional astrology and modern technology to empower individuals in understanding their cosmic path.',
              textAlign: TextAlign.justify,
              style: isTablet ? AppTextStyles.bodyText18 : AppTextStyles.bodyText16,
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

  Widget _buildBulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('• ', style: TextStyle(fontSize: 18)),
          Expanded(
            child: Text(
              text,
              style: AppTextStyles.bodyText16.copyWith(height: 1.4),
            ),
          ),
        ],
      ),
    );
  }
}
