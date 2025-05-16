import 'package:flutter/material.dart';

import '../.gen/i18n/strings.g.dart';
import '../features/settings.dart';
import '../navigation/navigator.dart';

class StatisticPage extends StatelessWidget {
  const StatisticPage({super.key});

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
                        t.strings.statistic,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      IconButton(
                        onPressed: AppNavigator.openHome,
                        icon: Icon(Icons.close),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
