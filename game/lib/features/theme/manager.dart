import 'package:flutter/material.dart';

import 'widget.dart';

class ThemeManager extends StatefulWidget {
  final Widget child;

  const ThemeManager({super.key, required this.child});

  @override
  State<ThemeManager> createState() => _ThemeManagerState();
}

class _ThemeManagerState extends State<ThemeManager> {
  ThemeMode _themeMode = ThemeMode.light;
  Color _seedColor = Colors.white;

  void toggleThemeMode(ThemeMode newThemeMode) {
    _themeMode = newThemeMode;
    setState(() {});
  }

  void toggleSeedColor(Color newSeedColor) {
    _seedColor = newSeedColor;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return GTheme(
      themeMode: _themeMode,
      seedColor: _seedColor,
      toggleThemeMode: toggleThemeMode,
      toggleSeedColor: toggleSeedColor,
      child: widget.child,
    );
  }
}
