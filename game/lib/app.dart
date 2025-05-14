import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'features/theme/widget.dart';
import 'navigation/router.dart';

class App extends StatelessWidget {
  final Color seedColor = const Color(0xFFFFFFFF);

  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = GTheme.of(context);

    return MaterialApp.router(
      title: 'Graphica',
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('en', 'US'),
        Locale('ru', 'RU'),
      ],
      themeMode: theme.themeMode,
      debugShowCheckedModeBanner: false,
      routerConfig: router,
      theme: ThemeData.from(
        colorScheme: ColorScheme.fromSeed(
          seedColor: theme.seedColor,
          brightness: Brightness.light,
        ),
      ),
      darkTheme: ThemeData.from(
        colorScheme: ColorScheme.fromSeed(
          seedColor: theme.seedColor,
          brightness: Brightness.dark,
        ),
      ),
    );
  }
}
