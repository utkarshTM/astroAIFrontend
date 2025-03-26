import 'dart:async';
import 'dart:convert';
import 'package:astro_ai_app/screens/reset_password_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:astro_ai_app/api_constants.dart';

class ForgotPasswordScreen extends StatefulWidget {
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  bool _isLoading = false;
  bool _showOtpField = false;
  String? _emailErrorMessage;
  String? _otpErrorMessage;
  String? _otpCode;
  bool _isResendDisabled = true;
  int _resendTimer = 60;
  Timer? _timer;

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
      _emailErrorMessage = null;
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
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("OTP sent to your email!")),
        );
      } else {
        setState(() {
          _emailErrorMessage = responseData["error"]?["message"] ?? "Request failed. Please try again.";
        });
      }
    } catch (e) {
      setState(() {
        _emailErrorMessage = "Error: $e";
      });
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

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Email Verified Successfully!")),
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ResetPasswordScreen(signature: signature),
          ),
        );
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

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Forgot Password")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Enter your email for verification", style: TextStyle(fontSize: 18)),
              SizedBox(height: 10),

              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
              ),
              if (_emailErrorMessage != null)
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(_emailErrorMessage!, style: TextStyle(color: Colors.red)),
                ),

              SizedBox(height: 20),

              if (!_showOtpField)
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _sendForgotPasswordRequest,
                    child: _isLoading ? CircularProgressIndicator() : Text("Send OTP"),
                  ),
                ),

              if (_showOtpField) ...[
                Text("Enter OTP", style: TextStyle(fontSize: 18)),
                SizedBox(height: 10),

                Row(
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
                          border: OutlineInputBorder(),
                          errorText: _otpErrorMessage,
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Column(
                      children: [
                        ElevatedButton(
                          onPressed: _isResendDisabled ? null : _sendForgotPasswordRequest,
                          child: Text("Resend OTP"),
                        ),
                        if (_isResendDisabled)
                          Text("Wait $_resendTimer sec", style: TextStyle(color: Colors.red)),
                      ],
                    ),
                  ],
                ),

                SizedBox(height: 20),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _verifyOtp,
                    child: _isLoading ? CircularProgressIndicator() : Text("Verify OTP"),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}







//get opt on phone number functionality

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
//                         style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
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
//                                   style: ElevatedButton.styleFrom(
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
//                                   style: ElevatedButton.styleFrom(
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
//                                     style: TextStyle(color: Colors.white, fontSize: 16,fontWeight: FontWeight.bold),
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
