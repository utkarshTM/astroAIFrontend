//**********************Previous Code*******************************//
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:astro_ai_app/core/features/auth/screens/forgot_password_screen.dart';
// import 'package:astro_ai_app/core/features/auth/screens/sign_up_screen.dart';
// import 'package:astro_ai_app/core/features/profile/screens/user_details_form_screen.dart';
// import 'package:astro_ai_app/core/constants/api_constants.dart';
// import 'package:astro_ai_app/core/theme/app_colors.dart';
// import 'package:astro_ai_app/core/theme/app_text_style.dart';
// import 'package:astro_ai_app/core/theme/app_spacing.dart';
// import 'package:astro_ai_app/core/theme/app_button.dart';
// import 'package:astro_ai_app/core/theme/app_radius.dart';
//
// class LoginScreen extends StatefulWidget {
//   @override
//   _LoginScreenState createState() => _LoginScreenState();
// }
//
// class _LoginScreenState extends State<LoginScreen> {
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   bool _obscurePassword = true;
//   bool _isLoading = false;
//
//   String? _errorMessage;
//
//   final GoogleSignIn _googleSignIn = GoogleSignIn(
//     clientId: "420273391995-kp6vve5ndaovvenhhvhkfhuk4uqju3dh.apps.googleusercontent.com",
//     scopes: ['email', 'profile'],
//   );
//
//   final String backendAuthUrl = ApiConstants.getAuthUrl("sso/google/callback");
//   final String apiUrl = "${ApiConstants.baseUrl}/api/auth/login";
//
//   Future<void> _login() async {
//     setState(() => _isLoading = true);
//
//     final email = _emailController.text.trim();
//     final password = _passwordController.text.trim();
//
//     if (email.isEmpty || password.isEmpty) {
//       _showMessage("Please enter both email and password");
//       setState(() => _isLoading = false);
//       return;
//     }
//
//     try {
//       final response = await http.post(
//         Uri.parse(apiUrl),
//         headers: {"Content-Type": "application/json"},
//         body: jsonEncode({"email": email, "password": password}),
//       );
//
//       final responseData = jsonDecode(response.body);
//       print("Login Response: $responseData");
//
//       if (response.statusCode == 200 && responseData["status"] == "success") {
//         final String accessToken = responseData["data"]["auth"];
//         if (accessToken.isEmpty) throw Exception("Access token is empty");
//         await _saveAccessToken(accessToken);
//         _showMessage("Login successful!");
//
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => UserDetailsScreen()),
//         );
//       } else {
//         _showMessage(responseData["message"] ?? "Login failed");
//       }
//     } catch (error) {
//       print("Login Error: $error");
//       _showMessage("Error connecting to the server: ${error.toString()}");
//     }
//
//     setState(() => _isLoading = false);
//   }
//
//   Future<void> _signInWithGoogle() async {
//     try {
//       final googleUser = await _googleSignIn.signIn();
//       if (googleUser == null) {
//         _showMessage("Google Sign-In canceled.");
//         return;
//       }
//
//       final googleAuth = await googleUser.authentication;
//       final idToken = googleAuth.idToken;
//       if (idToken == null) {
//         _showMessage("Failed to retrieve authentication tokens.");
//         return;
//       }
//
//       final response = await http.post(
//         Uri.parse(backendAuthUrl),
//         headers: {"Content-Type": "application/json"},
//         body: jsonEncode({"code": idToken}),
//       );
//
//       final responseData = jsonDecode(response.body);
//       print("Google Login Response: $responseData");
//
//       if (response.statusCode == 200) {
//         final String accessToken = responseData["data"]["auth"];
//         if (accessToken.isEmpty) throw Exception("Access token is empty");
//         await _saveAccessToken(accessToken);
//         _showMessage("Login successful!");
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => UserDetailsScreen()),
//         );
//       } else {
//         _showMessage(responseData["message"] ?? "Google login failed");
//       }
//     } catch (error) {
//       print("Google Login Error: $error");
//       _showMessage("Error: ${error.toString()}");
//     }
//   }
//
//   Future<void> _saveAccessToken(String token) async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setString('access_token', token);
//     print("Access token saved successfully");
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
//   // void _showMessage(String message) {
//   //   ScaffoldMessenger.of(context).showSnackBar(
//   //     SnackBar(
//   //       backgroundColor: Colors.red,
//   //       elevation: 0,
//   //       behavior: SnackBarBehavior.floating,
//   //       margin: const EdgeInsets.only(
//   //         top: 500,  // Distance from top
//   //         left: 20,
//   //         right: 20,
//   //       ),
//   //       content: Center(
//   //         child: Text(
//   //           message,
//   //           style: AppTextStyles.errorMessage,
//   //         ),
//   //       ),
//   //       duration: const Duration(seconds: 2),
//   //     ),
//   //   );
//   // }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.background,
//       body: SafeArea(
//         child: Stack(
//           children: [
//             GestureDetector(
//               onTap: () => FocusScope.of(context).unfocus(),
//               child: SingleChildScrollView(
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       const SizedBox(height: AppSpacing.xxl),
//                       Image.asset('assets/logo.png', height: 180),
//                       const SizedBox(height: AppSpacing.xl),
//                       const Text("Login", style: AppTextStyles.heading),
//                       const SizedBox(height: AppSpacing.lg),
//                       TextField(
//                         controller: _emailController,
//                         decoration: InputDecoration(
//                           labelText: 'Email',
//                           prefixIcon: const Icon(Icons.email, color: AppColors.bhagwa_Saffron),
//                           border: OutlineInputBorder(
//                             borderRadius: AppRadius.sm,
//                           ),
//                         ),
//                       ),
//                       const SizedBox(height: AppSpacing.md),
//                       TextField(
//                         controller: _passwordController,
//                         obscureText: _obscurePassword,
//                         decoration: InputDecoration(
//                           labelText: 'Password',
//                           prefixIcon: const Icon(Icons.lock, color: AppColors.bhagwa_Saffron),
//                           border: OutlineInputBorder(
//                             borderRadius: AppRadius.sm,
//                           ),
//                           suffixIcon: IconButton(
//                             icon: Icon(
//                               _obscurePassword ? Icons.visibility_off : Icons.visibility,
//                               color: AppColors.bhagwa_Saffron,
//                             ),
//                             onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
//                           ),
//                         ),
//                       ),
//                       const SizedBox(height: AppSpacing.sm),
//                       Align(
//                         alignment: Alignment.centerRight,
//                         child: TextButton(
//                           onPressed: () => Navigator.push(
//                             context,
//                             MaterialPageRoute(builder: (context) => ForgotPasswordScreen()),
//                           ),
//                           child: const Text("Forgot Password?", style: AppTextStyles.footerText),
//                         ),
//                       ),
//                       SizedBox(
//                         width: double.infinity,
//                         child: ElevatedButton(
//                           style: AppButtonStyle.primary,
//                           onPressed: _isLoading ? null : _login,
//                           child: _isLoading
//                               ? const SizedBox(
//                             height: 20,
//                             width: 20,
//                             child: CircularProgressIndicator(
//                               color: AppColors.primary,
//                               strokeWidth: 2,
//                             ),
//                           )
//                               : const Text(
//                             "LOGIN",
//                             style: TextStyle(color: AppColors.primary),
//                           ),
//                         ),
//                       ),
//                       const SizedBox(height: AppSpacing.md),
//                       const Text("Or sign in with", style: AppTextStyles.bodyText16),
//                       const SizedBox(height: AppSpacing.sm),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           IconButton(
//                             icon: FaIcon(
//                               FontAwesomeIcons.google,
//                               size: AppStyles.socialIconSize,
//                               color: AppStyles.googleIconColor,
//                             ),
//                             onPressed: _isLoading ? null : _signInWithGoogle,
//                           ),
//                           const SizedBox(width: AppSpacing.md),
//                           IconButton(
//                             icon: FaIcon(
//                               FontAwesomeIcons.facebook,
//                               size: AppStyles.socialIconSize,
//                               color: AppStyles.facebookIconColor,
//                             ),
//                             onPressed: _isLoading ? null : () {},
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: AppSpacing.xs),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           const Text("Don't have an account?", style: AppTextStyles.bodyText16),
//                           TextButton(
//                             onPressed: () => Navigator.push(
//                               context,
//                               MaterialPageRoute(builder: (context) => SignUpPage()),
//                             ),
//                             child: const Text("Sign up here", style: AppTextStyles.bodyText16),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//
//             // Error message overlay
//             if (_errorMessage != null)
//               Positioned(
//                 top: 20,
//                 left: 20,
//                 right: 20,
//                 child: Container(
//                   padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs2, horizontal: AppSpacing.sm3),
//                   decoration: BoxDecoration(
//                     color: Colors.red,
//                     borderRadius: AppRadius.sm2,
//                   ),
//                   child: Text(
//                     _errorMessage!,
//                     style: AppTextStyles.errorMessage,
//                     textAlign: TextAlign.center,
//                   ),
//                 ),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:astro_ai_app/core/features/auth/screens/forgot_password_screen.dart';
import 'package:astro_ai_app/core/features/auth/screens/sign_up_screen.dart';
import 'package:astro_ai_app/core/features/profile/screens/user_details_form_screen.dart';
import 'package:astro_ai_app/core/constants/api_constants.dart';
import 'package:astro_ai_app/core/theme/app_colors.dart';
import 'package:astro_ai_app/core/theme/app_text_style.dart';
import 'package:astro_ai_app/core/theme/app_spacing.dart';
import 'package:astro_ai_app/core/theme/app_button.dart';
import 'package:astro_ai_app/core/theme/app_radius.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _isLoading = false;
  String? _errorMessage;

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    clientId: "420273391995-kp6vve5ndaovvenhhvhkfhuk4uqju3dh.apps.googleusercontent.com",
    scopes: ['email', 'profile'],
  );

  final String backendAuthUrl = ApiConstants.getAuthUrl("sso/google/callback");
  final String apiUrl = "${ApiConstants.baseUrl}/api/auth/login";

  Future<void> _login() async {
    setState(() => _isLoading = true);

    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      _showMessage("Please enter both email and password");
      setState(() => _isLoading = false);
      return;
    }

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"email": email, "password": password}),
      );

      final responseData = jsonDecode(response.body);
      print("Login Response: $responseData");

      if (response.statusCode == 200 && responseData["status"] == "success") {
        final String accessToken = responseData["data"]["auth"];
        if (accessToken.isEmpty) throw Exception("Access token is empty");
        await _saveAccessToken(accessToken);
        _showMessage("Login successful!", isError: false, isNavigate: true);
      } else {
        _showMessage(responseData["message"] ?? "Login failed");
      }
    } catch (error) {
      print("Login Error: $error");
      _showMessage("Error connecting to the server: ${error.toString()}");
    }

    setState(() => _isLoading = false);
  }

  Future<void> _signInWithGoogle() async {
    try {
      final googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        _showMessage("Google Sign-In canceled.");
        return;
      }

      final googleAuth = await googleUser.authentication;
      final idToken = googleAuth.idToken;
      if (idToken == null) {
        _showMessage("Failed to retrieve authentication tokens.");
        return;
      }

      final response = await http.post(
        Uri.parse(backendAuthUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"code": idToken}),
      );

      final responseData = jsonDecode(response.body);
      print("Google Login Response: $responseData");

      if (response.statusCode == 200) {
        final String accessToken = responseData["data"]["auth"];
        if (accessToken.isEmpty) throw Exception("Access token is empty");
        await _saveAccessToken(accessToken);
        _showMessage("Login successful!", isError: false, isNavigate: true);
      } else {
        _showMessage(responseData["message"] ?? "Google login failed");
      }
    } catch (error) {
      print("Google Login Error: $error");
      _showMessage("Error: ${error.toString()}");
    }
  }

  Future<void> _saveAccessToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('access_token', token);
    print("Access token saved successfully");
  }

  void _showMessage(String message, {bool isError = true, bool isNavigate = false}) {
    setState(() {
      _errorMessage = message;
    });

    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() => _errorMessage = null);
        if (isNavigate) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => UserDetailsScreen()),
          );
        }
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
            GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: AppSpacing.xxl),
                      Image.asset('assets/logo.png', height: 180),
                      const SizedBox(height: AppSpacing.xl),
                      const Text("Login", style: AppTextStyles.heading),
                      const SizedBox(height: AppSpacing.lg),
                      TextField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          prefixIcon: const Icon(Icons.email, color: AppColors.bhagwa_Saffron),
                          border: OutlineInputBorder(
                            borderRadius: AppRadius.sm,
                          ),
                        ),
                      ),
                      const SizedBox(height: AppSpacing.md),
                      TextField(
                        controller: _passwordController,
                        obscureText: _obscurePassword,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          prefixIcon: const Icon(Icons.lock, color: AppColors.bhagwa_Saffron),
                          border: OutlineInputBorder(
                            borderRadius: AppRadius.sm,
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscurePassword ? Icons.visibility_off : Icons.visibility,
                              color: AppColors.bhagwa_Saffron,
                            ),
                            onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                          ),
                        ),
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ForgotPasswordScreen()),
                          ),
                          child: const Text("Forgot Password?", style: AppTextStyles.footerText),
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: AppButtonStyle.primary,
                          onPressed: _isLoading ? null : _login,
                          child: _isLoading
                              ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              color: AppColors.primary,
                              strokeWidth: 2,
                            ),
                          )
                              : const Text(
                            "LOGIN",
                            style: AppTextStyles.btnText,
                             // TextStyle(color: AppColors.primary)
                          ),
                        ),
                      ),
                      const SizedBox(height: AppSpacing.md),
                      const Text("Or sign in with", style: AppTextStyles.bodyText16),
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
                            onPressed: _isLoading ? null : _signInWithGoogle,
                          ),
                          const SizedBox(width: AppSpacing.md),
                          IconButton(
                            icon: FaIcon(
                              FontAwesomeIcons.facebook,
                              size: AppStyles.socialIconSize,
                              color: AppStyles.facebookIconColor,
                            ),
                            onPressed: _isLoading ? null : () {},
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Don't have an account?", style: AppTextStyles.bodyText16),
                          TextButton(
                            onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => SignUpPage()),
                            ),
                            child: const Text("Sign up here", style: AppTextStyles.bodyText16),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),

            if (_errorMessage != null)
              Positioned(
                top: 20,
                left: 20,
                right: 20,
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs2, horizontal: AppSpacing.sm3),
                  decoration: BoxDecoration(
                    color: _errorMessage == "Login successful!" ? Colors.green : Colors.red,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    _errorMessage!,
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
