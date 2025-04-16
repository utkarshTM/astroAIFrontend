import 'package:astro_ai_app/core/theme/app_button.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:astro_ai_app/core/theme/app_text_style.dart';
import 'package:astro_ai_app/core/theme/app_radius.dart';
import 'package:astro_ai_app/core/theme/app_colors.dart';
import 'package:astro_ai_app/core/theme/app_spacing.dart';
import 'package:astro_ai_app/core/features/profile/screens/user_detail_step3.dart';

class UserDetailsStep2 extends StatefulWidget {
  final String name;
  final String? gender;

  UserDetailsStep2({required this.name, required this.gender});

  @override
  _UserDetailsStep2State createState() => _UserDetailsStep2State();
}

class _UserDetailsStep2State extends State<UserDetailsStep2> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _placeController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();

  Future<void> _selectDate() async {
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

  Future<void> _selectTime() async {
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

  void _nextStep() {
    if (_formKey.currentState!.validate()) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => UserDetailsStep3(
            name: widget.name,
            gender: widget.gender,
            placeOfBirth: _placeController.text.trim(),
            dateOfBirth: _dateController.text,
            timeOfBirth: _timeController.text,
          ),
        ),
      );
    }
  }

  void _skipStep2() {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => UserDetailsStep3(
            name: widget.name,
            gender: widget.gender,
            placeOfBirth: _placeController.text.trim(),
            dateOfBirth: _dateController.text,
            timeOfBirth: _timeController.text,
          ),
        ),
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
              TextFormField(
                controller: _placeController,
                decoration: InputDecoration(
                  labelText: "Place of Birth",
                  border: OutlineInputBorder(borderRadius: AppRadius.sm),
                  suffixIcon: Icon(Icons.place, color: AppColors.bhagwa_Saffron),
                ),
                validator: (value) => value!.isEmpty ? "Enter place of birth" : null,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _dateController,
                decoration: InputDecoration(
                  labelText: "Date of Birth",
                  border: OutlineInputBorder(borderRadius: AppRadius.sm),
                  suffixIcon: Icon(Icons.calendar_today, color: AppColors.bhagwa_Saffron),
                ),
                readOnly: true,
                onTap: _selectDate,
                validator: (value) => value!.isEmpty ? "Select date of birth" : null,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _timeController,
                decoration: InputDecoration(
                  labelText: "Time of Birth",
                  border: OutlineInputBorder(borderRadius: AppRadius.sm),
                  suffixIcon: Icon(Icons.access_time, color: AppColors.bhagwa_Saffron),
                ),
                readOnly: true,
                onTap: _selectTime,
                validator: (value) => value!.isEmpty ? "Select time of birth" : null,
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: AppButtonStyle.primary,
                  onPressed: _nextStep,
                  child: Text('NEXT', style: AppTextStyles.btnText),
                ),
              ),
              SizedBox(height: 10),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: _skipStep2,
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
