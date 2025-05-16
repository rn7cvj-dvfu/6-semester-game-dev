import 'package:flutter/material.dart';

import '../.gen/i18n/strings.g.dart';
import '../features/language/widgets/toggle.dart';
import '../features/settings.dart';
import '../features/theme/widgets/color_toggle.dart';
import '../features/theme/widgets/theme_toggle.dart';
import '../navigation/navigator.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: SizedBox.square(
          dimension: GSettings.maxDialogWidth,
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        context.t.strings.settings,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      IconButton(
                        onPressed: AppNavigator.openHome,
                        icon: Icon(Icons.close),
                      ),
                    ],
                  ),
                  ThemeModelToggle(),
                  const Divider(),
                  SeedColorToggle(),
                  LanguageToggle(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
