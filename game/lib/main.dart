import 'package:flutter/material.dart';
import '.gen/i18n/strings.g.dart';

import 'app.dart';
import 'features/language/storage.dart';
import 'features/statistics/application/app_lifecycle_observer.dart';
import 'features/statistics/application/statistics_service.dart';
import 'features/theme/manager.dart';
import 'features/theme/storage.dart';
import 'utils/ui.dart';

Future<void> main() async {
  await setUpSystemUIOverlay();
  await LocaleSettings.useDeviceLocale();

  await StatisticsService.init();

  final (themeMode, seedColor) = await ThemeStorage.loadTheme();
  final language = await LanguageStorage.loadLanguage();

  if (language != null) {
    await LocaleSettings.setLocale(language);
  }

  runApp(
    ThemeManager(
      initialThemeMode: themeMode,
      initialSeedColor: seedColor,
      child: TranslationProvider(child: AppLifecycleObserver(child: App())),
    ),
  );
}
