import 'dart:convert';
import 'package:astro_ai_app/screens/sign_up_screen.dart';
import 'package:astro_ai_app/screens/forgot_password_screen.dart';
import 'package:astro_ai_app/screens/user_details_form_screen.dart';
import 'package:http/http.dart' as http;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:astro_ai_app/api_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  final String apiUrl = "${ApiConstants.baseUrl}/api/auth/login";
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
      print("Login Response: $responseData"); // Debug log

      if (response.statusCode == 200 && responseData["status"] == "success") {
        // Extract token from the nested structure
        final String accessToken = responseData["data"]["auth"];

        if (accessToken.isEmpty) {
          throw Exception("Access token is empty");
        }

        // Save the access token
        await _saveAccessToken(accessToken);

        _showMessage("Login successful!");
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => UserDetailsScreen()),
        );
      } else {
        final errorMessage = responseData["message"] ?? "Login failed";
        _showMessage(errorMessage);
      }
    } catch (error) {
      print("Login Error: $error"); // Debug log
      _showMessage("Error connecting to the server: ${error.toString()}");
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

      final responseData = jsonDecode(response.body);
      print("Google Login Response: $responseData"); // Debug log

      if (response.statusCode == 200) {
        // Extract token from the nested structure
        final String accessToken = responseData["data"]["auth"];

        if (accessToken.isEmpty) {
          throw Exception("Access token is empty");
        }

        // Save the access token
        await _saveAccessToken(accessToken);

        _showMessage("Login successful!");
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => UserDetailsScreen()),
        );
      } else {
        final errorMessage = responseData["message"] ?? "Google login failed";
        _showMessage(errorMessage);
      }
    } catch (error) {
      print("Google Login Error: $error"); // Debug log
      _showMessage("Error: ${error.toString()}");
    }
  }

  Future<void> _saveAccessToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('access_token', token);
    print("Access token saved successfully");
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Login",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: _passwordController,
                obscureText: _obscurePassword,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  suffixIcon: IconButton(
                    icon: Icon(_obscurePassword ? Icons.visibility_off : Icons.visibility),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                ),
              ),
              SizedBox(height: 10),
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
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
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
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
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
                    child: Text("Sign up here", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}