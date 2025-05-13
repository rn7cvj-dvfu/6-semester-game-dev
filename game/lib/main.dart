import 'package:flutter/material.dart';
import '.gen/i18n/strings.g.dart';

import 'app.dart';
import 'utils/ui.dart';

Future<void> main() async {
  await setUpSystemUIOverlay();
  await LocaleSettings.useDeviceLocale();

  runApp(TranslationProvider(child: App()));
}
