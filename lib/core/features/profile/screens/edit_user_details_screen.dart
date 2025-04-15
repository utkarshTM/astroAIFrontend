import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:astro_ai_app/core/constants/api_constants.dart';
import 'package:astro_ai_app/core/theme/app_colors.dart';
import 'package:astro_ai_app/core/theme/app_text_style.dart';
import 'package:astro_ai_app/core/theme/app_spacing.dart';
import 'package:astro_ai_app/core/theme/app_radius.dart';
import 'package:astro_ai_app/core/theme/app_button.dart';

class ProfileService {
  static Future<Map<String, dynamic>?> getProfile() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? accessToken = prefs.getString("access_token");

    if (accessToken == null) {
      throw Exception("No access token found. Please log in again.");
    }

    final String apiUrl = "${ApiConstants.baseUrl}/api/users/profile";

    try {
      final response = await http.get(
        Uri.parse(apiUrl),
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
    } catch (e) {
      throw Exception("Network error: ${e.toString()}");
    }
  }

  static Future<Map<String, dynamic>> updateProfile(Map<String, dynamic> profileData) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? accessToken = prefs.getString("access_token");

    if (accessToken == null) {
      throw Exception("No access token found");
    }

    final String apiUrl = "${ApiConstants.baseUrl}/api/users/profile";

    try {
      final response = await http.put(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
          'ngrok-skip-browser-warning': 'true',
        },
        body: json.encode(profileData),
      );

      if (response.statusCode == 200) {
        return json.decode(response.body)['data'];
      } else {
        throw Exception('Failed to update profile: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception("Network error: ${e.toString()}");
    }
  }
}

class EditUserDetailsScreen extends StatefulWidget {
  const EditUserDetailsScreen({Key? key}) : super(key: key);

  @override
  _EditUserDetailsScreenState createState() => _EditUserDetailsScreenState();
}

class _EditUserDetailsScreenState extends State<EditUserDetailsScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _dateController;
  late TextEditingController _timeController;
  String? _gender;
  String? _maritalStatus;
  String? _occupation;
  String? _placeOfBirth;

  bool _isLoading = true;
  bool _isUpdating = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _dateController = TextEditingController();
    _timeController = TextEditingController();
    _fetchUserProfile();
  }

  Future<void> _fetchUserProfile() async {
    try {
      setState(() {
        _isLoading = true;
        _errorMessage = null;
      });

      final profile = await ProfileService.getProfile();

      if (!mounted) return;

      if (profile != null) {
        setState(() {
          _nameController.text = profile['name'] ?? '';
          _gender = profile['gender'];
          _placeOfBirth = profile['placeOfBirth'];
          if (profile['dateOfBirth'] != null) {
            try {
              _dateController.text =
                  DateFormat('yyyy-MM-dd').format(DateTime.parse(profile['dateOfBirth']));
            } catch (e) {
              _dateController.text = '';
            }
          }
          _timeController.text = profile['timeOfBirth'] ?? '';
          _maritalStatus = profile['maritalStatus'];
          _occupation = profile['occupation'];
        });
      }
    } catch (e) {
      setState(() => _errorMessage = e.toString());
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _dateController.text.isNotEmpty
          ? DateTime.parse(_dateController.text)
          : DateTime.now(),
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
    TimeOfDay initialTime = TimeOfDay.now();
    if (_timeController.text.isNotEmpty) {
      final parts = _timeController.text.split(':');
      initialTime = TimeOfDay(
        hour: int.parse(parts[0]),
        minute: int.parse(parts[1]),
      );
    }

    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: initialTime,
    );

    if (picked != null) {
      setState(() {
        _timeController.text =
        "${picked.hour.toString().padLeft(2, '0')}:${picked.minute.toString().padLeft(2, '0')}";
      });
    }
  }

  Future<void> _updateProfile() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isUpdating = true);

    try {
      final profileData = {
        "name": _nameController.text.trim(),
        "gender": _gender,
        "placeOfBirth": _placeOfBirth?.trim(),
        "dateOfBirth": _dateController.text,
        "timeOfBirth": _timeController.text,
        "maritalStatus": _maritalStatus,
        "occupation": _occupation?.trim(),
      };

      await ProfileService.updateProfile(profileData);

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Profile updated successfully!")),
      );
      Navigator.pop(context, true);
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: ${e.toString()}")),
      );
    } finally {
      if (mounted) setState(() => _isUpdating = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
            "Edit Profile",
            style: AppTextStyles.appBarTitle
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: AppColors.bhagwa_Saffron,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _errorMessage != null
          ? Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: 0),
        //padding: AppSpacing.screenPadding,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Failed to load profile", style: AppTextStyles.heading),
              const SizedBox(height: 16),
              Text(
                _errorMessage!,
                textAlign: TextAlign.center,
                style: AppTextStyles.bodyText16.copyWith(color: AppColors.bhagwa_Saffron),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _fetchUserProfile,
                child: const Text("Retry"),
              ),
            ],
          ),
        ),
      )
          : SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: 0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(height: 20),
              Image.asset('assets/logo.png', height: 150, fit: BoxFit.contain),
              const SizedBox(height: 20),
              // Name
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: "Name",
                  border: OutlineInputBorder(borderRadius: AppRadius.sm)
                ),
                validator: (value) =>
                value?.isEmpty ?? true ? "Required" : null,
              ),
              const SizedBox(height: 16),

              // Gender
              DropdownButtonFormField<String>(
                value: _gender,
                decoration: InputDecoration(
                  labelText: "Gender",
                  border: OutlineInputBorder(borderRadius: AppRadius.sm),
                ),
                icon: Icon(Icons.arrow_drop_down, color: AppColors.bhagwa_Saffron),
                items: ["Male", "Female", "Other"]
                    .map((gender) => DropdownMenuItem(
                  value: gender,
                  child: Text(gender),
                ))
                    .toList(),
                onChanged: (value) => setState(() => _gender = value),
                validator: (value) => value == null ? "Required" : null,
              ),
              const SizedBox(height: 16),

              // Place of Birth
              TextFormField(
                controller: TextEditingController(text: _placeOfBirth),
                decoration: InputDecoration(
                  labelText: "Place of Birth",
                  border: OutlineInputBorder(borderRadius: AppRadius.sm),
                ),
                onChanged: (value) => _placeOfBirth = value,
                validator: (value) =>
                value?.isEmpty ?? true ? "Required" : null,
              ),
              const SizedBox(height: 16),

              // Date of Birth
              TextFormField(
                controller: _dateController,
                readOnly: true,
                onTap: () => _selectDate(context),
                decoration: InputDecoration(
                  labelText: "Date of Birth",
                  border: OutlineInputBorder(borderRadius: AppRadius.sm),
                  suffixIcon: Icon(Icons.calendar_today,color: AppColors.bhagwa_Saffron),
                ),
                validator: (value) =>
                value?.isEmpty ?? true ? "Required" : null,
              ),
              const SizedBox(height: 16),

              // Time of Birth
              TextFormField(
                controller: _timeController,
                readOnly: true,
                onTap: () => _selectTime(context),
                decoration: InputDecoration(
                  labelText: "Time of Birth",
                  border: OutlineInputBorder(borderRadius: AppRadius.sm),
                  suffixIcon: Icon(Icons.access_time,color: AppColors.bhagwa_Saffron),
                ),
                validator: (value) =>
                value?.isEmpty ?? true ? "Required" : null,
              ),
              const SizedBox(height: 16),

              // Marital Status
              DropdownButtonFormField<String>(
                value: _maritalStatus,
                decoration: InputDecoration(
                  labelText: "Marital Status",
                  border: OutlineInputBorder(borderRadius: AppRadius.sm),
                ),
                icon: Icon(Icons.arrow_drop_down, color: AppColors.bhagwa_Saffron),
                items: ["Single", "Married", "Divorced", "Widowed"]
                    .map((status) => DropdownMenuItem(
                  value: status,
                  child: Text(status),
                ))
                    .toList(),
                onChanged: (value) => setState(() => _maritalStatus = value),
                validator: (value) => value == null ? "Required" : null,
              ),
              const SizedBox(height: 16),

              // Occupation
              DropdownButtonFormField<String>(
                value: _occupation,
                decoration: InputDecoration(
                  labelText: "Occupation",
                  border: OutlineInputBorder(borderRadius: AppRadius.sm),
                ),
                icon: Icon(Icons.arrow_drop_down, color: AppColors.bhagwa_Saffron),
                items: ["Student", "Employed", "Unemployed", "Other"]
                    .map((occupation) => DropdownMenuItem(
                  value: occupation,
                  child: Text(occupation),
                ))
                    .toList(),
                onChanged: (value) => setState(() => _occupation = value),
                validator: (value) => value == null ? "Required" : null,
              ),
              const SizedBox(height: 24),

              // Submit
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isUpdating ? null : _updateProfile,
                  style: AppButtonStyle.primary,
                  child: _isUpdating
                      ? const CircularProgressIndicator()
                      : Text("UPDATE PROFILE",
                        style:
                        AppTextStyles.appBarTitle,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _dateController.dispose();
    _timeController.dispose();
    super.dispose();
  }
}
