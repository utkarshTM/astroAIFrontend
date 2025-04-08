import 'package:astro_ai_app/core/widgets/horoscope_period_selector.dart';
import 'package:flutter/material.dart';

class HoroscopeDetailScreen extends StatefulWidget {
  final String zodiacSign;
  final IconData icon;
  final Color color;

  const HoroscopeDetailScreen({
    super.key,
    required this.zodiacSign,
    required this.icon,
    required this.color,
  });

  @override
  State<HoroscopeDetailScreen> createState() => _HoroscopeDetailScreenState();
}

class _HoroscopeDetailScreenState extends State<HoroscopeDetailScreen> {
  String selectedPeriod = 'Daily';
  final DateTime today = DateTime.now();
  final DateTime tomorrow = DateTime.now().add(const Duration(days: 1));

  final Map<String, String> dummyHoroscopes = {
    'Daily': 'Today, the stars align in your favor, bringing unexpected opportunities. '
        'Your creativity is at its peak, so don\'t hesitate to express your ideas. '
        'A chance encounter could lead to a meaningful connection.',
    'Weekly': 'This week, focus on balancing your personal and professional life. '
        'Midweek brings a financial opportunity - be ready to act. '
        'Relationships flourish with open communication. '
        'Weekend is perfect for self-reflection and planning.',
    'Monthly': 'This month marks a turning point in your career. '
        'New responsibilities may arise around the 15th. '
        'Financially stable period, but avoid impulsive purchases. '
        'Personal relationships deepen through shared experiences. '
        'Health needs attention - prioritize sleep and nutrition.',
    'Yearly': '2025 is your year of transformation and growth. '
        'Career advancements are likely in Q2. '
        'Relationships will go through tests but emerge stronger. '
        'Financial investments made this year will pay off in the long term. '
        'Focus on personal development and learning new skills.',
  };

  final Map<String, Map<String, String>> luckyDetails = {
    'Daily': {'number': '7', 'color': 'Red'},
    'Weekly': {'number': '3, 9', 'color': 'Green'},
    'Monthly': {'number': '5', 'color': 'Blue'},
    'Yearly': {'number': '1, 8', 'color': 'Gold'},
  };

  @override
  Widget build(BuildContext context) {
    final isTablet = MediaQuery.of(context).size.shortestSide > 600;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Horoscope 2025'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(isTablet ? 24 : 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HoroscopePeriodSelector(
              selectedPeriod: selectedPeriod,
              onPeriodChanged: (period) {
                setState(() {
                  selectedPeriod = period;
                });
              },
            ),
            const SizedBox(height: 24),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: widget.color.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    widget.icon,
                    size: isTablet ? 48 : 36,
                    color: widget.color,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '$selectedPeriod Horoscope for Moon Sign : ${widget.zodiacSign}',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        _getDateString(selectedPeriod),
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Text(
              dummyHoroscopes[selectedPeriod]!,
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                _buildLuckyItem(
                  context,
                  'Lucky Number',
                  luckyDetails[selectedPeriod]!['number']!,
                ),
                const SizedBox(width: 16),
                _buildLuckyItem(
                  context,
                  'Lucky Color',
                  luckyDetails[selectedPeriod]!['color']!,
                ),
              ],
            ),
            const SizedBox(height: 32),
            if (selectedPeriod == 'Daily')
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      selectedPeriod = 'Daily';
                    });
                  },
                  child: Text(
                    "Tomorrow's Horoscope (${tomorrow.day}/${tomorrow.month}/${tomorrow.year})",
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildLuckyItem(BuildContext context, String title, String value) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getDateString(String period) {
    switch (period) {
      case 'Daily':
        return '${today.day} ${_getMonthName(today.month)}, ${today.year}';
      case 'Weekly':
        final startOfWeek = today.subtract(Duration(days: today.weekday - 1));
        final endOfWeek = startOfWeek.add(const Duration(days: 6));
        return '${startOfWeek.day} ${_getMonthName(startOfWeek.month)} - ${endOfWeek.day} ${_getMonthName(endOfWeek.month)}, ${today.year}';
      case 'Monthly':
        return '${_getMonthName(today.month)} ${today.year}';
      case 'Yearly':
        return '2025';
      default:
        return '';
    }
  }

  String _getMonthName(int month) {
    const months = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    return months[month - 1];
  }
}