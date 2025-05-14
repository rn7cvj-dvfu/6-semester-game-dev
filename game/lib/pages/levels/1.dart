import 'package:flutter/material.dart';

import '../../features/graph/ui/info_card.dart';
import '../../features/ui/back_button.dart';
import '../../navigation/navigator.dart';

class FirstLevelPage extends StatelessWidget {
  const FirstLevelPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: [
          // Positioned.fill(
          //   child: GameWidget(
          //     game: GraphWidget(
          //       backgroundColorValue: Theme.of(context).scaffoldBackgroundColor,
          //       dotColorValue: Theme.of(context).colorScheme.primary,
          //       connectionEdgeColorValue:
          //           Theme.of(context).colorScheme.primaryContainer,
          //     ),
          //   ),
          // ),
          Positioned(
            top: 16,
            left: 16,
            child: GBackButton(
              onTap: AppNavigator.openLevels,
            ),
          ),
          Positioned(
            bottom: 16,
            right: 16,
            child: InfoCardWidget(
              title: "Основы",
              text: "",
            ),
          )
        ],
      ),
    );
  }
}
