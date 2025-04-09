import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import './login_screen.dart';
import 'package:astro_ai_app/core/constants/api_constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:astro_ai_app/styles/app_Styles.dart';

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

  Future<void> _signUp() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    final String email = _emailController.text.trim();
    final String password = _passwordController.text.trim();
    final String refCode = _referralController.text.trim();

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

      // Print raw response for debugging
      print("Response status: ${response.statusCode}");
      print("Response body: ${response.body}");

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200 && responseData["success"] == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Registration Successful!")),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
      } else {
        String errorMessage = "Registration failed. Please try again.";

        if (responseData["error"] != null && responseData["error"]["message"] != null) {
          errorMessage = responseData["error"]["message"];
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorMessage)),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                //SizedBox(height: 60),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      SizedBox(height: 100),
                      Image.asset(
                        'assets/logo.png',
                        height: 200,
                      ),
                      SizedBox(height: 50),
                      Text(
                        'Create an Account',
                        textAlign: TextAlign.center,
                        style: AppTextStyles.pageTitle,
                        //style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 20),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              controller: _emailController,
                              decoration: InputDecoration(
                                labelText: 'Email',
                                prefixIcon: Icon(Icons.email, color: AppColors.bhagwa_Saffron),
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                              ),
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your email';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 16),
                            TextFormField(
                              controller: _passwordController,
                              decoration: InputDecoration(
                                labelText: 'Password',
                                prefixIcon: Icon(Icons.lock, color: AppColors.bhagwa_Saffron),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                                    color: AppColors.bhagwa_Saffron,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _isPasswordVisible = !_isPasswordVisible;
                                    });
                                  },
                                ),
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                              ),
                              obscureText: !_isPasswordVisible,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your password';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 16),
                            TextFormField(
                              controller: _referralController,
                              decoration: InputDecoration(
                                labelText: 'Referral Code (Optional)',
                                prefixIcon: Icon(Icons.redeem, color: AppColors.bhagwa_Saffron),
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                              ),
                            ),
                            SizedBox(height: 24.0),
                            SizedBox(
                              width: 130,
                              child: ElevatedButton(
                                onPressed: _isLoading ? null : _signUp,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.bhagwa_Saffron,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                  padding: EdgeInsets.symmetric(vertical: 14),
                                ), child: _isLoading ? CircularProgressIndicator(color: AppColors.primary)
                                    : Text('REGISTER',
                                        style: TextStyle(fontSize: 16, color: AppColors.primary)
                                    ),
                              ),
                            ),
                            SizedBox(height: 20),
                            Text("Or sign up with", style: TextStyle(fontSize: 16)),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                  icon: FaIcon(FontAwesomeIcons.google, size: 40, color: Colors.red),
                                  onPressed: () {},
                                ),
                                SizedBox(width: 20),
                                IconButton(
                                  icon: FaIcon(FontAwesomeIcons.facebook, size: 40, color: Colors.blue),
                                  onPressed: () {
                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(builder: (context) => BirthDetailsScreen()),
                                    // );
                                  },
                                ),
                              ],
                            ),
                            SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Already have an account?",style: TextStyle(fontSize: 16)),
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => LoginScreen()),
                                    );
                                  },
                                  child: Text('Sign in here',
                                        style: AppTextStyles.bodyText16,
                                      //style: TextStyle(color:Colors.blue,fontSize: 16,fontWeight: FontWeight.bold)
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import './login_screen.dart';
// import 'package:astro_ai_app/core/constants/api_constants.dart';
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
//   bool _isPasswordVisible = false;
//   bool _isLoading = false;
//
//   Future<void> _signUp() async {
//     if (!_formKey.currentState!.validate()) return;
//
//     setState(() {
//       _isLoading = true;
//     });
//
//     final String email = _emailController.text.trim();
//     final String password = _passwordController.text.trim();
//     final String refCode = _referralController.text.trim();
//
//     final String apiUrl = "${ApiConstants.baseUrl}/api/auth/register";
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
//
//       // Print raw response for debugging
//       print("Response status: ${response.statusCode}");
//       print("Response body: ${response.body}");
//
//       final responseData = jsonDecode(response.body);
//
//       if (response.statusCode == 200 && responseData["success"] == true) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text("Registration Successful!")),
//         );
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => LoginScreen()),
//         );
//       } else {
//         String errorMessage = "Registration failed. Please try again.";
//
//         if (responseData["error"] != null && responseData["error"]["message"] != null) {
//           errorMessage = responseData["error"]["message"];
//         }
//
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text(errorMessage)),
//         );
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Error: $e")),
//       );
//     } finally {
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           SingleChildScrollView(
//             child: Column(
//               children: [
//                 SizedBox(height: 60),
//                 Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 20),
//                   child: Column(
//                     children: [
//                       Text(
//                         'Create an Account',
//                         textAlign: TextAlign.center,
//                         styles: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//                       ),
//                       SizedBox(height: 20),
//                       Form(
//                         key: _formKey,
//                         child: Column(
//                           children: [
//                             TextFormField(
//                               controller: _emailController,
//                               decoration: InputDecoration(
//                                 labelText: 'Email',
//                                 prefixIcon: Icon(Icons.email, color: Colors.orangeAccent),
//                                 border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
//                               ),
//                               keyboardType: TextInputType.emailAddress,
//                               validator: (value) {
//                                 if (value == null || value.isEmpty) {
//                                   return 'Please enter your email';
//                                 }
//                                 return null;
//                               },
//                             ),
//                             SizedBox(height: 16),
//                             TextFormField(
//                               controller: _passwordController,
//                               decoration: InputDecoration(
//                                 labelText: 'Password',
//                                 prefixIcon: Icon(Icons.lock, color: Colors.orangeAccent),
//                                 suffixIcon: IconButton(
//                                   icon: Icon(
//                                     _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
//                                     color: Colors.orangeAccent,
//                                   ),
//                                   onPressed: () {
//                                     setState(() {
//                                       _isPasswordVisible = !_isPasswordVisible;
//                                     });
//                                   },
//                                 ),
//                                 border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
//                               ),
//                               obscureText: !_isPasswordVisible,
//                               validator: (value) {
//                                 if (value == null || value.isEmpty) {
//                                   return 'Please enter your password';
//                                 }
//                                 return null;
//                               },
//                             ),
//                             SizedBox(height: 16),
//                             TextFormField(
//                               controller: _referralController,
//                               decoration: InputDecoration(
//                                 labelText: 'Referral Code (Optional)',
//                                 prefixIcon: Icon(Icons.redeem, color: Colors.orangeAccent),
//                                 border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
//                               ),
//                             ),
//                             SizedBox(height: 24.0),
//                             SizedBox(
//                               width: double.infinity,
//                               child: ElevatedButton(
//                                 onPressed: _isLoading ? null : _signUp,
//                                 styles: ElevatedButton.styleFrom(
//                                   backgroundColor: Colors.orangeAccent,
//                                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//                                   padding: EdgeInsets.symmetric(vertical: 14),
//                                 ),
//                                 child: _isLoading
//                                     ? CircularProgressIndicator(color: Colors.white)
//                                     : Text('REGISTER', styles: TextStyle(fontSize: 16, color: Colors.white)),
//                               ),
//                             ),
//                             SizedBox(height: 16),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 GestureDetector(
//                                   onTap: () {
//                                     Navigator.push(
//                                       context,
//                                       MaterialPageRoute(builder: (context) => LoginScreen()),
//                                     );
//                                   },
//                                   child: Text('Sign in here',
//                                       styles: TextStyle(
//                                           color: Colors.orangeAccent, fontWeight: FontWeight.bold)),
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

