import 'package:flutter/material.dart';
import '.gen/i18n/strings.g.dart';

import 'app.dart';
import 'features/theme/manager.dart';
import 'features/theme/storage.dart';
import 'utils/ui.dart';

Future<void> main() async {
  await setUpSystemUIOverlay();
  await LocaleSettings.useDeviceLocale();

  final (themeMode, seedColor) = await ThemeStorage.loadTheme();

  runApp(
    ThemeManager(
      initialThemeMode: themeMode,
      initialSeedColor: seedColor,
      child: TranslationProvider(
        child: App(),
      ),
    ),
  );
}
