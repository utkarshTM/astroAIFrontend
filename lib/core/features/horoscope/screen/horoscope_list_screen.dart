import 'package:astro_ai_app/core/features/horoscope/screen/horoscope_detail_screen.dart';
import 'package:astro_ai_app/core/widgets/zodiac_card.dart';
import 'package:flutter/material.dart';

class HoroscopeListScreen extends StatelessWidget {
  const HoroscopeListScreen({super.key});

  static const List<Map<String, dynamic>> zodiacSigns = [
    {
      'name': 'Aries',
      'date': 'Mar 21 - Apr 19',
      'icon': Icons.self_improvement,
      'color': Colors.red,
    },
    {
      'name': 'Taurus',
      'date': 'Apr 20 - May 20',
      'icon': Icons.agriculture,
      'color': Colors.green,
    },
    {
      'name': 'Gemini',
      'date': 'May 21 - Jun 20',
      'icon': Icons.people,
      'color': Colors.yellow,
    },
    {
      'name': 'Cancer',
      'date': 'Jun 21 - Jul 22',
      'icon': Icons.water,
      'color': Colors.blue,
    },
    {
      'name': 'Leo',
      'date': 'Jul 23 - Aug 22',
      'icon': Icons.sunny,
      'color': Colors.orange,
    },
    {
      'name': 'Virgo',
      'date': 'Aug 23 - Sep 22',
      'icon': Icons.health_and_safety,
      'color': Colors.brown,
    },
    {
      'name': 'Libra',
      'date': 'Sep 23 - Oct 22',
      'icon': Icons.balance,
      'color': Colors.pink,
    },
    {
      'name': 'Scorpio',
      'date': 'Oct 23 - Nov 21',
      'icon': Icons.bug_report,
      'color': Colors.purple,
    },
    {
      'name': 'Sagittarius',
      'date': 'Nov 22 - Dec 21',
      'icon': Icons.arrow_upward,
      'color': Colors.indigo,
    },
    {
      'name': 'Capricorn',
      'date': 'Dec 22 - Jan 19',
      'icon': Icons.terrain,
      'color': Colors.grey,
    },
    {
      'name': 'Aquarius',
      'date': 'Jan 20 - Feb 18',
      'icon': Icons.water_drop,
      'color': Colors.cyan,
    },
    {
      'name': 'Pisces',
      'date': 'Feb 19 - Mar 20',
      'icon': Icons.waves,
      'color': Colors.blueAccent,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final isTablet = MediaQuery.of(context).size.shortestSide > 600;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Horoscope Signs'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(isTablet ? 24 : 16),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: isTablet ? 3 : 2,
            crossAxisSpacing: isTablet ? 20 : 16,
            mainAxisSpacing: isTablet ? 20 : 16,
            childAspectRatio: 0.9,
          ),
          itemCount: zodiacSigns.length,
          itemBuilder: (context, index) {
            final sign = zodiacSigns[index];
            return ZodiacCard(
              name: sign['name'],
              dateRange: sign['date'],
              icon: sign['icon'],
              color: sign['color'],
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HoroscopeDetailScreen(
                      zodiacSign: sign['name'],
                      icon: sign['icon'],
                      color: sign['color'],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}