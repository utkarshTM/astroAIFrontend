import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:astro_ai_app/api_constants.dart';

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

      print("Profile API Response: ${response.statusCode} - ${response.body}");

      if (response.statusCode == 200) {
        return json.decode(response.body)['data'];
      } else if (response.statusCode == 404) {
        return null; // Profile doesn't exist
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
              _dateController.text = DateFormat('yyyy-MM-dd')
                  .format(DateTime.parse(profile['dateOfBirth']));
            } catch (e) {
              print("Error parsing date: $e");
              _dateController.text = '';
            }
          }
          _timeController.text = profile['timeOfBirth'] ?? '';
          _maritalStatus = profile['maritalStatus'];
          _occupation = profile['occupation'];
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
      });
      print("Profile fetch error: $e");
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
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
        "${picked.hour.toString().padLeft(2, '0')}:"
            "${picked.minute.toString().padLeft(2, '0')}";
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
      if (mounted) {
        setState(() => _isUpdating = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Profile"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _errorMessage != null
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Failed to load profile",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 16),
            Text(
              _errorMessage!,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.error,
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _fetchUserProfile,
              child: const Text("Retry"),
            ),
          ],
        ),
      )
          : SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: "Name",
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                value?.isEmpty ?? true ? "Required" : null,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _gender,
                decoration: const InputDecoration(
                  labelText: "Gender",
                  border: OutlineInputBorder(),
                ),
                items: ["Male", "Female", "Other"]
                    .map((gender) => DropdownMenuItem(
                  value: gender,
                  child: Text(gender),
                ))
                    .toList(),
                onChanged: (value) => setState(() => _gender = value),
                validator: (value) =>
                value == null ? "Required" : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: TextEditingController(text: _placeOfBirth),
                decoration: const InputDecoration(
                  labelText: "Place of Birth",
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) => _placeOfBirth = value,
                validator: (value) =>
                value?.isEmpty ?? true ? "Required" : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _dateController,
                decoration: const InputDecoration(
                  labelText: "Date of Birth",
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.calendar_today),
                ),
                readOnly: true,
                onTap: () => _selectDate(context),
                validator: (value) =>
                value?.isEmpty ?? true ? "Required" : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _timeController,
                decoration: const InputDecoration(
                  labelText: "Time of Birth",
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.access_time),
                ),
                readOnly: true,
                onTap: () => _selectTime(context),
                validator: (value) =>
                value?.isEmpty ?? true ? "Required" : null,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _maritalStatus,
                decoration: const InputDecoration(
                  labelText: "Marital Status",
                  border: OutlineInputBorder(),
                ),
                items: ["Single", "Married", "Divorced", "Widowed"]
                    .map((status) => DropdownMenuItem(
                  value: status,
                  child: Text(status),
                ))
                    .toList(),
                onChanged: (value) =>
                    setState(() => _maritalStatus = value),
                validator: (value) =>
                value == null ? "Required" : null,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _occupation,
                decoration: const InputDecoration(
                  labelText: "Occupation",
                  border: OutlineInputBorder(),
                ),
                items: [
                  "Student",
                  "Employed",
                  "Unemployed",
                  "Other"
                ].map((occupation) => DropdownMenuItem(
                  value: occupation,
                  child: Text(occupation),
                ))
                    .toList(),
                onChanged: (value) =>
                    setState(() => _occupation = value),
                validator: (value) =>
                value == null ? "Required" : null,
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isUpdating ? null : _updateProfile,
                  child: _isUpdating
                      ? const CircularProgressIndicator()
                      : const Text("UPDATE PROFILE"),
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