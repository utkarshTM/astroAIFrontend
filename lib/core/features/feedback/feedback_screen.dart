import 'package:astro_ai_app/core/theme/app_button.dart';
//import 'package:astro_ai_app/core/theme/app_radius.dart';
import 'package:flutter/material.dart';
import 'package:astro_ai_app/core/theme/app_colors.dart';
import 'package:astro_ai_app/core/theme/app_text_style.dart';
//import 'package:astro_ai_app/core/theme/app_spacing.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({super.key});

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  bool _isSubmitting = false;
  String? _generalMessage;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  void _submitFeedback() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isSubmitting = true;
      _generalMessage = null;
    });

    try {
      // Simulate API submission
      await Future.delayed(const Duration(seconds: 2));

      setState(() {
        _generalMessage = 'Thank you for your feedback!';
      });

      _nameController.clear();
      _emailController.clear();
      _phoneController.clear();
      _messageController.clear();
    } catch (e) {
      setState(() {
        _generalMessage = 'Something went wrong, please try again!';
      });
    } finally {
      setState(() {
        _isSubmitting = false;
      });
    }
  }

  Widget _buildTextField({
    required String label,
    required String hint,
    required TextEditingController controller,
    int maxLines = 1,
    TextInputType inputType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
            label, 
            style: AppTextStyles.fieldLabel.copyWith(color: AppColors.adaptiveTextColor(context))
        ),
        const SizedBox(height: 10),
        TextFormField(
          controller: controller,
          keyboardType: inputType,
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hint,
            filled: true,
            fillColor: AppColors.blackWhite(context),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              //borderSide: BorderSide.none,
            ),
          ),
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Please enter $label.';
            }
            return null;
          },
        ),
        const SizedBox(height: 15),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blackWhite(context),
      appBar: AppBar(
        automaticallyImplyLeading: true,
        centerTitle: true,
        title: const Text('Feedback', style: AppTextStyles.appBarTitle),
        backgroundColor: AppColors.bhagwaSaffron(context),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
//************************Code For No spacing between the app bar icon and title***************************
      // appBar: AppBar(
      //   automaticallyImplyLeading: false,  // disable default back button spacing
      //   titleSpacing: 0,                   // remove default padding
      //   title: Row(
      //     children: [
      //       IconButton(
      //         icon: const Icon(Icons.arrow_back),
      //         color: Colors.white,
      //         onPressed: () {
      //           Navigator.pop(context);
      //         },
      //       ),
      //       const Text(
      //         'Feedback',
      //         style: AppTextStyles.appBarTitle,
      //       ),
      //     ],
      //   ),
      //   backgroundColor: AppColors.bhagwaSaffron(context),
      // ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(height: 0),
              Image.asset(
                  Theme.of(context).brightness == Brightness.dark
                      ? 'assets/light_logo.png'
                      : 'assets/dark_logo.png',
                  height: 180,
                  //width: 80,
                  fit: BoxFit.contain),
              SizedBox(height: 2),
              _buildTextField(
                label: 'Full Name',
                hint: 'Please enter full name',
                controller: _nameController,
              ),
              _buildTextField(
                label: 'Email Id',
                hint: 'Please enter your email id',
                controller: _emailController,
                inputType: TextInputType.emailAddress,
              ),
              _buildTextField(
                label: 'Phone Number',
                hint: 'Please enter your phone number',
                controller: _phoneController,
                inputType: TextInputType.phone,
              ),
              _buildTextField(
                label: 'Message',
                hint: 'Message...',
                controller: _messageController,
                maxLines: 4,
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: AppButtonStyle.primary,
                  // style: ElevatedButton.styleFrom(
                  //   backgroundColor: AppColors.primary,
                  //   padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
                  //   shape: RoundedRectangleBorder(
                  //     borderRadius: BorderRadius.circular(AppSpacing.sm2),
                  //   ),
                  // ),
                  onPressed: _isSubmitting ? null : _submitFeedback,
                  child: _isSubmitting
                      ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      strokeWidth: 2,
                    ),
                  )
                      : const Text(
                    'SEND',
                    style: AppTextStyles.btnText,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              if (_generalMessage != null)
                Text(
                  _generalMessage!,
                  style: _generalMessage == 'Something went wrong, please try again!'
                      ? AppTextStyles.errorMessage
                      : AppTextStyles.successMessage,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

