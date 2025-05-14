import 'package:flutter/material.dart';

import '../.gen/i18n/strings.g.dart';
import '../features/theme/togglers.dart';
import '../navigation/navigator.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: SizedBox.square(
          dimension: 384,
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        t.strings.settings,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      IconButton(
                        onPressed: AppNavigator.openHome,
                        icon: Icon(Icons.close),
                      ),
                    ],
                  ),
                  ThemeModelToggle(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
