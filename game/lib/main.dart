import 'package:flutter/material.dart';
import '.gen/i18n/strings.g.dart';

import 'app.dart';
import 'features/theme/manager.dart';
import 'utils/ui.dart';

Future<void> main() async {
  await setUpSystemUIOverlay();
  await LocaleSettings.useDeviceLocale();

  runApp(
    ThemeManager(
      child: TranslationProvider(
        child: App(),
      ),
    ),
  );
}
