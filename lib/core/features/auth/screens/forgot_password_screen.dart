// *******************Previous Code*************************************//---->
// import 'dart:async';
// import 'dart:convert';
// import 'package:astro_ai_app/core/features/auth/screens/reset_password_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:astro_ai_app/core/constants/api_constants.dart';
// import 'package:astro_ai_app/core/theme/app_colors.dart';
// import 'package:astro_ai_app/core/theme/app_text_style.dart';
// import 'package:astro_ai_app/core/theme/app_spacing.dart';
// import 'package:astro_ai_app/core/theme/app_button.dart';
// import 'package:astro_ai_app/core/theme/app_radius.dart';
//
// class ForgotPasswordScreen extends StatefulWidget {
//   @override
//   _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
// }
//
// class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController _emailController = TextEditingController();
//   bool _isLoading = false;
//   bool _showOtpField = false;
//   String? _emailErrorMessage;
//   String? _otpErrorMessage;
//   String? _otpCode;
//   bool _isResendDisabled = true;
//   int _resendTimer = 60;
//   Timer? _timer;
//
//   String? _generalMessage;
//
//   void _startResendTimer() {
//     setState(() {
//       _isResendDisabled = true;
//       _resendTimer = 60;
//     });
//
//     _timer?.cancel();
//     _timer = Timer.periodic(Duration(seconds: 1), (timer) {
//       setState(() {
//         if (_resendTimer > 0) {
//           _resendTimer--;
//         } else {
//           _isResendDisabled = false;
//           _timer?.cancel();
//         }
//       });
//     });
//   }
//
//   Future<void> _sendForgotPasswordRequest() async {
//     if (!_formKey.currentState!.validate()) return;
//
//     setState(() {
//       _isLoading = true;
//       _emailErrorMessage = null;
//     });
//
//     final String apiUrl = ApiConstants.getAuthUrl("forgot-password");
//
//     try {
//       final response = await http.post(
//         Uri.parse(apiUrl),
//         headers: {'Content-Type': 'application/json'},
//         body: jsonEncode({"email": _emailController.text.trim()}),
//       );
//
//       final responseData = jsonDecode(response.body);
//
//       if (response.statusCode == 200 && responseData["success"] == true) {
//         setState(() {
//           _showOtpField = true;
//         });
//         _startResendTimer();
//         _showMessage("OTP sent to your email!");
//       } else {
//         setState(() {
//           _emailErrorMessage = responseData["error"]?["message"] ?? "Request failed. Please try again.";
//         });
//       }
//     } catch (e) {
//       setState(() {
//         _emailErrorMessage = "Error: $e";
//       });
//     } finally {
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }
//
//   Future<void> _verifyOtp() async {
//     if (_otpCode == null || _otpCode!.isEmpty) {
//       setState(() {
//         _otpErrorMessage = "Please enter the OTP";
//       });
//       return;
//     }
//
//     final String verifyOtpUrl = ApiConstants.getAuthUrl("verify");
//
//     setState(() {
//       _isLoading = true;
//       _otpErrorMessage = null;
//     });
//
//     try {
//       final response = await http.post(
//         Uri.parse(verifyOtpUrl),
//         headers: {'Content-Type': 'application/json'},
//         body: jsonEncode({
//           "email": _emailController.text.trim(),
//           "code": int.tryParse(_otpCode!) ?? 0,
//           "type": "reset-password"
//         }),
//       );
//
//       final responseData = jsonDecode(response.body);
//
//       if (response.statusCode == 200 && responseData["success"] == true) {
//         String signature = responseData["data"]["signature"];
//         _showMessage("Email Verified Successfully!");
//
//         Future.delayed(const Duration(seconds: 2), () {
//           if (mounted) {
//             Navigator.pushReplacement(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => ResetPasswordScreen(signature: signature),
//               ),
//             );
//           }
//         });
//       } else {
//         setState(() {
//           _otpErrorMessage = responseData["message"] ?? "Invalid OTP";
//         });
//       }
//     } catch (e) {
//       setState(() {
//         _otpErrorMessage = "Error: $e";
//       });
//     } finally {
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }
//
//   void _showMessage(String message) {
//     setState(() {
//       _generalMessage = message;
//     });
//
//     Future.delayed(const Duration(seconds: 2), () {
//       if (mounted) {
//         setState(() => _generalMessage = null);
//       }
//     });
//   }
//
//   @override
//   void dispose() {
//     _timer?.cancel();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//
//     return Scaffold(
//       appBar: AppBar(
//           title: Text(
//               "Forgot Password",
//               style: AppTextStyles.appBarTitle,
//           ),
//         backgroundColor: AppColors.bhagwa_Saffron,
//         iconTheme: const IconThemeData(
//           color: Colors.white,
//         ),
//       ),
//       body: Stack(
//         children: [
//           SingleChildScrollView(
//             child: Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Form(
//                 key: _formKey,
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     SizedBox(height: 60),
//                     Image.asset(
//                       'assets/logo.png',
//                       height: 200,
//                     ),
//                     SizedBox(height: 20),
//                     Text("Enter your email",
//                       style: AppTextStyles.heading,
//                     ),
//                     SizedBox(height: 40),
//
//                     TextFormField(
//                       controller: _emailController,
//                       decoration: InputDecoration(
//                         labelText: "Email",
//                         prefixIcon: Icon(Icons.email, color: AppColors.bhagwa_Saffron),
//                         border: OutlineInputBorder(borderRadius: AppRadius.sm),
//                       ),
//                       keyboardType: TextInputType.emailAddress,
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Please enter your email';
//                         }
//                         return null;
//                       },
//                     ),
//
//                     SizedBox(height: 50),
//
//                     if (!_showOtpField)
//                       SizedBox(
//                         width: double.infinity,
//                         child: ElevatedButton(
//                           onPressed: _isLoading ? null : _sendForgotPasswordRequest,
//                           style: AppButtonStyle.primary,
//                           child: _isLoading ? CircularProgressIndicator() : Text("SEND OTP",
//                             style: AppTextStyles.bodyText15,
//                           ),
//                         ),
//                       ),
//
//                     if (_showOtpField) ...[
//                       Text("Enter OTP", style: AppTextStyles.subHeading),
//                       SizedBox(height: 15),
//
//                       Row(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Expanded(
//                             child: TextField(
//                               keyboardType: TextInputType.number,
//                               onChanged: (value) => setState(() {
//                                 _otpCode = value;
//                                 _otpErrorMessage = null;
//                               }),
//                               decoration: InputDecoration(
//                                 labelText: "OTP",
//                                 border: OutlineInputBorder(borderRadius: AppRadius.sm),
//                                 errorText: _otpErrorMessage,
//                               ),
//                             ),
//                           ),
//                           SizedBox(width: 10),
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             children: [
//                               ElevatedButton(
//                                 style: AppButtonStyle.small,
//                                 onPressed: _isResendDisabled ? null : _sendForgotPasswordRequest,
//                                 child: Text(
//                                   "Resend OTP",
//                                   style: AppTextStyles.appBarTitle,
//                                 ),
//                               ),
//                               if (_isResendDisabled)
//                                 Padding(
//                                   padding: const EdgeInsets.only(top: 8),
//                                   child: Text("Wait $_resendTimer sec",
//                                       style: TextStyle(color: AppColors.bhagwa_Saffron)
//                                   ),
//                                 ),
//                             ],
//                           ),
//                         ],
//                       ),
//
//                       SizedBox(height: 20),
//
//                       SizedBox(
//                         width: double.infinity,
//                         child: ElevatedButton(
//                           style: AppButtonStyle.primary,
//                           onPressed: _isLoading ? null : _verifyOtp,
//                           child: _isLoading
//                               ? CircularProgressIndicator()
//                               : Text("Verify OTP",
//                             style: AppTextStyles.appBarTitle,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ],
//                 ),
//               ),
//             ),
//           ),
//
//
//           //Error message overlay
//           if (_emailErrorMessage != null)
//             Positioned(
//               top: 20,
//               left: 20,
//               right: 20,
//               child: Container(
//                 padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//                 decoration: BoxDecoration(
//                   color: Colors.red,
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 child: Text(
//                  _emailErrorMessage!,
//                   style: AppTextStyles.errorMessage,
//                   textAlign: TextAlign.center,
//                 ),
//               ),
//             ),
//
//           if (_generalMessage != null)
//             Positioned(
//               top: 20,
//               left: 20,
//               right: 20,
//               child: Container(
//                 padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//                 decoration: BoxDecoration(
//                   color: Colors.red,
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 child: Text(
//                   _generalMessage!,
//                   style: AppTextStyles.errorMessage,
//                   textAlign: TextAlign.center,
//                 ),
//               ),
//             ),
//         ],
//       )
//     );
//   }
// }
//
















//<!******************************| Get Otp On Phone Number Functionality |***********************************!>

// import 'package:flutter/material.dart';
// import 'package:intl_phone_field/intl_phone_field.dart';
// import './login_screen.dart';
// import './otp_screen.dart';
//
// class ForgotPasswordPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           // Background image
//           Container(
//             decoration: BoxDecoration(
//               image: DecorationImage(
//                 image: AssetImage(''),
//                 fit: BoxFit.cover,
//               ),
//             ),
//           ),
//           SingleChildScrollView(
//             child: Column(
//               children: [
//                 SizedBox(height: 60),
//                 Container(
//                   height: 300,
//                   decoration: BoxDecoration(
//                     image: DecorationImage(
//                       image: AssetImage('assets/welcome.png'),
//                       fit: BoxFit.contain,
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 100),
//                 Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 20),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       Text(
//                         'Forgot Password',
//                         theme: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//                       ),
//                       SizedBox(height: 20),
//                       Container(
//                         padding: EdgeInsets.all(20),
//                         decoration: BoxDecoration(
//                           color: Colors.white.withOpacity(0.9),
//                           borderRadius: BorderRadius.circular(15),
//                         ),
//                         child: Column(
//                           children: [
//                             IntlPhoneField(
//                               decoration: InputDecoration(
//                                 labelText: 'Phone Number',
//                                 border: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(10),
//                                   borderSide: BorderSide(),
//                                 ),
//                               ),
//                               initialCountryCode: 'AU',
//                               onChanged: (phone) {
//                                 print(phone.completeNumber);
//                               },
//                             ),
//                             SizedBox(height: 20),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 ElevatedButton(
//                                   theme: ElevatedButton.styleFrom(
//                                     backgroundColor: Colors.grey,
//                                     padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
//                                     shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(10),
//                                     ),
//                                   ),
//                                   onPressed: () {
//                                     Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
//                                   },
//                                   child: Icon(Icons.arrow_back, color: Colors.white),
//                                 ),
//                                 ElevatedButton(
//                                   theme: ElevatedButton.styleFrom(
//                                     backgroundColor: Colors.orange,
//                                     padding: EdgeInsets.symmetric(horizontal: 90, vertical: 13),
//                                     shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(10),
//                                     ),
//                                   ),
//                                   onPressed: () {
//                                     Navigator.push(context, MaterialPageRoute(builder: (context) => OtpScreen()));
//                                   },
//                                   child: Text(
//                                     'NEXT',
//                                     theme: TextStyle(color: Colors.white, fontSize: 16,fontWeight: FontWeight.bold),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'dart:async';
import 'dart:convert';
import 'package:astro_ai_app/core/features/auth/screens/reset_password_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:astro_ai_app/core/constants/api_constants.dart';
import 'package:astro_ai_app/core/theme/app_colors.dart';
import 'package:astro_ai_app/core/theme/app_text_style.dart';
import 'package:astro_ai_app/core/theme/app_spacing.dart';
import 'package:astro_ai_app/core/theme/app_button.dart';
import 'package:astro_ai_app/core/theme/app_radius.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  bool _isLoading = false;
  bool _showOtpField = false;
  String? _otpErrorMessage;
  String? _otpCode;
  bool _isResendDisabled = true;
  int _resendTimer = 60;
  Timer? _timer;
  Timer? _messageTimer;
  String? _generalMessage;

  void _startResendTimer() {
    setState(() {
      _isResendDisabled = true;
      _resendTimer = 60;
    });
    _timer?.cancel();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_resendTimer > 0) {
          _resendTimer--;
        } else {
          _isResendDisabled = false;
          _timer?.cancel();
        }
      });
    });
  }

  Future<void> _sendForgotPasswordRequest() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
      _clearMessage();
    });

    final String apiUrl = ApiConstants.getAuthUrl("forgot-password");

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({"email": _emailController.text.trim()}),
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200 && responseData["success"] == true) {
        setState(() {
          _showOtpField = true;
        });
        _startResendTimer();
        _showTimedMessage("OTP sent to your email!", isError: false);
      } else {
        _showTimedMessage(responseData["error"]?["message"] ?? "Request failed. Please try again.");
      }
    } catch (e) {
      _showTimedMessage("Error: $e");
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _verifyOtp() async {
    if (_otpCode == null || _otpCode!.isEmpty) {
      setState(() {
        _otpErrorMessage = "Please enter the OTP";
      });
      return;
    }

    final String verifyOtpUrl = ApiConstants.getAuthUrl("verify");

    setState(() {
      _isLoading = true;
      _otpErrorMessage = null;
    });

    try {
      final response = await http.post(
        Uri.parse(verifyOtpUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "email": _emailController.text.trim(),
          "code": int.tryParse(_otpCode!) ?? 0,
          "type": "reset-password"
        }),
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200 && responseData["success"] == true) {
        String signature = responseData["data"]["signature"];
        _showTimedMessage("Email Verified Successfully!", isError: false);
        Future.delayed(const Duration(seconds: 2), () {
          if (mounted) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => ResetPasswordScreen(signature: signature),
              ),
            );
          }
        });
      } else {
        setState(() {
          _otpErrorMessage = responseData["message"] ?? "Invalid OTP";
        });
      }
    } catch (e) {
      setState(() {
        _otpErrorMessage = "Error: $e";
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _showTimedMessage(String message, {bool isError = true}) {
    setState(() {
      _generalMessage = message;
    });

    _messageTimer?.cancel();
    _messageTimer = Timer(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() => _generalMessage = null);
      }
    });
  }

  void _clearMessage() {
    _generalMessage = null;
    _otpErrorMessage = null;
  }

  @override
  void dispose() {
    _timer?.cancel();
    _messageTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //Color displayColor = Colors.red;
    return Scaffold(
      appBar: AppBar(
        title: Text("Forgot Password", style: AppTextStyles.appBarTitle),
        backgroundColor: AppColors.bhagwa_Saffron,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.sm3),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 60),
                    Image.asset('assets/logo.png', height: 200),
                    SizedBox(height: 20),
                    Text("Enter your email", style: AppTextStyles.heading),
                    SizedBox(height: 40),
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: "Email",
                        prefixIcon: Icon(Icons.email, color: AppColors.bhagwa_Saffron),
                        border: OutlineInputBorder(borderRadius: AppRadius.sm),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) => value == null || value.isEmpty ? 'Please enter your email' : null,
                    ),
                    SizedBox(height: 50),

                    if (!_showOtpField)
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _isLoading ? null : _sendForgotPasswordRequest,
                          style: AppButtonStyle.primary,
                          child: _isLoading
                              ? CircularProgressIndicator()
                              : Text("SEND OTP", style: AppTextStyles.btnText),
                           // AppTextStyles.bodyText15
                        ),
                      ),

                    if (_showOtpField) ...[
                      Text("Enter OTP", style: AppTextStyles.subHeading),
                      SizedBox(height: 15),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: TextField(
                              keyboardType: TextInputType.number,
                              onChanged: (value) => setState(() {
                                _otpCode = value;
                                _otpErrorMessage = null;
                              }),
                              decoration: InputDecoration(
                                labelText: "OTP",
                                border: OutlineInputBorder(borderRadius: AppRadius.sm),
                                errorText: _otpErrorMessage,
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                style: AppButtonStyle.small,
                                onPressed: _isResendDisabled ? null : _sendForgotPasswordRequest,
                                child: Text("Resend OTP", style: AppTextStyles.btnText),
                              ),
                              if (_isResendDisabled)
                                Padding(
                                  padding: const EdgeInsets.only(top: 8),
                                  child: Text("Wait $_resendTimer sec", style: TextStyle(color: AppColors.bhagwa_Saffron)),
                                ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: AppButtonStyle.primary,
                          onPressed: _isLoading ? null : _verifyOtp,
                          child: _isLoading
                              ? CircularProgressIndicator()
                              : Text("Verify OTP", style: AppTextStyles.btnText),
                        ),
                      ),
                    ],
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
                  color: _generalMessage!.contains("Error") || _generalMessage!.contains("fail") ? Colors.red : Colors.green,
                  borderRadius: AppRadius.sm2,
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

