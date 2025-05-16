import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

final class ThemeStorage {
  static const String _themeModeKey = 'theme_mode';
  static const String _seedColorKey = 'seed_color';

  static Future<(ThemeMode, Color)> loadTheme() async {
    final prefs = await SharedPreferences.getInstance();

    final themeModeString = prefs.getString(_themeModeKey);
    final seedColorString = prefs.getString(_seedColorKey);

    try {
      final themeMode = ThemeMode.values.firstWhere(
        (e) => e.toString() == themeModeString,
        orElse: () => ThemeMode.light,
      );

      final seedColor = Color(int.parse(
        seedColorString ?? Colors.white.toARGB32().toString(),
      ));
      return (themeMode, seedColor);
    } catch (e) {
      return (ThemeMode.light, Colors.white);
    }
  }

  static Future<void> saveTheme(ThemeMode themeMode, Color seedColor) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(_themeModeKey, themeMode.toString());
    await prefs.setString(_seedColorKey, seedColor.toARGB32().toString());
  }
}
