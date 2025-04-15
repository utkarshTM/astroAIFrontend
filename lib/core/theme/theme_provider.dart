// *************** | Previous Code | ****************

// import 'package:flutter/material.dart';
//
// class ThemeProvider extends ChangeNotifier {
//   ThemeMode _themeMode = ThemeMode.system;
//
//   ThemeMode get currentTheme => _themeMode;
//
//   bool get isDarkMode {
//     if (_themeMode == ThemeMode.system) {
//       final brightness = MediaQuery.of(context).platformBrightness;
//      // WidgetsBinding.instance.window.platformBrightness
//       return brightness == Brightness.dark;
//     }
//     return _themeMode == ThemeMode.dark;
//   }
//
//   void toggleTheme() {
//     if (_themeMode == ThemeMode.dark) {
//       _themeMode = ThemeMode.light;
//     } else {
//       _themeMode = ThemeMode.dark;
//     }
//     notifyListeners();
//   }
// }


import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier with WidgetsBindingObserver {
  ThemeMode _themeMode = ThemeMode.system;

  ThemeProvider() {
    WidgetsBinding.instance.addObserver(this);
  }

  ThemeMode get currentTheme => _themeMode;

  bool get isDarkMode {
    final brightness = WidgetsBinding.instance.platformDispatcher.platformBrightness;
    return _themeMode == ThemeMode.system
        ? brightness == Brightness.dark
        : _themeMode == ThemeMode.dark;
  }

  void toggleTheme() {
    if (_themeMode == ThemeMode.dark) {
      _themeMode = ThemeMode.light;
    } else {
      _themeMode = ThemeMode.dark;
    }
    notifyListeners();
  }

  @override
  void didChangePlatformBrightness() {
    if (_themeMode == ThemeMode.system) {
      notifyListeners();  // Force UI to rebuild when system theme changes
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}
