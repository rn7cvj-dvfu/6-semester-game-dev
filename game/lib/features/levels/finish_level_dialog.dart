import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart'; // No longer needed

import '../../.gen/i18n/strings.g.dart';
import '../../navigation/navigator.dart';
// import '../statistics/bloc/statistics_bloc.dart'; // No longer needed

Future<void> showFinishLevelDialog(
  BuildContext context, [
  // String currentLevelId, // Removed
  // Duration timeSpent, // Removed
  int? nextLevel,
]) {
  // Removed level time recording
  /*
  try {
    final statsBloc = context.read<StatisticsBloc>();
    statsBloc.add(RecordLevelTime(currentLevelId, timeSpent));
  } catch (e) {
    print('Error recording level time: $e');
  }
  */

  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(context.t.strings.common.levelComplete),
        content: nextLevel != null
            ? Text(context.t.strings.common.nextLevelPrompt)
            : null,
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
      );
    },
  );
}
