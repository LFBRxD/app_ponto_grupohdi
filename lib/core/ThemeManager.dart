import 'package:flutter/material.dart';

class ThemeManager {
  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.grey.shade900,
    primaryColor: Colors.black38,
    colorScheme: const ColorScheme.dark(),
  );
  static final whiteTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    primaryColor: Colors.cyan.shade500,
    colorScheme: const ColorScheme.light(),
  );
}
