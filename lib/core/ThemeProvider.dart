import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode tMode = ThemeMode.light;
  bool get isDarkMode => tMode == ThemeMode.dark;

  void toggleTheme(bool isOn) {
    tMode = isOn ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}
