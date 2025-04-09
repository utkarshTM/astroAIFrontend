import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:astro_ai_app/core/constants/api_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:astro_ai_app/core/features/dashboard/screens/dashboard_screen.dart';

class UserDetailsScreen extends StatefulWidget {
  @override
  _UserDetailsScreenState createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  String? _gender;
  String? _maritalStatus;
  String? _occupation;
  String? _placeOfBirth;

  Future<void> _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _dateController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        _timeController.text = picked.format(context);
      });
    }
  }

  Future<void> _submitProfile() async {
    print("Submit button pressed!");

    if (!_formKey.currentState!.validate()) {
      print("Form validation failed.");
      return;
    }

    final String apiUrl = "${ApiConstants.baseUrl}/api/users/profile";
    print("API URL: $apiUrl");

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString("access_token");

    if (accessToken == null) {
      print("Error: No access token found. Please log in.");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: No access token found. Please log in.")),
      );
      return;
    }

    // Request body
    Map<String, dynamic> requestBody = {
      "name": _nameController.text.trim(),
      "gender": _gender,
      "placeOfBirth": _placeOfBirth?.trim(),
      "dateOfBirth": _dateController.text,
      "timeOfBirth": _timeController.text,
      "maritalStatus": _maritalStatus,
      "occupation": _occupation?.trim(),
    };

    print("Request Body: ${jsonEncode(requestBody)}");
    print("Access Token: $accessToken");

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
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
        // Navigate to dashboard after successful submission
        _navigateToDashboard();
      } else if (response.statusCode == 401) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Session expired. Please log in again.")),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error: ${responseData['message'] ?? 'Unknown error'}")),
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
      appBar: AppBar(title: Text("Profile")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 25),
              Center(
                child: Image.asset(
                  'assets/logo.png', // <-- Replace with your image asset path
                  height: 150,
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(height: 10),
              Center(
                child: Text(
                  'Share Personal Details',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              //SizedBox(height: 25),

              SizedBox(height: 10),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: "Name",
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                ),
                validator: (value) => value!.isEmpty ? "Enter your name" : null,
              ),
              SizedBox(height: 10),
              DropdownButtonFormField<String>(
                value: _gender,
                decoration: InputDecoration(
                  labelText: "Gender",
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                ),
                items: ["Male", "Female", "Other"]
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (value) => setState(() => _gender = value),
                validator: (value) => value == null ? "Select gender" : null,
              ),
              SizedBox(height: 10),
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Place of Birth",
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                ),
                onChanged: (value) => _placeOfBirth = value,
                validator: (value) => value!.isEmpty ? "Enter place of birth" : null,
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _dateController,
                decoration: InputDecoration(
                  labelText: "Date of Birth",
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  suffixIcon: Icon(Icons.calendar_today, color: Colors.orangeAccent),
                ),
                readOnly: true,
                onTap: () => _selectDate(context),
                validator: (value) => value!.isEmpty ? "Select date of birth" : null,
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _timeController,
                decoration: InputDecoration(
                  labelText: "Time of Birth",
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  suffixIcon: Icon(Icons.access_time, color: Colors.orangeAccent),
                ),
                readOnly: true,
                onTap: () => _selectTime(context),
                validator: (value) => value!.isEmpty ? "Select time of birth" : null,
              ),
              SizedBox(height: 10),
              DropdownButtonFormField<String>(
                value: _maritalStatus,
                decoration: InputDecoration(
                  labelText: "Marital Status",
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                ),
                items: ["Single", "Married", "Divorced", "Widowed"]
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (value) => setState(() => _maritalStatus = value),
                validator: (value) => value == null ? "Select marital status" : null,
              ),
              SizedBox(height: 10),
              DropdownButtonFormField<String>(
                value: _occupation,
                decoration: InputDecoration(
                  labelText: "Occupation",
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                ),
                items: ["Student", "Employed", "Un-Employed", "Other"]
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (value) => setState(() => _occupation = value),
                validator: (value) => value == null ? "Select occupation" : null,
              ),
              SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    backgroundColor: Colors.orange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: _submitProfile,
                  child: Text(
                    'SUBMIT',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
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
                      color: Colors.orange,
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