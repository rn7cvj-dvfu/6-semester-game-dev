import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future<void> setUpSystemUIOverlay() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Setting SysemUIOverlay
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      systemStatusBarContrastEnforced: false,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarDividerColor: Colors.transparent,
    ),
  );
  // Setting SystmeUIMode
  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
}
