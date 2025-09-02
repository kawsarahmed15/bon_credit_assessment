import 'package:flutter/material.dart';

/// Minimal stub of the previously removed ThemeColors class so existing
/// screens compile without refactoring. Provides a fixed dark palette.
/// If future dynamic theming is required, extend this class accordingly.
class ThemeColors {
  final Color background = Colors.black;
  final Color surface = Colors.grey.shade900;
  final Color borderLight = Colors.grey.shade900;
  final List<Color> appBarGradient = [Colors.black, Colors.grey.shade900];
  final Color textPrimary = Colors.white;
  final Color textSecondary = Colors.white70;
  final Color accent = Colors.blueAccent;
  final Color shadow = Colors.black.withOpacity(0.5);
  final Color shadowLight = Colors.black.withOpacity(0.3);
  final Color success = Colors.green;
  final Color error = Colors.red;
}
