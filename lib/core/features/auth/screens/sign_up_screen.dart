//**********************Previous Code*******************************//
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import './login_screen.dart';
// import 'package:astro_ai_app/core/constants/api_constants.dart';
// import 'package:astro_ai_app/core/theme/app_colors.dart';
// import 'package:astro_ai_app/core/theme/app_text_style.dart';
// import 'package:astro_ai_app/core/theme/app_spacing.dart';
// import 'package:astro_ai_app/core/theme/app_button.dart';
// import 'package:astro_ai_app/core/theme/app_radius.dart';
//
// class SignUpPage extends StatefulWidget {
//   const SignUpPage({super.key});
//
//   @override
//   _SignUpPageState createState() => _SignUpPageState();
// }
//
// class _SignUpPageState extends State<SignUpPage> {
//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController _referralController = TextEditingController();
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//
//   bool _isPasswordVisible = false;
//   bool _isLoading = false;
//
//   String? _errorMessage;
//
//   Future<void> _signUp() async {
//     if (!_formKey.currentState!.validate()) return;
//
//     setState(() => _isLoading = true);
//
//     final email = _emailController.text.trim();
//     final password = _passwordController.text.trim();
//     final refCode = _referralController.text.trim();
//
//     final String apiUrl = ApiConstants.getAuthUrl("register");
//
//     try {
//       final response = await http.post(
//         Uri.parse(apiUrl),
//         headers: {'Content-Type': 'application/json'},
//         body: jsonEncode({
//           "email": email,
//           "password": password,
//           "refCode": refCode.isNotEmpty ? refCode : null,
//         }),
//       );
//       final responseData = jsonDecode(response.body);
//       print("Signup Response: $responseData");
//
//       if (response.statusCode == 200 && responseData["success"] == true) {
//         _showMessage("Registration Successful!");
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => LoginScreen()),
//         );
//       } else {
//         String errorMessage = "Registration failed. Please try again.";
//         if (responseData["error"]?["message"] != null) {
//           errorMessage = responseData["error"]["message"];
//         }
//         _showMessage(errorMessage);
//       }
//     } catch (e) {
//         print("Signup Error: $e");
//         _showMessage("Error: $e");
//     }finally {
//         setState(() => _isLoading = false);
//     }
//   }
//
//   void _showMessage(String message) {
//     setState(() {
//       _errorMessage = message;
//     });
//
//     Future.delayed(const Duration(seconds: 2), () {
//       if (mounted) {
//         setState(() => _errorMessage = null);
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.background,
//       body: SafeArea(
//         child: Stack(
//           children: [
//             SingleChildScrollView(
//               padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
//               child: Column(
//                 children: [
//                   const SizedBox(height: AppSpacing.xxl),
//                   Image.asset('assets/logo.png', height: 180),
//                   const SizedBox(height: AppSpacing.xl),
//                   const Text('Create an Account', style: AppTextStyles.heading),
//                   const SizedBox(height: AppSpacing.lg),
//                   Form(
//                     key: _formKey,
//                     child: Column(
//                       children: [
//                         TextFormField(
//                           controller: _emailController,
//                           decoration: InputDecoration(
//                             labelText: 'Email',
//                             prefixIcon: const Icon(Icons.email, color: AppColors.bhagwa_Saffron),
//                             border: OutlineInputBorder(borderRadius: AppRadius.sm),
//                           ),
//                           keyboardType: TextInputType.emailAddress,
//                           validator: (value) {
//                             if (value == null || value.isEmpty) {
//                               return 'Please enter your email';
//                             }
//                             final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
//                             if (!emailRegex.hasMatch(value)) {
//                               return 'Please enter a valid email';
//                             }
//                             return null;
//                           },
//                         ),
//                         const SizedBox(height: AppSpacing.md),
//                         TextFormField(
//                           controller: _passwordController,
//                           obscureText: !_isPasswordVisible,
//                           decoration: InputDecoration(
//                             labelText: 'Password',
//                             prefixIcon: const Icon(Icons.lock, color: AppColors.bhagwa_Saffron),
//                             suffixIcon: IconButton(
//                               icon: Icon(
//                                 _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
//                                 color: AppColors.bhagwa_Saffron,
//                               ),
//                               onPressed: () => setState(() => _isPasswordVisible = !_isPasswordVisible),
//                             ),
//                             border: OutlineInputBorder(borderRadius: AppRadius.sm),
//                           ),
//                           validator: (value) {
//                             if (value == null || value.isEmpty) {
//                               return 'Please enter your password';
//                             }
//                             final passwordRegex =
//                             RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[\W_]).{8,}$');
//                             if (!passwordRegex.hasMatch(value)) {
//                               return "Password must be 8+ chars with upper, lower, number & symbol.";
//                             }
//                             return null;
//                           },
//                         ),
//                         const SizedBox(height: AppSpacing.md),
//                         TextFormField(
//                           controller: _referralController,
//                           decoration: InputDecoration(
//                             labelText: 'Referral Code (Optional)',
//                             prefixIcon: const Icon(Icons.redeem, color: AppColors.bhagwa_Saffron),
//                             border: OutlineInputBorder(borderRadius: AppRadius.sm),
//                           ),
//                         ),
//                         const SizedBox(height: AppSpacing.lg),
//                         SizedBox(
//                           width: double.infinity,
//                           child: ElevatedButton(
//                             style: AppButtonStyle.primary,
//                             onPressed: _isLoading ? null : _signUp,
//                             child: _isLoading
//                                 ? const CircularProgressIndicator(color: AppColors.primary)
//                                 : const Text(
//                               'REGISTER',
//                               style: TextStyle(fontSize: 16, color: AppColors.primary),
//                             ),
//                           ),
//                         ),
//                         const SizedBox(height: AppSpacing.lg),
//                         const Text("Or sign up with", style: AppTextStyles.bodyText16),
//                         const SizedBox(height: AppSpacing.sm),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             IconButton(
//                               icon: FaIcon(
//                                 FontAwesomeIcons.google,
//                                 size: AppStyles.socialIconSize,
//                                 color: AppStyles.googleIconColor,
//                               ),
//                               onPressed: () {},
//                             ),
//                             const SizedBox(width: AppSpacing.md),
//                             IconButton(
//                               icon: FaIcon(
//                                 FontAwesomeIcons.facebook,
//                                 size: AppStyles.socialIconSize,
//                                 color: AppStyles.facebookIconColor,
//                               ),
//                               onPressed: () {},
//                             ),
//                           ],
//                         ),
//                         const SizedBox(height: AppSpacing.xs),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             const Text("Already have an account?", style: AppTextStyles.bodyText16),
//                             TextButton(
//                               onPressed: () => Navigator.push(
//                                 context,
//                                 MaterialPageRoute(builder: (context) => LoginScreen()),
//                               ),
//                               child: const Text('Sign in here', style: AppTextStyles.bodyText16),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             // Error message overlay
//             if (_errorMessage != null)
//               Positioned(
//                 top: 20,
//                 left: 20,
//                 right: 20,
//                 child: Container(
//                   padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//                   decoration: BoxDecoration(
//                     color: Colors.red,
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   child: Text(
//                     _errorMessage!,
//                     style: AppTextStyles.errorMessage,
//                     textAlign: TextAlign.center,
//                   ),
//                 ),
//               ),
//           ],
//         )
//       ),
//     );
//   }
// }

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import './login_screen.dart';
import 'package:astro_ai_app/core/constants/api_constants.dart';
import 'package:astro_ai_app/core/theme/app_colors.dart';
import 'package:astro_ai_app/core/theme/app_text_style.dart';
import 'package:astro_ai_app/core/theme/app_spacing.dart';
import 'package:astro_ai_app/core/theme/app_button.dart';
import 'package:astro_ai_app/core/theme/app_radius.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _referralController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isPasswordVisible = false;
  bool _isLoading = false;

  String? _generalMessage;
  Color _messageBackgroundColor = Colors.red;

  Future<void> _signUp() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final refCode = _referralController.text.trim();

    final String apiUrl = ApiConstants.getAuthUrl("register");

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "email": email,
          "password": password,
          "refCode": refCode.isNotEmpty ? refCode : null,
        }),
      );
      final responseData = jsonDecode(response.body);
      print("Signup Response: $responseData");

      if (response.statusCode == 200 && responseData["success"] == true) {
        _showSuccessAndNavigate("Registration Successful!");
      } else {
        String errorMessage = "Registration failed. Please try again.";
        if (responseData["error"]?["message"] != null) {
          errorMessage = responseData["error"]["message"];
        }
        _showTemporaryMessage(errorMessage);
      }
    } catch (e) {
      print("Signup Error: $e");
      _showTemporaryMessage("Error: $e");
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _showTemporaryMessage(String message) {
    setState(() {
      _generalMessage = message;
      _messageBackgroundColor = Colors.red;
    });
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) setState(() => _generalMessage = null);
    });
  }

  void _showSuccessAndNavigate(String message) {
    setState(() {
      _generalMessage = message;
      _messageBackgroundColor = Colors.green;
    });
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() => _generalMessage = null);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
              child: Column(
                children: [
                  const SizedBox(height: AppSpacing.xxl),
                  Image.asset('assets/logo.png', height: 180),
                  const SizedBox(height: AppSpacing.xl),
                  const Text('Create an Account', style: AppTextStyles.heading),
                  const SizedBox(height: AppSpacing.lg),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            labelText: 'Email',
                            prefixIcon: const Icon(Icons.email, color: AppColors.bhagwa_Saffron),
                            border: OutlineInputBorder(borderRadius: AppRadius.sm),
                          ),
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            }
                            final emailRegex = RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$');
                            //final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                            if (!emailRegex.hasMatch(value)) {
                              return 'Please enter a valid email';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: AppSpacing.md),
                        TextFormField(
                          controller: _passwordController,
                          obscureText: !_isPasswordVisible,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            prefixIcon: const Icon(Icons.lock, color: AppColors.bhagwa_Saffron),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                                color: AppColors.bhagwa_Saffron,
                              ),
                              onPressed: () => setState(() => _isPasswordVisible = !_isPasswordVisible),
                            ),
                            border: OutlineInputBorder(borderRadius: AppRadius.sm),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            final passwordRegex = RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[\W_]).{8,}$');
                            if (!passwordRegex.hasMatch(value)) {
                              return "Password must be 8+ chars with upper, lower, number & symbol.";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: AppSpacing.md),
                        TextFormField(
                          controller: _referralController,
                          decoration: InputDecoration(
                            labelText: 'Referral Code (Optional)',
                            prefixIcon: const Icon(Icons.redeem, color: AppColors.bhagwa_Saffron),
                            border: OutlineInputBorder(borderRadius: AppRadius.sm),
                          ),
                        ),
                        const SizedBox(height: AppSpacing.lg),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: AppButtonStyle.primary,
                            onPressed: _isLoading ? null : _signUp,
                            child: _isLoading
                                ? const CircularProgressIndicator(color: AppColors.primary)
                                : const Text(
                              'REGISTER',
                              style: AppTextStyles.btnText,
                            ),
                          ),
                        ),
                        const SizedBox(height: AppSpacing.lg),
                        const Text("Or sign up with", style: AppTextStyles.bodyText16),
                        const SizedBox(height: AppSpacing.sm),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              icon: FaIcon(
                                FontAwesomeIcons.google,
                                size: AppStyles.socialIconSize,
                                color: AppStyles.googleIconColor,
                              ),
                              onPressed: () {},
                            ),
                            const SizedBox(width: AppSpacing.md),
                            IconButton(
                              icon: FaIcon(
                                FontAwesomeIcons.facebook,
                                size: AppStyles.socialIconSize,
                                color: AppStyles.facebookIconColor,
                              ),
                              onPressed: () {},
                            ),
                          ],
                        ),
                        const SizedBox(height: AppSpacing.xs),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Already have an account?", style: AppTextStyles.bodyText16),
                            TextButton(
                              onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => LoginScreen()),
                              ),
                              child: const Text('Sign in here', style: AppTextStyles.bodyText16),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            if (_generalMessage != null)
              Positioned(
                top: 20,
                left: 20,
                right: 20,
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs2, horizontal: AppSpacing.sm3),
                  decoration: BoxDecoration(
                    color: _messageBackgroundColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    _generalMessage!,
                    style: AppTextStyles.errorMessage,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}


