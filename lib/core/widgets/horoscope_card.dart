import 'package:astro_ai_app/core/features/horoscope/screen/horoscope_list_screen.dart';
import 'package:flutter/material.dart';

class HoroscopeCard extends StatelessWidget {
  final VoidCallback onTap;

  const HoroscopeCard({Key? key, required this.onTap}) : super(key: key);

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
                  builder: (context) => const HoroscopeListScreen(),
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
                      Icons.star,
                      size: isTablet ? 56 : 48,
                      color: Colors.orange
                  ),
                  SizedBox(height: isTablet ? 16 : 12),
                  Text(
                    'Horoscope',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: isTablet ? 22 : 18,
                    ),
                  ),
                  SizedBox(height: isTablet ? 12 : 8),
                  Text(
                    'Daily predictions',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: isTablet ? 16 : 14,
                    ),
                    maxLines: 2,
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