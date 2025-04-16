import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:astro_ai_app/core/constants/api_constants.dart';
import 'package:astro_ai_app/core/theme/app_text_style.dart';
import 'package:astro_ai_app/core/theme/app_radius.dart';
import 'package:astro_ai_app/core/theme/app_colors.dart';
import 'package:astro_ai_app/core/theme/app_button.dart';
import 'package:astro_ai_app/core/theme/app_spacing.dart';
import 'package:astro_ai_app/core/features/dashboard/screens/dashboard_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserDetailsStep3 extends StatefulWidget {
  final String name;
  final String? gender;
  final String placeOfBirth;
  final String dateOfBirth;
  final String timeOfBirth;

  UserDetailsStep3({
    required this.name,
    required this.gender,
    required this.placeOfBirth,
    required this.dateOfBirth,
    required this.timeOfBirth,
  });

  @override
  _UserDetailsStep3State createState() => _UserDetailsStep3State();
}

class _UserDetailsStep3State extends State<UserDetailsStep3> {
  final _formKey = GlobalKey<FormState>();
  String? _maritalStatus;
  String? _occupation;
  String? _language;

  Future<void> _submitProfile() async {
    print("Submit button pressed!");

    if (!_formKey.currentState!.validate()) {
      print("Form validation failed.");
      return;
    }

    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString("access_token");

    if (accessToken == null) {
      print("Error: No access token found. Please log in.");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: No access token found. Please log in.")),
      );
      return;
    }

    final requestBody = {
      "name": widget.name.trim(),
      "gender": widget.gender,
      "placeOfBirth": widget.placeOfBirth.trim(),
      "dateOfBirth": widget.dateOfBirth,
      "timeOfBirth": widget.timeOfBirth,
      "maritalStatus": _maritalStatus,
      "occupation": _occupation?.trim(),
    };

    print("Request Body: ${jsonEncode(requestBody)}");
    print("Access Token: $accessToken");

    try {
      final response = await http.post(
        Uri.parse("${ApiConstants.baseUrl}/api/users/profile"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $accessToken",
        },
        body: jsonEncode(requestBody),
      );

      print("Response Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Profile saved successfully!")),
        );
        _navigateToDashboard();
      } else if (response.statusCode == 401) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Session expired. Please log in again.")),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(responseData['message'] ?? "Unknown error")),
        );
      }
    } catch (error) {
      print("Error: $error");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to connect to the server.")),
      );
    }
  }

  void _navigateToDashboard() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => DashboardScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile", style: AppTextStyles.appBarTitle),
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: AppColors.bhagwaSaffron(context),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 100),
              Center(child: Image.asset('assets/logo.png', height: 160)),
              const SizedBox(height: 30),
              DropdownButtonFormField<String>(
                value: _maritalStatus,
                decoration: InputDecoration(
                  labelText: "Marital Status",
                  border: OutlineInputBorder(borderRadius: AppRadius.sm),
                ),
                icon: Icon(Icons.arrow_drop_down, color: AppColors.bhagwa_Saffron),
                items: ["Single", "Married", "Divorced", "Widowed"]
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (value) => setState(() => _maritalStatus = value),
                validator: (value) => value == null ? "Select marital status" : null,
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField<String>(
                value: _occupation,
                decoration: InputDecoration(
                  labelText: "Occupation",
                  border: OutlineInputBorder(borderRadius: AppRadius.sm),
                ),
                icon: Icon(Icons.arrow_drop_down, color: AppColors.bhagwa_Saffron),
                items: ["Student", "Employed", "Un-Employed", "Other"]
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (value) => setState(() => _occupation = value),
                validator: (value) => value == null ? "Select occupation" : null,
              ),
              //const SizedBox(height: 30),
              const SizedBox(height: 10),
              DropdownButtonFormField<String>(
                value: _language,
                decoration: InputDecoration(
                  labelText: "Language",
                  border: OutlineInputBorder(borderRadius: AppRadius.sm),
                ),
                icon: Icon(Icons.arrow_drop_down, color: AppColors.bhagwa_Saffron),
                items: ["English","हिन्दी", "اردو", "தமிழ்","मराठी","ગુજરાતી"]
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (value) => setState(() => _language = value),
                validator: (value) => value == null ? "Select Language" : null,
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: AppButtonStyle.primary,
                  onPressed: _submitProfile,
                  child: Text('SUBMIT', style: AppTextStyles.btnText),
                ),
              ),
              SizedBox(height: 10),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: _navigateToDashboard,
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: Text(
                    'Skip',
                    style: TextStyle(
                      fontSize: 16,
                      decoration: TextDecoration.underline,
                      color: AppColors.bhagwa_Saffron,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
