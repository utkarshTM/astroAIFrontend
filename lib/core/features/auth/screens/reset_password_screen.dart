//*********** Previous Code ******************************//
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:astro_ai_app/core/constants/api_constants.dart';
// import 'package:astro_ai_app/core/features/auth/screens/login_screen.dart';
// import 'package:astro_ai_app/core/theme/app_colors.dart';
// import 'package:astro_ai_app/core/theme/app_text_style.dart';
// import 'package:astro_ai_app/core/theme/app_spacing.dart';
// import 'package:astro_ai_app/core/theme/app_button.dart';
// import 'package:astro_ai_app/core/theme/app_radius.dart';
//
// class ResetPasswordScreen extends StatefulWidget {
//   final String signature;
//
//   const ResetPasswordScreen({super.key, required this.signature});
//
//   @override
//   _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
// }
//
// class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController _passwordController = TextEditingController();
//   final TextEditingController _confirmPasswordController = TextEditingController();
//
//   bool _isLoading = false;
//   bool _obscurePassword = true;
//   bool _obscureConfirmPassword = true;
//   String? _errorMessage;
//
//   Future<void> _resetPassword() async {
//     if (!_formKey.currentState!.validate()) return;
//
//     setState(() {
//       _isLoading = true;
//       _errorMessage = null;
//     });
//
//     final String apiUrl = "${ApiConstants.baseUrl}/api/auth/reset-password";
//
//     try {
//       final response = await http.post(
//         Uri.parse(apiUrl),
//         headers: {'Content-Type': 'application/json'},
//         body: jsonEncode({
//           "signature": widget.signature,
//           "password": _passwordController.text.trim(),
//           "password_confirmation": _confirmPasswordController.text.trim(),
//         }),
//       );
//
//       final responseData = jsonDecode(response.body);
//
//       if (response.statusCode == 200 && responseData["success"] == true) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             backgroundColor: Colors.transparent,
//             elevation: 0,
//             behavior: SnackBarBehavior.floating,
//             content: Center(
//               child: Text(
//                 "Password reset successful! Please log in.",
//                 style: AppTextStyles.errorMessage,
//               ),
//             ),
//             duration: const Duration(seconds: 2),
//           ),
//         );
//         await Future.delayed(const Duration(seconds: 2));  // Wait for message
//         if (mounted) {
//           Navigator.pushReplacement(
//             context,
//             MaterialPageRoute(builder: (context) => LoginScreen()),
//           );
//         }
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             backgroundColor: Colors.transparent,
//             elevation: 0,
//             behavior: SnackBarBehavior.floating,
//             content: Center(
//               child: Text(
//                 responseData["message"] ?? "Password reset failed",
//                 style: AppTextStyles.errorMessage,
//               ),
//             ),
//             duration: const Duration(seconds: 2),
//           ),
//         );
//       }
//     } catch (e) {
//       _showMessage("Error: $e");
//     } finally {
//       setState(() {
//         _isLoading = false;
//       });
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
//       appBar: AppBar(
//         title: const Text("Reset Password", style: AppTextStyles.appBarTitle),
//         backgroundColor: AppColors.bhagwa_Saffron,
//         iconTheme: const IconThemeData(color: AppColors.primary),
//       ),
//       body: Stack(
//         children: [
//           SingleChildScrollView(
//             child: Padding(
//               padding: const EdgeInsets.all(AppSpacing.md),
//               child: Form(
//                 key: _formKey,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     const SizedBox(height: 50),
//                     Image.asset('assets/logo.png', height: 180),
//                     const SizedBox(height: 20),
//                     const Text("Enter your new password", style: AppTextStyles.heading),
//                     const SizedBox(height: AppSpacing.lg),
//
//                     TextFormField(
//                       controller: _passwordController,
//                       obscureText: _obscurePassword,
//                       decoration: InputDecoration(
//                         labelText: "New Password",
//                         labelStyle: AppTextStyles.bodyText16,
//                         border: OutlineInputBorder(borderRadius: AppRadius.sm),
//                         suffixIcon: IconButton(
//                           icon: Icon(
//                             _obscurePassword ? Icons.visibility_off : Icons.visibility,
//                             color: AppColors.bhagwa_Saffron,
//                           ),
//                           onPressed: () {
//                             setState(() => _obscurePassword = !_obscurePassword);
//                           },
//                         ),
//                       ),
//                       validator: (value) {
//                         if (value == null || value.isEmpty) return "Enter a new password";
//                         if (value.length < 8) return "Password must be at least 8 characters";
//                         if (!RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[\s\S]).{8,}$').hasMatch(value)) {
//                           return "Must contain upper, lower, number & special character";
//                         }
//                         if (value.contains(widget.signature)) {
//                           return "Password must not contain email";
//                         }
//                         return null;
//                       },
//                     ),
//                     const SizedBox(height: AppSpacing.md),
//
//                     TextFormField(
//                       controller: _confirmPasswordController,
//                       obscureText: _obscureConfirmPassword,
//                       decoration: InputDecoration(
//                         labelText: "Confirm Password",
//                         labelStyle: AppTextStyles.bodyText16,
//                         border: OutlineInputBorder(borderRadius: AppRadius.sm),
//                         suffixIcon: IconButton(
//                           icon: Icon(
//                             _obscureConfirmPassword ? Icons.visibility_off : Icons.visibility,
//                             color: AppColors.bhagwa_Saffron,
//                           ),
//                           onPressed: () {
//                             setState(() => _obscureConfirmPassword = !_obscureConfirmPassword);
//                           },
//                         ),
//                       ),
//                       validator: (value) {
//                         if (value == null || value.isEmpty) return "Confirm your password";
//                         if (value != _passwordController.text) return "Passwords do not match";
//                         return null;
//                       },
//                     ),
//                     const SizedBox(height: AppSpacing.sm),
//
//                     if (_errorMessage != null)
//                       Positioned(
//                         bottom: 30,
//                         left: 0,
//                         right: 0,
//                         child: Center(
//                           child: Text(
//                             _errorMessage!,
//                             style: AppTextStyles.errorMessage,
//                             textAlign: TextAlign.center,
//                           ),
//                         ),
//                       ),
//
//                     const SizedBox(height: AppSpacing.lg),
//
//                     SizedBox(
//                       width: double.infinity,
//                       child: ElevatedButton(
//                         onPressed: _isLoading ? null : _resetPassword,
//                         style: AppButtonStyle.primary,
//                         child: _isLoading
//                             ? const CircularProgressIndicator(color: AppColors.primary)
//                             : const Text("Reset Password", style: AppTextStyles.appBarTitle),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }


import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:astro_ai_app/core/constants/api_constants.dart';
import 'package:astro_ai_app/core/features/auth/screens/login_screen.dart';
import 'package:astro_ai_app/core/theme/app_colors.dart';
import 'package:astro_ai_app/core/theme/app_text_style.dart';
import 'package:astro_ai_app/core/theme/app_spacing.dart';
import 'package:astro_ai_app/core/theme/app_button.dart';
import 'package:astro_ai_app/core/theme/app_radius.dart';

class ResetPasswordScreen extends StatefulWidget {
  final String signature;

  const ResetPasswordScreen({super.key, required this.signature});

  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  bool _isLoading = false;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  String? _generalMessage;
  Color _messageBackgroundColor = Colors.red;

  Future<void> _resetPassword() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
      _generalMessage = null;
    });

    final String apiUrl = "${ApiConstants.baseUrl}/api/auth/reset-password";

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "signature": widget.signature,
          "password": _passwordController.text.trim(),
          "password_confirmation": _confirmPasswordController.text.trim(),
        }),
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200 && responseData["success"] == true) {
        _showSuccessAndNavigate("Password reset successful! Please log in.");
      } else {
        String errorMessage = responseData["message"] ?? "Password reset failed";
        _showTemporaryMessage(errorMessage);
      }
    } catch (e) {
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
    final isTablet = MediaQuery
        .of(context)
        .size
        .shortestSide > 600;
    return Scaffold(
      appBar: AppBar(
        title: Text(
            "Reset Password",
            style: AppTextStyles.appBarTitle,
            // style: isTablet ? AppTextStyles.appBarTitle.copyWith(color: AppColors.adaptiveTextColor(context))
            //     : AppTextStyles.appBarTitle.copyWith(color: AppColors.adaptiveTextColor(context))
        ),
        backgroundColor: AppColors.bhagwaSaffron(context),
        iconTheme: const IconThemeData(color: AppColors.primary),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 50),
                    Image.asset('assets/logo.png', height: 180),
                    const SizedBox(height: 20),
                    Text(
                        "Enter your new password",
                        style: isTablet ? AppTextStyles.heading.copyWith(color: AppColors.adaptiveTextColor(context))
                            : AppTextStyles.heading.copyWith(color: AppColors.adaptiveTextColor(context))
                    ),
                    const SizedBox(height: AppSpacing.lg),

                    TextFormField(
                      controller: _passwordController,
                      obscureText: _obscurePassword,
                      decoration: InputDecoration(
                        labelText: "New Password",
                        labelStyle: AppTextStyles.bodyText16.copyWith(color: AppColors.adaptiveTextColor(context)),
                        border: OutlineInputBorder(borderRadius: AppRadius.sm),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword ? Icons.visibility_off : Icons.visibility,
                            color: AppColors.bhagwa_Saffron,
                          ),
                          onPressed: () {
                            setState(() => _obscurePassword = !_obscurePassword);
                          },
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) return "Enter a new password";
                        if (value.length < 8) return "Password must be at least 8 characters";
                        if (!RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[\s\S]).{8,}$').hasMatch(value)) {
                          return "Must contain upper, lower, number & special character";
                        }
                        if (value.contains(widget.signature)) {
                          return "Password must not contain email";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: AppSpacing.md),

                    TextFormField(
                      controller: _confirmPasswordController,
                      obscureText: _obscureConfirmPassword,
                      decoration: InputDecoration(
                        labelText: "Confirm Password",
                        labelStyle: AppTextStyles.bodyText16.copyWith(color: AppColors.adaptiveTextColor(context)),
                        border: OutlineInputBorder(borderRadius: AppRadius.sm),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscureConfirmPassword ? Icons.visibility_off : Icons.visibility,
                            color: AppColors.bhagwa_Saffron,
                          ),
                          onPressed: () {
                            setState(() => _obscureConfirmPassword = !_obscureConfirmPassword);
                          },
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) return "Confirm your password";
                        if (value != _passwordController.text) return "Passwords do not match";
                        return null;
                      },
                    ),
                    const SizedBox(height: AppSpacing.lg),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : _resetPassword,
                        style: AppButtonStyle.primary,
                        child: _isLoading
                            ? const CircularProgressIndicator(color: AppColors.primary)
                            : const Text("Reset Password", style: AppTextStyles.btnText),
                      ),
                    ),
                  ],
                ),
              ),
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
    );
  }
}
