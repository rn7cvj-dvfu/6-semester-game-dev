import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import '../features/graph/info_card.dart';
import '../features/graph/widget.dart';
import '../features/ui/back_button.dart';
import '../navigation/navigator.dart';

class LevelPage extends StatelessWidget {
  final int levelId;

  const LevelPage({super.key, required this.levelId});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: [
          Positioned.fill(
            child: GameWidget(
              game: GraphWidget(
                backgroundColorValue: Theme.of(context).scaffoldBackgroundColor,
                dotColorValue: Theme.of(context).colorScheme.primary,
                connectionEdgeColorValue:
                    Theme.of(context).colorScheme.primaryContainer,
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
              text:
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum." *
                      2,
            ),
          )
        ],
      ),
    );
  }
}
