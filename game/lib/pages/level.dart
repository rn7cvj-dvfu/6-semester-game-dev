import 'package:flame/game.dart';
import 'package:flutter/material.dart';

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
        ],
      ),
    );
  }
}
