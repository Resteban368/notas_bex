import 'package:flutter/material.dart';

class AppThemeColors {
  ThemeData getTheme() =>
      ThemeData(useMaterial3: true, colorSchemeSeed: const Color(0xFF2862F5));

  static const Color primary = Colors.deepPurpleAccent;
  static Color green = Colors.green[100]!;
  static Color orange = Colors.orange[100]!;
  static Color red = Colors.red[100]!;
  static Color black = Colors.black;
  static Color white = Colors.white;
  static const Color grey = Color(0xFFB9B9B9);
}
