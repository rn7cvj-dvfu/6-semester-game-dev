import 'package:flutter/material.dart';

import '../../.gen/i18n/strings.g.dart';
import '../../navigation/navigator.dart';

Future<void> showFinishLevelDialog(BuildContext context, int nextLevel) =>
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(context.t.strings.common.levelComplete),
          content: Text(context.t.strings.common.nextLevelPrompt),
          actions: <Widget>[
            TextButton(
              child: Text(context.t.strings.common.toMainMenu),
              onPressed: () {
                Navigator.of(context).pop();
                AppNavigator.openLevels();
              },
            ),
            FilledButton(
              child: Text(context.t.strings.common.nextLevel),
              onPressed: () {
                Navigator.of(context).pop();
                AppNavigator.openLevel(nextLevel);
              },
            ),
          ],
        );
      },
    );
