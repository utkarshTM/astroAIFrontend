import 'package:flutter/material.dart';
import 'package:astro_ai_app/core/widgets/app_header.dart';
import 'package:astro_ai_app/core/widgets/app_drawer.dart';
import 'package:astro_ai_app/core/widgets/chat_card.dart';
import 'package:astro_ai_app/core/widgets/horoscope_card.dart';
import 'package:astro_ai_app/core/widgets/matchmaking_card.dart';
import 'package:astro_ai_app/core/services/profile_service.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String? _firstName;
  bool _isLoading = true;
  String _greeting = 'Hello';

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
    _setGreeting();
  }

  void _setGreeting() {
    final hour = DateTime.now().hour;
    setState(() {
      if (hour < 12) {
        _greeting = 'Good Morning';
      } else if (hour < 17) {
        _greeting = 'Good Afternoon';
      } else {
        _greeting = 'Good Evening';
      }
    });
  }

  Future<void> _loadUserProfile() async {
    try {
      final profile = await ProfileService.getProfile();
      if (mounted) {
        setState(() {
          _firstName = profile?['name']?.toString().split(' ').first;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isTablet = MediaQuery.of(context).size.shortestSide > 600;

    return Scaffold(
      appBar: AppHeader(),
      drawer: AppDrawer(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(isTablet ? 24 : 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildGreetingRow(isTablet),
              SizedBox(height: isTablet ? 12 : 8),
              Text(
                'The universe has aligned to bring you here today',
                style: TextStyle(
                  fontSize: isTablet ? 18 : 14,
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(height: isTablet ? 28 : 24),
              _buildFeatureGrid(isTablet),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGreetingRow(bool isTablet) {
    if (_isLoading) {
      return SizedBox(
        height: isTablet ? 28 : 24,
        child: Center(child: CircularProgressIndicator()),
      );
    }

    return RichText(
      text: TextSpan(
        style: TextStyle(
          fontSize: isTablet ? 28 : 24,
          fontWeight: FontWeight.bold,
          color: Colors.orange,
        ),
        children: [
          TextSpan(text: _greeting),
          if (_firstName != null) ...[
            TextSpan(text: ', '),
            TextSpan(
              text: _firstName!,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildFeatureGrid(bool isTablet) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return GridView.count(
          crossAxisCount: isTablet ? 3 : 2,
          crossAxisSpacing: isTablet ? 20 : 16,
          mainAxisSpacing: isTablet ? 20 : 16,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          childAspectRatio: isTablet ? 1.0 : 0.9,
          children: [
            HoroscopeCard(onTap: () => print('Horoscope tapped')),
            ChatCard(onTap: () => print('Chat tapped')),
            MatchmakingCard(onTap: () => print('Matchmaking tapped')),
            if (isTablet) ...[
              // Additional cards for tablet layout
            ],
          ],
        );
      },
    );
  }
}