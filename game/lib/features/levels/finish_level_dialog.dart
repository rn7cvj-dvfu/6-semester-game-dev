import 'package:flutter/material.dart';
import '../../.gen/i18n/strings.g.dart';
import '../../navigation/navigator.dart';

Future<void> showFinishLevelDialog(BuildContext context, [int? nextLevel]) {
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) => AlertDialog(
      insetPadding: EdgeInsets.all(16),
      title: Text(context.t.strings.common.levelComplete),
      actions: <Widget>[
        TextButton(
          child: Text(context.t.strings.common.toMainMenu),
          onPressed: () {
            Navigator.of(context).pop();
            AppNavigator.openHome();
          },
        ),
        if (nextLevel != null)
          FilledButton(
            child: Text(context.t.strings.common.nextLevel),
            onPressed: () {
              Navigator.of(context).pop();
              AppNavigator.openLevel(nextLevel);
            },
          ),
      ],
    ),
  );
}
