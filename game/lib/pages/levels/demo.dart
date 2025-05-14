import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import '../../features/graph/bloc/model.dart';
import '../../features/graph/ui/info_card.dart';
import '../../features/graph/ui/widget.dart';
import '../../features/ui/back_button.dart';
import '../../navigation/navigator.dart';

class DemoLevelPage extends StatelessWidget {
  const DemoLevelPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
      child: Stack(
        children: [
          Positioned.fill(
            child: GameWidget(
              game: GraphWidget(
                backgroundColorValue: theme.scaffoldBackgroundColor,
                dotColorValue: theme.colorScheme.primary,
                connectionEdgeColorValue: theme.colorScheme.primaryContainer,
                graphModel: GraphModel(
                  adjacencyMatrix: [
                    [0, 0, 0, 0, 0],
                    [1, 0, 0, 0, 0],
                    [1, 0, 1, 0, 0],
                    [1, 0, 1, 0, 1],
                    [1, 0, 1, 1, 0],
                  ],
                ),
              ),
            ),
          ),
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
                title: "Информация о уровне",
                text: "Это демонстрационный уровень с отобрженим графа "),
          )
        ],
      ),
    );
  }
}
