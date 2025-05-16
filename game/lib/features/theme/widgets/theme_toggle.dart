import 'package:flutter/material.dart';

import '../../../.gen/i18n/strings.g.dart';
import '../widget.dart';

class ThemeModelToggle extends StatelessWidget {
  const ThemeModelToggle({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = GTheme.of(context);

    return SwitchListTile(
      // key:
      title: Text(context.t.strings.useDarkTheme),
      value: theme.themeMode == ThemeMode.dark,
      onChanged: (value) =>
          theme.toggleThemeMode(value ? ThemeMode.dark : ThemeMode.light),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    );
  }
}
