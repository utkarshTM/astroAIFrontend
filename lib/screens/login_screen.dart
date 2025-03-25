import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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

  final String backendAuthUrl = "https://7d73-2405-201-7001-51b3-28ca-7d2f-8e3c-a1f1.ngrok-free.app/api/auth/sso/google/callback";
  final String apiUrl = "https://7d73-2405-201-7001-51b3-28ca-7d2f-8e3c-a1f1.ngrok-free.app/api/auth/login";
  /// 🔹 Handles user login
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

      print("Response Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");

      final responseData = jsonDecode(response.body);
      if (response.statusCode == 200 && responseData["status"] == "success") {
        _showBanner("Login successful!", Colors.green);
        print("User Data: ${responseData['data']}");
      } else {
        _showMessage(responseData["message"] ?? "Login failed");
      }
    } catch (error) {
      _showMessage("Error connecting to the server");
      print("Error: $error");
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
        print("User Data: ${response.body}");
      } else {
        _showMessage("Google login failed: ${response.body}");
      }
    } catch (error) {
      _showMessage("Error: $error");
    }
  }


  /// 🔹 Shows a Snackbar message
  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  /// 🔹 Shows a MaterialBanner when login is successful
  void _showBanner(String message, Color color) {
    ScaffoldMessenger.of(context).showMaterialBanner(
      MaterialBanner(
        content: Text(message, style: const TextStyle(color: Colors.white, fontSize: 16)),
        backgroundColor: color,
        actions: [
          TextButton(
            onPressed: () {
              ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
            },
            child: const Text("OK", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // 🔹 Background Image
            Container(
              width: double.infinity,
              height: 250,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/astrology-background.webp'),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // 🔹 Email Input
                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      prefixIcon: const Icon(Icons.person),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // 🔹 Password Input
                  TextField(
                    controller: _passwordController,
                    obscureText: _obscurePassword,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      prefixIcon: const Icon(Icons.lock),
                      suffixIcon: IconButton(
                        icon: Icon(_obscurePassword ? Icons.visibility_off : Icons.visibility),
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                      ),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // 🔹 Login Button
                  _isLoading
                      ? const CircularProgressIndicator()
                      : ElevatedButton(
                    onPressed: _login,
                    child: const Text('Login'),
                  ),

                  // 🔹 "Or sign up with" text
                  const SizedBox(height: 20),
                  const Text("Or sign up with", style: TextStyle(fontSize: 16)),

                  // 🔹 Social Media Login Buttons
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: const FaIcon(FontAwesomeIcons.google, size: 40, color: Colors.red),
                        onPressed: _signInWithGoogle,
                      ),
                      const SizedBox(width: 20),
                      IconButton(
                        icon: const FaIcon(FontAwesomeIcons.facebook, size: 40, color: Colors.blue),
                        onPressed: () {},
                      ),
                    ],
                  ),
                  // 🔹 "Don't have an account?" with Sign-up link
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account?", style: TextStyle(fontSize: 16)),
                      TextButton(
                        onPressed: () {
                          // Navigate to Sign Up screen
                        },
                        child: const Text(
                          "Sign up here",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
    );
  }
}
