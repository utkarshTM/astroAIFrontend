import 'dart:convert';
import 'package:astro_ai_app/screens/sign_up_screen.dart';
import 'package:astro_ai_app/screens/forgot_password_screen.dart';
import 'package:http/http.dart' as http;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:astro_ai_app/api_constants.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _isLoading = false;

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    clientId: "420273391995-kp6vve5ndaovvenhhvhkfhuk4uqju3dh.apps.googleusercontent.com",
    scopes: ['email', 'profile'],
  );

  final String backendAuthUrl = ApiConstants.getAuthUrl("sso/google/callback");
  final String apiUrl = ApiConstants.getAuthUrl("login");

  Future<void> _login() async {
    setState(() {
      _isLoading = true;
    });

    final String email = _emailController.text.trim();
    final String password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      _showMessage("Please enter both email and password");
      setState(() {
        _isLoading = false;
      });
      return;
    }

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"email": email, "password": password}),
      );

      final responseData = jsonDecode(response.body);
      if (response.statusCode == 200 && responseData["status"] == "success") {
        _showMessage("Login successful!");
      } else {
        _showMessage(responseData["message"] ?? "Login failed");
      }
    } catch (error) {
      _showMessage("Error connecting to the server");
    }

    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        _showMessage("Google Sign-In canceled.");
        return;
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final String? idToken = googleAuth.idToken;

      if (idToken == null) {
        _showMessage("Failed to retrieve authentication tokens.");
        return;
      }

      final response = await http.post(
        Uri.parse(backendAuthUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"code": idToken}),
      );

      if (response.statusCode == 200) {
        _showMessage("Login successful!");
      } else {
        _showMessage("Google login failed");
      }
    } catch (error) {
      _showMessage("Error: $error");
    }
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          //onTap: () => FocusScope.of(context).unfocus(), // Dismiss keyboard on tap
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 55),
                  Image.asset(
                    'assets/logo.png',
                    height: 200,
                  ),
                  SizedBox(height: 50),
                  Text(
                    "Login",
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      prefixIcon: Icon(Icons.email, color: Colors.orangeAccent),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                  SizedBox(height: 16),
                  TextField(
                    controller: _passwordController,
                    obscureText: _obscurePassword,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      prefixIcon: Icon(Icons.lock, color: Colors.orangeAccent),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword ? Icons.visibility_off : Icons.visibility,
                          color: Colors.orange,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ForgotPasswordScreen()),
                        );
                      },
                      child: Text(
                        "Forgot Password?",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blue),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  _isLoading
                      ? CircularProgressIndicator()
                      : ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                    onPressed: _login,
                    child: Text("Login", style: TextStyle(color: Colors.white)),
                  ),
                  SizedBox(height: 20),
                  Text("Or sign up with", style: TextStyle(fontSize: 16)),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: FaIcon(FontAwesomeIcons.google, size: 40, color: Colors.red),
                        onPressed: _signInWithGoogle,
                      ),
                      SizedBox(width: 20),
                      IconButton(
                        icon: FaIcon(FontAwesomeIcons.facebook, size: 40, color: Colors.blue),
                        onPressed: () {},
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don't have an account?", style: TextStyle(fontSize: 16)),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => SignUpPage()),
                          );
                        },
                        child: Text(
                          "Sign up here",
                          style: TextStyle(color: Colors.blue, fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  //SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}





































// import 'dart:convert';
// import 'package:astro_ai_app/screens/sign_up_screen.dart';
// import 'package:astro_ai_app/screens/forgot_password_screen.dart';
// import 'package:http/http.dart' as http;
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:astro_ai_app/api_constants.dart';
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
//   final GoogleSignIn _googleSignIn = GoogleSignIn(
//     clientId: "420273391995-kp6vve5ndaovvenhhvhkfhuk4uqju3dh.apps.googleusercontent.com",
//     scopes: ['email', 'profile'],
//   );
//
//   final String backendAuthUrl = ApiConstants.getAuthUrl("sso/google/callback");
//   final String apiUrl = ApiConstants.getAuthUrl("login");
//
//   Future<void> _login() async {
//     setState(() {
//       _isLoading = true;
//     });
//
//     final String email = _emailController.text.trim();
//     final String password = _passwordController.text.trim();
//
//     if (email.isEmpty || password.isEmpty) {
//       _showMessage("Please enter both email and password");
//       setState(() {
//         _isLoading = false;
//       });
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
//       if (response.statusCode == 200 && responseData["status"] == "success") {
//         _showMessage("Login successful!");
//       } else {
//         _showMessage(responseData["message"] ?? "Login failed");
//       }
//     } catch (error) {
//       _showMessage("Error connecting to the server");
//     }
//
//     setState(() {
//       _isLoading = false;
//     });
//   }
//
//   Future<void> _signInWithGoogle() async {
//     try {
//       final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
//       if (googleUser == null) {
//         _showMessage("Google Sign-In canceled.");
//         return;
//       }
//
//       final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
//       final String? idToken = googleAuth.idToken;
//
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
//       if (response.statusCode == 200) {
//         _showMessage("Login successful!");
//       } else {
//         _showMessage("Google login failed");
//       }
//     } catch (error) {
//       _showMessage("Error: $error");
//     }
//   }
//
//   void _showMessage(String message) {
//     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Padding(
//           padding: EdgeInsets.symmetric(horizontal: 20),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               SizedBox(height: 100),
//               Image.asset(
//                 'assets/welcome.png',
//                 height: 200,
//               ),
//               SizedBox(height: 20),
//               Text(
//                 "Login",
//                 style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
//               ),
//               SizedBox(height: 20),
//               TextField(
//                 controller: _emailController,
//                 decoration: InputDecoration(
//                   labelText: 'Email',
//                   prefixIcon: Icon(Icons.email, color: Colors.orangeAccent), // Added Email & Password Icons...
//                   border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
//                 ),
//               ),
//               SizedBox(height: 16),
//               TextField(
//                 controller: _passwordController,
//                 obscureText: _obscurePassword,
//                 decoration: InputDecoration(
//                   labelText: 'Password',
//                   prefixIcon: Icon(Icons.lock, color: Colors.orangeAccent),
//                   border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
//                   suffixIcon: IconButton(
//                     icon: Icon(_obscurePassword ? Icons.visibility_off : Icons.visibility, color: Colors.orange,),// Add the color to similarity
//                     onPressed: () {
//                       setState(() {
//                         _obscurePassword = !_obscurePassword;
//                       });
//                     },
//                   ),
//                 ),
//               ),
//               SizedBox(height: 10),
//               SizedBox(height: 10),
//               Align(
//                 alignment: Alignment.centerRight, // Aligns to the right
//                 child: TextButton(
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (context) => ForgotPasswordScreen()),
//                     );
//                   },
//                   child: Text(
//                     "Forgot Password?",
//                     style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.blue, // Matches the "Sign up here" link
//                     ),
//                   ),
//                 ),
//               ),
//
//               SizedBox(height: 20),
//               _isLoading
//                   ? CircularProgressIndicator()
//                   : ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.orange,
//                   padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                 ),
//                 onPressed: _login,
//                 child: Text("Login", style: TextStyle(color: Colors.white)),
//               ),
//               SizedBox(height: 20),
//               Text("Or sign up with", style: TextStyle(fontSize: 16)),
//               SizedBox(height: 10),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   IconButton(
//                     icon: FaIcon(FontAwesomeIcons.google, size: 40, color: Colors.red),
//                     onPressed: _signInWithGoogle,
//                   ),
//                   SizedBox(width: 20),
//                   IconButton(
//                     icon: FaIcon(FontAwesomeIcons.facebook, size: 40, color: Colors.blue),
//                     onPressed: () {},
//                   ),
//                 ],
//               ),
//               SizedBox(height: 20),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text("Don't have an account?", style: TextStyle(fontSize: 16)),
//                   TextButton(
//                     onPressed: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (context) => SignUpPage()),
//                       );
//                     },
//                     child: Text("Sign up here", style: TextStyle(color:Colors.blue,fontSize: 16, fontWeight: FontWeight.bold)),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
