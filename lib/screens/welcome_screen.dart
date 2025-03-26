import 'package:astro_ai_app/screens/forgot_password_screen.dart';
import 'package:flutter/material.dart';
import './sign_up_screen.dart';
import './login_screen.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: WelcomePage(),
  ));
}

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  int _currentIndex = 0; // Track selected dot

  void _navigateToPage(int index, BuildContext context) {
    setState(() {
      _currentIndex = index;
    });
    if (index == 1) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpPage()));
    } else if (index == 2) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/bg1.webp'),
                fit: BoxFit.cover, // Covers full screen
              ),
            ),
          ),

          // Content
          Column(
            children: [
              // Top Image (Existing Welcome Image)
              Stack(
                children: [
                  Container(
                    height: 280,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(''),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 15,
                      // decoration: BoxDecoration(
                      //   color: Colors.white,
                      //   // borderRadius: BorderRadius.only(
                      //   //   topLeft: Radius.circular(30),
                      //   //   topRight: Radius.circular(30),
                      //   // ),
                      // ),
                    ),
                  ),
                ],
              ),

              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Text(
                      'Hello, And Welcome to Astro Ai.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white, // Adjust text color for better visibility
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      '',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey[300]),
                    ),
                    SizedBox(height: 20),

                    // Navigation Dots
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(3, (index) {
                        return GestureDetector(
                          onTap: () => _navigateToPage(index, context),
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 5),
                            width: 10,
                            height: 10,
                            decoration: BoxDecoration(
                              color: _currentIndex == index ? Colors.orange : Colors.grey,
                              shape: BoxShape.circle,
                            ),
                          ),
                        );
                      }),
                    ),

                    SizedBox(height: 20),

                    // Create Account Button
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {
                        _navigateToPage(1, context);
                      },
                      child: Text(
                        'CREATE ACCOUNT',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),

                    SizedBox(height: 10),

                    // Sign In Button
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[300],
                        padding: EdgeInsets.symmetric(horizontal: 120, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {
                        _navigateToPage(2, context);
                      },
                      child: Text(
                        'SIGN IN',
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                    ),

                    SizedBox(height: 10),

                    // Forgot Account Link
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ForgotPasswordPage()),
                        );
                      },
                      child: Text(
                        'Forgot your account?',
                        style: TextStyle(color: Colors.deepOrange),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
