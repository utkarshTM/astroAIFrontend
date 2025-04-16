import 'package:astro_ai_app/core/theme/app_button.dart';
import 'package:flutter/material.dart';
import 'package:astro_ai_app/core/theme/app_text_style.dart';
import 'package:astro_ai_app/core/theme/app_radius.dart';
import 'package:astro_ai_app/core/theme/app_colors.dart';
import 'package:astro_ai_app/core/theme/app_spacing.dart';
import 'user_detail_step2.dart';

class UserDetailsStep1 extends StatefulWidget {
  @override
  _UserDetailsStep1State createState() => _UserDetailsStep1State();
}

class _UserDetailsStep1State extends State<UserDetailsStep1> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  String? _gender;

  //********************** For Name & Gender Field Required from user ****************************

  void _nextStep() {
    if (_formKey.currentState!.validate()) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => UserDetailsStep2(
            name: _nameController.text.trim(),
            gender: _gender,
          ),
        ),
      );
    }
  }

  void _skipStep1() {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => UserDetailsStep2(
            name: _nameController.text.trim(),
            gender: _gender,
          ),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    final isTablet = MediaQuery.of(context).size.shortestSide > 600;
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 100),
              Center(child: Image.asset('assets/logo.png', height: 160)),
              const SizedBox(height: 30),
              Center(
                child: Text(
                  'Share Personal Details',
                  style: isTablet
                      ? AppTextStyles.heading.copyWith(color: AppColors.adaptiveTextColor(context))
                      : AppTextStyles.heading.copyWith(color: AppColors.adaptiveTextColor(context)),
                ),
              ),
              const SizedBox(height: 30),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: "Name",
                  border: OutlineInputBorder(borderRadius: AppRadius.sm),
                ),
                validator: (value) => value!.isEmpty ? "Enter your name" : null,
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField<String>(
                value: _gender,
                decoration: InputDecoration(
                  labelText: "Gender",
                  border: OutlineInputBorder(borderRadius: AppRadius.sm),
                ),
                icon: Icon(Icons.arrow_drop_down, color: AppColors.bhagwa_Saffron),
                items: ["Male", "Female", "Other"].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                onChanged: (value) => setState(() => _gender = value),
                validator: (value) => value == null ? "Select gender" : null,
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _nextStep,
                  style: AppButtonStyle.primary,
                  child: Text('NEXT', style: AppTextStyles.btnText),
                ),
              ),
              SizedBox(height: 10),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: _skipStep1,
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
