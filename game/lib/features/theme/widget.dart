import 'package:flutter/material.dart';

class GTheme extends InheritedWidget {
  final ThemeMode themeMode;
  final Color seedColor;

  final void Function(ThemeMode newThemeMode) toggleThemeMode;
  final void Function(Color newSeedColor) toggleSeedColor;

  const GTheme({
    super.key,
    required super.child,
    required this.themeMode,
    required this.seedColor,
    required this.toggleThemeMode,
    required this.toggleSeedColor,
  });

  static GTheme of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<GTheme>()!;
  }

  @override
  bool updateShouldNotify(covariant GTheme oldWidget) {
    return oldWidget.themeMode != themeMode || oldWidget.seedColor != seedColor;
  }
}
