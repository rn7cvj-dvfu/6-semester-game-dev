import 'package:flutter/material.dart';

import 'storage.dart';
import 'widget.dart';

class ThemeManager extends StatefulWidget {
  final ThemeMode initialThemeMode;
  final Color initialSeedColor;

  final Widget child;

  const ThemeManager({
    super.key,
    this.initialThemeMode = ThemeMode.light,
    this.initialSeedColor = Colors.white,
    required this.child,
  });

  @override
  State<ThemeManager> createState() => _ThemeManagerState();
}

class _ThemeManagerState extends State<ThemeManager> {
  ThemeMode _themeMode = ThemeMode.light;
  Color _seedColor = Colors.white;

  @override
  void initState() {
    super.initState();
    _themeMode = widget.initialThemeMode;
    _seedColor = widget.initialSeedColor;
  }

  void toggleThemeMode(ThemeMode newThemeMode) {
    _themeMode = newThemeMode;
    setState(() {});

    ThemeStorage.saveTheme(_themeMode, _seedColor);
  }

  void toggleSeedColor(Color newSeedColor) {
    _seedColor = newSeedColor;
    setState(() {});

    ThemeStorage.saveTheme(_themeMode, _seedColor);
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
