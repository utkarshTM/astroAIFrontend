// import 'package:astro_ai_app/core/features/auth/screens/forgot_password_screen.dart';
// import 'package:astro_ai_app/core/features/auth/screens/sign_up_screen.dart';
// import 'package:flutter/material.dart';
// import 'login_screen.dart';
// import 'package:astro_ai_app/styles/app_Styles.dart';
//
// void main() {
//   runApp(MaterialApp(
//     debugShowCheckedModeBanner: false,
//     home: WelcomePage(),
//   ));
// }
//
// class WelcomePage extends StatefulWidget {
//   @override
//   _WelcomePageState createState() => _WelcomePageState();
// }
//
// class _WelcomePageState extends State<WelcomePage> {
//   int _currentIndex = 0;
//
//   void _navigateToPage(int index, BuildContext context) {
//     setState(() {
//       _currentIndex = index;
//     });
//     if (index == 1) {
//       Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpPage()));
//     } else if (index == 2) {
//       Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
//     }
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Stack(
//           children: [
//             Column(
//               children: [
//                 const SizedBox(height: 200),
//                 Stack(
//                   children: [
//                     Container(
//                       height: 150,
//                       decoration: const BoxDecoration(
//                         image: DecorationImage(
//                           image: AssetImage('assets/logo.png'),
//                           fit: BoxFit.contain,
//                         ),
//                       ),
//                     ),
//                     const Positioned(
//                       bottom: 0,
//                       left: 0,
//                       right: 0,
//                       child: SizedBox(height: 15),
//                     ),
//                   ],
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(20.0),
//                   child: Column(
//                     children: [
//                       const Text(
//                         'Hello,Welcome to Astro Ai.',
//                         textAlign: TextAlign.center,
//                         style: TextStyle(
//                           fontSize: 22,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.black,
//                         ),
//                       ),
//                       const SizedBox(height: 10),
//                       Text(
//                         '',
//                         textAlign: TextAlign.center,
//                         style: TextStyle(color: Colors.grey[300]),
//                       ),
//                       const SizedBox(height: 20),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: List.generate(3, (index) {
//                           return GestureDetector(
//                             onTap: () => _navigateToPage(index, context),
//                             child: Container(
//                               margin: const EdgeInsets.symmetric(horizontal: 5),
//                               width: 10,
//                               height: 10,
//                               decoration: BoxDecoration(
//                                 color: _currentIndex == index ? Colors.orange : Colors.grey,
//                                 shape: BoxShape.circle,
//                               ),
//                             ),
//                           );
//                         }),
//                       ),
//                       const SizedBox(height: 20),
//                       ElevatedButton(
//                         style: ElevatedButton.styleFrom(
//                           //backgroundColor: Colors.orange,
//                           backgroundColor: AppColors.primary,
//                           padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                         ),
//                         onPressed: () {
//                           _navigateToPage(1, context);
//                         },
//                         child: const Text(
//                           'CREATE ACCOUNT',
//                           //style: TextStyle(color: Colors.white, fontSize: 16),
//                         ),
//                       ),
//                       const SizedBox(height: 10),
//                       ElevatedButton(
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.grey[300],
//                           padding: const EdgeInsets.symmetric(horizontal: 120, vertical: 15),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                         ),
//                         onPressed: () {
//                           _navigateToPage(2, context);
//                         },
//                         child: const Text(
//                           'SIGN IN',
//                           style: TextStyle(color: Colors.black, fontSize: 16),
//                         ),
//                       ),
//                       const SizedBox(height: 10),
//                       TextButton(
//                         onPressed: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => ForgotPasswordScreen(),
//                             ),
//                           );
//                         },
//                         child: const Text(
//                           'Forgot your account?',
//                           style: TextStyle(color: Colors.deepOrange),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'package:astro_ai_app/core/features/auth/screens/forgot_password_screen.dart';
import 'package:astro_ai_app/core/features/auth/screens/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'package:astro_ai_app/styles/app_Styles.dart';

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  int _currentIndex = 0;

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
      backgroundColor: AppColors.primary,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              children: [
                const SizedBox(height: 200),
                Stack(
                  children: [
                    Container(
                      height: 150,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/logo.png'),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    const Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: SizedBox(height: 15),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      const Text(
                        'Hello,Welcome to Astro Ai.',
                        textAlign: TextAlign.center,
                        style: AppTextStyles.bodyText16,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        '', // placeholder, use AppTextStyles.bodyText16 if needed
                        textAlign: TextAlign.center,
                        style: AppTextStyles.bodyText16.copyWith(color: Colors.grey),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(3, (index) {
                          return GestureDetector(
                            onTap: () => _navigateToPage(index, context),
                            child: Container(
                              margin: const EdgeInsets.symmetric(horizontal: 5),
                              width: 10,
                              height: 10,
                              decoration: BoxDecoration(
                                color: _currentIndex == index
                                    ? AppColors.highlight
                                    : Colors.grey,
                                shape: BoxShape.circle,
                              ),
                            ),
                          );
                        }),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.bhagwa_Saffron,
                          padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () => _navigateToPage(1, context),
                        child: const Text(
                          'CREATE ACCOUNT',
                          style: AppTextStyles.appBarTitle,
                        ),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          //backgroundColor: Colors.grey[300],
                          backgroundColor: AppColors.bhagwa_Saffron,
                          padding: const EdgeInsets.symmetric(horizontal: 125, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () => _navigateToPage(2, context),
                        child: const Text(
                          'SIGN IN',
                          style: AppTextStyles.appBarTitle,
                          //style: TextStyle(color: Colors.black, fontSize: 16), // custom
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ForgotPasswordScreen()),
                          );
                        },
                        child: const Text(
                          'Forgot your account?',
                          style: AppTextStyles.footerText,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
