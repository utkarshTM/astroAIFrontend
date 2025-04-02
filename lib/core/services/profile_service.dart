import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:astro_ai_app/core/constants/api_constants.dart';

class ProfileService {
  static Future<Map<String, dynamic>?> getProfile() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? accessToken = prefs.getString("access_token");

    if (accessToken == null) {
      throw Exception("No access token found. Please log in again.");
    }

    final response = await http.get(
      Uri.parse('${ApiConstants.baseUrl}/api/users/profile'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
        'ngrok-skip-browser-warning': 'true',
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body)['data'];
    } else if (response.statusCode == 404) {
      return null;
    } else {
      throw Exception("Failed to load profile: ${response.statusCode}");
    }
  }
}