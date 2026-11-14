import 'package:flutter/material.dart';

class ThemeManager {
  // Global notifier for theme mode (light or dark)
  static final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.light);
}